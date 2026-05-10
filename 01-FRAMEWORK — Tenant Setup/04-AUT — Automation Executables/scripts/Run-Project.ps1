param(
    [string]$ProjectName,
    [string]$ProjectPath,
    [switch]$Execute
)

$BasePath = "..\..\..\02-INSTANCES — Projects"

Write-Host "=== PROJECT DEPLOY RUNNER ==="

# -----------------------------
# 1. RESOLVE PROJECT
# -----------------------------

if ($ProjectPath) {
    $projectFullPath = Resolve-Path $ProjectPath
}
elseif ($ProjectName) {
    $projectFullPath = Join-Path $BasePath $ProjectName
}
else {
    Write-Host ""
    Write-Host "Available Projects:"
    $projects = Get-ChildItem $BasePath -Directory

    for ($i=0; $i -lt $projects.Count; $i++) {
        Write-Host "[$i] $($projects[$i].Name)"
    }

    $selection = Read-Host "Select project number"
    $projectFullPath = $projects[$selection].FullName
}

# -----------------------------
# 2. VALIDATE
# -----------------------------

$mtxPath = Join-Path $projectFullPath "03-MTX — Data Matrices"

if (-not (Test-Path $mtxPath)) {
    throw "❌ Matrix folder not found: $mtxPath"
}

$requiredFiles = @(
    "MTX-USERS.csv",
    "MTX-GROUPS.csv",
    "MTX-MAILBOXES.csv",
    "MTX-PERMISSIONS.csv"
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path (Join-Path $mtxPath $file))) {
        throw "❌ Missing file: $file"
    }
}

Write-Host ""
Write-Host "Project:" $projectFullPath
Write-Host "Matrix:" $mtxPath
Write-Host ""

# -----------------------------
# 3. CONFIRMATION
# -----------------------------

if (-not $Execute) {
    Write-Host "[DRY-RUN MODE]"
    $confirm = Read-Host "Run in EXECUTE mode? (yes/no)"

    if ($confirm -ne "yes") {
        Write-Host "Cancelled."
        exit
    }
}

# -----------------------------
# 4. EXECUTE DEPLOY
# -----------------------------

Write-Host "Starting deployment..."

.\Deploy-Tenant.ps1 -ProjectPath $mtxPath -Execute

Write-Host "DONE"