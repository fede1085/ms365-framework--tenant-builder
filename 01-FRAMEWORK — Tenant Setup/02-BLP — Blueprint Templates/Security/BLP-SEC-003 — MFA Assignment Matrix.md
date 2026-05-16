# BLP-SEC-003 — MFA Assignment Matrix

## Layer: Security  
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Define the structured MFA assignment matrix used to translate:

```text
Identity risk
+
Role sensitivity
+
Operational exposure
```

into:

```text
Practical MFA enforcement assignments
```

This matrix acts as the operational bridge between:

```text
ARC-SEC-001
ARC-SEC-002
ARC-SEC-003
ARC-SEC-004
```

and:

```text
MTX security deployment data
```

---

# 2. Core Principle

```text
Authentication strength must match operational risk
```

---

# 3. Assignment Logic

MFA assignment is based on:

| Factor | Description |
|-------|-------------|
| Role sensitivity | admin / finance / management |
| Privilege level | tenant impact |
| Remote exposure | external access |
| Operational dependency | workflow criticality |
| Collaboration exposure | Teams / mailbox access |

---

# 4. MFA Enforcement Levels

| Level | Enforcement | Example |
|------|-------------|---------|
| CRITICAL | strongest controls | Global Admin |
| HIGH | mandatory MFA | Finance |
| STANDARD | phased MFA | Operations |
| CONDITIONAL | controlled MFA | Guests |

---

# 5. CRITICAL Level Assignments

## 5.1 Scope

Examples:

```text
Global Admin
Security Admin
Privileged Role Admin
```

---

## 5.2 Requirements

Mandatory:

```text
MFA enabled
Trusted device
Strong authentication methods
Conditional Access protection
```

---

## 5.3 Restrictions

```text
No SMS-only MFA
No unmanaged devices
No legacy authentication
```

---

# 6. HIGH Level Assignments

## 6.1 Scope

Examples:

```text
Finance
Management
IT Administrators
HR
```

---

## 6.2 Requirements

Mandatory:

```text
MFA enabled
Approved authentication methods
Protected sessions
```

---

# 7. STANDARD Level Assignments

## 7.1 Scope

Examples:

```text
Operations
Warehouse coordination
Support
Sales
```

---

## 7.2 Goal

```text
Balanced security + usability
```

---

## 7.3 Rollout Strategy

Priority:

```text
Remote workers
Shared mailbox owners
Cross-department users
```

---

# 8. CONDITIONAL Level Assignments

## 8.1 Scope

Examples:

```text
Guest users
Temporary collaboration accounts
External partners
```

---

## 8.2 Controls

Examples:

```text
MFA required
Restricted collaboration
Limited access scope
```

---

# 9. Authentication Methods Matrix

| Method | Usage |
|-------|------|
| Microsoft Authenticator | Preferred |
| FIDO2 Security Key | High Security |
| SMS | Fallback only |
| Voice Call | Discouraged |

---

# 10. Administrative MFA Rules

## 10.1 Rule

```text
All privileged identities require MFA
```

---

## 10.2 Additional Controls

```text
Restricted sessions
Trusted devices
Conditional Access integration
```

---

# 11. Shared Mailbox Security Relationship

## 11.1 Principle

```text
Mailbox ownership increases identity sensitivity
```

---

## 11.2 Examples

| Mailbox Type | MFA Priority |
|-------------|-------------|
| Finance | HIGH |
| External-facing | HIGH |
| Operations | STANDARD |

---

# 12. Teams Collaboration Relationship

## 12.1 Principle

```text
Cross-department collaboration increases exposure
```

---

## 12.2 Examples

| Collaboration Type | MFA Priority |
|-------------------|-------------|
| Shared channels | HIGH |
| Operational Teams | STANDARD |
| External Teams | HIGH |

---

# 13. Registration Model

## 13.1 Requirements

Users should register:

```text
Primary MFA method
Backup MFA method
```

---

## 13.2 Rule

```text
Avoid single authentication dependency
```

---

# 14. Break-Glass Exception Model

## 14.1 Scope

Applies ONLY to:

```text
Emergency recovery accounts
```

---

## 14.2 Requirements

```text
Strong password
Isolated storage
Continuous monitoring
```

---

## 14.3 Restriction

```text
Break-glass accounts are never operational accounts
```

---

# 15. Rollout Phases

| Phase | Scope |
|------|------|
| Phase 1 | Admin accounts |
| Phase 2 | Finance & Management |
| Phase 3 | Standard users |
| Phase 4 | Guests |

---

# 16. Governance Rules

## 16.1 Naming Convention

Assignments should follow:

```text
MFA-<ROLE>-<LEVEL>
```

Examples:

```text
MFA-ADM-CRITICAL
MFA-FIN-HIGH
MFA-OPS-STANDARD
```

---

## 16.2 Ownership

Each assignment scope requires:

```text
Primary owner
Secondary reviewer
```

---

# 17. Monitoring & Audit

## 17.1 Principle

```text
Critical MFA events must remain auditable
```

---

## 17.2 Examples

```text
MFA disabled
Authentication method changed
Failed MFA attempts
Admin bypass
```

---

# 18. Operational Constraints

## 18.1 SME Compatibility

The model must remain:

```text
manageable by small IT teams
```

---

## 18.2 Simplicity Principle

```text
Minimal complexity
Clear enforcement
```

---

## 18.3 Scalability

Must support:

```text
10 → 50 → 500+ users
```

---

# 19. Integration Model

This blueprint must align with:

```text
Conditional Access
Identity tiers
Admin tiering
Operational workflows
Lifecycle governance
```

---

# 20. Automation Compatibility

This blueprint must remain compatible with:

```text
ARC
BLP
OPS
MTX
AUT
```

---

# 21. Output Mapping

Feeds into:

```text
MTX-SEC-002 — MFA Assignment Matrix
MTX-SEC-003 — Privileged Identity Matrix

AUT-SEC-002 — MFA Enforcement Deployment Script
```

---

# 22. Final Principle

```text
MFA enforcement should strengthen identity trust without breaking operational efficiency
```
