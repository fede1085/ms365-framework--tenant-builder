# BLP-COMP-002 — Information Classification Blueprint

## Layer: Compliance
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Define the operational implementation model for:

```text
information classification
data sensitivity
resource labeling
operational data protection
```

across the tenant.

---

# 2. Core Principle

```text
All information must be:
- classifiable
- understandable
- protectable
- governable
```

---

# 3. Scope

Applies to:

- emails
- shared mailboxes
- Teams
- SharePoint
- files
- documents
- operational records
- automation outputs
- exported reports

---

# 4. Classification Model

## 4.1 Classification Levels

| Level | Description |
|---|---|
| PUBLIC | Public information |
| INTERNAL | Internal operational information |
| CONFIDENTIAL | Sensitive business information |
| RESTRICTED | High-risk protected information |

---

# 5. Classification Definitions

## 5.1 PUBLIC

Examples:

- marketing material
- public website content
- public announcements

---

## 5.2 INTERNAL

Examples:

- operational procedures
- internal communication
- department workflows

---

## 5.3 CONFIDENTIAL

Examples:

- financial records
- HR information
- contracts
- customer operational data

---

## 5.4 RESTRICTED

Examples:

- admin credentials
- privileged access data
- security investigations
- legal-sensitive information

---

# 6. Classification Governance

## 6.1 Requirement

```text
All critical operational resources must have classification
```

---

## 6.2 Ownership

Every classified resource requires:

- business owner
- operational owner
- review process

---

# 7. Mailbox Classification Blueprint

## 7.1 Shared Mailboxes

| Mailbox Type | Default Classification |
|---|---|
| MBX-BIZ | INTERNAL |
| MBX-OPS | INTERNAL |
| MBX-FIN | CONFIDENTIAL |
| MBX-SEC | RESTRICTED |
| MBX-EXT | INTERNAL |

---

# 8. Teams Classification Blueprint

## 8.1 Team Classification

Teams inherit classification based on:

- operational purpose
- department
- sensitivity

---

## 8.2 Examples

| Team | Classification |
|---|---|
| TEAM-OPS | INTERNAL |
| TEAM-FIN | CONFIDENTIAL |
| TEAM-SEC | RESTRICTED |

---

# 9. SharePoint Classification Blueprint

## 9.1 Site Classification

SharePoint sites require:

- classification
- owner
- review cycle

---

## 9.2 Examples

| Site Type | Classification |
|---|---|
| Operational | INTERNAL |
| Finance | CONFIDENTIAL |
| Security | RESTRICTED |

---

# 10. File Classification Blueprint

## 10.1 File Rules

Sensitive files require:

- restricted access
- owner
- retention alignment

---

## 10.2 High-Risk Files

High-risk files include:

```text
financial exports
identity exports
admin reports
security reports
audit reports
```

---

# 11. Labeling Blueprint

## 11.1 Labels

Resources may include:

```text
PUBLIC
INTERNAL
CONFIDENTIAL
RESTRICTED
```

---

## 11.2 Governance Rule

```text
Labels must remain consistent across systems
```

---

# 12. Access Alignment

## 12.1 Principle

```text
Higher classification = stricter access
```

---

## 12.2 Examples

| Classification | Access Model |
|---|---|
| PUBLIC | Broad |
| INTERNAL | Departmental |
| CONFIDENTIAL | Restricted |
| RESTRICTED | Explicit approval only |

---

# 13. Retention Alignment

## 13.1 Rule

Retention policies align with classification.

---

## 13.2 Examples

| Classification | Retention Sensitivity |
|---|---|
| PUBLIC | Low |
| INTERNAL | Medium |
| CONFIDENTIAL | High |
| RESTRICTED | Critical |

---

# 14. Automation Integration

## 14.1 Automation Rules

Automation must preserve:

- classification
- ownership
- traceability

---

## 14.2 Restrictions

```text
Restricted information cannot be exported automatically without approval
```

---

# 15. External Collaboration Governance

## 15.1 Guests

Guests cannot access:

```text
RESTRICTED
```

resources by default.

---

## 15.2 Shared Resources

External collaboration requires:

- classification review
- owner approval
- expiration review

---

# 16. Compliance Review Workflow

## 16.1 Reviews

Review:

- missing labels
- incorrect classification
- orphaned sensitive data
- stale restricted resources

---

## 16.2 Frequency

| Review Type | Frequency |
|---|---|
| Operational | Monthly |
| Sensitive Resources | Monthly |
| Restricted Resources | Weekly |

---

# 17. Incident Integration

## 17.1 Security Incidents

Incidents involving:

```text
CONFIDENTIAL
RESTRICTED
```

data require escalation.

---

# 18. Matrix Integration

Feeds into:

```text
MTX-CLASSIFICATION.csv
MTX-RETENTION.csv
MTX-SENSITIVE-RESOURCES.csv
```

---

# 19. Failure Conditions

## 19.1 Critical Violations

```text
Missing classification
Sensitive data without owner
Restricted data shared externally
Inconsistent labels
Unreviewed sensitive resources
```

---

# 20. Final Principle

```text
Information classification is operational risk control
NOT documentation decoration
```