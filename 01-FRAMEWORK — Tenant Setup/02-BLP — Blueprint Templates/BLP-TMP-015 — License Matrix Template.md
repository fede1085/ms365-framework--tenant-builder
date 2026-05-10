# BLP-TMP-015 — License Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define the licensing model for the tenant.

Goal:

Assign the right Microsoft 365 license to the right user role.

Avoid:

- overpaying
- underlicensing
- random assignments
- inconsistent features

This document is optimized for SME environments.

---

# 2. Licensing Philosophy

Use:

- role-based assignment
- minimum viable cost
- upgrade only when justified
- standardization
- easy automation

Rule:

Same role = same license whenever possible.

License assignment based on:
- communication requirement
- collaboration requirement
- system access level

---

# 3. Recommended Core License Stack

| Tier | Typical Microsoft License | Use Case |
|---|---|---|
| Basic | Microsoft 365 Business Basic | Web apps + email + Teams |
| Standard | Microsoft 365 Business Standard | Desktop Office + business users |
| Premium | Microsoft 365 Business Premium | Security + device management |
| Frontline | Microsoft 365 F3 (optional) | Warehouse / mobile workers |

---

# 4. Department Role Matrix

| Department | Typical Users | Recommended License |
|---|---|---|
| Operations | Coordinators / planners | Business Basic / Standard |
| Warehouse | Floor users / scanners | F3 / Basic |
| Support | Shared mailbox operators | Business Basic |
| Sales | Client-facing staff | Business Standard |
| Finance | Sensitive data users | Business Premium |
| HR | Sensitive data users | Business Premium |
| IT | Admin / technical staff | Business Premium |
| Admin | Back office | Business Standard / Premium |
| Leadership | Managers | Business Standard / Premium |

---

# 5. Example Role Matrix

| Role | License |
|---|---|
| ROLE-WHS-OPERATOR | None / Basic |
| ROLE-OPS-AGENT | Business Basic |
| ROLE-OPS-COORDINATOR | Business Premium |
| ROLE-SAL-REP | Business Standard |
| ROLE-FIN-ANALYST | Business Premium |
| ROLE-HR-COORD | Business Premium |
| ROLE-IT-SEC | Business Premium |
| ROLE-EXEC-GLOBAL | Business Standard / Premium |

---

# 6. Feature Logic

## Business Basic

Includes:

- Exchange email
- Teams
- OneDrive
- Web Office apps

Best for:

- users using browser only
- shared PCs
- light office users

## Business Standard

Adds:

- Desktop Word / Excel / Outlook
- more productivity needs

Best for:

- office staff
- sales
- managers

## Business Premium

Adds:

- Intune
- Conditional Access (via Entra capabilities in package)
- stronger security
- device management

Best for:

- IT
- Finance
- HR
- privileged users

---

# 7. Shared Mailbox Note

Shared mailboxes usually do not need a separate license when within Microsoft limits and used correctly.

Use user licenses for people, not for generic mailboxes.

Examples:

- support@
- finance@
- hr@
- info@

---

# 8. Automation Model

Licenses can be assigned by:

- department
- group membership
- job title
- CSV import
- onboarding workflow

Example:

ROLE-FIN-ANALYST -> Premium  
ROLE-SAL-REP -> Standard

---

# 9. Cost Optimization Rules

- Review inactive users monthly
- Remove leavers quickly
- Downgrade unused premium users
- Standardize by role
- Avoid one-off custom assignments

---

# 10. Security Upgrade Rules

Upgrade to Premium when user needs:

- company laptop management
- stronger security controls
- privileged access
- sensitive data handling

---

# 11. Joiner / Mover / Leaver Logic

## Joiner

Assign license based on department role.

## Mover

Recalculate license after role change.

## Leaver

Remove license immediately.

---

# 12. Governance Rules

- Every licensed user must have business reason
- No zombie licenses
- No admin without proper security tier
- Review quarterly
- Keep matrix updated after org changes

---

# 13. Example CSV Source

users.csv

Name,Department,Role,License

Juan Perez,Sales,Rep,Standard  
Ana Costa,Finance,Analyst,Premium  
Luis Vega,Warehouse,Operator,F3

---

# 14. Recommended SME Baseline

## Low Cost Setup

- Most users = Basic
- Few users = Standard
- Key users = Premium

## Mature Setup

- Frontline = F3
- Office = Standard
- Sensitive/Admin = Premium

---

# 15. Priority Order

1. Admin accounts licensed correctly
2. Finance / HR secured
3. Office productivity users
4. Frontline optimization
5. Monthly cleanup

---

# 16. Final Principle

Do not buy licenses by person names.

Buy by business function.

---

# 17. Next Document

```
ARC-GOV-016 — User Lifecycle Model
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard