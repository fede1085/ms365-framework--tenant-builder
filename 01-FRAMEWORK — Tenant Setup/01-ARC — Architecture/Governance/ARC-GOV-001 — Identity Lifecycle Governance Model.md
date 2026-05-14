# ARC-GOV-001 — Identity Lifecycle Governance Model

## Layer: Governance
## Type: Architecture Standard

---

# 1. Objective

Define how identities are:

- created
- modified
- reviewed
- disabled
- archived
- removed


throughout their lifecycle inside the tenant.

---

# 2. Core Principle

Identities are governed operational assets
NOT permanent objects

---

# 3. Scope

Applies to:

- users
- admins
- guests
- shared identities
- service accounts

---

# 4. Identity Lifecycle States

| State     | Description                |
| --------- | -------------------------- |
| Requested | Pending creation           |
| Active    | Operational identity       |
| Suspended | Temporarily blocked        |
| Mover     | Role/department transition |
| Leaver    | Pending removal            |
| Archived  | Retained for audit         |
| Deleted   | Permanently removed        |

---

# 5. Lifecycle Model

## 5.1 Joiner

### Objective
Create identities safely and consistently

---

### Required Inputs

| Field        | Required |
| ------------ | -------- |
| Display Name | Yes      |
| Department   | Yes      |
| Role         | Yes      |
| Manager      | Yes      |
| License Type | Yes      |
| Access Scope | Yes      |

---

### Governance Rules

- No user created manually outside governance flow
- All users must map to a role
- All users require owner approval

---

# 6. Mover Process

## 6.1 Objective

Handle:

- department changes
- promotions
- responsibility changes

without permission drift.

---

## 6.2 Rules

Old permissions must be reviewed


New permissions inherit from role


Temporary overlap allowed only during transition


---

## 6.3 Transition Window

| Type                 | Maximum |
| -------------------- | ------- |
| Standard Role Change | 7 days  |
| Critical Operations  | 14 days |

---

# 7. Leaver Process

## 7.1 Objective

Safely decommission identities.

---

## 7.2 Immediate Actions

| Action                   | Required |
| ------------------------ | -------- |
| Block sign-in            | Yes      |
| Revoke sessions          | Yes      |
| Remove privileged access | Yes      |
| Transfer ownership       | Yes      |

---

## 7.3 Delayed Actions

| Action             | Retention               |
| ------------------ | ----------------------- |
| Mailbox retention  | 30–90 days              |
| OneDrive retention | According to policy     |
| Audit retention    | According to compliance |

---

# 8. Ownership Governance

## 8.1 Requirement

Every identity must have:
- manager
- department
- operational owner


---

## 8.2 Admin Identities

Privileged identities require separate ownership validation


---

# 9. Privileged Identity Governance

## 9.1 Rules


Admin accounts must be separated from daily identities



No shared admin credentials



Privileged access must be time-limited where possible


---

# 10. Guest Lifecycle

## 10.1 Rules


Guests must have:
- sponsor
- expiration review
- restricted scope


---

## 10.2 Expiration

| Guest Type             | Review Cycle       |
| ---------------------- | ------------------ |
| External Collaboration | 90 days            |
| Vendor                 | 30–90 days         |
| Temporary Project      | Defined expiration |

---

# 11. Inactive Identity Governance

## 11.1 Detection

Detect:

* inactive users
* stale admins
* orphaned accounts

---

## 11.2 Thresholds

| Type          | Threshold  |
| ------------- | ---------- |
| Standard User | 45–90 days |
| Admin User    | 30 days    |
| Guest         | 30–60 days |

---

# 12. Protected Identities

## 12.1 Protected Objects

Critical identities must be protected:


break-glass
global admin
automation accounts
security admins


---


## 12.2 Restrictions


Protected identities cannot be:
- auto-deleted
- auto-modified
- auto-disabled


without explicit approval.

---

## 12.3 Lifecycle Exclusion

Protected admin identities are excluded from normal joiner, mover, and leaver automation.

They require manual governance review before any lifecycle change.

Example protected admin identity pattern:

GLOBAL-Admin / homelab@federicomosqueira0910.onmicrosoft.com

---

# 13. Identity Classification

| Classification | Description                   |
| -------------- | ----------------------------- |
| STANDARD       | Normal operational users      |
| PRIVILEGED     | Admin/security users          |
| SHARED         | Shared operational identities |
| SERVICE        | Automation/service accounts   |
| GUEST          | External collaboration        |

---

# 14. Governance Reviews

## 14.1 Mandatory Reviews

| Review               | Frequency |
| -------------------- | --------- |
| Active Users         | Monthly   |
| Privileged Users     | Monthly   |
| Guests               | Quarterly |
| Ownership Validation | Quarterly |

---

# 15. Automation Rules

## 15.1 Allowed Automation


Provisioning
License assignment
Group assignment
Notifications


---

## 15.2 Restricted Automation


Deletion
Privilege elevation
Protected object modification


require approval.

---

# 16. Compliance Integration

Feeds into:

Audit
Access Reviews
Retention
Conditional Access


---

# 17. Failure Conditions

## 17.1 Critical Violations

Orphaned admin account
Missing owner
Inactive privileged account
Expired guest still active


---

# 18. Final Principle

Identity governance is continuous operational control
NOT one-time provisioning
