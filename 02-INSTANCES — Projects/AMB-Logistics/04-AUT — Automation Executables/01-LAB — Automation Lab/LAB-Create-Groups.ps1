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

function ConvertTo-LabBoolean {
    Param([String]$Value)
    return [System.Convert]::ToBoolean($Value)
}

function Escape-LabODataString {
    Param([String]$Value)
    return $Value.Replace("'", "''")
}

$CSVPath = Join-Path $MTXDir "MTX-GROUPS.csv"
if (-not (Test-Path -LiteralPath $CSVPath)) {
    throw "MTX-GROUPS.csv not found at $CSVPath"
}

$Groups = @(Import-Csv $CSVPath)
$RequiredColumns = @("GroupID", "DisplayName", "GroupType", "MailNickname", "PrimarySMTP", "Department", "OwnerUPN", "MailEnabled", "SecurityEnabled", "Description")
$Columns = @($Groups | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name -Unique)
$MissingColumns = @($RequiredColumns | Where-Object { $_ -notin $Columns })
if ($MissingColumns.Count -gt 0) {
    throw "MTX-GROUPS.csv missing required column(s): $($MissingColumns -join ', ')"
}

foreach ($Group in $Groups) {
    $Name = $Group.DisplayName
    $GroupKind = $Group.GroupType
    $MailNickname = $Group.MailNickname
    $OwnerUPN = $Group.OwnerUPN
    $MailEnabled = ConvertTo-LabBoolean $Group.MailEnabled
    $SecurityEnabled = ConvertTo-LabBoolean $Group.SecurityEnabled
    $GroupProtection = Assert-LabNotProtectedObject -InputObject $Group -ObjectType "Group" -ObjectName $Name -AttemptedAction "Create or update group"
    if ($GroupProtection.IsProtected) {
        Write-Host "[$($GroupProtection.State)] $($GroupProtection.Reason)" -ForegroundColor Yellow
        continue
    }

    $OwnerProtection = Assert-LabNotProtectedObject -InputObject ([PSCustomObject]@{ UserPrincipalName = $OwnerUPN }) -ObjectType "GroupOwner" -ObjectName $OwnerUPN -AttemptedAction "Add explicit group owner"
    Write-Host "Processing Group: $Name [$GroupKind] [Alias: $MailNickname] [Owner: $OwnerUPN]" -NoNewline
    if ($OwnerProtection.IsProtected) {
        Write-Host " [PROTECTED OWNER: explicit non-destructive add allowed]" -NoNewline
    }

    if ($DryRun) {
        Write-Host " [DRY-RUN: verify, create if missing, add owner if missing]" -ForegroundColor Gray
        continue
    }

    $EscapedName = Escape-LabODataString $Name
    $EscapedNickname = Escape-LabODataString $MailNickname
    $ExistingGroup = @(Get-MgGroup -Filter "displayName eq '$EscapedName' or mailNickname eq '$EscapedNickname'" -ErrorAction SilentlyContinue | Select-Object -First 1)

    if ($ExistingGroup.Count -eq 0) {
        [void](Assert-LabNotProtectedObject -InputObject $Group -ObjectType "Group" -ObjectName $Name -AttemptedAction "Create group" -ThrowOnProtected)
        $NewGroupParams = @{
            DisplayName     = $Name
            MailNickname    = $MailNickname
            MailEnabled     = $MailEnabled
            SecurityEnabled = $SecurityEnabled
            Description     = $Group.Description
        }
        if ($GroupKind -in @("Microsoft365", "M365Group", "Team")) {
            $NewGroupParams["GroupTypes"] = @("Unified")
        }
        $ExistingGroup = New-MgGroup @NewGroupParams
        Write-Host " [CREATED]" -ForegroundColor Green
    } else {
        $ExistingGroup = $ExistingGroup[0]
        $UpdateBody = @{}
        if ($ExistingGroup.Description -ne $Group.Description) { $UpdateBody["Description"] = $Group.Description }
        if ($UpdateBody.Count -gt 0) {
            [void](Assert-LabNotProtectedObject -InputObject $ExistingGroup -ObjectType "Group" -ObjectName $Name -AttemptedAction "Update safe group fields" -ThrowOnProtected)
            Update-MgGroup -GroupId $ExistingGroup.Id @UpdateBody
            Write-Host " [UPDATED: safe fields]" -ForegroundColor Green
        } else {
            Write-Host " [SKIPPED: group already correct]" -ForegroundColor Yellow
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($OwnerUPN)) {
        $OwnerUser = Get-MgUser -UserId $OwnerUPN -ErrorAction SilentlyContinue
        if ($null -eq $OwnerUser) {
            Write-Host "[BLOCKED] Owner UPN not found: $OwnerUPN" -ForegroundColor Red
            continue
        }

        $ExistingOwners = @(Get-MgGroupOwner -GroupId $ExistingGroup.Id -All -ErrorAction SilentlyContinue | Where-Object { $_.Id -eq $OwnerUser.Id })
        if ($ExistingOwners.Count -gt 0) {
            Write-Host "[SKIPPED] Owner already present: $OwnerUPN" -ForegroundColor Yellow
            continue
        }

        [void](Assert-LabNotProtectedObject -InputObject $ExistingGroup -ObjectType "Group" -ObjectName $Name -AttemptedAction "Add group owner" -ThrowOnProtected)
        New-MgGroupOwnerByRef -GroupId $ExistingGroup.Id -OdataId "https://graph.microsoft.com/v1.0/directoryObjects/$($OwnerUser.Id)"
        Write-Host "[UPDATED] Owner added: $OwnerUPN" -ForegroundColor Green
    }
}

Write-Host "Group processing completed. No owners or members removed." -ForegroundColor Cyan
