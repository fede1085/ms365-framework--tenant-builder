# ARC-STD-007 — Naming Convention Standard (Base Standard)

## 1. Purpose

Define one universal naming system for the tenant.

This standard controls:

- users
- groups
- Teams
- shared mailboxes
- folders
- tags
- scripts
- scalability

---

# 2. Core Principle

Use names that are:

- clear
- short
- readable
- searchable
- consistent

Avoid random names.

---

# 3. Prefix Dictionary

| Prefix | Meaning |
| --- | --- |
| GLOBAL | Global Administration |
| ADMIN | Administrative Specialists |
| OPS | Operations |
| SUPPORT | Customer Support |
| SALES | Sales |
| FINANCE | Finance |
| HR | Human Resources |
| IT | IT General |
| DEV | Development |
| SECURITY | Security |

---

# 4. User Display Names

## Standard Format

```
PREFIX-FirstName LastName
```

## Examples

```
OPS-Chris Green
SUPPORT-Lisa Bennett
SALES-Anna Carter
FINANCE-Eva Morgan
HR-Nina Brooks
ADMIN-Karina Mosqueira
DEV-Pablo Novoa
SECURITY-Gustavo Betancor
GLOBAL-Federico Mosqueira
```

---

# 5. Usernames / Login IDs

## Functional Users

```
firstname.department@
```

Examples:

```
eva.finance@
john.sales@
nina.hr@
chris.operations@
```

## Technical Users

```
name.function@
```

Examples:

```
licenses.admin@
users.admin@
team.admin@
gustavo.security@
pablo.dev@
```

---

# 6. Shared Mailboxes

## Format

```
function@
```

## Examples

```
support@
sales@
finance@
hr@
it@
admin@
operations@
billing@
info@
```

Rule:

- no spaces
- no sharedmailbox wording
- no mailbox suffix

---

# 7. Department Display Names

## Format

```
DEPT-Name
```

## Examples

```
DEPT-Operations
DEPT-Support
DEPT-Sales
DEPT-Finance
DEPT-HR
DEPT-IT
DEPT-Admin
```

---

# 8. Group / Team Names

## Team Workspaces

```
Operations Team
Support Team
Sales Team
Finance Team
HR Team
IT Team
Dev Team
```

## Non-Team Groups

```
Admin Group
Security Group
Leadership Group
```

---

# 9. Folder Naming

## Format

```
NN-NAME
```

NN = sorting number.

## Examples

```
00-INBOX
01-NEW
02-IN PROGRESS
03-WAITING
04-RESOLVED
99-ARCHIVE
```

---

# 10. Tag / Category Naming

## Priority

```
PRI-HIGH
PRI-MEDIUM
PRI-LOW
```

## Status

```
STAT-OPEN
STAT-INPROGRESS
STAT-WAITING
STAT-CLOSED
```

## Routing

```
DEPT-IT
DEPT-FINANCE
DEPT-SUPPORT
```

---

# 11. Script Naming

## PowerShell Files

```
script01.ps1
script02.ps1
tenant-users-create.ps1
mailbox-permissions-set.ps1
```

---

# 12. Bad Examples (Avoid)

```
john123
teamnew2
Mailbox Shared IT Final
finance_new_real
User Test 7
```

---

# 13. Governance Rules

- one object = one clear purpose
- no duplicates
- no slang
- keep English standard
- use prefixes consistently
- rename legacy chaos gradually

---

# 14. Automation Use

This file feeds scripts for:

- user creation
- display names
- mailboxes
- tags
- folders
- reporting consistency checks

---

# 15. Next Document

```
AUT-DOC-008 — Automation Script Blueprint
```

---

## Naming Hierarchy

- **ARC-STD-007:** Base Standard (This document)
- **ARC-STD-007a:** Usage Guide
- **ARC-STD-007b:** Visual/Emoji Extension

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- ARC-STD-007a — Naming Convention Standard Guide
- ARC-STD-007b — Naming Convention Emoji Guide