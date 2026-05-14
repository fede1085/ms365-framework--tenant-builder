<#
LAB / EXPERIMENTAL / NON-CANONICAL
Disposable execution layer
Safe to delete
Not authoritative framework governance
#>

Param(
    [String]$MTXDir,
    [Switch]$DryRun,
    [String]$TenantId,
    [String]$TenantDomain
)

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$ReportsDir = Join-Path $ScriptDir "reports"
$LogsDir = Join-Path $ScriptDir "logs"
$TranscriptsDir = Join-Path $ScriptDir "transcripts"
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$ReportPath = Join-Path $ReportsDir "LAB-Validation-Report-$Timestamp.md"
$SummaryPath = Join-Path $ReportsDir "LAB-Validation-Summary-$Timestamp.json"
$LogPath = Join-Path $LogsDir "LAB-Validation-Summary-$Timestamp.log"
$TranscriptPath = Join-Path $TranscriptsDir "LAB-Validation-Transcript-$Timestamp.log"

foreach ($Directory in @($ReportsDir, $LogsDir, $TranscriptsDir)) {
    if (-not (Test-Path -LiteralPath $Directory)) {
        New-Item -ItemType Directory -Path $Directory | Out-Null
    }
}

$TranscriptStarted = $false
try {
    Start-Transcript -Path $TranscriptPath -Force | Out-Null
    $TranscriptStarted = $true

    Write-Host "`n============================================================" -ForegroundColor Cyan
    Write-Host "LAB VALIDATION REPORT - AMB LOGISTICS" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan

    $ValidationRecords = New-Object System.Collections.Generic.List[Object]
    $FailedCount = 0
    $WarningCount = 0
    $WaitingPropagationCount = 0
    $ValidatedCount = 0

    function Add-ValidationRecord {
        Param(
            [Parameter(Mandatory=$true)][String]$Status,
            [Parameter(Mandatory=$true)][String]$Scope,
            [Parameter(Mandatory=$true)][String]$Message,
            [String]$Reference = ""
        )

        $script:ValidationRecords.Add([PSCustomObject]@{
            Status    = $Status
            Scope     = $Scope
            Message   = $Message
            Reference = $Reference
        })

        switch ($Status) {
            "FAILED" {
                $script:FailedCount++
                Write-Host "[FAILED] $Scope - $Message" -ForegroundColor Red
            }
            "WARNING" {
                $script:WarningCount++
                Write-Host "[WARNING] $Scope - $Message" -ForegroundColor Yellow
            }
            "WAITING_PROPAGATION" {
                $script:WaitingPropagationCount++
                Write-Host "[WAITING_PROPAGATION] $Scope - $Message" -ForegroundColor Yellow
            }
            "VALIDATING_RESULT" {
                $script:ValidatedCount++
                Write-Host "[VALIDATING_RESULT] $Scope - $Message" -ForegroundColor Cyan
            }
            default {
                Write-Host "[$Status] $Scope - $Message"
            }
        }
    }

    # Semantic MTX identifiers such as UserID, GroupID, and MailboxID remain
    # internal traceability keys. Runtime execution uses UPN, SMTP, alias, and
    # boolean group settings so LAB behavior aligns with execution schemas.
    $MatrixSchemas = @{
        "MTX-USERS.csv"       = @("UserID", "DisplayName", "FirstName", "LastName", "UserPrincipalName", "MailNickname", "Department", "JobTitle", "UsageLocation", "LicenseSKU", "PasswordProfile", "AccountEnabled")
        "MTX-GROUPS.csv"      = @("GroupID", "DisplayName", "GroupType", "MailNickname", "PrimarySMTP", "Department", "OwnerUPN", "MailEnabled", "SecurityEnabled", "Description")
        "MTX-MAILBOXES.csv"   = @("MailboxID", "DisplayName", "Alias", "TargetAddress", "Department", "OwnerUPN", "Purpose")
        "MTX-PERMISSIONS.csv" = @("PermissionID", "ObjectType", "ObjectName", "TargetAddress", "UserUPN", "AccessType", "RoleScope", "Enabled")
        "MTX-LICENSES.csv"    = @("LicenseID", "UserID", "SKU", "Status")
    }

    $MatrixData = @{}
    foreach ($MatrixName in $MatrixSchemas.Keys) {
        $MatrixPath = Join-Path $MTXDir $MatrixName
        if (-not (Test-Path -LiteralPath $MatrixPath)) {
            Add-ValidationRecord -Status "FAILED" -Scope $MatrixName -Message "Matrix file not found." -Reference $MatrixPath
            continue
        }

        $Rows = Import-Csv $MatrixPath
        $Columns = @($Rows | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name -Unique)
        $MissingColumns = @($MatrixSchemas[$MatrixName] | Where-Object { $_ -notin $Columns })
        if ($MissingColumns.Count -gt 0) {
            Add-ValidationRecord -Status "FAILED" -Scope $MatrixName -Message "Missing required column(s): $($MissingColumns -join ', ')." -Reference $MatrixPath
            continue
        }

        $MatrixData[$MatrixName] = $Rows
        Add-ValidationRecord -Status "VALIDATING_RESULT" -Scope $MatrixName -Message "Schema present; row count $($Rows.Count)." -Reference $MatrixPath
    }

    if ($FailedCount -eq 0) {
        $UserIDs = @{}
        $UserUPNs = @{}
        $GroupIDs = @{}
        $GroupNames = @{}
        $GroupPrimarySMTPs = @{}
        $MailboxIDs = @{}
        $MailboxAddresses = @{}

        foreach ($User in $MatrixData["MTX-USERS.csv"]) {
            $UserIDs[$User.UserID] = $true
            $UserUPNs[$User.UserPrincipalName] = $true
        }
        foreach ($Group in $MatrixData["MTX-GROUPS.csv"]) {
            $GroupIDs[$Group.GroupID] = $true
            $GroupNames[$Group.DisplayName] = $true
            if (-not [string]::IsNullOrWhiteSpace($Group.PrimarySMTP)) {
                $GroupPrimarySMTPs[$Group.PrimarySMTP] = $true
            }
        }
        foreach ($Mailbox in $MatrixData["MTX-MAILBOXES.csv"]) {
            $MailboxIDs[$Mailbox.MailboxID] = $true
            $MailboxAddresses[$Mailbox.TargetAddress] = $true
        }

        foreach ($Group in $MatrixData["MTX-GROUPS.csv"]) {
            if (-not $UserUPNs.ContainsKey($Group.OwnerUPN)) {
                Add-ValidationRecord -Status "WARNING" -Scope $Group.GroupID -Message "Group owner UPN does not resolve to MTX-USERS UserPrincipalName: $($Group.OwnerUPN)." -Reference "MTX-GROUPS.csv"
            }
            if ($Group.GroupType -notin @("Microsoft365", "Security")) {
                Add-ValidationRecord -Status "WARNING" -Scope $Group.GroupID -Message "GroupType should be Microsoft365 or Security: $($Group.GroupType)." -Reference "MTX-GROUPS.csv"
            }
            if ($Group.MailEnabled -notin @("True", "False")) {
                Add-ValidationRecord -Status "WARNING" -Scope $Group.GroupID -Message "MailEnabled must be True or False: $($Group.MailEnabled)." -Reference "MTX-GROUPS.csv"
            }
            if ($Group.SecurityEnabled -notin @("True", "False")) {
                Add-ValidationRecord -Status "WARNING" -Scope $Group.GroupID -Message "SecurityEnabled must be True or False: $($Group.SecurityEnabled)." -Reference "MTX-GROUPS.csv"
            }
            if ($Group.MailEnabled -eq "True" -and [string]::IsNullOrWhiteSpace($Group.PrimarySMTP)) {
                Add-ValidationRecord -Status "WARNING" -Scope $Group.GroupID -Message "Mail-enabled group has no PrimarySMTP." -Reference "MTX-GROUPS.csv"
            }
        }

        foreach ($Mailbox in $MatrixData["MTX-MAILBOXES.csv"]) {
            if (-not $UserUPNs.ContainsKey($Mailbox.OwnerUPN)) {
                Add-ValidationRecord -Status "WARNING" -Scope $Mailbox.MailboxID -Message "Mailbox owner UPN does not resolve to MTX-USERS UserPrincipalName: $($Mailbox.OwnerUPN)." -Reference "MTX-MAILBOXES.csv"
            }
            if ([string]::IsNullOrWhiteSpace($Mailbox.TargetAddress)) {
                Add-ValidationRecord -Status "WARNING" -Scope $Mailbox.MailboxID -Message "TargetAddress is empty." -Reference "MTX-MAILBOXES.csv"
            }
        }

        foreach ($Permission in $MatrixData["MTX-PERMISSIONS.csv"]) {
            if (-not $UserUPNs.ContainsKey($Permission.UserUPN)) {
                Add-ValidationRecord -Status "WARNING" -Scope $Permission.PermissionID -Message "Permission UserUPN does not resolve to MTX-USERS UserPrincipalName: $($Permission.UserUPN)." -Reference "MTX-PERMISSIONS.csv"
            }

            $TargetIsKnown = $MailboxAddresses.ContainsKey($Permission.TargetAddress) -or $GroupPrimarySMTPs.ContainsKey($Permission.TargetAddress) -or $GroupNames.ContainsKey($Permission.ObjectName)
            if (-not $TargetIsKnown) {
                Add-ValidationRecord -Status "WARNING" -Scope $Permission.PermissionID -Message "Permission target does not resolve to mailbox TargetAddress, group PrimarySMTP, or group DisplayName: $($Permission.TargetAddress)." -Reference "MTX-PERMISSIONS.csv"
            }

            if ($Permission.Enabled -notin @("True", "False")) {
                Add-ValidationRecord -Status "WARNING" -Scope $Permission.PermissionID -Message "Enabled must be True or False: $($Permission.Enabled)." -Reference "MTX-PERMISSIONS.csv"
            }
        }

        foreach ($License in $MatrixData["MTX-LICENSES.csv"]) {
            if (-not $UserIDs.ContainsKey($License.UserID)) {
                Add-ValidationRecord -Status "WARNING" -Scope $License.LicenseID -Message "License UserID does not resolve to semantic MTX-USERS UserID: $($License.UserID)." -Reference "MTX-LICENSES.csv"
            }
        }

        # Propagation-aware validation state is recorded without live polling,
        # tenant calls, retries, or loops. LAB remains human-supervised.
        Add-ValidationRecord -Status "WAITING_PROPAGATION" -Scope "TenantDrift" -Message "Live tenant drift validation intentionally not executed in LAB hardening mode." -Reference "AUT-OPS-001"
    }

    $Counts = [PSCustomObject]@{
        Users       = if ($MatrixData.ContainsKey("MTX-USERS.csv")) { $MatrixData["MTX-USERS.csv"].Count } else { 0 }
        Groups      = if ($MatrixData.ContainsKey("MTX-GROUPS.csv")) { $MatrixData["MTX-GROUPS.csv"].Count } else { 0 }
        Mailboxes   = if ($MatrixData.ContainsKey("MTX-MAILBOXES.csv")) { $MatrixData["MTX-MAILBOXES.csv"].Count } else { 0 }
        Permissions = if ($MatrixData.ContainsKey("MTX-PERMISSIONS.csv")) { $MatrixData["MTX-PERMISSIONS.csv"].Count } else { 0 }
        Licenses    = if ($MatrixData.ContainsKey("MTX-LICENSES.csv")) { $MatrixData["MTX-LICENSES.csv"].Count } else { 0 }
    }

    $OverallStatus = if ($FailedCount -gt 0) { "FAILED" } elseif ($WarningCount -gt 0) { "WARNING" } else { "VALIDATING_RESULT" }
    $Summary = [PSCustomObject]@{
        Project                = "AMB Logistics"
        GeneratedAt            = (Get-Date).ToString("o")
        Mode                   = if ($DryRun) { "DRY-RUN" } else { "VALIDATION-ONLY" }
        OverallStatus          = $OverallStatus
        Failed                 = $FailedCount
        Warning                = $WarningCount
        WaitingPropagation     = $WaitingPropagationCount
        ValidatingResult       = $ValidatedCount
        Counts                 = $Counts
        Reports                = [PSCustomObject]@{
            Markdown   = $ReportPath
            Json       = $SummaryPath
            Log        = $LogPath
            Transcript = $TranscriptPath
        }
        Records                = @($ValidationRecords)
    }

    $ReportLines = @(
        "# LAB Validation Report - AMB Logistics",
        "",
        "- Generated: $($Summary.GeneratedAt)",
        "- Mode: $($Summary.Mode)",
        "- OverallStatus: $OverallStatus",
        "- Failed: $FailedCount",
        "- Warning: $WarningCount",
        "- WaitingPropagation: $WaitingPropagationCount",
        "- ValidatingResult: $ValidatedCount",
        "",
        "## Target Counts",
        "",
        "| Matrix | Count |",
        "| --- | ---: |",
        "| Users | $($Counts.Users) |",
        "| Groups | $($Counts.Groups) |",
        "| Mailboxes | $($Counts.Mailboxes) |",
        "| Permissions | $($Counts.Permissions) |",
        "| Licenses | $($Counts.Licenses) |",
        "",
        "## Validation Records",
        "",
        "| Status | Scope | Message | Reference |",
        "| --- | --- | --- | --- |"
    )

    foreach ($Record in $ValidationRecords) {
        $ReportLines += "| $($Record.Status) | $($Record.Scope) | $($Record.Message -replace '\|','/') | $($Record.Reference) |"
    }

    $ReportLines += @(
        "",
        "## LAB Boundary",
        "",
        "Validation is schema and relationship only. No tenant connection, production retry, infinite loop, or execution simulation is performed by this report."
    )

    $ReportLines | Set-Content -Path $ReportPath -Encoding UTF8
    $Summary | ConvertTo-Json -Depth 6 | Set-Content -Path $SummaryPath -Encoding UTF8
    @(
        "GeneratedAt=$($Summary.GeneratedAt)",
        "Mode=$($Summary.Mode)",
        "OverallStatus=$OverallStatus",
        "Failed=$FailedCount",
        "Warning=$WarningCount",
        "WaitingPropagation=$WaitingPropagationCount",
        "ValidatingResult=$ValidatedCount",
        "Report=$ReportPath",
        "Summary=$SummaryPath",
        "Transcript=$TranscriptPath"
    ) | Set-Content -Path $LogPath -Encoding UTF8

    Write-Host ""
    Write-Host "Target User Count:        $($Counts.Users)"
    Write-Host "Target Group Count:       $($Counts.Groups)"
    Write-Host "Target Mailbox Count:     $($Counts.Mailboxes)"
    Write-Host "Target Permission Count:  $($Counts.Permissions)"
    Write-Host "Target License Count:     $($Counts.Licenses)"
    Write-Host ""
    Write-Host "Report:     $ReportPath"
    Write-Host "Summary:    $SummaryPath"
    Write-Host "Log:        $LogPath"
    Write-Host "Transcript: $TranscriptPath"
    Write-Host ""
    Write-Host "Status: $OverallStatus" -ForegroundColor Cyan
}
finally {
    if ($TranscriptStarted) {
        Stop-Transcript | Out-Null
    }
}
