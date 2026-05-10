# BLP-TMP-002 — Department Matrix

# BLP-TMP-002 — Department Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define all core departments of the company.

This matrix is the control source for:

- users
- groups
- shared mailboxes
- permissions
- workflows
- automation scripts

---

# 2. Department Matrix

| Department ID | Display Name | Prefix | Core Mission | Shared Mailbox | Team/Group | Priority Level |
| --- | --- | --- | --- | --- | --- | --- |
| D001 | Operations | OPS | Daily logistics execution | operations@ | Operations Team | Critical |
| D002 | Warehouse | WHS | Stock and freight handling | NONE | Warehouse Team | Critical |
| D003 | Support | SUP | Client support / requests | support@ | Support Team | Critical |
| D004 | Sales | SAL | Commercial growth | sales@ | Sales Team | High |
| D005 | Finance | FIN | Billing / payments | finance@ | Finance Team | Critical |
| D006 | IT | IT | Internal systems support | it@ | IT Team | Critical |
| D007 | HR | HR | Employee lifecycle | hr@ | HR Team | High |
| D008 | Admin | ADM | Tenant administration | admin@ | Admin Group | Critical |
| D009 | Management | MGMT | Executive leadership | NONE | NONE | Critical |

---

# 3. Operational Meaning

## Critical

Must function daily.  

Downtime impacts business.

## High

Important but can tolerate short delays.

---

# 4. Department Responsibilities

## Operations

- warehouse coordination
- transport planning
- delivery issues
- scheduling

## Warehouse

- stock control
- freight loading
- picking / packing
- receiver management

## Support

- client mailbox
- incidents
- requests
- follow-up

## Sales

- quotes
- leads
- renewals

## Finance

- invoices
- collections
- supplier payments

## HR

- hiring
- onboarding
- contracts

## IT

- access
- passwords
- devices
- internal issues

## Admin

- users
- licenses
- Teams / Groups
- governance

## Management

- executive decisions
- company strategy
- financial approval

---

# 5. Shared Mailbox Standard

Format:

```
department@<domain>
```

Examples:

```
support@
finance@
it@
admin@
```

---

# 6. Naming Standard

Display:

```
DEPT-Operations
DEPT-Warehouse
DEPT-Support
DEPT-Sales
DEPT-Finance
DEPT-HR
DEPT-IT
DEPT-Admin
DEPT-Management
```

---

# 7. Automation Use

This file later feeds scripts to create:

- groups
- mailboxes
- folder structures
- permissions
- tags

---

# 8. Next Document

```
BLP-TMP-003 — User Matrix
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard