# BLP-TMP-003 — User Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define all core users of the tenant.

This template guides MTX generation for:

- user creation scripts
- display names
- departments
- licenses
- group memberships
- mailbox permissions
- admin roles

---

# 2. User Matrix

> **Note: Example data only — not automation source of truth.**
> This document defines ROLE STRUCTURE, not real users.
> Production automation should use the structured lists in the MATRICES layer.

**Example:**

| Role ID | Example Display Name | Example Username | Prefix | Department | Role | License |
| --- | --- | --- | --- | --- | --- | --- |
| R001 | ROLE-EXEC-GLOBAL | admin.global | GLOBAL | Executive | Global Administrator | Yes |
| R002 | ROLE-ADM-LICENSE | admin.license | ADM | Admin | License Admin | No |
| R003 | ROLE-ADM-USER | admin.user | ADM | Admin | User Admin | No |
| R004 | ROLE-ADM-TEAMS | admin.teams | ADM | Admin | Teams Admin | No |
| R005 | ROLE-IT-SEC | admin.security | IT | IT | Security Admin | No |
| R006 | ROLE-IT-DEV | dev.user | IT | IT | Developer | No |
| R007 | ROLE-OPS-AGENT | ops.agent | OPS | Operations | Ops Agent | Optional |
| R008 | ROLE-SAL-REP | sales.rep | SAL | Sales | Sales Rep | Optional |
| R009 | ROLE-FIN-ANALYST | finance.analyst | FIN | Finance | Finance Analyst | Optional |
| R010 | ROLE-HR-COORD | hr.coord | HR | HR | HR Coordinator | Optional |
| R011 | ROLE-SUP-AGENT | support.agent | SUP | Support | Support Agent | Optional |

---

# 3. Username Standard

## Technical / Admin Users

```
name.function@
```

Examples:

```
admin.license
admin.user
admin.teams
admin.security
dev.user
```

---

## Functional Users

```
firstname.department@
```

Examples:

```
finance.analyst
sales.rep
hr.coord
ops.agent
```

---

# 4. Display Name Standard

```
PREFIX-FirstName LastName
```

Examples:

```
ADM-License Admin
IT-Developer
OPS-Ops Agent
FIN-Finance Analyst
SUP-Support Agent
```

---

# 5. Licensing Logic

## Licensed

Needs Outlook / Teams / Apps.

## Optional

Can remain unlicensed in lab mode.

## No

Admin identity only.

---

# 6. Governance Logic

## One identity = one clear role

Avoid generic users.

## Shared work = mailbox, not personal user.

## Admin roles separated.

---

# 7. MTX Generation Use

This file guides generation of MTX user data. It is not AUT runtime input.

- user runtime rows
- generated password strategy
- license contract fields
- display names
- department fields
- usage location

---

# 8. Next Document

```
BLP-TMP-004 — Group Matrix
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard
