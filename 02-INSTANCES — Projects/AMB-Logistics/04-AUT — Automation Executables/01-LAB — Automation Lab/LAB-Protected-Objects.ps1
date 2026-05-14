<#
Tenant-local controlled runtime
Production-ready guarded execution
Protected-object enforced
No license assignment
No destructive default behavior
#>

$script:LabProtectedObjectPolicy = [PSCustomObject]@{
    ProtectedUPNs = @(
        "homelab@federicomosqueira0910.onmicrosoft.com"
    )
    ProtectedAliases = @(
        "global.admin@federicomosqueira.site",
        "hello@federicomosqueira.site"
    )
    ProtectedDisplayNames = @(
        "GLOBAL-Admin"
    )
    ProtectedObjectIds = @(
        "<UNKNOWN_OBJECT_ID_GLOBAL_ADMIN>"
    )
    ProtectedRoles = @(
        "Global Administrator"
    )
    CurrentConnectedUserUPN = ""
}

function Normalize-LabIdentityValue {
    Param(
        [AllowNull()][Object]$Value
    )

    if ($null -eq $Value) {
        return ""
    }

    return ([string]$Value).Trim().ToLowerInvariant()
}

function Test-LabValueInProtectedSet {
    Param(
        [AllowNull()][Object]$Value,
        [String[]]$ProtectedValues
    )

    $NormalizedValue = Normalize-LabIdentityValue $Value
    if ([string]::IsNullOrWhiteSpace($NormalizedValue)) {
        return $false
    }

    foreach ($ProtectedValue in $ProtectedValues) {
        $NormalizedProtectedValue = Normalize-LabIdentityValue $ProtectedValue
        if ([string]::IsNullOrWhiteSpace($NormalizedProtectedValue)) {
            continue
        }

        if ($NormalizedProtectedValue -eq (Normalize-LabIdentityValue "<UNKNOWN_OBJECT_ID_GLOBAL_ADMIN>")) {
            continue
        }

        if ($NormalizedValue -eq $NormalizedProtectedValue) {
            return $true
        }

        if ($NormalizedProtectedValue.Contains("@")) {
            $ProtectedMailNickname = ($NormalizedProtectedValue -split "@")[0]
            if ($NormalizedValue -eq $ProtectedMailNickname) {
                return $true
            }
        }
    }

    return $false
}

function Add-LabProtectedObjectId {
    Param(
        [String]$ObjectId
    )

    $NormalizedObjectId = Normalize-LabIdentityValue $ObjectId
    if ([string]::IsNullOrWhiteSpace($NormalizedObjectId)) {
        return $false
    }

    if ($NormalizedObjectId -eq (Normalize-LabIdentityValue "<UNKNOWN_OBJECT_ID_GLOBAL_ADMIN>")) {
        return $false
    }

    $Existing = @($script:LabProtectedObjectPolicy.ProtectedObjectIds | ForEach-Object { Normalize-LabIdentityValue $_ })
    if ($NormalizedObjectId -notin $Existing) {
        $script:LabProtectedObjectPolicy.ProtectedObjectIds = @($script:LabProtectedObjectPolicy.ProtectedObjectIds) + $ObjectId
    }

    return $true
}

function Set-LabCurrentConnectedUser {
    Param(
        [String]$UserPrincipalName
    )

    $script:LabProtectedObjectPolicy.CurrentConnectedUserUPN = $UserPrincipalName
}

