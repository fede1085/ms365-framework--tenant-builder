param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,

    [switch]$Execute
)

Write-Host "=== DEPLOY TENANT ==="

$Mode = if ($Execute) { "EXECUTE" } else { "DRY-RUN" }
Write-Host "Mode:" $Mode

# -----------------------------
# VALIDATE PATH
# -----------------------------

if (-not (Test-Path $ProjectPath)) {
    throw "❌ ProjectPath not found: $ProjectPath"
}

# -----------------------------
# LOAD FILES
# -----------------------------

$UsersFile       = Join-Path $ProjectPath "MTX-USERS.csv"
$GroupsFile      = Join-Path $ProjectPath "MTX-GROUPS.csv"
$MailboxesFile   = Join-Path $ProjectPath "MTX-MAILBOXES.csv"
$PermissionsFile = Join-Path $ProjectPath "MTX-PERMISSIONS.csv"

$files = @($UsersFile,$GroupsFile,$MailboxesFile,$PermissionsFile)

foreach ($f in $files) {
    if (-not (Test-Path $f)) {
        throw "❌ Missing file: $f"
    }
}

$Users       = Import-Csv $UsersFile
$Groups      = Import-Csv $GroupsFile
$Mailboxes   = Import-Csv $MailboxesFile
$Permissions = Import-Csv $PermissionsFile

# -----------------------------
# CONNECT (ONLY EXECUTE)
# -----------------------------

if ($Execute) {
    Write-Host "Connecting..."

    Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"
    Connect-ExchangeOnline
}

# -----------------------------
# USERS
# -----------------------------

Write-Host "`n--- USERS ---"

foreach ($u in $Users) {

    $msg = "$($u.UPN)"

    if (-not $Execute) {
        Write-Host "[DRY] Create user $msg"
        continue
    }

    try {
        New-MgUser `
            -DisplayName $u.DisplayName `
            -UserPrincipalName $u.UPN `
            -MailNickname ($u.UPN.Split("@")[0]) `
            -AccountEnabled $true `
            -PasswordProfile @{
                Password = "TempP@ss1234"
                ForceChangePasswordNextSignIn = $true
            }

        Write-Host "[OK] User $msg"
    }
    catch {
        Write-Host "[ERR] User $msg"
    }
}

# -----------------------------
# GROUPS
# -----------------------------

Write-Host "`n--- GROUPS ---"

foreach ($g in $Groups) {

    $msg = "$($g.GroupName)"

    if (-not $Execute) {
        Write-Host "[DRY] Create group $msg"
        continue
    }

    try {
        New-MgGroup `
            -DisplayName $g.GroupName `
            -MailEnabled $true `
            -MailNickname $g.Alias `
            -SecurityEnabled $false `
            -GroupTypes @("Unified")

        Write-Host "[OK] Group $msg"
    }
    catch {
        Write-Host "[ERR] Group $msg"
    }
}

# -----------------------------
# MAILBOXES
# -----------------------------

Write-Host "`n--- MAILBOXES ---"

foreach ($m in $Mailboxes) {

    $msg = "$($m.Mailbox)"

    if (-not $Execute) {
        Write-Host "[DRY] Create mailbox $msg"
        continue
    }

    try {
        New-Mailbox -Shared `
            -Name ($m.Mailbox.Split("@")[0]) `
            -PrimarySmtpAddress $m.Mailbox

        Write-Host "[OK] Mailbox $msg"
    }
    catch {
        Write-Host "[ERR] Mailbox $msg"
    }
}

# -----------------------------
# PERMISSIONS
# -----------------------------

Write-Host "`n--- PERMISSIONS ---"

foreach ($p in $Permissions) {

    $mbx = $p.Mailbox

    if (-not $Execute) {
        Write-Host "[DRY] Permissions on $mbx"
        continue
    }

    try {
        if ($p.FullAccess) {
            Add-MailboxPermission `
                -Identity $mbx `
                -User $p.FullAccess `
                -AccessRights FullAccess `
                -Confirm:$false
        }

        if ($p.SendAs) {
            Add-RecipientPermission `
                -Identity $mbx `
                -Trustee $p.SendAs `
                -AccessRights SendAs `
                -Confirm:$false
        }

        Write-Host "[OK] Permissions $mbx"
    }
    catch {
        Write-Host "[ERR] Permissions $mbx"
    }
}

Write-Host "`nDONE"