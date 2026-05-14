# LAB Hardening Report

## Scope

Controlled runtime hardening was limited to:

- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/`
- `AMB-Logistics/03-MTX — Data Matrices/`

No canonical, framework, architecture, blueprint, doctrine, discovery, BLP, or other tenant files were intentionally modified.

## Runtime Status

The LAB layer is now a tenant-local controlled runtime:

- Tenant-local controlled runtime
- Production-ready guarded execution
- Protected-object enforced
- No license assignment
- No destructive default behavior
- DryRun first
- Execute requires explicit confirmation

This is production-ready for controlled AMB-Logistics tenant execution. It is not a generic enterprise automation platform.

## Files Updated

- `LAB-Protected-Objects.ps1`
- `LAB-Run-Project.ps1`
- `LAB-Deploy-Tenant.ps1`
- `LAB-Create-Users.ps1`
- `LAB-Create-Groups.ps1`
- `LAB-Create-Mailboxes.ps1`
- `LAB-Apply-Permissions.ps1`
- `LAB-Validation-Report.ps1`
- `LAB-README.md`
- `LAB-HARDENING-REPORT.md`

## Execution Capabilities

- Users: `New-MgUser` for missing users; `Update-MgUser` for safe field updates only.
- Groups: `New-MgGroup` for missing groups; `Update-MgGroup` for safe metadata updates; `New-MgGroupOwnerByRef` for missing explicit owners.
- Shared mailboxes: `New-Mailbox -Shared` for missing shared mailboxes; bounded propagation polling at 15, 30, and 60 seconds.
- Permissions: `Add-MailboxPermission`, `Add-RecipientPermission`, `Set-Mailbox -GrantSendOnBehalfTo`, `New-MgGroupMemberByRef`, and `New-MgGroupOwnerByRef` for supported add-if-missing operations.
- Validation: static validation by default; live validation only with `-LiveValidation`.

## Protected Identity Enforcement

`GLOBAL-Admin` is protected by:

- UPN: `homelab@federicomosqueira0910.onmicrosoft.com`
- Aliases: `global.admin@federicomosqueira.site`, `hello@federicomosqueira.site`
- Display name: `GLOBAL-Admin`
- Role: `Global Administrator`
- ObjectId placeholder: `<UNKNOWN_OBJECT_ID_GLOBAL_ADMIN>`

Runtime ObjectId protection is supported through:

- `-ProtectedGlobalAdminObjectId "<object-id>"`
- dynamic `Add-LabProtectedObjectId`
- read-only live lookup with `Get-MgUser -UserId "homelab@federicomosqueira0910.onmicrosoft.com"` before write phases

If the ObjectId remains unresolved, the runtime logs:

```text
GLOBAL-Admin ObjectId unresolved; protection continues by UPN, alias, display name, and role.
```

## Guard Rails

- Protected-object policy loads before any tenant connection.
- Scripts fail closed if `LAB-Protected-Objects.ps1` is missing.
- `Confirm-LabProtectedBaseline` fails if required GLOBAL-Admin UPN, aliases, display name, or role are missing.
- Write operations call `Assert-LabNotProtectedObject` or equivalent target guard before tenant-facing mutation.
- Current connected Graph account is added to runtime mutation protection.
- Non-DryRun execution requires the hard phrase `I UNDERSTAND THIS WILL MODIFY THE TENANT`.
- No licenses are assigned.
- No deletion, wipe, reset, or destructive reconciliation path is implemented by default.

## Remaining Limitations

- Live validation verifies supported objects and common permission paths; it does not implement a full privileged role audit beyond the protected identity existence/enabled checks.
- SharePoint permission application is not part of this runtime branch.
- Propagation polling is intentionally bounded and may require a later rerun if Microsoft 365 propagation exceeds the configured waits.
- There is no rollback automation.
- There is no report retention cleanup policy.
