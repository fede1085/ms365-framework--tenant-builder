# BLP-TMP-004 — Group Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define collaboration groups of the tenant.

This matrix feeds:

- Microsoft 365 Groups
- Teams
- memberships
- SharePoint sites
- collaboration permissions
- Planner ownership
- communication structure

---

# 2. Group Matrix

| Group ID | Group Name | Type | Prefix | Department | Purpose | Shared Mailbox |
| --- | --- | --- | --- | --- | --- | --- |
| G001 | Operations Team | Team + M365 Group | OPS | Operations | Daily logistics collaboration | operations@ |
| G002 | Support Team | Team + M365 Group | SUPPORT | Support | Client issue coordination | support@ |
| G003 | Sales Team | Team + M365 Group | SALES | Sales | Commercial pipeline | sales@ |
| G004 | Finance Team | Team + M365 Group | FINANCE | Finance | Billing / payments | finance@ |
| G005 | HR Team | Team + M365 Group | HR | HR | Employee lifecycle | hr@ |
| G006 | IT Team | Team + M365 Group | IT | IT | Technical support / projects | it@ |
| G007 | Dev Team | Team + M365 Group | DEV | IT | Development workstream | none |
| G008 | Security Team | M365 Group | SECURITY | IT | Security governance | none |
| G009 | Admin Group | M365 Group | ADMIN | Admin | Tenant administration | admin@ |
| G010 | Leadership Team | Team + M365 Group | EXEC | Executive | Management decisions | none |

---

# 3. Type Meaning

## Team + M365 Group

Creates:

- Microsoft Teams workspace
- Microsoft 365 Group
- SharePoint site
- mailbox/group identity
- Planner support

## M365 Group

Light collaboration without full Teams need.

---

# 4. Membership Logic

## Operations Team

- OPS users
- Support lead optional

## Support Team

- Support users
- Ops coordinator optional

## IT Team

- admins
- security
- dev
- global admin

## Admin Group

- admin.license
- admin.user
- admin.teams
- admin.global

---

# 5. Governance Rules

## Naming

Use readable names:

```
Operations Team
Finance Team
Admin Group
```

## Ownership

Every group needs:

- primary owner
- backup owner

## Lifecycle

Unused groups reviewed quarterly.

---

# 6. SharePoint Logic

Every Team-backed group creates site for:

- files
- department docs
- internal SOPs
- collaboration assets

---

# 7. What NOT to Use Groups For

Do not use groups as:

- ticket queues
- customer support inboxes
- formal departmental mail handling

Use Shared Mailboxes for that.

---

# 8. Automation Use

This file later generates:

- New-MgGroup
- Team creation
- owners
- members
- SharePoint-connected collaboration spaces

---

# 9. Next Document

```
BLP-TMP-005 — Shared Mailbox Matrix
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard