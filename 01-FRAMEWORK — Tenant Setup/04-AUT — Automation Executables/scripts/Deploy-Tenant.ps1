param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,

    [Parameter(Mandatory=$true)]
    [string]$TenantId,

    [Parameter(Mandatory=$true)]
    [string]$TenantDomain,

    [string]$EnvironmentName = "PROD",

    [switch]$Execute,

    [switch]$IncludeTeams,

    [switch]$IncludeSharePoint,

    [string]$SharePointAdminUrl
)

$ErrorActionPreference = "Stop"

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProtectedHelper = Join-Path $ScriptRoot "AUT-Protected-Objects.ps1"

if (Test-Path $ProtectedHelper) {
    . $ProtectedHelper
}
else {
    throw "FAILED: Protected-object helper not found: $ProtectedHelper"
}

$ProtectedObjects = Get-AutProtectedObjects
$BlockedCount = 0
$CreatedCount = 0
$PlannedCount = 0
$SkippedCount = 0
$SkippedProtectedCount = 0
$WarningCount = 0
$FailedCount = 0
$UnsupportedFutureCount = 0

function Write-AutState {
    param(
        [Parameter(Mandatory=$true)]
        [string]$State,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    switch ($State) {
        "COMPLETED" { $script:CreatedCount++ }
        "SKIPPED" { $script:SkippedCount++ }
        "SKIPPED_PROTECTED" { $script:SkippedProtectedCount++ }
        "BLOCKED" { $script:BlockedCount++ }
        "WARNING" {
            $script:WarningCount++
            if ($Message -match "FUTURE_NOT_IMPLEMENTED|UNSUPPORTED_IN_GLOBAL_BASELINE") {
                $script:UnsupportedFutureCount++
            }
        }
        "FAILED" { $script:FailedCount++ }
    }

    Write-Host "[$State] $Message"
}

function Write-AutBlocked {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-AutState "BLOCKED" $Message
}

function Write-AutPlanned {
    param(
        [Parameter(Mandatory=$true)]
        [string]$State,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    $script:PlannedCount++
    Write-AutState $State $Message
}

function Write-AutSummary {
    param(
        [int]$LicenseRows
    )

    Write-Host ""
    Write-Host "=== AUT EXECUTION SUMMARY ==="
    Write-Host "created/planned              : $CreatedCount / $PlannedCount"
    Write-Host "skipped                      : $SkippedCount"
    Write-Host "skipped protected            : $SkippedProtectedCount"
    Write-Host "blocked                      : $BlockedCount"
    Write-Host "warnings                     : $WarningCount"
    Write-Host "failed                       : $FailedCount"
    Write-Host "unsupported future actions   : $UnsupportedFutureCount"
    Write-Host "license rows loaded only     : $LicenseRows"
    Write-Host "license assignments performed: 0"
    Write-Host ""
}

function Get-AutProjectRoot {
    param(
        [Parameter(Mandatory=$true)]
        [string]$RuntimeProjectPath
    )

    $resolved = Resolve-Path $RuntimeProjectPath
    $leaf = Split-Path $resolved -Leaf

    if ($leaf -eq "03-MTX — Data Matrices") {
        return Split-Path $resolved -Parent
    }

    return $resolved.Path
}

function Import-AutTenantProtectedObjects {
    param(
        [Parameter(Mandatory=$true)]
        [string]$RuntimeProjectPath,

        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects
    )

    $projectRoot = Get-AutProjectRoot -RuntimeProjectPath $RuntimeProjectPath
    $loaded = $false

    $candidatePs1Files = @(
        (Join-Path $projectRoot "04-AUT — Automation Executables/01-LAB — Automation Lab/LAB-Protected-Objects.ps1"),
        (Join-Path $projectRoot "04-AUT — Automation Executables/Protected-Objects.ps1")
    )

    foreach ($candidate in $candidatePs1Files) {
        if (-not (Test-Path $candidate)) {
            continue
        }

        Write-AutState "READY" "Loading tenant-local protected-object rules: $candidate"
        . $candidate

        if (Get-Command Get-TenantProtectedObjects -ErrorAction SilentlyContinue) {
            Add-AutProtectedObjectValues -ProtectedObjects $ProtectedObjects -Values (Get-TenantProtectedObjects)
            $loaded = $true
        }
        elseif (Get-Variable -Name TenantProtectedObjects -Scope Local -ErrorAction SilentlyContinue) {
            Add-AutProtectedObjectValues -ProtectedObjects $ProtectedObjects -Values $TenantProtectedObjects
            $loaded = $true
        }
        elseif (Get-Variable -Name AutTenantProtectedObjects -Scope Local -ErrorAction SilentlyContinue) {
            Add-AutProtectedObjectValues -ProtectedObjects $ProtectedObjects -Values $AutTenantProtectedObjects
            $loaded = $true
        }
        else {
            Write-AutState "WARNING" "Tenant protected-object script did not expose Get-TenantProtectedObjects, TenantProtectedObjects, or AutTenantProtectedObjects"
        }
    }

    $candidateCsv = Join-Path $projectRoot "03-MTX — Data Matrices/MTX-PROTECTED-OBJECTS.csv"

    if (Test-Path $candidateCsv) {
        Write-AutState "READY" "Loading tenant-local protected-object CSV: $candidateCsv"
        Import-AutProtectedObjectsCsv -Path $candidateCsv -ProtectedObjects $ProtectedObjects
        $loaded = $true
    }

    if (-not $loaded) {
        Write-AutState "WARNING" "No tenant-local protected-object override found; using framework placeholder protected objects"
    }
}

function New-RandomTenantPassword {
    param([int]$Length = 20)

    $chars = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789!@$%*?-_".ToCharArray()
    $bytes = New-Object byte[] ($Length)

    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)

    return -join ($bytes | ForEach-Object {
        $chars[$_ % $chars.Length]
    })
}

function ConvertTo-AutBool {
    param(
        [AllowNull()]
        [object]$Value,

        [bool]$Default = $false
    )

    if ($null -eq $Value -or $Value.ToString().Trim() -eq "") {
        return $Default
    }

    $text = $Value.ToString().Trim().ToLowerInvariant()

    return @("true", "yes", "1", "y") -contains $text
}

function Add-AutNoteProperty {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Row,

        [Parameter(Mandatory=$true)]
        [string]$Name,

        [AllowNull()]
        [object]$Value
    )

    if ($Row.PSObject.Properties.Name.Contains($Name)) {
        $Row.$Name = $Value
    }
    else {
        $Row | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
    }
}

function Get-AutCsvHeader {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $headerLine = Get-Content -Path $Path -TotalCount 1

    if (-not $headerLine) {
        return @()
    }

    return $headerLine.Split(",") | ForEach-Object { $_.Trim().Trim('"') }
}

function Import-AutCsv {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $rows = @(Import-Csv -Path $Path)
    return $rows
}

function Assert-AutColumns {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter(Mandatory=$true)]
        [object[]]$Rows,

        [Parameter(Mandatory=$true)]
        [string[]]$RequiredColumns,

        [hashtable]$LegacyAliases = @{}
    )

    Write-AutState "VALIDATING" "Checking columns for $Name"

    $headers = @(Get-AutCsvHeader -Path $Path)
    $missing = New-Object System.Collections.Generic.List[string]

    foreach ($column in $RequiredColumns) {
        if ($headers -contains $column) {
            continue
        }

        if ($LegacyAliases.ContainsKey($column)) {
            $legacy = $LegacyAliases[$column]

            if ($headers -contains $legacy) {
                Write-AutState "WARNING" "$Name uses legacy column '$legacy'; mapping to '$column' for this run"

                foreach ($row in $Rows) {
                    Add-AutNoteProperty -Row $row -Name $column -Value $row.$legacy
                }

                continue
            }
        }

        $missing.Add($column)
    }

    if ($missing.Count -gt 0) {
        throw "FAILED: $Name missing required runtime columns: $($missing -join ', ')"
    }

    Write-AutState "READY" "$Name columns validated"
}