function Get-LabProtectedIdentityMatch {
    Param(
        [String]$UPN,
        [String]$DisplayName,
        [String]$Alias,
        [String]$ObjectId,
        [Object]$Role,
        [String]$MailNickname,
        [String]$PrimarySMTP
    )

    $Checks = @(
        @{ Field = "UPN"; Value = $UPN; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedUPNs },
        @{ Field = "DisplayName"; Value = $DisplayName; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedDisplayNames },
        @{ Field = "Alias"; Value = $Alias; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "ObjectId"; Value = $ObjectId; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedObjectIds },
        @{ Field = "MailNickname"; Value = $MailNickname; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "PrimarySMTP"; Value = $PrimarySMTP; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases }
    )

    foreach ($Check in $Checks) {
        if (Test-LabValueInProtectedSet -Value $Check.Value -ProtectedValues $Check.ProtectedValues) {
            return [PSCustomObject]@{
                IsProtected  = $true
                MatchedField = $Check.Field
                MatchedValue = $Check.Value
                Reason       = "Matched protected $($Check.Field): $($Check.Value)"
            }
        }
    }

    foreach ($RoleValue in @($Role)) {
        if ($null -eq $RoleValue) {
            continue
        }

        foreach ($ExpandedRole in @([string]$RoleValue -split "[,;]")) {
            if (Test-LabValueInProtectedSet -Value $ExpandedRole -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedRoles) {
                return [PSCustomObject]@{
                    IsProtected  = $true
                    MatchedField = "Role"
                    MatchedValue = $ExpandedRole
                    Reason       = "Matched protected Role: $ExpandedRole"
                }
            }
        }
    }

    return [PSCustomObject]@{
        IsProtected  = $false
        MatchedField = ""
        MatchedValue = ""
        Reason       = ""
    }
}

function Get-LabProtectedObjectMatch {
    Param(
        [AllowNull()][Object]$InputObject
    )

    if ($null -eq $InputObject) {
        return [PSCustomObject]@{
            IsProtected  = $false
            MatchedField = ""
            MatchedValue = ""
            Reason       = ""
        }
    }

    $ProtectedUPNs = @($script:LabProtectedObjectPolicy.ProtectedUPNs)
    if (-not [string]::IsNullOrWhiteSpace($script:LabProtectedObjectPolicy.CurrentConnectedUserUPN)) {
        $ProtectedUPNs += $script:LabProtectedObjectPolicy.CurrentConnectedUserUPN
    }

    $FieldChecks = @(
        @{ Field = "UserPrincipalName"; ProtectedValues = $ProtectedUPNs },
        @{ Field = "UPN"; ProtectedValues = $ProtectedUPNs },
        @{ Field = "UserUPN"; ProtectedValues = $ProtectedUPNs },
        @{ Field = "OwnerUPN"; ProtectedValues = $ProtectedUPNs },
        @{ Field = "CurrentConnectedUserUPN"; ProtectedValues = $ProtectedUPNs },
        @{ Field = "DisplayName"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedDisplayNames },
        @{ Field = "ObjectName"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedDisplayNames },
        @{ Field = "TargetAddress"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "PrimarySMTP"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "Alias"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "MailNickname"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedAliases },
        @{ Field = "Id"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedObjectIds },
        @{ Field = "ObjectId"; ProtectedValues = $script:LabProtectedObjectPolicy.ProtectedObjectIds }
    )

    foreach ($Check in $FieldChecks) {
        $Value = $InputObject.($Check.Field)
        if (Test-LabValueInProtectedSet -Value $Value -ProtectedValues $Check.ProtectedValues) {
            return [PSCustomObject]@{
                IsProtected  = $true
                MatchedField = $Check.Field
                MatchedValue = $Value
                Reason       = "Matched protected $($Check.Field): $Value"
            }
        }
    }

    foreach ($RoleField in @("Role", "Roles")) {
        foreach ($RoleValue in @($InputObject.$RoleField)) {
            if ($null -eq $RoleValue) {
                continue
            }

            foreach ($ExpandedRole in @([string]$RoleValue -split "[,;]")) {
                if (Test-LabValueInProtectedSet -Value $ExpandedRole -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedRoles) {
                    return [PSCustomObject]@{
                        IsProtected  = $true
                        MatchedField = $RoleField
                        MatchedValue = $ExpandedRole
                        Reason       = "Matched protected ${RoleField}: $ExpandedRole"
                    }
                }
            }
        }
    }

    return [PSCustomObject]@{
        IsProtected  = $false
        MatchedField = ""
        MatchedValue = ""
        Reason       = ""
    }
}

function Test-LabProtectedIdentity {
    Param(
        [String]$UPN,
        [String]$DisplayName,
        [String]$Alias,
        [String]$ObjectId,
        [Object]$Role,
        [String]$MailNickname,
        [String]$PrimarySMTP
    )

    $Match = Get-LabProtectedIdentityMatch -UPN $UPN -DisplayName $DisplayName -Alias $Alias -ObjectId $ObjectId -Role $Role -MailNickname $MailNickname -PrimarySMTP $PrimarySMTP
    return [bool]$Match.IsProtected
}

