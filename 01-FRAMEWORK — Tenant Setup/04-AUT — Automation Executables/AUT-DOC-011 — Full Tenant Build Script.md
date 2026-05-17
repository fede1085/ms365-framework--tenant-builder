# AUT-DOC-011 — Full Tenant Build Script

## Reusable Tenant Automation Layer

**Legacy compatible naming:**
- users.csv → MTX-USERS.csv
- groups.csv → MTX-GROUPS.csv
- mailboxes.csv → MTX-MAILBOXES.csv
- permissions.csv → MTX-PERMISSIONS.csv
- licenses.csv → MTX-LICENSES.csv

Legacy names are references only. Active runtime input names use the MTX-* filenames below.

Preferred MTX naming:

- MTX-USERS.csv
- MTX-GROUPS.csv
- MTX-MAILBOXES.csv
- MTX-PERMISSIONS.csv
- MTX-LICENSES.csv

---

# Data Source Rule

Automation reads MTX files.
Automation does not use BLP as execution data.
BLP explains the model.
MTX provides the data.
AUT executes the data.

Current global script-supported fields:

- `MTX-USERS.csv`: `UserPrincipalName`, `MailNickname`, `DisplayName`
- `MTX-GROUPS.csv`: `GroupName`, `Alias`
- `MTX-MAILBOXES.csv`: `Mailbox`
- `MTX-PERMISSIONS.csv`: `Enabled`, `PermissionID`, `TargetAddress`, `UserUPN`, `AccessType`
- `MTX-LICENSES.csv`: required input contract; loaded only; no license assignment

These fields describe the current global baseline scripts only. They do not replace `AUT-SCH-001` as the target runtime contract.

---

# 1. Purpose

Provide the master execution script model.

Goal:

Build a full Microsoft 365 SME logistics tenant from zero using runtime MTX CSV files.

This is the orchestration layer.

The current global scripts are baseline/reference scripts and only partially implement this model.

---

# 2. Required Input Files

```
MTX-USERS.csv
MTX-GROUPS.csv
MTX-MAILBOXES.csv
MTX-PERMISSIONS.csv
MTX-LICENSES.csv
MTX-PROTECTED-OBJECTS.csv
```

License runtime execution status:

```text
License runtime execution not yet implemented.
```

Current scripts load `MTX-LICENSES.csv` to prevent input ambiguity, but do not assign licenses yet.

Protected-object enforcement is required by AUT doctrine.

`MTX-PROTECTED-OBJECTS.csv` must be loaded when present in the tenant instance.

Current global scripts may still be baseline/reference implementations, but tenant-local runtimes should check this file before modifying users, groups, mailboxes, permissions, roles, aliases, ownership, or licenses.

Optional:

```
folders.csv
aliases.csv
```

---

# 3. Required Connections

## Microsoft Graph

For:

- users
- groups
- licenses

## Exchange Online

For:

- shared mailboxes
- mailbox permissions
- aliases

---

# 4. Recommended File Name

```
build-tenant.ps1
```

---

# 5. Master Flow

```
01 Connect
02 Validate CSVs
03 Load Protected-Object Rules
04 Check Protected Objects
05 Create Users
06 Set User Properties
07 Load License Contract (no assignment unless implemented)
08 Create Groups
09 Add Members
10 Create Shared Mailboxes
11 Apply Permissions
12 Add Aliases
13 Validation Report
```

Full tenant build scripts must import and check protected-object rules before modifying users, groups, mailboxes, permissions, roles, aliases, or licenses.

License runtime execution remains not implemented unless explicitly documented elsewhere.

**Protected-object rules are loaded from:**

02-INSTANCES — Projects/<Tenant>/03-MTX — Data Matrices/MTX-PROTECTED-OBJECTS.csv

If the file is absent, production execution should warn or block depending on execution mode.

Lab execution may continue with warning only.

---

# 6. Script Skeleton

```powershell
# =====================================
# BUILD TENANT
# =====================================

# Connect

# Connection Strategy
# Sandbox / Lab environments may use active-session authentication.
# Production environments should prefer explicit tenant targeting.

# Example production-safe pattern:
# Connect-MgGraph -TenantId $TenantId
# Connect-ExchangeOnline -Organization $TenantDomain

# Current runtime connection
Connect-MgGraph
Connect-ExchangeOnline
Write-Host "Starting Tenant Build..."

# Import Data
$Users       = Import-Csv .\MTX-USERS.csv
$Licenses    = Import-Csv .\MTX-LICENSES.csv
$Permissions = Import-Csv .\MTX-PERMISSIONS.csv

# License runtime execution not yet implemented.

# Step 1 Users
foreach ($u in $Users) {
    Write-Host "Create user: $($u.UserPrincipalName)"
}

# Step 2 Permissions
foreach ($p in $Permissions) {
    Write-Host "Apply permission: $($p.AccessType)"
}

Write-Host "Completed."
```

---

# 7. Real Modular Version

## Main Script Calls Child Scripts

```powershell
.\01-connect.ps1
.\02-create-users.ps1
.\03-groups.ps1
.\04-mailboxes.ps1
.\05-permissions.ps1
.\06-report.ps1
```

Better than one huge file.

---

# 8. Safety Features

## Dry Run Switch

```powershell
-param DryRun
```

If DryRun:

- no changes
- show actions only

---

## Logging

```powershell
Start-Transcript
```

Save all output.

---

## Exists Check

Before create:

```
if exists -> skip
```

---

# 9. Example Real Actions

## Create User

```powershell
New-MgUser
```

## Create Group

```powershell
New-MgGroup
```

## Create Shared Mailbox

```powershell
New-Mailbox -Shared
```

## Full Access

```powershell
Add-MailboxPermission
```

## Send As

```powershell
Add-RecipientPermission
```

---

# 10. Folder Creation Note

Mailbox folders often require:

- Outlook automation
- Graph mailbox APIs
- EWS legacy methods

Recommended phase 2.

---

# 11. Validation Report Output

After build generate:

```
Users Created: 17
Groups Created: 9
Mailboxes Created: 7
Permissions Applied: 34
Errors: 0
```

---

# 12. Governance Checks

After build verify:

- every department exists
- every mailbox has owner
- every user has department
- no duplicate aliases
- no missing permissions

---

# 13. End Goal

One command:

```powershell
.\build-tenant.ps1
```

Builds tenant baseline.

---

# 14. Future Versions

## v2

- Teams channels
- SharePoint libraries
- Planner plans

## v3

- MFA baseline
- Conditional Access
- Intune devices

---

# 15. Next Document

```
AUT-DOC-012 — Validation & Audit Toolkit
```

---

## Related Documents

- AUT-SYS-000 — Automation Control Layer.md
- BLP-SYS-000 — Blueprint Control Layer.md
- ARC-SYS-000 — Architecture Control Map.md

## Execution Path Expectations
- Scripts assume framework-relative paths as documented in `scripts/Run-Project.ps1`.
- Preferred execution directory is `01-FRAMEWORK — Tenant Setup/04-AUT — Automation Executables/scripts`.
- `-ProjectPath` can be provided explicitly to avoid path-resolution ambiguity.
- Path conventions are ontology-dependent and must not be renamed in hardening passes.