function Get-AutUniqueKey {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Row,

        [Parameter(Mandatory=$true)]
        [string[]]$FieldNames
    )

    return ($FieldNames | ForEach-Object {
        $field = $_
        $value = ""

        if ($Row.PSObject.Properties.Name.Contains($field) -and $null -ne $Row.$field) {
            $value = $Row.$field.ToString().Trim().ToLowerInvariant()
        }

        "$field=$value"
    }) -join "|"
}

function Get-AutDisplayKey {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Row,

        [Parameter(Mandatory=$true)]
        [string[]]$FieldNames
    )

    return ($FieldNames | ForEach-Object {
        $field = $_
        $value = "<EMPTY>"

        if ($Row.PSObject.Properties.Name.Contains($field) -and $null -ne $Row.$field -and $Row.$field.ToString().Trim()) {
            $value = $Row.$field.ToString().Trim()
        }

        "$field=$value"
    }) -join ", "
}

function Assert-AutUniqueRows {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [object[]]$Rows,

        [Parameter(Mandatory=$true)]
        [string[]]$FieldNames,

        [Parameter(Mandatory=$true)]
        [string]$LabelField
    )

    Write-AutState "VALIDATING" "Checking uniqueness for $Name: $($FieldNames -join ' + ')"

    $groups = $Rows | Group-Object -Property {
        Get-AutUniqueKey -Row $_ -FieldNames $FieldNames
    }

    foreach ($group in $groups) {
        if ($group.Count -le 1) {
            continue
        }

        $labels = @($group.Group | ForEach-Object {
            if ($_.PSObject.Properties.Name.Contains($LabelField) -and $_.$LabelField) {
                $_.$LabelField
            }
            else {
                "<UNLABELED>"
            }
        })

        $displayKey = Get-AutDisplayKey -Row $group.Group[0] -FieldNames $FieldNames
        Write-AutBlocked "$Name duplicate detected for $displayKey; rows: $($labels -join ', ')"

        foreach ($row in $group.Group) {
            Add-AutNoteProperty -Row $row -Name "AutDuplicateBlocked" -Value $true
        }
    }
}

function Test-AutRowBlocked {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Row
    )

    return (
        ($Row.PSObject.Properties.Name.Contains("AutDuplicateBlocked") -and $Row.AutDuplicateBlocked) -or
        ($Row.PSObject.Properties.Name.Contains("AutValidationBlocked") -and $Row.AutValidationBlocked)
    )
}

function Test-AutRowProtection {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Row,

        [Parameter(Mandatory=$true)]
        [string[]]$Fields,

        [Parameter(Mandatory=$true)]
        [string]$ObjectLabel
    )

    $matches = Test-AutProtectedRow `
        -ProtectedObjects $ProtectedObjects `
        -Row $Row `
        -Fields $Fields

    if ($matches.Count -gt 0) {
        Write-AutState "SKIPPED_PROTECTED" "$ObjectLabel matched protected-object rules: $($matches -join '; ')"
        return $true
    }

    return $false
}

function Assert-AutExecuteAllowed {
    if (-not $Execute) {
        return
    }

    if (-not $TenantId -or -not $TenantDomain) {
        throw "FAILED: Execute mode requires TenantId and TenantDomain"
    }

    Write-Host ""
    Write-Host "=== EXECUTE CONFIRMATION ==="
    Write-Host "Target Tenant ID     : $TenantId"
    Write-Host "Target Tenant Domain : $TenantDomain"
    Write-Host "Environment          : $EnvironmentName"
    Write-Host ""

    $confirmation = Read-Host "Type YES to continue"

    if ($confirmation -ne "YES") {
        throw "FAILED: Deployment cancelled by user."
    }
}

function Connect-AutTenant {
    Write-AutState "VALIDATING" "Connecting to Microsoft Graph and Exchange Online"

    Connect-MgGraph `
        -TenantId $TenantId `
        -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"

    Connect-ExchangeOnline `
        -Organization $TenantDomain

    $context = Get-MgContext

    Write-Host "Connected Tenant ID : $($context.TenantId)"
    Write-Host "Expected Tenant ID  : $TenantId"

    if ($context.TenantId -ne $TenantId) {
        throw "FAILED: Connected tenant does not match expected tenant."
    }

    Write-AutState "READY" "Tenant validation successful"
}

function Test-AutSemanticIdentifier {
    param(
        [AllowNull()]
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    return $Value.ToString().Trim() -match '^ROLE-[A-Z0-9-]+$'
}

function ConvertTo-AutODataLiteral {
    param(
        [AllowNull()]
        [object]$Value
    )

    if ($null -eq $Value) {
        return ""
    }

    return $Value.ToString().Replace("'", "''")
}

function Get-AutSingleMgGroup {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Filter,

        [Parameter(Mandatory=$true)]
        [string]$LookupDescription
    )

    $matches = @(Get-MgGroup -Filter $Filter)

    if ($matches.Count -eq 0) {
        return $null
    }

    if ($matches.Count -gt 1) {
        Write-AutBlocked "Group lookup is ambiguous for $LookupDescription"
        return $null
    }

    return $matches[0]
}

function Resolve-AutPermissionGroup {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Permission,

        [Parameter(Mandatory=$true)]
        [object[]]$Groups
    )

    $targetAddress = $Permission.TargetAddress.ToString().Trim()
    $objectName = $Permission.ObjectName.ToString().Trim()

    if ($targetAddress) {
        $mailFilter = "mail eq '$(ConvertTo-AutODataLiteral $targetAddress)'"
        $group = Get-AutSingleMgGroup -Filter $mailFilter -LookupDescription "TargetAddress/mail '$targetAddress'"

        if ($group) {
            return $group
        }

        $matchingMtxGroups = @($Groups | Where-Object {
            $_.PrimarySMTP -and
            $_.PrimarySMTP.ToString().Trim().ToLowerInvariant() -eq $targetAddress.ToLowerInvariant()
        })

        if ($matchingMtxGroups.Count -eq 1 -and $matchingMtxGroups[0].MailNickname) {
            $mailNickname = $matchingMtxGroups[0].MailNickname.ToString().Trim()
            $nickFilter = "mailNickname eq '$(ConvertTo-AutODataLiteral $mailNickname)'"
            $group = Get-AutSingleMgGroup -Filter $nickFilter -LookupDescription "MTX MailNickname '$mailNickname'"

            if ($group) {
                return $group
            }
        }
        elseif ($matchingMtxGroups.Count -gt 1) {
            Write-AutBlocked "Multiple MTX groups match TargetAddress '$targetAddress'"
            return $null
        }

        $targetAsNicknameFilter = "mailNickname eq '$(ConvertTo-AutODataLiteral $targetAddress)'"
        $group = Get-AutSingleMgGroup -Filter $targetAsNicknameFilter -LookupDescription "TargetAddress/mailNickname '$targetAddress'"

        if ($group) {
            return $group
        }
    }

    if ($objectName) {
        $nameFilter = "displayName eq '$(ConvertTo-AutODataLiteral $objectName)'"
        $group = Get-AutSingleMgGroup -Filter $nameFilter -LookupDescription "ObjectName/displayName '$objectName'"

        if ($group) {
            return $group
        }
    }

    Write-AutBlocked "Group permission row $($Permission.PermissionID) could not resolve target group uniquely"
    return $null
}