function Test-LabProtectedObject {
    Param(
        [AllowNull()][Object]$InputObject
    )

    $Match = Get-LabProtectedObjectMatch -InputObject $InputObject
    return [bool]$Match.IsProtected
}

function Assert-LabNotProtectedObject {
    Param(
        [AllowNull()][Object]$InputObject,
        [String]$ObjectType = "Object",
        [String]$ObjectName = "",
        [String]$AttemptedAction = "Mutate",
        [Switch]$ThrowOnProtected
    )

    $Match = Get-LabProtectedObjectMatch -InputObject $InputObject

    if (-not $Match.IsProtected) {
        return [PSCustomObject]@{
            State           = "READY"
            IsProtected     = $false
            ObjectType      = $ObjectType
            ObjectName      = $ObjectName
            AttemptedAction = $AttemptedAction
            Reason          = ""
        }
    }

    $ResolvedObjectName = if ([string]::IsNullOrWhiteSpace($ObjectName)) { "<unknown>" } else { $ObjectName }
    $Reason = "Protected object blocked. Type=$ObjectType; Name=$ResolvedObjectName; Action=$AttemptedAction; $($Match.Reason)"

    if ($ThrowOnProtected) {
        throw $Reason
    }

    return [PSCustomObject]@{
        State           = "SKIPPED_PROTECTED"
        IsProtected     = $true
        ObjectType      = $ObjectType
        ObjectName      = $ResolvedObjectName
        AttemptedAction = $AttemptedAction
        Reason          = $Reason
    }
}

function Confirm-LabProtectedBaseline {
    $RequiredUPN = "homelab@federicomosqueira0910.onmicrosoft.com"
    $RequiredAliases = @("global.admin@federicomosqueira.site", "hello@federicomosqueira.site")
    $RequiredDisplayName = "GLOBAL-Admin"
    $RequiredRole = "Global Administrator"

    $Problems = New-Object System.Collections.Generic.List[String]
    if (-not (Test-LabValueInProtectedSet -Value $RequiredUPN -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedUPNs)) {
        $Problems.Add("Missing protected UPN: $RequiredUPN")
    }
    foreach ($Alias in $RequiredAliases) {
        if (-not (Test-LabValueInProtectedSet -Value $Alias -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedAliases)) {
            $Problems.Add("Missing protected alias: $Alias")
        }
    }
    if (-not (Test-LabValueInProtectedSet -Value $RequiredDisplayName -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedDisplayNames)) {
        $Problems.Add("Missing protected display name: $RequiredDisplayName")
    }
    if (-not (Test-LabValueInProtectedSet -Value $RequiredRole -ProtectedValues $script:LabProtectedObjectPolicy.ProtectedRoles)) {
        $Problems.Add("Missing protected role: $RequiredRole")
    }

    if ($Problems.Count -gt 0) {
        throw "Protected baseline invalid. $($Problems -join '; ')"
    }

    return $true
}

function Get-LabProtectedObjectSummary {
    return [PSCustomObject]@{
        ProtectedUPNs             = $script:LabProtectedObjectPolicy.ProtectedUPNs
        ProtectedAliases         = $script:LabProtectedObjectPolicy.ProtectedAliases
        ProtectedDisplayNames     = $script:LabProtectedObjectPolicy.ProtectedDisplayNames
        ProtectedObjectIds        = $script:LabProtectedObjectPolicy.ProtectedObjectIds
        ProtectedRoles            = $script:LabProtectedObjectPolicy.ProtectedRoles
        CurrentConnectedUserUPN   = $script:LabProtectedObjectPolicy.CurrentConnectedUserUPN
        ObjectIdResolved          = @($script:LabProtectedObjectPolicy.ProtectedObjectIds | Where-Object {
            (Normalize-LabIdentityValue $_) -ne (Normalize-LabIdentityValue "<UNKNOWN_OBJECT_ID_GLOBAL_ADMIN>")
        }).Count -gt 0
        Boundary                  = "Tenant-local controlled runtime; Production-ready guarded execution; Protected-object enforced; No license assignment; No destructive default behavior"
    }
}
