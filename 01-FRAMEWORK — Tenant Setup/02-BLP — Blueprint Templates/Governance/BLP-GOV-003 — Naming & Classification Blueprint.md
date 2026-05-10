# BLP-GOV-003 — Naming & Classification Blueprint

## Layer: Governance
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Define the operational implementation model for:

```text
naming
classification
resource labeling
organizational identification
```

across the tenant.

---

# 2. Core Principle

```text
All objects must be:
- identifiable
- searchable
- classifiable
- automation-ready
```

---

# 3. Scope

Applies to:

- users
- groups
- Teams
- channels
- shared mailboxes
- devices
- policies
- automation objects
- workflows
- SharePoint resources

---

# 4. Naming Blueprint Model

## 4.1 Standard Structure

```text
PREFIX-TYPE-SCOPE-NAME
```

---

## 4.2 Naming Goals

Names must:

- describe purpose
- define ownership
- define operational scope
- support automation
- remain human-readable

---

# 5. Prefix Blueprint

| Prefix | Purpose |
|---|---|
| ARC | Architecture |
| BLP | Blueprint |
| MTX | Matrix |
| AUT | Automation |
| GOV | Governance |
| SEC | Security |
| COMP | Compliance |
| OPS | Operations |
| POL | Policy |
| TEAM | Team |
| GRP | Group |
| MBX | Shared Mailbox |
| DEV | Device |

---

# 6. Department Codes

| Code | Department |
|---|---|
| OPS | Operations |
| WHS | Warehouse |
| FIN | Finance |
| SAL | Sales |
| SUP | Support |
| IT | IT |
| SEC | Security |
| MGMT | Management |

---

# 7. User Naming Blueprint

## 7.1 UPN Structure

```text
firstname.lastname@domain
```

---

## 7.2 Admin Accounts

```text
adm.firstname.lastname@domain
```

---

## 7.3 Service Accounts

```text
svc-purpose@domain
```

---

# 8. Group Naming Blueprint

## 8.1 Standard Groups

```text
GRP-OPS-DISPATCH
GRP-FIN-INVOICING
```

---

## 8.2 Security Groups

```text
GRP-SEC-ADMINS
GRP-SEC-CA-POLICY
```

---

# 9. Teams Naming Blueprint

## 9.1 Team Structure

```text
TEAM-OPS
TEAM-FIN
TEAM-SUP
```

---

## 9.2 Channel Structure

```text
CH-GEN-General
CH-FNC-Dispatch
CH-XD-Warehouse
CH-SEC-Restricted
```

---

# 10. Shared Mailbox Naming Blueprint

## 10.1 Structure

```text
MBX-BIZ-SUPPORT
MBX-OPS-DISPATCH
MBX-EXT-INFO
```

---

## 10.2 Classification Types

| Type | Purpose |
|---|---|
| BIZ | Business-facing |
| OPS | Operational |
| TECH | Technical |
| SEC | Security |
| EXT | External collaboration |

---

# 11. Device Naming Blueprint

## 11.1 Standard Devices

```text
DEV-CORP-STANDARD
DEV-WHS-SHARED
DEV-IT-ADMIN
```

---

## 11.2 Temporary Devices

```text
TEMP-DEV-PROJECT
```

---

# 12. Classification Blueprint

## 12.1 Information Classification Levels

| Level | Description |
|---|---|
| PUBLIC | Public information |
| INTERNAL | Internal operational data |
| CONFIDENTIAL | Sensitive business data |
| RESTRICTED | High-risk protected data |

---

# 13. Operational Classification Blueprint

## 13.1 Resource Categories

| Category | Purpose |
|---|---|
| OPS | Operational |
| BIZ | Business-facing |
| TECH | Technical |
| SEC | Security |
| EXT | External collaboration |

---

# 14. Temporary Resource Governance

## 14.1 Requirements

Temporary resources require:

- owner
- expiration date
- review cycle

---

## 14.2 Naming Standard

```text
TEMP-<RESOURCE>-<PURPOSE>
```

---

# 15. Guest & External Classification

## 15.1 Guest Objects

External collaboration objects must be identifiable.

---

## 15.2 Examples

```text
EXT-TEAM-VENDOR
EXT-GRP-PROJECT
```

---

# 16. Automation Compatibility

## 16.1 Requirement

Names must support:

```text
filtering
reporting
automation
validation
auditing
```

---

## 16.2 Restrictions

Avoid:

```text
special characters
inconsistent abbreviations
duplicate names
undefined prefixes
```

---

# 17. Naming Validation Workflow

## 17.1 Provisioning Validation

Naming must be validated during:

- provisioning
- synchronization
- automation execution

---

## 17.2 Invalid Objects

Invalid objects must:

```text
be flagged
be reviewed
be corrected
```

---

# 18. Protected Naming Scope

## 18.1 Protected Objects

Protected resources include:

```text
Global Admin groups
Security policies
Break-glass accounts
Automation identities
```

---

## 18.2 Governance Requirement

Protected resources require:

- stricter naming validation
- ownership validation
- approval workflow

---

# 19. Lifecycle Integration

Naming and classification feed into:

```text
security
automation
retention
auditing
access reviews
governance
```

---

# 20. Matrix Integration

Feeds into:

```text
MTX-USERS.csv
MTX-GROUPS.csv
MTX-MAILBOXES.csv
MTX-DEVICES.csv
MTX-CLASSIFICATION.csv
```

---

# 21. Failure Conditions

## 21.1 Critical Violations

```text
Duplicate naming
Missing classification
Unknown ownership
Undefined prefixes
Protected resources without governance
```

---

# 22. Final Principle

```text
Naming and classification are governance controls
NOT cosmetic conventions
```