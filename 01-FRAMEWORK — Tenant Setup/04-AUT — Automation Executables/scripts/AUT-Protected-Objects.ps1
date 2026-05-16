# AUT protected-object baseline helpers.
# These are framework examples/placeholders only. Real tenant runtimes should provide tenant-local protected-object rules.

$script:AutDefaultProtectedObjects = @{
    UserPrincipalNames = @(
        "homelab@federicomosqueira0910.onmicrosoft.com"
    )
    DisplayNames = @(
        "GLOBAL-Admin"
    )
    Aliases = @(
        "global.admin@federicomosqueira.site",
        "hello@federicomosqueira.site"
    )
    RoleTitles = @(
        "Global Administrator"
    )
}

function Normalize-AutProtectedValue {
    param(
        [AllowNull()]
        [object]$Value
    )

    if ($null -eq $Value) {
        return ""
    }

    return $Value.ToString().Trim().ToLowerInvariant()
}

function Get-AutProtectedObjects {
    $normalized = @{
        UserPrincipalNames = @{}
        DisplayNames = @{}
        Aliases = @{}
        RoleTitles = @{}
    }

    foreach ($category in $script:AutDefaultProtectedObjects.Keys) {
        foreach ($value in $script:AutDefaultProtectedObjects[$category]) {
            $key = Normalize-AutProtectedValue $value
            if ($key) {
                $normalized[$category][$key] = $value
            }
        }
    }

    return $normalized
}

function Add-AutProtectedObjectValue {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects,

        [Parameter(Mandatory=$true)]
        [string]$Category,

        [AllowNull()]
        [object]$Value
    )

    if (-not $ProtectedObjects.ContainsKey($Category)) {
        $ProtectedObjects[$Category] = @{}
    }

    $key = Normalize-AutProtectedValue $Value

    if ($key) {
        $ProtectedObjects[$Category][$key] = $Value
    }
}

function Add-AutProtectedObjectValues {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects,

        [Parameter(Mandatory=$true)]
        [hashtable]$Values
    )

    foreach ($category in $Values.Keys) {
        foreach ($value in @($Values[$category])) {
            Add-AutProtectedObjectValue -ProtectedObjects $ProtectedObjects -Category $category -Value $value
        }
    }
}

function Import-AutProtectedObjectsCsv {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects
    )

    $rows = @(Import-Csv -Path $Path)

    foreach ($row in $rows) {
        foreach ($field in @("UserPrincipalName", "UPN", "UserUPN")) {
            if ($row.PSObject.Properties.Name.Contains($field)) {
                Add-AutProtectedObjectValue -ProtectedObjects $ProtectedObjects -Category "UserPrincipalNames" -Value $row.$field
            }
        }

        foreach ($field in @("DisplayName", "Name")) {
            if ($row.PSObject.Properties.Name.Contains($field)) {
                Add-AutProtectedObjectValue -ProtectedObjects $ProtectedObjects -Category "DisplayNames" -Value $row.$field
            }
        }

        foreach ($field in @("Alias", "PrimarySMTP", "TargetAddress", "MailNickname", "Email")) {
            if ($row.PSObject.Properties.Name.Contains($field)) {
                Add-AutProtectedObjectValue -ProtectedObjects $ProtectedObjects -Category "Aliases" -Value $row.$field
            }
        }

        foreach ($field in @("RoleTitle", "JobTitle", "Role")) {
            if ($row.PSObject.Properties.Name.Contains($field)) {
                Add-AutProtectedObjectValue -ProtectedObjects $ProtectedObjects -Category "RoleTitles" -Value $row.$field
            }
        }
    }
}

function Test-AutProtectedValue {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects,

        [Parameter(Mandatory=$true)]
        [string]$Category,

        [AllowNull()]
        [object]$Value
    )

    $key = Normalize-AutProtectedValue $Value

    if (-not $key) {
        return $false
    }

    if (-not $ProtectedObjects.ContainsKey($Category)) {
        return $false
    }

    return $ProtectedObjects[$Category].ContainsKey($key)
}

function Test-AutProtectedRow {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$ProtectedObjects,

        [Parameter(Mandatory=$true)]
        [object]$Row,

        [string[]]$Fields = @()
    )

    $matches = New-Object System.Collections.Generic.List[string]

    foreach ($field in $Fields) {
        if (-not $Row.PSObject.Properties.Name.Contains($field)) {
            continue
        }

        $value = $Row.$field

        if (Test-AutProtectedValue -ProtectedObjects $ProtectedObjects -Category "UserPrincipalNames" -Value $value) {
            $matches.Add("$field=$value")
        }

        if (Test-AutProtectedValue -ProtectedObjects $ProtectedObjects -Category "DisplayNames" -Value $value) {
            $matches.Add("$field=$value")
        }

        if (Test-AutProtectedValue -ProtectedObjects $ProtectedObjects -Category "Aliases" -Value $value) {
            $matches.Add("$field=$value")
        }

        if (Test-AutProtectedValue -ProtectedObjects $ProtectedObjects -Category "RoleTitles" -Value $value) {
            $matches.Add("$field=$value")
        }
    }

    return $matches
}
