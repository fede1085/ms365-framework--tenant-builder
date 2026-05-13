<#
LAB / EXPERIMENTAL / NON-CANONICAL
Disposable execution layer
Safe to delete
Not authoritative framework governance
#>

Param(
    [Parameter(Mandatory=$true)]
    [String]$ProjectName,

    [Switch]$Execute,
    [String]$TenantId,
    [String]$TenantDomain
)

$Mode = if ($Execute) { "EXECUTION" } else { "DRY-RUN" }
$Header = @(
    "============================================================"
    "AMB LOGISTICS - LAB EXECUTION ORCHESTRATOR"
    "============================================================"
    "Project: $ProjectName"
    "Mode: $Mode"
) -join [Environment]::NewLine

Write-Host $Header -ForegroundColor Cyan

# 1. Target Verification
if ([string]::IsNullOrEmpty($TenantId) -or [string]::IsNullOrEmpty($TenantDomain)) {
    Write-Host "[!] Error: TenantId and TenantDomain must be provided for targeting." -ForegroundColor Red
    return
}

Write-Host ""
Write-Host "[TARGET TENANT]" -ForegroundColor Yellow
Write-Host "TenantId:     $TenantId"
Write-Host "TenantDomain: $TenantDomain"

if ($Execute) {
    $Confirm = Read-Host "Type 'YES' to confirm execution against the target tenant"
    if ($Confirm -ne "YES") {
        Write-Host "Execution cancelled." -ForegroundColor Red
        return
    }
}

# 2. Orchestration
$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$MTXDir = Get-ChildItem -LiteralPath $ProjectRoot -Directory |
    Where-Object { $_.Name -like "03-MTX*" } |
    Select-Object -First 1 -ExpandProperty FullName

if ([string]::IsNullOrEmpty($MTXDir)) {
    Write-Host "[!] Error: MTX data matrix directory not found under $ProjectRoot" -ForegroundColor Red
    return
}

Write-Host ""
Write-Host "[STARTING DEPLOYMENT ORCHESTRATION]" -ForegroundColor Green

$DeployParams = @{
    MTXDir       = $MTXDir
    DryRun       = (-not $Execute)
    TenantId     = $TenantId
    TenantDomain = $TenantDomain
}

& "$ScriptDir\LAB-Deploy-Tenant.ps1" @DeployParams

Write-Host ""
Write-Host "[ORCHESTRATION COMPLETE]" -ForegroundColor Cyan
