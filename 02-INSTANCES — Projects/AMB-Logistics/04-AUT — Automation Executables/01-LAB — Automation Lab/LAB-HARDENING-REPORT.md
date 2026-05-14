# LAB Hardening Report

## Scope

Controlled LAB hardening was limited to:

- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/`
- `AMB-Logistics/03-MTX — Data Matrices/`

No canonical, framework, architecture, blueprint, or doctrine documents were modified.

## Files Modified

- `AMB-Logistics/03-MTX — Data Matrices/MTX-MAILBOXES.csv`
- `AMB-Logistics/03-MTX — Data Matrices/MTX-GROUPS.csv`
- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/LAB-Create-Mailboxes.ps1`
- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/LAB-Create-Groups.ps1`
- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/LAB-Validation-Report.ps1`
- `AMB-Logistics/04-AUT — Automation Executables/01-LAB — Automation Lab/LAB-HARDENING-REPORT.md`

## Schemas Normalized

### MTX-MAILBOXES.csv

- Replaced legacy `UPN` with execution-facing `TargetAddress`.
- Replaced `OwnerID` with execution-facing `OwnerUPN`.
- Preserved `MailboxID`, display names, aliases, departments, and mailbox purpose records.
- Normalized CSV quoting.

### MTX-GROUPS.csv

- Replaced legacy `Type` with `GroupType`.
- Replaced `OwnerID` with execution-facing `OwnerUPN`.
- Added execution-facing `MailNickname`, `PrimarySMTP`, `MailEnabled`, and `SecurityEnabled`.
- Preserved `GroupID`, display names, departments, descriptions, and existing group intent.
- Set Microsoft 365 team groups as mail-enabled and non-security-enabled.
- Set security groups as non-mail-enabled and security-enabled.
- Normalized CSV quoting.

## Runtime Alignment Status

- `LAB-Create-Mailboxes.ps1` now requires and reads `TargetAddress` and `OwnerUPN`.
- `LAB-Create-Groups.ps1` now requires and reads `GroupType`, `MailNickname`, `PrimarySMTP`, `OwnerUPN`, `MailEnabled`, and `SecurityEnabled`.
- `LAB-Validation-Report.ps1` now validates normalized runtime schemas and distinguishes semantic IDs from execution identifiers.
- Validation report generation is persistent and timestamped:
  - `reports/*.md`
  - `reports/*.json`
  - `logs/*.log`
  - `transcripts/*.log`
- Validation states include:
  - `WAITING_PROPAGATION`
  - `VALIDATING_RESULT`
  - `WARNING`
  - `FAILED`

## Remaining Technical Debt

- `LAB-Deploy-Tenant.ps1` still contains non-dry-run connection branches inherited from the existing LAB orchestrator.
- `LAB-Apply-Permissions.ps1` remains a lightweight placeholder and does not consume group ownership metadata.
- Relationship validation remains matrix-only and does not inspect live Microsoft 365 state.
- Report retention and cleanup policy is not defined.

## Remaining Production Gaps

- No production-grade tenant execution logic was added.
- No production retry, backoff, reconciliation, rollback, or delete workflow exists.
- No live tenant propagation polling exists.
- No destructive cleanup logic exists.
- Human review remains required before any tenant-facing operation.
