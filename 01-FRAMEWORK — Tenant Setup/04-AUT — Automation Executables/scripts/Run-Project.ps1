param(
    [string]$ProjectName,
    [string]$ProjectPath,

    [string]$TenantId,
    [string]$TenantDomain,

    [string]$EnvironmentName = "PROD",

    [switch]$Execute,

    [switch]$IncludeTeams,

    [switch]$IncludeSharePoint,

    [string]$SharePointAdminUrl
)

$ErrorActionPreference = "Stop"

$BasePath = "..\..\..\02-INSTANCES — Projects"

$OrchestrationMode = if ($Execute) {
    "EXECUTE"
}
else {
    "READ_ONLY / DRY-RUN"
}

Write-Host "=== PROJECT DEPLOY RUNNER ==="
Write-Host "Orchestration Mode:" $OrchestrationMode
Write-Host "Working directory:" (Get-Location)
Write-Host "Expected base path root:" (Resolve-Path "..\..\.." -ErrorAction SilentlyContinue)
Write-Host ""

if ($ProjectPath) {
    $projectFullPath = Resolve-Path $ProjectPath
}
elseif ($ProjectName) {
    $projectFullPath = Join-Path $BasePath $ProjectName
}
else {
    Write-Host "Available Projects:"

    $projects = Get-ChildItem $BasePath -Directory

    for ($i = 0; $i -lt $projects.Count; $i++) {
        Write-Host "[$i] $($projects[$i].Name)"
    }

    $selection = Read-Host "Select project number"
    $projectFullPath = $projects[$selection].FullName
}

$mtxPath = Join-Path `
    $projectFullPath `
    "03-MTX — Data Matrices"

if (-not (Test-Path $mtxPath)) {
    throw "FAILED: Matrix folder not found: $mtxPath"
}

$requiredFiles = @(
    "MTX-USERS.csv",
    "MTX-GROUPS.csv",
    "MTX-MAILBOXES.csv",
    "MTX-PERMISSIONS.csv",
    "MTX-LICENSES.csv"
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path (Join-Path $mtxPath $file))) {
        throw "FAILED: Missing file: $file"
    }
}

Write-Host "=== PROJECT VALIDATION ==="
Write-Host "Project Path :" $projectFullPath
Write-Host "Matrix Path  :" $mtxPath
Write-Host ""

if (-not $TenantId) {
    $TenantId = Read-Host "Tenant ID"
}

if (-not $TenantDomain) {
    $TenantDomain = Read-Host "Tenant Domain"
}

Write-Host "=== TARGET TENANT ==="
Write-Host "Tenant ID      :" $TenantId
Write-Host "Tenant Domain  :" $TenantDomain
Write-Host "Environment    :" $EnvironmentName
Write-Host "Include Teams  :" $(if ($IncludeTeams) { "YES" } else { "NO" })
Write-Host "Include SharePoint:" $(if ($IncludeSharePoint) { "YES" } else { "NO" })
Write-Host ""

$deployScript = Join-Path $PSScriptRoot "Deploy-Tenant.ps1"

if (-not (Test-Path $deployScript)) {
    throw "FAILED: Deploy script not found: $deployScript"
}

if ($Execute) {
    Write-Host "[EXECUTE MODE REQUESTED]"

    $deployParams = @{
        ProjectPath = $mtxPath
        TenantId = $TenantId
        TenantDomain = $TenantDomain
        EnvironmentName = $EnvironmentName
        Execute = $true
    }

    if ($IncludeTeams) {
        $deployParams["IncludeTeams"] = $true
    }

    if ($IncludeSharePoint) {
        $deployParams["IncludeSharePoint"] = $true
    }

    if ($SharePointAdminUrl) {
        $deployParams["SharePointAdminUrl"] = $SharePointAdminUrl
    }

    & $deployScript @deployParams
}
else {
    Write-Host "[READ_ONLY / DRY-RUN MODE]"

    $deployParams = @{
        ProjectPath = $mtxPath
        TenantId = $TenantId
        TenantDomain = $TenantDomain
        EnvironmentName = $EnvironmentName
    }

    if ($IncludeTeams) {
        $deployParams["IncludeTeams"] = $true
    }

    if ($IncludeSharePoint) {
        $deployParams["IncludeSharePoint"] = $true
    }

    if ($SharePointAdminUrl) {
        $deployParams["SharePointAdminUrl"] = $SharePointAdminUrl
    }

    & $deployScript @deployParams

    Write-Host ""
    Write-Host "[STOP] DryRun complete. No execution was started."
    Write-Host "To execute, rerun this command with -Execute after reviewing DryRun output."
}

Write-Host ""
Write-Host "DONE"
