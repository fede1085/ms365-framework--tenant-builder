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

$CSVPath = Join-Path $MTXDir "MTX-USERS.csv"
if (-not (Test-Path -LiteralPath $CSVPath)) {
    throw "MTX-USERS.csv not found at $CSVPath"
}

$Users = @(Import-Csv $CSVPath)
$RequiredColumns = @("UserID", "DisplayName", "FirstName", "LastName", "UserPrincipalName", "MailNickname", "Department", "JobTitle", "UsageLocation", "LicenseSKU", "PasswordProfile", "AccountEnabled")
$Columns = @($Users | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name -Unique)
$MissingColumns = @($RequiredColumns | Where-Object { $_ -notin $Columns })
if ($MissingColumns.Count -gt 0) {
    throw "MTX-USERS.csv missing required column(s): $($MissingColumns -join ', ')"
}

foreach ($User in $Users) {
    $UserPrincipalName = $User.UserPrincipalName
    $Protection = Assert-LabNotProtectedObject -InputObject $User -ObjectType "User" -ObjectName $UserPrincipalName -AttemptedAction "Create or update user"
    if ($Protection.IsProtected) {
        Write-Host "[$($Protection.State)] $($Protection.Reason)" -ForegroundColor Yellow
        continue
    }

    Write-Host "Processing User: $UserPrincipalName" -NoNewline

    if ($DryRun) {
        Write-Host " [DRY-RUN: verify, create if missing, update safe fields only if required]" -ForegroundColor Gray
        continue
    }

    $ExistingUser = Get-MgUser -UserId $UserPrincipalName -ErrorAction SilentlyContinue
    if ($ExistingUser) {
        $UpdateBody = @{}
        if ($ExistingUser.DisplayName -ne $User.DisplayName) { $UpdateBody["DisplayName"] = $User.DisplayName }
        if ($ExistingUser.GivenName -ne $User.FirstName) { $UpdateBody["GivenName"] = $User.FirstName }
        if ($ExistingUser.Surname -ne $User.LastName) { $UpdateBody["Surname"] = $User.LastName }
        if ($ExistingUser.MailNickname -ne $User.MailNickname) { $UpdateBody["MailNickname"] = $User.MailNickname }
        if ($ExistingUser.Department -ne $User.Department) { $UpdateBody["Department"] = $User.Department }
        if ($ExistingUser.JobTitle -ne $User.JobTitle) { $UpdateBody["JobTitle"] = $User.JobTitle }
        if ($ExistingUser.UsageLocation -ne $User.UsageLocation) { $UpdateBody["UsageLocation"] = $User.UsageLocation }

        if ($UpdateBody.Count -eq 0) {
            Write-Host " [SKIPPED: already correct]" -ForegroundColor Yellow
            continue
        }

        [void](Assert-LabNotProtectedObject -InputObject $ExistingUser -ObjectType "User" -ObjectName $UserPrincipalName -AttemptedAction "Update safe user fields" -ThrowOnProtected)
        Update-MgUser -UserId $ExistingUser.Id @UpdateBody
        Write-Host " [UPDATED: safe profile fields only; password/license/account state untouched]" -ForegroundColor Green
        continue
    }

    if ([string]::IsNullOrWhiteSpace($User.PasswordProfile)) {
        Write-Host " [BLOCKED: Missing PasswordProfile for new user]" -ForegroundColor Red
        continue
    }

    [void](Assert-LabNotProtectedObject -InputObject $User -ObjectType "User" -ObjectName $UserPrincipalName -AttemptedAction "Create user" -ThrowOnProtected)
    $PasswordProfile = @{
        Password = $User.PasswordProfile
        ForceChangePasswordNextSignIn = $true
    }
    New-MgUser -DisplayName $User.DisplayName `
        -UserPrincipalName $UserPrincipalName `
        -MailNickname $User.MailNickname `
        -AccountEnabled (ConvertTo-LabBoolean $User.AccountEnabled) `
        -PasswordProfile $PasswordProfile `
        -GivenName $User.FirstName `
        -Surname $User.LastName `
        -Department $User.Department `
        -JobTitle $User.JobTitle `
        -UsageLocation $User.UsageLocation

    Write-Host " [CREATED: no license assignment]" -ForegroundColor Green
}

Write-Host "User processing completed. License assignment skipped." -ForegroundColor Cyan
