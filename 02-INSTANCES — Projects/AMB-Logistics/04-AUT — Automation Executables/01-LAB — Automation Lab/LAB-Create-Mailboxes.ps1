<#
Tenant-local controlled runtime
Production-ready guarded execution
Protected-object enforced
No license assignment
No destructive default behavior
#>

Param(
    [String]$MTXDir,
    [Switch]$DryRun,
    [String]$TenantId,
    [String]$TenantDomain,
    [String]$ProtectedGlobalAdminObjectId
)

if (-not $PSBoundParameters.ContainsKey("DryRun")) {
    $DryRun = $true
}

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProtectedObjectsPath = Join-Path $ScriptRoot "LAB-Protected-Objects.ps1"
if (-not (Test-Path -LiteralPath $ProtectedObjectsPath)) {
    throw "Protected object policy file missing. Execution blocked."
}
. $ProtectedObjectsPath
if (-not [string]::IsNullOrWhiteSpace($ProtectedGlobalAdminObjectId)) {
    [void](Add-LabProtectedObjectId -ObjectId $ProtectedGlobalAdminObjectId)
}
[void](Confirm-LabProtectedBaseline)

function Wait-LabMailboxAvailable {
    Param(
        [String]$Identity
    )

    foreach ($Delay in @(15, 30, 60)) {
        Start-Sleep -Seconds $Delay
        $Mailbox = Get-Mailbox -Identity $Identity -ErrorAction SilentlyContinue
        if ($Mailbox) {
            return $Mailbox
        }
        Write-Host "[WAITING_PROPAGATION] Shared mailbox not visible yet after $Delay seconds: $Identity" -ForegroundColor Yellow
    }

    return $null
}

$CSVPath = Join-Path $MTXDir "MTX-MAILBOXES.csv"
if (-not (Test-Path -LiteralPath $CSVPath)) {
    throw "MTX-MAILBOXES.csv not found at $CSVPath"
}

$Mailboxes = @(Import-Csv $CSVPath)
$RequiredColumns = @("MailboxID", "DisplayName", "Alias", "TargetAddress", "Department", "Purpose", "OwnerUPN", "Enabled")
$Columns = @($Mailboxes | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name -Unique)
$MissingColumns = @($RequiredColumns | Where-Object { $_ -notin $Columns })
if ($MissingColumns.Count -gt 0) {
    throw "MTX-MAILBOXES.csv missing required column(s): $($MissingColumns -join ', ')"
}

foreach ($MBX in $Mailboxes) {
    if ($MBX.Enabled -ne "True") {
        Write-Host "[SKIPPED] Disabled mailbox row: $($MBX.MailboxID) $($MBX.TargetAddress)" -ForegroundColor Yellow
        continue
    }

    $Address = $MBX.TargetAddress
    $Alias = $MBX.Alias
    $OwnerUPN = $MBX.OwnerUPN
    $MailboxProtection = Assert-LabNotProtectedObject -InputObject $MBX -ObjectType "SharedMailbox" -ObjectName $Address -AttemptedAction "Create or update shared mailbox"
    if ($MailboxProtection.IsProtected) {
        Write-Host "[$($MailboxProtection.State)] $($MailboxProtection.Reason)" -ForegroundColor Yellow
        continue
    }

    $OwnerProtection = Assert-LabNotProtectedObject -InputObject ([PSCustomObject]@{ UserPrincipalName = $OwnerUPN }) -ObjectType "MailboxOwner" -ObjectName $OwnerUPN -AttemptedAction "Reference mailbox owner"
    Write-Host "Processing Shared Mailbox: $Address [Owner: $OwnerUPN]" -NoNewline
    if ($OwnerProtection.IsProtected) {
        Write-Host " [PROTECTED OWNER: no owner mutation]" -NoNewline
    }

    if ($DryRun) {
        Write-Host " [DRY-RUN: verify, create if missing, update safe mailbox fields if required]" -ForegroundColor Gray
        continue
    }

    $ExistingMBX = Get-Mailbox -Identity $Address -ErrorAction SilentlyContinue
    if (-not $ExistingMBX) {
        [void](Assert-LabNotProtectedObject -InputObject $MBX -ObjectType "SharedMailbox" -ObjectName $Address -AttemptedAction "Create shared mailbox" -ThrowOnProtected)
        New-Mailbox -Shared -Name $MBX.DisplayName -Alias $Alias -PrimarySmtpAddress $Address
        Write-Host " [CREATED]" -ForegroundColor Green
        $ExistingMBX = Wait-LabMailboxAvailable -Identity $Address
        if (-not $ExistingMBX) {
            Write-Host "[BLOCKED] Shared mailbox was created but did not become visible within bounded polling: $Address" -ForegroundColor Red
            continue
        }
    } else {
        Write-Host " [EXISTS]" -ForegroundColor Yellow
    }

    if ($ExistingMBX.DisplayName -ne $MBX.DisplayName) {
        [void](Assert-LabNotProtectedObject -InputObject $ExistingMBX -ObjectType "SharedMailbox" -ObjectName $Address -AttemptedAction "Update shared mailbox display name" -ThrowOnProtected)
        Set-Mailbox -Identity $Address -DisplayName $MBX.DisplayName
        Write-Host "[UPDATED] DisplayName set for $Address" -ForegroundColor Green
    }

    if (-not [string]::IsNullOrWhiteSpace($MBX.Department)) {
        [void](Assert-LabNotProtectedObject -InputObject $ExistingMBX -ObjectType "SharedMailbox" -ObjectName $Address -AttemptedAction "Update shared mailbox department" -ThrowOnProtected)
        Set-User -Identity $Address -Department $MBX.Department
        Write-Host "[UPDATED] Department set for $Address" -ForegroundColor Green
    }
}

Write-Host "Shared mailbox processing completed. No mailbox deletion or owner mutation performed." -ForegroundColor Cyan