function Resolve-AutPermissionUser {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Permission
    )

    $userUpn = $Permission.UserUPN.ToString().Trim()

    if (-not $userUpn) {
        Write-AutBlocked "Permission row $($Permission.PermissionID) has empty UserUPN"
        return $null
    }

    if (Test-AutSemanticIdentifier $userUpn) {
        Write-AutBlocked "UNSUPPORTED_SEMANTIC_IDENTIFIER UserUPN '$userUpn' in permission row $($Permission.PermissionID)"
        return $null
    }

    try {
        return Get-MgUser -UserId $userUpn
    }
    catch {
        Write-AutBlocked "UserUPN could not be resolved for permission row $($Permission.PermissionID): $userUpn"
        return $null
    }
}

function Resolve-AutExistingGroupForCreation {
    param(
        [Parameter(Mandatory=$true)]
        [object]$GroupRow
    )

    $mailNickname = $GroupRow.MailNickname.ToString().Trim()
    $primarySmtp = $GroupRow.PrimarySMTP.ToString().Trim()
    $displayName = $GroupRow.DisplayName.ToString().Trim()

    if ($mailNickname) {
        $group = Get-AutSingleMgGroup `
            -Filter "mailNickname eq '$(ConvertTo-AutODataLiteral $mailNickname)'" `
            -LookupDescription "MailNickname '$mailNickname'"

        if ($group) {
            return $group
        }
    }

    if ($primarySmtp) {
        $group = Get-AutSingleMgGroup `
            -Filter "mail eq '$(ConvertTo-AutODataLiteral $primarySmtp)'" `
            -LookupDescription "PrimarySMTP '$primarySmtp'"

        if ($group) {
            return $group
        }
    }

    if ($displayName) {
        $matches = @(Get-MgGroup -Filter "displayName eq '$(ConvertTo-AutODataLiteral $displayName)'")

        if ($matches.Count -gt 1) {
            Write-AutBlocked "Multiple groups match DisplayName '$displayName'; refusing ambiguous skip/create"
            return $null
        }

        if ($matches.Count -eq 1) {
            return $matches[0]
        }
    }

    return $null
}

function Get-AutNormalizedGroupFlags {
    param(
        [Parameter(Mandatory=$true)]
        [object]$GroupRow
    )

    $groupType = $GroupRow.GroupType.ToString().Trim()
    $mailEnabled = ConvertTo-AutBool -Value $GroupRow.MailEnabled -Default $true
    $securityEnabled = ConvertTo-AutBool -Value $GroupRow.SecurityEnabled -Default $false

    if ($groupType -in @("M365Group", "Unified")) {
        if (-not $mailEnabled) {
            Write-AutState "WARNING" "M365Group '$($GroupRow.DisplayName)' should be MailEnabled=true; normalizing for global baseline"
            $mailEnabled = $true
        }

        if ($securityEnabled) {
            Write-AutState "WARNING" "M365Group '$($GroupRow.DisplayName)' should usually be SecurityEnabled=false; normalizing for global baseline"
            $securityEnabled = $false
        }

        return @{
            GroupTypes = @("Unified")
            MailEnabled = $mailEnabled
            SecurityEnabled = $securityEnabled
        }
    }

    if ($groupType -eq "SecurityGroup") {
        if ($mailEnabled) {
            Write-AutState "WARNING" "SecurityGroup '$($GroupRow.DisplayName)' should be MailEnabled=false; normalizing for global baseline"
            $mailEnabled = $false
        }

        if (-not $securityEnabled) {
            Write-AutState "WARNING" "SecurityGroup '$($GroupRow.DisplayName)' should be SecurityEnabled=true; normalizing for global baseline"
            $securityEnabled = $true
        }

        return @{
            GroupTypes = @()
            MailEnabled = $mailEnabled
            SecurityEnabled = $securityEnabled
        }
    }

    return $null
}

function Test-AutGraphRelationshipExists {
    param(
        [Parameter(Mandatory=$true)]
        [string]$GroupId,

        [Parameter(Mandatory=$true)]
        [string]$UserId,

        [Parameter(Mandatory=$true)]
        [string]$AccessType
    )

    if ($AccessType -eq "Member") {
        $existing = @(Get-MgGroupMember -GroupId $GroupId -All | Where-Object { $_.Id -eq $UserId })
    }
    elseif ($AccessType -eq "Owner") {
        $existing = @(Get-MgGroupOwner -GroupId $GroupId -All | Where-Object { $_.Id -eq $UserId })
    }
    else {
        return $false
    }

    return $existing.Count -gt 0
}

function Add-AutGraphGroupRelationship {
    param(
        [Parameter(Mandatory=$true)]
        [string]$GroupId,

        [Parameter(Mandatory=$true)]
        [string]$UserId,

        [Parameter(Mandatory=$true)]
        [string]$AccessType
    )

    $body = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$UserId"
    }

    if ($AccessType -eq "Member") {
        New-MgGroupMemberByRef -GroupId $GroupId -BodyParameter $body
    }
    elseif ($AccessType -eq "Owner") {
        New-MgGroupOwnerByRef -GroupId $GroupId -BodyParameter $body
    }
    else {
        throw "Unsupported group relationship access type: $AccessType"
    }
}

function Resolve-AutTeamSourceGroup {
    param(
        [Parameter(Mandatory=$true)]
        [object]$TeamRow
    )

    $groupMailNickname = $TeamRow.GroupMailNickname.ToString().Trim()
    $primarySmtp = $TeamRow.PrimarySMTP.ToString().Trim()
    $displayName = $TeamRow.DisplayName.ToString().Trim()

    if ($groupMailNickname) {
        $group = Get-AutSingleMgGroup `
            -Filter "mailNickname eq '$(ConvertTo-AutODataLiteral $groupMailNickname)'" `
            -LookupDescription "Team GroupMailNickname '$groupMailNickname'"

        if ($group) {
            return $group
        }
    }

    if ($primarySmtp) {
        $group = Get-AutSingleMgGroup `
            -Filter "mail eq '$(ConvertTo-AutODataLiteral $primarySmtp)'" `
            -LookupDescription "Team PrimarySMTP '$primarySmtp'"

        if ($group) {
            return $group
        }
    }

    if ($displayName) {
        $matches = @(Get-MgGroup -Filter "displayName eq '$(ConvertTo-AutODataLiteral $displayName)'")

        if ($matches.Count -gt 1) {
            Write-AutBlocked "Multiple groups match Team DisplayName '$displayName'; refusing ambiguous Team creation"
            return $null
        }

        if ($matches.Count -eq 1) {
            return $matches[0]
        }
    }

    Write-AutBlocked "Team row $($TeamRow.TeamID) could not resolve source Microsoft 365 group uniquely"
    return $null
}

function Test-AutUnifiedGroup {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Group,

        [Parameter(Mandatory=$true)]
        [object]$TeamRow
    )

    if ($Group.GroupTypes -contains "Unified") {
        return $true
    }

    Write-AutBlocked "Team row $($TeamRow.TeamID) resolved group '$($Group.DisplayName)' but it is not a Microsoft 365/Unified group"
    return $false
}

function Get-AutExistingTeam {
    param(
        [Parameter(Mandatory=$true)]
        [string]$GroupId
    )

    try {
        return Get-MgGroupTeam -GroupId $GroupId -ErrorAction Stop
    }
    catch {
        return $null
    }
}

function Wait-AutTeamProvisioning {
    param(
        [Parameter(Mandatory=$true)]
        [string]$GroupId,

        [Parameter(Mandatory=$true)]
        [string]$TeamName,

        [int]$MaxAttempts = 10,

        [int]$DelaySeconds = 30
    )

    for ($attempt = 1; $attempt -le $MaxAttempts; $attempt++) {
        $team = Get-AutExistingTeam -GroupId $GroupId

        if ($team) {
            Write-AutState "READY" "Team provisioning validated for $TeamName"
            return $team
        }

        if ($attempt -lt $MaxAttempts) {
            Write-AutState "WAITING_PROPAGATION" "Waiting for Team provisioning $TeamName attempt $attempt/$MaxAttempts"
            Start-Sleep -Seconds $DelaySeconds
        }
    }

    Write-AutState "FAILED" "Team provisioning did not validate within bounded wait for $TeamName"
    return $null
}

function Get-AutTeamChannels {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TeamId
    )

    return @(Get-MgTeamChannel -TeamId $TeamId)
}

function Test-AutTeamChannelExists {
    param(
        [Parameter(Mandatory=$true)]
        [string]$TeamId,

        [Parameter(Mandatory=$true)]
        [string]$ChannelName
    )

    $matches = @(Get-AutTeamChannels -TeamId $TeamId | Where-Object {
        $_.DisplayName -eq $ChannelName
    })

    if ($matches.Count -gt 1) {
        Write-AutBlocked "Multiple Teams channels match '$ChannelName' in TeamId $TeamId"
        return $true
    }

    return $matches.Count -eq 1
}

function Resolve-AutSharePointAdminUrl {
    if ($SharePointAdminUrl) {
        return $SharePointAdminUrl.Trim().TrimEnd("/")
    }

    $domain = $TenantDomain.ToString().Trim().ToLowerInvariant()

    if ($domain -match '^([a-z0-9-]+)\.onmicrosoft\.com$') {
        return "https://$($Matches[1])-admin.sharepoint.com"
    }

    Write-AutBlocked "SharePoint admin URL cannot be safely derived from TenantDomain '$TenantDomain'; supply -SharePointAdminUrl"
    return $null
}

function Connect-AutSharePoint {
    param(
        [Parameter(Mandatory=$true)]
        [string]$AdminUrl
    )

    Write-AutState "VALIDATING" "Connecting to SharePoint Online admin endpoint $AdminUrl"
    Connect-SPOService -Url $AdminUrl
    Write-AutState "READY" "SharePoint admin connection initialized"
}

function Get-AutExistingSharePointSite {
    param(
        [Parameter(Mandatory=$true)]
        [string]$SiteUrl
    )

    try {
        return Get-SPOSite -Identity $SiteUrl -ErrorAction Stop
    }
    catch {
        return $null
    }
}

function Get-AutSharePointTemplate {
    param(
        [Parameter(Mandatory=$true)]
        [string]$SiteType
    )

    if ($SiteType -eq "Communication") {
        return "SITEPAGEPUBLISHING#0"
    }

    if ($SiteType -eq "StandaloneTeamSite") {
        return "STS#3"
    }

    return $null
}

function Ensure-AutPnPConnection {
    param(
        [Parameter(Mandatory=$true)]
        [string]$SiteUrl
    )

    Write-AutState "VALIDATING" "Connecting to SharePoint site for library provisioning $SiteUrl"
    Connect-PnPOnline -Url $SiteUrl -Interactive
}

function Test-AutSharePointLibraryExists {
    param(
        [Parameter(Mandatory=$true)]
        [string]$LibraryName
    )

    try {
        $existing = Get-PnPList -Identity $LibraryName -ErrorAction Stop
        return $null -ne $existing
    }
    catch {
        return $false
    }
}

function Wait-AutSharePointSite {
    param(
        [Parameter(Mandatory=$true)]
        [string]$SiteUrl,

        [int]$MaxAttempts = 10,

        [int]$DelaySeconds = 30
    )

    for ($attempt = 1; $attempt -le $MaxAttempts; $attempt++) {
        $site = Get-AutExistingSharePointSite -SiteUrl $SiteUrl

        if ($site) {
            Write-AutState "READY" "SharePoint site availability validated for $SiteUrl"
            return $site
        }

        if ($attempt -lt $MaxAttempts) {
            Write-AutState "WAITING_PROPAGATION" "Waiting for SharePoint site $SiteUrl attempt $attempt/$MaxAttempts"
            Start-Sleep -Seconds $DelaySeconds
        }
    }

    Write-AutState "FAILED" "SharePoint site did not validate within bounded wait: $SiteUrl"
    return $null
}

Write-Host "=== DEPLOY TENANT ==="
Write-Host "Mode:" $(if ($Execute) { "EXECUTE" } else { "DRY-RUN" })
Write-Host "Tenant ID      :" $TenantId
Write-Host "Tenant Domain  :" $TenantDomain
Write-Host "Environment    :" $EnvironmentName
Write-Host "Project Path   :" $ProjectPath
Write-Host "Include Teams  :" $(if ($IncludeTeams) { "YES" } else { "NO" })
Write-Host "Include SharePoint:" $(if ($IncludeSharePoint) { "YES" } else { "NO" })
Write-Host ""

Write-AutState "VALIDATING" "Checking MTX project path"

if (-not (Test-Path $ProjectPath)) {
    throw "FAILED: ProjectPath not found: $ProjectPath"
}

Import-AutTenantProtectedObjects -RuntimeProjectPath $ProjectPath -ProtectedObjects $ProtectedObjects

$UsersFile       = Join-Path $ProjectPath "MTX-USERS.csv"
$GroupsFile      = Join-Path $ProjectPath "MTX-GROUPS.csv"
$MailboxesFile   = Join-Path $ProjectPath "MTX-MAILBOXES.csv"
$PermissionsFile = Join-Path $ProjectPath "MTX-PERMISSIONS.csv"
$LicensesFile    = Join-Path $ProjectPath "MTX-LICENSES.csv"
$TeamsFile       = Join-Path $ProjectPath "MTX-TEAMS.csv"
$ChannelsFile    = Join-Path $ProjectPath "MTX-CHANNELS.csv"
$SitesFile       = Join-Path $ProjectPath "MTX-SITES.csv"
$LibrariesFile   = Join-Path $ProjectPath "MTX-LIBRARIES.csv"

$RequiredFiles = @(
    $UsersFile,
    $GroupsFile,
    $MailboxesFile,
    $PermissionsFile,
    $LicensesFile
)

if ($IncludeTeams) {
    $RequiredFiles += $TeamsFile
}

if ($IncludeSharePoint) {
    $RequiredFiles += $SitesFile
}

foreach ($file in $RequiredFiles) {
    if (-not (Test-Path $file)) {
        throw "FAILED: Missing MTX file: $file"
    }
}

$Users       = Import-AutCsv -Path $UsersFile
$Groups      = Import-AutCsv -Path $GroupsFile
$Mailboxes   = Import-AutCsv -Path $MailboxesFile
$Permissions = Import-AutCsv -Path $PermissionsFile
$Licenses    = Import-AutCsv -Path $LicensesFile
$Teams       = @()
$Channels    = @()
$Sites       = @()
$Libraries   = @()

if ($IncludeTeams) {
    $Teams = Import-AutCsv -Path $TeamsFile

    if (Test-Path $ChannelsFile) {
        $Channels = Import-AutCsv -Path $ChannelsFile
    }
    else {
        Write-AutState "WARNING" "MTX-CHANNELS.csv not found; Teams channels will not be provisioned"
    }
}

if ($IncludeSharePoint) {
    $Sites = Import-AutCsv -Path $SitesFile

    if (Test-Path $LibrariesFile) {
        $Libraries = Import-AutCsv -Path $LibrariesFile
    }
    else {
        Write-AutState "WARNING" "MTX-LIBRARIES.csv not found; SharePoint libraries will not be provisioned"
    }
}

Assert-AutColumns `
    -Name "MTX-USERS.csv" `
    -Path $UsersFile `
    -Rows $Users `
    -RequiredColumns @(
        "UserPrincipalName",
        "DisplayName",
        "MailNickname",
        "JobTitle",
        "Department",
        "UsageLocation",
        "LicenseSKU",
        "PasswordProfile",
        "AccountEnabled"
    )

