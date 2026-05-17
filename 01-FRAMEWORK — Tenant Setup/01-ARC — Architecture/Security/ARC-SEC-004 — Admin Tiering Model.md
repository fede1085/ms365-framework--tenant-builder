# ARC-SEC-004 — Admin Tiering Model

## Layer: Security  
## Type: Architecture (Source of Truth)

---

# 1. Objective

Define the administrative tiering model for the tenant.

This layer establishes:

- admin separation
- privilege boundaries
- admin account classification
- operational restrictions
- privileged workflow isolation

The model must remain:

```text
Enterprise-grade
+
SME-operable
```

---

# 2. Core Principle

```text
Administrative access must be isolated and controlled
```

---

# 3. Admin Tiering Philosophy

## 3.1 Principle

```text
Not all administrators are equal
```

Different administrative roles require:

- different privileges
- different protections
- different restrictions

---

## 3.2 Goal

Reduce risk exposure from privileged identities.

---

# 4. Tiering Model

## 4.1 Tier Definitions

| Tier | Scope | Risk Level |
|------|------|------------|
| Tier 0 | Tenant-wide administration | Critical |
| Tier 1 | Service administration | High |
| Tier 2 | Operational administration | Medium |

---

# 5. Tier 0 — Core Administration

## 5.1 Scope

Examples:

```text
Global Admin
Privileged Role Admin
Security Admin
```

---

## 5.2 Characteristics

```text
Highest privilege
Minimal usage
Strongest protection
```

---

## 5.3 Restrictions

```text
No daily usage
No email activity
No Teams collaboration
No browsing
```

---

## 5.4 Requirements

```text
Dedicated admin account
MFA mandatory
Trusted device
Restricted sessions
```

---

## 5.5 Automation Protection

```text
Tier 0 and Global Administrator accounts are protected objects.
```

Automation must not mutate, disable, delete, recreate, rename, password-reset, role-change, alias-change, license-change, remove ownership, or remove group memberships from these accounts unless a documented emergency override workflow exists.

Example tenant-local protected object:

```text
GLOBAL-Admin / homelab@federicomosqueira0910.onmicrosoft.com
```

## Protected Admin Objects

Privileged administrative accounts that can affect tenant availability or security must be treated as protected objects.

Examples:

- Global Administrator accounts
- break-glass accounts
- security administrator accounts
- tenant owner accounts
- automation operator accounts

The operational protected-object list should be stored per tenant instance:

02-INSTANCES — Projects/<Tenant>/03-MTX — Data Matrices/MTX-PROTECTED-OBJECTS.csv

AUT must not delete, disable, rename, reset, downgrade, relicense, remove aliases, remove ownership, or alter role assignments for these accounts without explicit approval.

---

# 6. Tier 1 — Service Administration

## 6.1 Scope

Examples:

```text
Exchange Admin
Teams Admin
SharePoint Admin
Intune Admin
```

---

## 6.2 Principle

```text
Service-specific administration only
```

---

## 6.3 Restrictions

```text
No unnecessary tenant-wide permissions
```

---

## 6.4 Requirements

```text
Dedicated admin account
MFA mandatory
Managed device preferred
```

---

# 7. Tier 2 — Operational Administration

## 7.1 Scope

Examples:

```text
Helpdesk
Password reset
User provisioning
License management
```

---

## 7.2 Principle

```text
Operational support without elevated control
```

---

## 7.3 Restrictions

```text
No security administration
No tenant-wide changes
```

---

# 8. Administrative Account Model

## 8.1 Rule

```text
Standard account ≠ Admin account
```

---

## 8.2 Example

| User | Standard | Admin |
|------|----------|------|
| John Smith | john.smith@ | adm.john.smith@ |

---

## 8.3 Naming Principle

```text
Admin accounts must remain clearly identifiable
```

---

# 9. Least Privilege Principle

## 9.1 Rule

```text
Administrators receive ONLY required permissions
```

---

## 9.2 Goal

Reduce blast radius during compromise.

---

# 10. Session Isolation Model

## 10.1 Principle

```text
Privileged sessions must remain isolated
```

---

## 10.2 Examples

```text
Separate browser profile
Separate admin workstation
Restricted applications
```

---

# 11. Device Trust Requirements

## 11.1 Tier 0

Requires:

```text
Managed trusted devices only
```

---

## 11.2 Tier 1

Strongly recommended:

```text
Managed devices
```

---

## 11.3 Tier 2

Operational flexibility allowed with controls.

---

# 12. MFA Requirements

## 12.1 Mandatory

All admin tiers require:

```text
MFA enabled
```

---

## 12.2 Tier 0

Should prefer:

```text
Phishing-resistant MFA
```

Examples:

```text
FIDO2
Authenticator
```

---

# 13. Break-Glass Relationship

## 13.1 Rule

```text
Break-glass accounts are NOT operational admin accounts
```

---

## 13.2 Purpose

Emergency recovery only.

---

# 14. Monitoring & Audit Model

## 14.1 Principle

```text
All privileged activity must be auditable
```

---

## 14.2 Examples

```text
Privilege changes
Role assignments
Mailbox delegation
Conditional Access changes
```

---

# 15. Administrative Workflow Model

## 15.1 Rule

```text
Operational work uses standard accounts
Administrative work uses admin accounts
```

---

## 15.2 Goal

Prevent privilege bleed into daily work.

---

# 16. Shared Responsibility Principle

## 16.1 Rule

```text
Critical administrative functions should not depend on one person
```

---

## 16.2 Example

```text
Primary Admin
Secondary Admin
Break-glass account
```

---

# 17. Operational Constraints

## 17.1 SME Compatibility

The model must remain:

```text
manageable by small organizations
```

---

## 17.2 Simplicity Principle

```text
Minimal admin tiers
Maximum clarity
```

---

## 17.3 Scalability

Must support:

```text
10 → 50 → 500+ users
```

---

# 18. Governance Integration

Admin tiering must align with:

```text
Identity lifecycle
Ownership governance
Access reviews
Security policies
```

---

# 19. Automation Compatibility

This model must remain compatible with:

```text
ARC
BLP
OPS
MTX
AUT
```

---

# 20. Output Impact

Feeds:

```text
ARC-GOV-001 — Identity Lifecycle Governance
ARC-GOV-002 — Ownership Governance Model

BLP-SEC-001 — Security Blueprint
BLP-SEC-004 — Admin Access Blueprint

MTX-SEC-003 — Admin Tier Matrix
```

---

# 21. Final Principle

```text
Administrative privilege must remain isolated, minimal, and controlled
```
