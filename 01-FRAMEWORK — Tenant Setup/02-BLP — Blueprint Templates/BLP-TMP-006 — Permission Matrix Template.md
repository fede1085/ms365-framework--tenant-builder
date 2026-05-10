# BLP-TMP-006 — Permission Matrix

# BLP-TMP-006 — Permission Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define who can access what.

This matrix controls:

- admin roles
- mailbox access
- Send As rights
- group ownership
- least privilege model
- governance boundaries

---

# 2. Permission Philosophy

Use:

```
minimum access needed
```

Not:

```
everyone can do everything
```

**Core Logic (No Real Users):**
- **Lead role** → optional SendAs (where permitted)
- **Team roles** → FullAccess
- **Sensitive mailboxes** → No SendAs, Restricted access

**Permission Rule Hardening:**
- SendAs allowed ONLY for customer-facing mailboxes.
- SendAs forbidden for admin/security/system mailboxes.

---

# 3. Core Admin Role Matrix

| User Role | Role | Scope |
| --- | --- | --- |
| ROLE-EXEC-GLOBAL | Global Administrator | Full tenant control |
| ROLE-ADM-USER | User Administrator | Users / passwords / licenses |
| ROLE-ADM-TEAMS | Teams Administrator | Teams / groups / collaboration |
| ROLE-IT-SEC | Security Administrator | Security / access controls |
| ROLE-IT-DEV | Developer / Power Platform | Apps / automation |

---

# 4. Shared Mailbox Access Matrix

| Mailbox | Full Access | Send As | Owner |
| --- | --- | --- | --- |
| admin@<domain> | ROLE-ADM-USER, ROLE-EXEC-GLOBAL | None | ROLE-EXEC-GLOBAL |
| it@<domain> | ROLE-IT-DEV, ROLE-IT-SEC | None | ROLE-IT-SEC |
| support@<domain> | ROLE-SUP-AGENT | ROLE-SUP-LEAD | ROLE-SUP-LEAD |
| sales@<domain> | ROLE-SAL-REP | ROLE-SAL-LEAD | ROLE-SAL-LEAD |
| finance@<domain> | ROLE-FIN-ANALYST | ROLE-FIN-LEAD (Optional) | ROLE-FIN-LEAD |
| hr@<domain> | ROLE-HR-COORD | ROLE-HR-LEAD (Optional) | ROLE-HR-LEAD |
| operations@<domain> | ROLE-OPS-AGENT | ROLE-OPS-LEAD | ROLE-OPS-LEAD |

---

# 5. Group Ownership Matrix

| Group | Primary Owner | Backup Owner |
| --- | --- | --- |
| Operations Team | ROLE-OPS-LEAD | ROLE-IT-DEV |
| Warehouse Team | ROLE-WHS-LEAD | ROLE-IT-DEV |
| Support Team | ROLE-SUP-LEAD | ROLE-IT-DEV |
| Sales Team | ROLE-SAL-LEAD | ROLE-IT-DEV |
| Finance Team | ROLE-FIN-LEAD | ROLE-IT-DEV |
| HR Team | ROLE-HR-LEAD | ROLE-IT-DEV |
| IT Team | ROLE-IT-SEC | ROLE-IT-DEV |
| Admin Group | ROLE-ADM-USER | ROLE-EXEC-GLOBAL |

---

# 6. User Self-Service Rights

## Standard Users

Allowed:

- change password
- use Teams
- use Outlook
- access assigned groups

Not allowed:

- create uncontrolled groups (optional policy)
- admin center changes
- tenant settings

---

# 7. Sensitive Access Rules

## Finance

Only finance members should access:

```
finance@
billing data
payment files
```

## HR

Only HR members should access:

```
employee docs
contracts
personal data
```

## Admin / IT

Restricted to specialists.

---

# 8. Escalation Logic

## Level 1

Department owner resolves.

## Level 2

Admin / IT reviews.

## Level 3

Global Admin decides.

---

# 9. Governance Rules

- no shared passwords
- use delegated access
- remove leavers quickly
- review quarterly
- keep owner + backup owner
- avoid permanent excessive rights

---

# 10. Automation Use

This file later generates:

- Add-MailboxPermission
- Add-RecipientPermission
- Add-MgGroupOwner
- Add-MgGroupMember
- role assignments

---

# 11. Recommended Future Policies

- MFA for admins
- privileged admin accounts
- access reviews
- approval flow for new shared mailboxes

---

# 12. Next Document

```
BLP-ARC-STD-007 — Naming Convention Standard
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard