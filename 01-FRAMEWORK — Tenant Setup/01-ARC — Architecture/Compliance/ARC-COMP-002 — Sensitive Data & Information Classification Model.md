# ARC-COMP-002 — Sensitive Data & Information Classification Model

## Layer: Compliance
## Type: Architecture Standard

---

# 1. Objective

Define how information is:

```text
classified
protected
stored
shared
reviewed
retained
```

across the tenant.

---

# 2. Core Principle

```text
All information must have:
- classification
- ownership
- protection level
```

---

# 3. Scope

Applies to:

- emails
- Teams messages
- documents
- SharePoint files
- OneDrive files
- exports
- reports
- automation outputs
- CSV matrices
- audit logs

---

# 4. Information Classification Philosophy

## 4.1 Objective

Classify information according to:

```text
business sensitivity
operational impact
security risk
compliance exposure
```

---

## 4.2 Rule

```text
Protection level follows data sensitivity
```

---

# 5. Classification Levels

| Level | Description |
|---|---|
| PUBLIC | Non-sensitive public information |
| INTERNAL | Internal operational information |
| CONFIDENTIAL | Sensitive business information |
| RESTRICTED | Highly sensitive protected information |

---

# 6. PUBLIC Classification

## 6.1 Characteristics

```text
Low risk
Externally shareable
No operational impact
```

---

## 6.2 Examples

- public website content
- marketing materials
- public company information

---

# 7. INTERNAL Classification

## 7.1 Characteristics

```text
Operationally relevant
Internal collaboration only
Moderate exposure risk
```

---

## 7.2 Examples

- operational procedures
- Teams collaboration
- department workflows
- internal project documentation

---

# 8. CONFIDENTIAL Classification

## 8.1 Characteristics

```text
Sensitive business impact
Restricted internal visibility
Controlled sharing required
```

---

## 8.2 Examples

- financial information
- HR documents
- customer operational data
- internal reports
- governance documents

---

# 9. RESTRICTED Classification

## 9.1 Characteristics

```text
High operational risk
Security-sensitive
Strict access control required
```

---

## 9.2 Examples

- privileged access exports
- admin credentials references
- security policies
- break-glass procedures
- protected automation secrets

---

# 10. Ownership Requirements

## 10.1 Mandatory Ownership

```text
All classified information requires ownership
```

---

## 10.2 Owner Responsibilities

Owners must:

- validate classification
- validate sharing scope
- review retention
- approve external sharing

---

# 11. Access Control Model

## 11.1 Classification-Based Access

| Classification | Access Scope |
|---|---|
| PUBLIC | Broad |
| INTERNAL | Employees |
| CONFIDENTIAL | Approved Internal |
| RESTRICTED | Explicitly Authorized |

---

## 11.2 Least Access Principle

```text
Access follows business necessity
```

---

# 12. Sharing Governance

## 12.1 External Sharing

| Classification | External Sharing |
|---|---|
| PUBLIC | Allowed |
| INTERNAL | Restricted |
| CONFIDENTIAL | Approval Required |
| RESTRICTED | Forbidden |

---

## 12.2 Guest Restrictions

```text
Guests cannot access RESTRICTED information
```

---

# 13. Storage Governance

## 13.1 Approved Storage

Classified information must remain inside:

- approved SharePoint sites
- approved Teams
- governed mailboxes
- managed OneDrive

---

## 13.2 Restrictions

```text
Sensitive information cannot be stored:
- locally
- unmanaged devices
- personal cloud storage
```

---

# 14. Teams & Collaboration Governance

## 14.1 Teams Classification

Teams should inherit classification.

---

## 14.2 Shared Channels

```text
Shared channels cannot expose RESTRICTED information
```

---

# 15. Email Governance

## 15.1 Sensitive Email Rules

Sensitive emails require:

- controlled recipients
- correct classification
- retention compliance

---

## 15.2 Restricted Information

```text
RESTRICTED information should avoid email when possible
```

---

# 16. Automation Governance

## 16.1 Sensitive Automation Outputs

Automation outputs containing:

- identities
- permissions
- security exports
- audit results

must inherit classification.

---

## 16.2 Matrix Governance

| Matrix Type | Recommended Classification |
|---|---|
| MTX-USERS | CONFIDENTIAL |
| MTX-PERMISSIONS | RESTRICTED |
| MTX-SECURITY | RESTRICTED |
| Reports | INTERNAL / CONFIDENTIAL |

---

# 17. Device & Endpoint Integration

## 17.1 Access Restrictions

Sensitive information requires:

- managed devices
- compliant sessions
- MFA enforcement

---

## 17.2 Unmanaged Devices

```text
Unmanaged devices cannot access RESTRICTED data
```

---

# 18. Retention Integration

## 18.1 Retention Dependency

Retention must align with:

- classification
- legal requirements
- operational requirements

---

## 18.2 High-Risk Data

```text
RESTRICTED data requires stricter retention controls
```

---

# 19. Audit & Monitoring

## 19.1 Monitoring Requirements

Monitor:

- external sharing
- unusual downloads
- permission drift
- exposure risk

---

## 19.2 Audit Visibility

```text
Sensitive data access must be auditable
```

---

# 20. Labeling Model

## 20.1 Label Structure

```text
CLASSIFICATION + SCOPE + OWNER
```

---

## 20.2 Examples

```text
CONFIDENTIAL-FINANCE
RESTRICTED-SECURITY
INTERNAL-OPS
```

---

# 21. Governance Reviews

## 21.1 Mandatory Reviews

| Review Type | Frequency |
|---|---|
| Classification Review | Quarterly |
| External Sharing Review | Monthly |
| Restricted Access Review | Monthly |
| Sensitive Storage Review | Quarterly |

---

# 22. Failure Conditions

## 22.1 Critical Violations

```text
Restricted data externally shared
Missing classification
Unknown ownership
Sensitive data on unmanaged device
Untracked external access
```

---

# 23. Integration Points

Feeds into:

```text
Conditional Access
Retention
DLP
Access Reviews
Security Governance
Automation Governance
```

---

# 24. Final Principle

```text
Classification is operational protection metadata
NOT cosmetic labeling
```