# ARC-GOV-003 — Naming & Classification Governance Model

## Layer: Governance
## Type: Architecture Standard

---

# 1. Objective

Define standardized:

```text
naming
classification
tagging
resource labeling
organizational identification
```

across the tenant.

---

# 2. Core Principle

```text
Every object must be:
- identifiable
- classifiable
- searchable
- governable
```

---

# 3. Scope

Applies to:

- users
- groups
- Teams
- channels
- shared mailboxes
- security groups
- devices
- automation accounts
- SharePoint sites
- workflows
- policies

---

# 4. Naming Philosophy

## 4.1 Objective

```text
Names must describe:
- purpose
- ownership
- scope
- type
```

---

## 4.2 Rules

Names must be:

- predictable
- readable
- scalable
- automation-friendly

---

# 5. Naming Structure

## 5.1 Standard Model

```text
PREFIX-TYPE-SCOPE-NAME
```

---

## 5.2 Examples

| Resource | Example |
|---|---|
| Team | TEAM-OPS-DISPATCH |
| Group | GRP-SEC-ADMINS |
| Mailbox | MBX-BIZ-SUPPORT |
| Device | DEV-CORP-STANDARD |
| Policy | POL-SEC-MFA |
| Automation | AUT-USER-PROVISION |

---

# 6. Prefix Standards

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
| DEV | Device |
| GRP | Group |
| TEAM | Team |
| MBX | Shared Mailbox |

---

# 7. Department Codes

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

# 8. Classification Model

## 8.1 Objective

Classify resources based on:

```text
sensitivity
ownership
risk
operational impact
```

---

# 9. Information Classification Levels

| Level | Description |
|---|---|
| PUBLIC | Public information |
| INTERNAL | Internal operational data |
| CONFIDENTIAL | Sensitive business data |
| RESTRICTED | High-risk protected data |

---

# 10. Operational Classification

## 10.1 Resource Types

| Classification | Purpose |
|---|---|
| BIZ | Business-facing |
| OPS | Operational |
| TECH | Technical |
| SEC | Security |
| EXT | External collaboration |

---

# 11. Naming Governance Rules

## 11.1 Uniqueness

```text
All names must be unique within scope
```

---

## 11.2 Reserved Terms

Restricted names:

```text
admin
root
global
system
security
```

require approval.

---

## 11.3 Human Readability

```text
Names must remain understandable by humans
```

---

# 12. Automation Compatibility

## 12.1 Requirement

```text
Names must support:
- scripting
- filtering
- automation
- reporting
```

---

## 12.2 Restrictions

Avoid:

```text
spaces
special characters
inconsistent abbreviations
```

unless explicitly defined.

---

# 13. Resource Labeling

## 13.1 Labels

Resources may include:

- environment
- sensitivity
- operational tier
- owner category

---

## 13.2 Examples

| Label | Meaning |
|---|---|
| PROD | Production |
| TEST | Testing |
| CRIT | Critical |
| TEMP | Temporary |

---

# 14. Temporary Resources

## 14.1 Requirement

Temporary resources require:

- expiration date
- owner
- cleanup review

---

## 14.2 Naming Rule

```text
TEMP-<RESOURCE>-<PURPOSE>
```

---

# 15. Guest & External Classification

## 15.1 Guest Objects

Guest-related objects must be clearly identifiable.

---

## 15.2 Example

```text
EXT-TEAM-VENDOR-PROJECT
```

---

# 16. Naming Enforcement

## 16.1 Governance Requirement

```text
Naming must be validated during provisioning
```

---

## 16.2 Non-Compliant Objects

Non-compliant names must:

- be flagged
- reviewed
- corrected

---

# 17. Lifecycle Integration

Naming and classification feed into:

```text
automation
security
retention
auditing
access reviews
```

---

# 18. Audit & Reporting

## 18.1 Reporting Requirements

Reports must identify:

- orphaned resources
- inconsistent naming
- missing classifications
- stale temporary objects

---

# 19. Protected Naming Scope

## 19.1 Protected Objects

Protected objects require:

- stricter naming
- ownership validation
- change approval

---

## 19.2 Examples

```text
Global Admin groups
Break-glass accounts
Security policies
Automation identities
```

---

# 20. Failure Conditions

## 20.1 Critical Violations

```text
Duplicate naming
Missing classification
Unknown ownership
Untracked temporary objects
Reserved names without approval
```

---

# 21. Final Principle

```text
Naming is governance metadata
NOT cosmetic formatting
```