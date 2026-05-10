# BLP-TMP-005 — Shared Mailbox Matrix

## SME Logistics Tenant Blueprint

---

## Data Mode

This document contains:
[ ] Real Data
[X] Template Data
[X] Example Data

---

# 1. Purpose

Define all Shared Mailboxes of the tenant.

This matrix feeds:

- Exchange Online mailbox creation
- Full Access permissions
- Send As permissions
- departmental workflows
- Outlook structures
- operational ownership

---

# 2. Shared Mailbox Matrix

| Mailbox ID | Address | Display Name | Department | Type | Purpose | Access Model |
| --- | --- | --- | --- | --- | --- | --- |
| M001 | operations@<domain> | MBX-OPS | Operations | OPS | Daily coordination inbox | Internal |
| M002 | support@<domain> | MBX-BIZ-SUP | Support | BIZ | Client requests / support | External |
| M003 | sales@<domain> | MBX-BIZ-SAL | Sales | BIZ | Quotes / prospects | External |
| M004 | finance@<domain> | MBX-BIZ-FIN | Finance | BIZ | Billing / payments | Internal + External |
| M005 | hr@<domain> | MBX-BIZ-HR | HR | BIZ | Employee administration | Internal |
| M006 | it@<domain> | MBX-TECH-IT | IT | TECH | Internal helpdesk / systems | Internal |
| M007 | admin@<domain> | MBX-SEC-ADM | Admin | SEC | Tenant administration | Internal |
| M008 | billing@<domain> | MBX-BIZ-BIL | Finance | BIZ | Dedicated invoicing mailbox | External |
| M009 | info@<domain> | MBX-EXT-INF | General | EXT | Generic company contact | External |

---

## Mailbox Types

The following mailbox types are used:
- BIZ (Business / Commercial)
- OPS (Operations)
- TECH (Technology / IT)
- SEC (Security / Admin)
- EXT (External / General)

*Note: Mailbox types are defined in Architecture layer.*

---

# 3. Usage Logic

## Internal

Used between departments.

Examples:

```
it@
admin@
operations@
hr@
```

## External

Used with customers / vendors.

Examples:

```
support@
sales@
billing@
info@
```

## Mixed

Internal + external.

Example:

```
finance@
```

---

# 4. Naming Standard

Naming is inherited from Architecture layer. Do not define naming conventions in the Blueprint.

---

# 5. Permission Model

Every mailbox should define:

## Full Access

Can open and manage mailbox.

## Send As

Can send as department identity.

## Owner (conceptual)

Responsible lead.

---

# 6. Suggested Access Model

| Mailbox | Full Access | Send As |
| --- | --- | --- |
| support@<domain> | Support users | Support users |
| sales@<domain> | Sales users | Sales users |
| finance@<domain> | Finance users | Finance users |
| hr@<domain> | HR users | HR users |
| it@<domain> | IT + Admin leads | IT specialists |
| admin@<domain> | Admin specialists | Admin specialists |
| operations@<domain> | Ops coordinators | Ops coordinators |

---

# 7. Folder Blueprint Examples

## support@

```
00-INBOX
01-REQUESTS
02-ISSUES
03-WAITING CLIENT
04-RESOLVED
99-ARCHIVE
```

## it@

```
00-INBOX
01-NEW
02-IN PROGRESS
03-WAITING USER
04-RESOLVED
99-ARCHIVE
```

## finance@

```
00-INBOX
01-INVOICES IN
02-INVOICES OUT
03-PAYMENTS
99-ARCHIVE
```

---

# 8. Governance Rules

- no personal use
- clear department purpose
- minimum two authorized users
- monthly permission review
- archive completed work

---

# 9. Automation Use

This file later generates:

- New-Mailbox -Shared
- Add-MailboxPermission
- Add-RecipientPermission
- aliases
- display names

---

# 10. Next Document

```
BLP-TMP-006 — Permission Matrix
```

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- BLP-SYS-000 — Blueprint Control Layer
- ARC-STD-007 — Naming Convention Standard