Assert-AutColumns `
    -Name "MTX-GROUPS.csv" `
    -Path $GroupsFile `
    -Rows $Groups `
    -RequiredColumns @(
        "DisplayName",
        "MailNickname",
        "PrimarySMTP",
        "GroupType",
        "OwnerUPN",
        "MailEnabled",
        "SecurityEnabled"
    ) `
    -LegacyAliases @{
        DisplayName = "GroupName"
        MailNickname = "Alias"
    }

Assert-AutColumns `
    -Name "MTX-MAILBOXES.csv" `
    -Path $MailboxesFile `
    -Rows $Mailboxes `
    -RequiredColumns @(
        "DisplayName",
        "Alias",
        "TargetAddress",
        "Department",
        "OwnerUPN"
    ) `
    -LegacyAliases @{
        TargetAddress = "Mailbox"
    }

Assert-AutColumns `
    -Name "MTX-PERMISSIONS.csv" `
    -Path $PermissionsFile `
    -Rows $Permissions `
    -RequiredColumns @(
        "PermissionID",
        "ObjectType",
        "ObjectName",
        "TargetAddress",
        "UserUPN",
        "AccessType",
        "RoleScope",
        "Enabled"
    )

if ($IncludeTeams) {
    Assert-AutColumns `
        -Name "MTX-TEAMS.csv" `
        -Path $TeamsFile `
        -Rows $Teams `
        -RequiredColumns @(
            "TeamID",
            "DisplayName",
            "GroupMailNickname",
            "PrimarySMTP",
            "OwnerUPN",
            "Visibility",
            "Enabled"
        )

    Assert-AutUniqueRows -Name "MTX-TEAMS.csv" -Rows $Teams -FieldNames @("TeamID") -LabelField "DisplayName"
    Assert-AutUniqueRows -Name "MTX-TEAMS.csv" -Rows $Teams -FieldNames @("DisplayName") -LabelField "TeamID"
    Assert-AutUniqueRows -Name "MTX-TEAMS.csv" -Rows $Teams -FieldNames @("GroupMailNickname") -LabelField "TeamID"
    Assert-AutUniqueRows -Name "MTX-TEAMS.csv" -Rows $Teams -FieldNames @("PrimarySMTP") -LabelField "TeamID"

    if (Test-Path $ChannelsFile) {
        Assert-AutColumns `
            -Name "MTX-CHANNELS.csv" `
            -Path $ChannelsFile `
            -Rows $Channels `
            -RequiredColumns @(
                "ChannelID",
                "TeamID",
                "TeamDisplayName",
                "ChannelName",
                "ChannelType",
                "Enabled"
            )

        Assert-AutUniqueRows -Name "MTX-CHANNELS.csv" -Rows $Channels -FieldNames @("ChannelID") -LabelField "ChannelName"
        Assert-AutUniqueRows -Name "MTX-CHANNELS.csv" -Rows $Channels -FieldNames @("TeamID", "ChannelName") -LabelField "ChannelID"
        Assert-AutUniqueRows -Name "MTX-CHANNELS.csv" -Rows $Channels -FieldNames @("TeamDisplayName", "ChannelName") -LabelField "ChannelID"
    }
}

if ($IncludeSharePoint) {
    Assert-AutColumns `
        -Name "MTX-SITES.csv" `
        -Path $SitesFile `
        -Rows $Sites `
        -RequiredColumns @(
            "SiteID",
            "SiteName",
            "SiteUrl",
            "SiteType",
            "OwnerUPN",
            "Enabled"
        )

    Assert-AutUniqueRows -Name "MTX-SITES.csv" -Rows $Sites -FieldNames @("SiteID") -LabelField "SiteName"
    Assert-AutUniqueRows -Name "MTX-SITES.csv" -Rows $Sites -FieldNames @("SiteName") -LabelField "SiteID"
    Assert-AutUniqueRows -Name "MTX-SITES.csv" -Rows $Sites -FieldNames @("SiteUrl") -LabelField "SiteID"

    foreach ($site in $Sites) {
        $siteType = $site.SiteType.ToString().Trim()

        if ($siteType -notin @("TeamBacked", "Communication", "StandaloneTeamSite")) {
            Write-AutBlocked "MTX-SITES.csv row $($site.SiteID) has unsupported SiteType '$siteType'"
            Add-AutNoteProperty -Row $site -Name "AutValidationBlocked" -Value $true
        }
    }

    if (Test-Path $LibrariesFile) {
        Assert-AutColumns `
            -Name "MTX-LIBRARIES.csv" `
            -Path $LibrariesFile `
            -Rows $Libraries `
            -RequiredColumns @(
                "LibraryID",
                "SiteID",
                "LibraryName",
                "LibraryType",
                "OwnerUPN",
                "Enabled"
            )

        Assert-AutUniqueRows -Name "MTX-LIBRARIES.csv" -Rows $Libraries -FieldNames @("LibraryID") -LabelField "LibraryName"
        Assert-AutUniqueRows -Name "MTX-LIBRARIES.csv" -Rows $Libraries -FieldNames @("SiteID", "LibraryName") -LabelField "LibraryID"

        foreach ($library in $Libraries) {
            $parentMatches = @($Sites | Where-Object {
                $_.SiteID -eq $library.SiteID -and
                (ConvertTo-AutBool -Value $_.Enabled -Default $false) -and
                (-not (Test-AutRowBlocked -Row $_))
            })

            if ($parentMatches.Count -eq 0) {
                Write-AutBlocked "MTX-LIBRARIES.csv row $($library.LibraryID) references unresolved SiteID '$($library.SiteID)'"
                Add-AutNoteProperty -Row $library -Name "AutValidationBlocked" -Value $true
            }
            elseif ($parentMatches.Count -gt 1) {
                Write-AutBlocked "MTX-LIBRARIES.csv row $($library.LibraryID) matches multiple site rows for SiteID '$($library.SiteID)'"
                Add-AutNoteProperty -Row $library -Name "AutValidationBlocked" -Value $true
            }
        }
    }
}

Write-AutState "READY" "MTX-LICENSES.csv loaded as input contract only; rows: $($Licenses.Count)"
Write-AutState "WARNING" "License assignment is not implemented in the global baseline scripts"

$ResolvedSharePointAdminUrl = $null

if ($Execute -and $IncludeSharePoint) {
    $ResolvedSharePointAdminUrl = Resolve-AutSharePointAdminUrl
}

if ($Execute -and $BlockedCount -gt 0) {
    throw "FAILED: Blocking validation errors detected before execution. Blocked=$BlockedCount"
}

Assert-AutExecuteAllowed

if ($Execute) {
    Connect-AutTenant

    if ($IncludeSharePoint) {
        Connect-AutSharePoint -AdminUrl $ResolvedSharePointAdminUrl
    }
}
else {
    Write-AutState "READY" "DryRun mode will not connect to Graph, Exchange, or SharePoint and will not mutate tenant state"
}

Write-Host ""
Write-Host "--- USERS ---"

foreach ($u in $Users) {
    $label = $u.UserPrincipalName

    if (Test-AutRowProtection -Row $u -Fields @("UserPrincipalName", "DisplayName", "MailNickname", "JobTitle") -ObjectLabel "User $label") {
        continue
    }

    $accountEnabled = ConvertTo-AutBool -Value $u.AccountEnabled -Default $true
    $password = $u.PasswordProfile

    if (-not $password -or $password -eq "<GENERATED_SECURE_PASSWORD>") {
        $password = New-RandomTenantPassword
    }

    if (-not $Execute) {
        Write-AutPlanned "READY" "DRY-RUN create/update user $label"
        continue
    }

    try {
        $existingUser = Get-MgUser `
            -Filter "userPrincipalName eq '$($u.UserPrincipalName)'"

        if ($existingUser) {
            Write-AutState "SKIPPED" "User already exists $label"
            continue
        }

        New-MgUser `
            -DisplayName $u.DisplayName `
            -UserPrincipalName $u.UserPrincipalName `
            -MailNickname $u.MailNickname `
            -AccountEnabled $accountEnabled `
            -PasswordProfile @{
                Password = $password
                ForceChangePasswordNextSignIn = $true
            }

        Write-AutState "COMPLETED" "User created $label"
    }
    catch {
        Write-AutState "FAILED" "User failed $label :: $_"
    }
}

Write-Host ""
Write-Host "--- GROUPS ---"

foreach ($g in $Groups) {
    $label = $g.DisplayName

    if (Test-AutRowProtection -Row $g -Fields @("DisplayName", "MailNickname", "PrimarySMTP", "OwnerUPN") -ObjectLabel "Group $label") {
        continue
    }

    $groupType = $g.GroupType.ToString().Trim()
    $groupFlags = Get-AutNormalizedGroupFlags -GroupRow $g

    if (-not $groupFlags) {
        Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE group type '$groupType' for $label"
        continue
    }

    if (-not $Execute) {
        Write-AutPlanned "READY" "DRY-RUN create/verify group $label type=$groupType owner=$($g.OwnerUPN) primary=$($g.PrimarySMTP)"
        continue
    }

    try {
        $blockedBeforeGroupLookup = $BlockedCount
        $existingGroup = Resolve-AutExistingGroupForCreation -GroupRow $g

        if ($BlockedCount -gt $blockedBeforeGroupLookup) {
            continue
        }

        if ($existingGroup) {
            Write-AutState "SKIPPED" "Group already exists $label"
            continue
        }

        $params = @{
            DisplayName = $g.DisplayName
            MailEnabled = $groupFlags.MailEnabled
            MailNickname = $g.MailNickname
            SecurityEnabled = $groupFlags.SecurityEnabled
        }

        if ($groupFlags.GroupTypes.Count -gt 0) {
            $params["GroupTypes"] = $groupFlags.GroupTypes
        }

        New-MgGroup @params

        Write-AutState "COMPLETED" "Group created $label"
        Write-AutState "WARNING" "OwnerUPN is validated/planned only in global baseline: $($g.OwnerUPN)"
    }
    catch {
        Write-AutState "FAILED" "Group failed $label :: $_"
    }
}

if ($IncludeTeams) {
    Write-Host ""
    Write-Host "--- TEAMS ---"

    $enabledTeams = @($Teams | Where-Object {
        (ConvertTo-AutBool -Value $_.Enabled -Default $false) -and
        (-not $_.PSObject.Properties.Name.Contains("AutDuplicateBlocked") -or -not $_.AutDuplicateBlocked)
    })

    foreach ($t in $Teams) {
        $label = $t.DisplayName

        if ($t.PSObject.Properties.Name.Contains("AutDuplicateBlocked") -and $t.AutDuplicateBlocked) {
            Write-AutState "SKIPPED" "Duplicate-blocked Team row $($t.TeamID) skipped"
            continue
        }

        if (-not (ConvertTo-AutBool -Value $t.Enabled -Default $false)) {
            Write-AutState "SKIPPED" "Disabled Team row $($t.TeamID)"
            continue
        }

        if (Test-AutRowProtection -Row $t -Fields @("DisplayName", "GroupMailNickname", "PrimarySMTP", "OwnerUPN") -ObjectLabel "Team $label") {
            continue
        }

        $visibility = $t.Visibility.ToString().Trim()

        if ($visibility -notin @("Private", "Public")) {
            Write-AutBlocked "Team row $($t.TeamID) has unsupported Visibility '$visibility'"
            continue
        }

        if (Test-AutSemanticIdentifier $t.OwnerUPN) {
            Write-AutBlocked "UNSUPPORTED_SEMANTIC_IDENTIFIER OwnerUPN '$($t.OwnerUPN)' in Team row $($t.TeamID)"
            continue
        }

        if (-not $Execute) {
            Write-AutPlanned "READY" "DRY-RUN create/verify Team $label from group alias=$($t.GroupMailNickname) primary=$($t.PrimarySMTP)"
            continue
        }

        try {
            try {
                $null = Get-MgUser -UserId $t.OwnerUPN
            }
            catch {
                Write-AutBlocked "OwnerUPN could not be resolved for Team row $($t.TeamID): $($t.OwnerUPN)"
                continue
            }

            $blockedBeforeTeamLookup = $BlockedCount
            $sourceGroup = Resolve-AutTeamSourceGroup -TeamRow $t

            if ($BlockedCount -gt $blockedBeforeTeamLookup -or -not $sourceGroup) {
                continue
            }

            if (-not (Test-AutUnifiedGroup -Group $sourceGroup -TeamRow $t)) {
                continue
            }

            $existingTeam = Get-AutExistingTeam -GroupId $sourceGroup.Id

            if ($existingTeam) {
                Write-AutState "SKIPPED" "Team already exists $label"
                continue
            }

            $teamBody = @{
                "template@odata.bind" = "https://graph.microsoft.com/v1.0/teamsTemplates('standard')"
                memberSettings = @{
                    allowCreateUpdateChannels = $true
                    allowDeleteChannels = $false
                }
                messagingSettings = @{
                    allowUserEditMessages = $true
                    allowUserDeleteMessages = $false
                }
                funSettings = @{
                    allowGiphy = $true
                    giphyContentRating = "moderate"
                }
            }

            New-MgGroupTeam -GroupId $sourceGroup.Id -BodyParameter $teamBody
            Write-AutState "COMPLETED" "Team creation requested $label"
            $null = Wait-AutTeamProvisioning -GroupId $sourceGroup.Id -TeamName $label
        }
        catch {
            Write-AutState "FAILED" "Team failed $label :: $_"
        }
    }

    Write-Host ""
    Write-Host "--- TEAMS CHANNELS ---"

    if ($Channels.Count -eq 0) {
        Write-AutState "SKIPPED" "No MTX-CHANNELS.csv rows available"
    }

    foreach ($c in $Channels) {
        $label = "$($c.TeamDisplayName) / $($c.ChannelName)"

        if ($c.PSObject.Properties.Name.Contains("AutDuplicateBlocked") -and $c.AutDuplicateBlocked) {
            Write-AutState "SKIPPED" "Duplicate-blocked channel row $($c.ChannelID)"
            continue
        }

        if (-not (ConvertTo-AutBool -Value $c.Enabled -Default $false)) {
            Write-AutState "SKIPPED" "Disabled channel row $($c.ChannelID)"
            continue
        }

        if (Test-AutRowProtection -Row $c -Fields @("TeamID", "TeamDisplayName", "ChannelName") -ObjectLabel "Teams channel $label") {
            continue
        }

        $channelName = $c.ChannelName.ToString().Trim()
        $channelType = $c.ChannelType.ToString().Trim()

        if ($channelName -eq "General") {
            Write-AutState "WARNING" "General channel is system-created by Teams; skipping MTX channel row $($c.ChannelID)"
            continue
        }

        if ($channelType -in @("Private", "Shared")) {
            Write-AutState "WARNING" "FUTURE_NOT_IMPLEMENTED Teams channel type '$channelType' for $label"
            continue
        }

        if ($channelType -ne "Standard") {
            Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE Teams channel type '$channelType' for $label"
            continue
        }

        $teamRowMatches = @($enabledTeams | Where-Object {
            $_.TeamID -eq $c.TeamID -or
            $_.DisplayName -eq $c.TeamDisplayName
        })

        if ($teamRowMatches.Count -gt 1) {
            Write-AutBlocked "Channel row $($c.ChannelID) matches multiple Teams by TeamID/TeamDisplayName"
            continue
        }

        if ($teamRowMatches.Count -eq 0) {
            Write-AutBlocked "Channel row $($c.ChannelID) does not match an enabled MTX-TEAMS row"
            continue
        }

        if (-not $Execute) {
            Write-AutPlanned "READY" "DRY-RUN create/verify Standard Teams channel $label"
            continue
        }

        try {
            $teamRow = $teamRowMatches[0]
            $blockedBeforeChannelLookup = $BlockedCount
            $sourceGroup = Resolve-AutTeamSourceGroup -TeamRow $teamRow

            if ($BlockedCount -gt $blockedBeforeChannelLookup -or -not $sourceGroup) {
                continue
            }

            if (-not (Test-AutUnifiedGroup -Group $sourceGroup -TeamRow $teamRow)) {
                continue
            }

            $team = Wait-AutTeamProvisioning -GroupId $sourceGroup.Id -TeamName $teamRow.DisplayName

            if (-not $team) {
                continue
            }

            if (Test-AutTeamChannelExists -TeamId $sourceGroup.Id -ChannelName $channelName) {
                Write-AutState "SKIPPED" "Teams channel already exists $label"
                continue
            }

            New-MgTeamChannel `
                -TeamId $sourceGroup.Id `
                -DisplayName $channelName `
                -MembershipType "standard"

            Write-AutState "COMPLETED" "Teams channel created $label"
        }
        catch {
            Write-AutState "FAILED" "Teams channel failed $label :: $_"
        }
    }
}

if ($IncludeSharePoint) {
    Write-Host ""
    Write-Host "--- SHAREPOINT SITES ---"

    $enabledSites = @($Sites | Where-Object {
        (ConvertTo-AutBool -Value $_.Enabled -Default $false) -and
        (-not (Test-AutRowBlocked -Row $_))
    })

    $resolvedSharePointSites = @{}

    foreach ($s in $Sites) {
        $label = "$($s.SiteName) <$($s.SiteUrl)>"

        if (Test-AutRowBlocked -Row $s) {
            Write-AutState "SKIPPED" "Validation-blocked SharePoint site row $($s.SiteID)"
            continue
        }

        if (-not (ConvertTo-AutBool -Value $s.Enabled -Default $false)) {
            Write-AutState "SKIPPED" "Disabled SharePoint site row $($s.SiteID)"
            continue
        }

        if (Test-AutRowProtection -Row $s -Fields @("SiteName", "SiteUrl", "OwnerUPN") -ObjectLabel "SharePoint site $label") {
            continue
        }

        $siteType = $s.SiteType.ToString().Trim()

        if ($siteType -notin @("TeamBacked", "Communication", "StandaloneTeamSite")) {
            Write-AutBlocked "SharePoint site row $($s.SiteID) has unsupported SiteType '$siteType'"
            continue
        }

        if (Test-AutSemanticIdentifier $s.OwnerUPN) {
            Write-AutBlocked "UNSUPPORTED_SEMANTIC_IDENTIFIER OwnerUPN '$($s.OwnerUPN)' in SharePoint site row $($s.SiteID)"
            continue
        }

        if ($siteType -eq "TeamBacked") {
            if (-not $Execute) {
                Write-AutPlanned "READY" "DRY-RUN validate Team-backed SharePoint site $label; Team-backed sites are created by Teams/M365 group provisioning"
                continue
            }

            $existingTeamBackedSite = Get-AutExistingSharePointSite -SiteUrl $s.SiteUrl

            if ($existingTeamBackedSite) {
                $resolvedSharePointSites[$s.SiteID] = $s.SiteUrl
                Write-AutState "SKIPPED" "Team-backed SharePoint site already exists $label"
            }
            else {
                Write-AutState "WARNING" "Team-backed SharePoint site not found yet; not creating separately: $label"
            }

            continue
        }

        if (-not $Execute) {
            Write-AutPlanned "READY" "DRY-RUN create/verify SharePoint $siteType site $label owner=$($s.OwnerUPN)"
            continue
        }

        try {
            try {
                $null = Get-MgUser -UserId $s.OwnerUPN
            }
            catch {
                Write-AutBlocked "OwnerUPN could not be resolved for SharePoint site row $($s.SiteID): $($s.OwnerUPN)"
                continue
            }

            $existingSite = Get-AutExistingSharePointSite -SiteUrl $s.SiteUrl

            if ($existingSite) {
                $resolvedSharePointSites[$s.SiteID] = $s.SiteUrl
                Write-AutState "SKIPPED" "SharePoint site already exists $label"
                continue
            }

            $template = Get-AutSharePointTemplate -SiteType $siteType

            if (-not $template) {
                Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE SharePoint SiteType '$siteType' for $label"
                continue
            }

            New-SPOSite `
                -Url $s.SiteUrl `
                -Owner $s.OwnerUPN `
                -Title $s.SiteName `
                -Template $template `
                -StorageQuota 1024

            Write-AutState "COMPLETED" "SharePoint site creation requested $label"
            $validatedSite = Wait-AutSharePointSite -SiteUrl $s.SiteUrl

            if ($validatedSite) {
                $resolvedSharePointSites[$s.SiteID] = $s.SiteUrl
            }
        }
        catch {
            Write-AutState "FAILED" "SharePoint site failed $label :: $_"
        }
    }

    Write-Host ""
    Write-Host "--- SHAREPOINT LIBRARIES ---"

    if ($Libraries.Count -eq 0) {
        Write-AutState "SKIPPED" "No MTX-LIBRARIES.csv rows available"
    }

    foreach ($l in $Libraries) {
        $label = "$($l.SiteID) / $($l.LibraryName)"

        if (Test-AutRowBlocked -Row $l) {
            Write-AutState "SKIPPED" "Validation-blocked SharePoint library row $($l.LibraryID)"
            continue
        }

        if (-not (ConvertTo-AutBool -Value $l.Enabled -Default $false)) {
            Write-AutState "SKIPPED" "Disabled SharePoint library row $($l.LibraryID)"
            continue
        }

        if (Test-AutRowProtection -Row $l -Fields @("LibraryName", "OwnerUPN") -ObjectLabel "SharePoint library $label") {
            continue
        }

        if (Test-AutSemanticIdentifier $l.OwnerUPN) {
            Write-AutBlocked "UNSUPPORTED_SEMANTIC_IDENTIFIER OwnerUPN '$($l.OwnerUPN)' in SharePoint library row $($l.LibraryID)"
            continue
        }

        $siteRows = @($enabledSites | Where-Object { $_.SiteID -eq $l.SiteID })

        if ($siteRows.Count -eq 0) {
            Write-AutBlocked "SharePoint library row $($l.LibraryID) references unresolved SiteID '$($l.SiteID)'"
            continue
        }

        if ($siteRows.Count -gt 1) {
            Write-AutBlocked "SharePoint library row $($l.LibraryID) matches multiple site rows for SiteID '$($l.SiteID)'"
            continue
        }

        $parentSite = $siteRows[0]
        $libraryType = $l.LibraryType.ToString().Trim()

        if ($libraryType -notin @("Documents", "DocumentLibrary", "SensitiveDocuments")) {
            Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE SharePoint LibraryType '$libraryType' for $label"
            continue
        }

        if (-not $Execute) {
            Write-AutPlanned "READY" "DRY-RUN create/verify SharePoint library $label on $($parentSite.SiteUrl); permission inheritance remains unchanged"
            continue
        }

        if (-not $resolvedSharePointSites.ContainsKey($l.SiteID)) {
            Write-AutState "SKIPPED" "SharePoint library skipped because parent site was not resolved: $label"
            continue
        }

        try {
            try {
                $null = Get-MgUser -UserId $l.OwnerUPN
            }
            catch {
                Write-AutBlocked "OwnerUPN could not be resolved for SharePoint library row $($l.LibraryID): $($l.OwnerUPN)"
                continue
            }

            Ensure-AutPnPConnection -SiteUrl $resolvedSharePointSites[$l.SiteID]

            if (Test-AutSharePointLibraryExists -LibraryName $l.LibraryName) {
                Write-AutState "SKIPPED" "SharePoint library already exists $label"
                continue
            }

            New-PnPList `
                -Title $l.LibraryName `
                -Template DocumentLibrary

            Write-AutState "COMPLETED" "SharePoint library created $label"
            Write-AutState "WARNING" "SharePoint permission inheritance was not changed for library $label"
        }
        catch {
            Write-AutState "FAILED" "SharePoint library failed $label :: $_"
        }
    }
}

Write-Host ""
Write-Host "--- MAILBOXES ---"

foreach ($m in $Mailboxes) {
    $label = $m.TargetAddress

    if (Test-AutRowProtection -Row $m -Fields @("DisplayName", "Alias", "TargetAddress", "OwnerUPN") -ObjectLabel "Mailbox $label") {
        continue
    }

    if (-not $Execute) {
        Write-AutPlanned "READY" "DRY-RUN create shared mailbox $label owner=$($m.OwnerUPN) department=$($m.Department)"
        continue
    }

    try {
        $existingMailbox = Get-Mailbox `
            -Identity $m.TargetAddress `
            -ErrorAction SilentlyContinue

        if ($existingMailbox) {
            Write-AutState "SKIPPED" "Mailbox already exists $label"
            continue
        }

        New-Mailbox `
            -Shared `
            -Name $m.DisplayName `
            -DisplayName $m.DisplayName `
            -Alias $m.Alias `
            -PrimarySmtpAddress $m.TargetAddress

        Write-AutState "COMPLETED" "Mailbox created $label"
        Write-AutState "WAITING_PROPAGATION" "Allowing basic mailbox propagation stabilization for $label"
        Start-Sleep -Seconds 30
    }
    catch {
        Write-AutState "FAILED" "Mailbox failed $label :: $_"
    }
}

Write-Host ""
Write-Host "--- PERMISSIONS ---"

foreach ($p in $Permissions) {
    $label = "$($p.ObjectType) $($p.AccessType) $($p.UserUPN) -> $($p.TargetAddress)"

    if (-not (ConvertTo-AutBool -Value $p.Enabled -Default $false)) {
        Write-AutState "SKIPPED" "Disabled permission row $($p.PermissionID)"
        continue
    }

    if (Test-AutRowProtection -Row $p -Fields @("TargetAddress", "UserUPN", "ObjectName", "RoleScope") -ObjectLabel "Permission $label") {
        continue
    }

    if (Test-AutSemanticIdentifier $p.UserUPN) {
        Write-AutBlocked "UNSUPPORTED_SEMANTIC_IDENTIFIER UserUPN '$($p.UserUPN)' in permission row $($p.PermissionID)"
        continue
    }

    if ($p.ObjectType -in @("Team", "SharePointSite")) {
        Write-AutState "WARNING" "FUTURE_NOT_IMPLEMENTED permission object type '$($p.ObjectType)' for $label"
        continue
    }

    if ($p.ObjectType -eq "SharedMailbox") {
        if ($p.AccessType -notin @("FullAccess", "SendAs")) {
            Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE access type '$($p.AccessType)' for $label"
            continue
        }

        if (-not $Execute) {
            Write-AutPlanned "READY" "DRY-RUN apply $label"
            continue
        }

        try {
            if ($p.AccessType -eq "FullAccess") {
                $existingPermission = Get-MailboxPermission `
                    -Identity $p.TargetAddress `
                    -User $p.UserUPN `
                    -ErrorAction SilentlyContinue |
                    Where-Object {
                        $_.AccessRights -contains "FullAccess" -and
                        -not $_.IsInherited
                    }

                if ($existingPermission) {
                    Write-AutState "SKIPPED" "FullAccess already exists for $($p.UserUPN) on $($p.TargetAddress)"
                    continue
                }

                Add-MailboxPermission `
                    -Identity $p.TargetAddress `
                    -User $p.UserUPN `
                    -AccessRights FullAccess `
                    -Confirm:$false
            }
            elseif ($p.AccessType -eq "SendAs") {
                $existingPermission = Get-RecipientPermission `
                    -Identity $p.TargetAddress `
                    -Trustee $p.UserUPN `
                    -ErrorAction SilentlyContinue |
                    Where-Object {
                        $_.AccessRights -contains "SendAs"
                    }

                if ($existingPermission) {
                    Write-AutState "SKIPPED" "SendAs already exists for $($p.UserUPN) on $($p.TargetAddress)"
                    continue
                }

                Add-RecipientPermission `
                    -Identity $p.TargetAddress `
                    -Trustee $p.UserUPN `
                    -AccessRights SendAs `
                    -Confirm:$false
            }

            Write-AutState "COMPLETED" "$label"
        }
        catch {
            Write-AutState "FAILED" "Permission failed $label :: $_"
        }

        continue
    }

    if ($p.ObjectType -in @("M365Group", "SecurityGroup")) {
        if ($p.AccessType -notin @("Member", "Owner")) {
            Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE access type '$($p.AccessType)' for $label"
            continue
        }

        if (-not $Execute) {
            $plannedState = if ($p.AccessType -eq "Member") { "WOULD_ADD_MEMBER" } else { "WOULD_ADD_OWNER" }
            Write-AutState "VALIDATING" "Group permission row $($p.PermissionID) uses executable UserUPN $($p.UserUPN)"
            Write-AutState "WOULD_CHECK_EXISTING_MEMBERSHIP" "$label"
            Write-AutPlanned $plannedState "$label"
            continue
        }

        try {
            $targetGroup = Resolve-AutPermissionGroup -Permission $p -Groups $Groups

            if (-not $targetGroup) {
                continue
            }

            $targetUser = Resolve-AutPermissionUser -Permission $p

            if (-not $targetUser) {
                continue
            }

            $resolvedProtectionRow = [pscustomobject]@{
                GroupDisplayName = $targetGroup.DisplayName
                GroupMail = $targetGroup.Mail
                GroupMailNickname = $targetGroup.MailNickname
                UserUPN = $p.UserUPN
                UserDisplayName = $targetUser.DisplayName
                ObjectName = $p.ObjectName
                TargetAddress = $p.TargetAddress
            }

            if (Test-AutRowProtection -Row $resolvedProtectionRow -Fields @("GroupDisplayName", "GroupMail", "GroupMailNickname", "UserUPN", "UserDisplayName", "ObjectName", "TargetAddress") -ObjectLabel "Group permission $label") {
                continue
            }

            if (Test-AutGraphRelationshipExists -GroupId $targetGroup.Id -UserId $targetUser.Id -AccessType $p.AccessType) {
                Write-AutState "SKIPPED" "$($p.AccessType) already exists for $($p.UserUPN) on $($targetGroup.DisplayName)"
                continue
            }

            if ($p.AccessType -eq "Member") {
                Write-AutState "ADDING_MEMBER" "$($p.UserUPN) -> $($targetGroup.DisplayName)"
            }
            else {
                Write-AutState "ADDING_OWNER" "$($p.UserUPN) -> $($targetGroup.DisplayName)"
            }

            Add-AutGraphGroupRelationship -GroupId $targetGroup.Id -UserId $targetUser.Id -AccessType $p.AccessType
            Write-AutState "COMPLETED" "$($p.AccessType) added for $($p.UserUPN) on $($targetGroup.DisplayName)"
        }
        catch {
            Write-AutState "FAILED" "Group permission failed $label :: $_"
        }

        continue
    }

    Write-AutState "WARNING" "UNSUPPORTED_IN_GLOBAL_BASELINE permission object type '$($p.ObjectType)' for $label"
}

Write-AutSummary -LicenseRows $Licenses.Count

if ($FailedCount -gt 0 -or $BlockedCount -gt 0) {
    Write-Host "[COMPLETED_WITH_FAILURES] DONE"

    if ($Execute) {
        throw "FAILED: AUT execution completed with failures or blocked states. Failed=$FailedCount Blocked=$BlockedCount"
    }
}
else {
    Write-Host "[COMPLETED] DONE"
}
