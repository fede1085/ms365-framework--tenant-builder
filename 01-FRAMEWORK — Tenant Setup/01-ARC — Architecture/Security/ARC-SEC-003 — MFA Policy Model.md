# ARC-SEC-003 — MFA Policy Model

## Layer: Security  
## Type: Architecture (Source of Truth)

---

# 1. Objective

Define the Multi-Factor Authentication (MFA) model for the tenant.

This layer establishes:

- MFA scope
- enforcement levels
- authentication methods
- privileged access requirements
- operational usability

The model must remain:

```text
Enterprise-grade
+
SME-operable
```

---

# 2. Core Principle

```text
Passwords alone are not trusted
```

MFA becomes the primary protection layer for identities.

---

# 3. MFA Philosophy

## 3.1 Principle

```text
Higher privilege = stronger authentication
```

---

## 3.2 Goal

Protect identities while minimizing operational friction.

---

# 4. MFA Enforcement Levels

## 4.1 Levels

| Level | Target | Requirement |
|------|--------|-------------|
| Critical | Global Admin | mandatory |
| High | IT / Finance / Management | mandatory |
| Standard | Operational users | recommended / phased |
| Guest | External collaboration | controlled |

---

# 5. Mandatory MFA Scope

## 5.1 Required Accounts

Mandatory MFA for:

```text
- Global Admin
- Exchange Admin
- Teams Admin
- Finance roles
- Executive roles
- External remote access
```

---

## 5.2 Rule

```text
No privileged account may operate without MFA
```

---

# 6. Authentication Methods Strategy

## 6.1 Approved Methods

| Method | Status |
|------|--------|
| Microsoft Authenticator | preferred |
| FIDO2 Security Keys | high security |
| SMS | fallback only |
| Voice Call | discouraged |

---

## 6.2 Principle

```text
Prefer phishing-resistant methods when possible
```

---

# 7. Administrative MFA Model

## 7.1 Tier 0 Accounts

Global Admin accounts require:

```text
MFA
Trusted device
Restricted access
```

---

## 7.2 Session Restrictions

```text
Short admin sessions
Frequent reauthentication
No persistent trust
```

---

# 8. User MFA Model

## 8.1 Standard Users

Operational users should gradually adopt MFA.

Priority:

```text
Remote users
Sensitive departments
Shared mailbox owners
```

---

## 8.2 Goal

```text
Increase tenant-wide MFA maturity over time
```

---

# 9. Guest MFA Policy

## 9.1 Principle

```text
External access must not weaken tenant security
```

---

## 9.2 Requirements

Guest users may require:

```text
MFA
Approved domains
Restricted collaboration
```

---

# 10. Break-Glass Exception Model

## 10.1 Purpose

Emergency recovery accounts.

---

## 10.2 Exception Rule

Break-glass accounts may be:

```text
excluded from MFA
```

ONLY if:

```text
strong password
isolated storage
continuous monitoring
```

---

## 10.3 Restriction

```text
Break-glass accounts are never used operationally
```

---

# 11. Registration Strategy

## 11.1 Requirement

Users must register:

```text
Primary MFA method
Backup MFA method
```

---

## 11.2 Rule

```text
No single-point authentication dependency
```

---

# 12. Recovery & Reset Strategy

## 12.1 Goal

Secure recovery without weakening protection.

---

## 12.2 Requirements

| Requirement | Rule |
|-------------|------|
| Identity verification | mandatory |
| Admin approval | controlled |
| Audit logging | enabled |

---

# 13. Operational Constraints

## 13.1 SME Compatibility

The model must remain:

```text
manageable by small IT teams
```

---

## 13.2 Simplicity Principle

```text
Few methods
Clear policies
Low confusion
```

---

## 13.3 Scalability

Must support:

```text
10 → 50 → 500+ users
```

---

# 14. Monitoring Principle

## 14.1 Rule

Critical MFA events must be auditable.

---

## 14.2 Examples

```text
MFA disabled
Method changed
Failed MFA attempts
Admin bypass
```

---

# 15. Conditional Access Integration

MFA policies must integrate with:

```text
Conditional Access
Identity tiers
Device trust
Risk evaluation
```

---

# 16. Governance Integration

MFA must align with:

```text
Lifecycle governance
Role ownership
Access reviews
```

---

# 17. Automation Compatibility

This model must remain compatible with:

```text
ARCH
BLP
OPS
MTX
AUT
```

---

# 18. Output Impact

Feeds:

```text
ARC-SEC-004 — Privileged Access Model
ARC-GOV-001 — Identity Lifecycle Governance

BLP-SEC-001 — Security Blueprint
BLP-SEC-003 — MFA Blueprint

MTX-SEC-002 — MFA Matrix
```

---

# 19. Final Principle

```text
MFA is the minimum baseline for modern identity security
```