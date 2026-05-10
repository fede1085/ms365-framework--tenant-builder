# ARC-SEC-001 — Enterprise Identity Security Model

## Layer: Security  
## Type: Architecture (Source of Truth)

---

# 1. Objective

Define the core identity security model for the tenant.

This layer establishes:

- account separation
- privileged access
- MFA enforcement
- admin boundaries
- emergency access
- trust levels

The model must remain:

```text
Enterprise-grade
+
SME-operable
```

---

# 2. Core Principle

```text
Protect aggressively
Operate simply
```

Security must:

- reduce risk
- preserve usability
- remain scalable

---

# 3. Identity Security Philosophy

## 3.1 Rule

```text
Identity = primary security perimeter
```

---

## 3.2 Principle

Compromised identity = compromised tenant.

Therefore:

```text
Identity protection has highest priority
```

---

# 4. Account Separation Model

## 4.1 Account Types

| Type | Purpose |
|------|---------|
| Standard Account | daily work |
| Privileged Account | administration |
| Emergency Account | break-glass |

---

## 4.2 Rule

```text
Administrative tasks must NOT use standard accounts
```

---

## 4.3 Example

| User | Standard | Admin |
|------|----------|------|
| John Smith | john.smith@ | adm.john.smith@ |

---

# 5. Privileged Access Model

## 5.1 Principle

```text
Least privilege by default
```

---

## 5.2 Rule

Users receive:

```text
ONLY the permissions required
```

---

## 5.3 Restrictions

```text
No permanent Global Admin usage
No shared admin accounts
No excessive permissions
```

---

# 6. Identity Tiers

## 6.1 Tier Model

| Tier | Description |
|------|-------------|
| Tier 0 | Global administration |
| Tier 1 | Service administration |
| Tier 2 | Standard users |

---

## 6.2 Tier Rules

### Tier 0

```text
Global Admin
Highest protection
Minimal usage
```

---

### Tier 1

```text
Exchange Admin
Teams Admin
SharePoint Admin
```

Limited scope.

---

### Tier 2

```text
Daily operational users
```

---

# 7. MFA Enforcement Model

## 7.1 Mandatory MFA

Required for:

```text
- all admin accounts
- finance roles
- management roles
- remote access
```

---

## 7.2 Principle

```text
No privileged account without MFA
```

---

# 8. Emergency Access Model

## 8.1 Break-Glass Accounts

Purpose:

```text
Emergency tenant recovery
```

---

## 8.2 Requirements

| Requirement | Rule |
|-------------|------|
| MFA exempt | YES |
| Long password | YES |
| Monitored | YES |
| Daily usage | NO |

---

## 8.3 Rule

```text
Break-glass accounts exist ONLY for emergencies
```

---

# 9. Device Trust Principle

## 9.1 Rule

```text
Trusted identity + trusted device
```

---

## 9.2 Principle

Sensitive access should require:

```text
managed or compliant devices
```

---

# 10. Access Boundary Model

## 10.1 Principle

```text
Department access is isolated by default
```

---

## 10.2 Exceptions

Cross-access allowed ONLY when:

```text
Operational dependency exists
```

Example:

```text
WHS Lead → OPS coordination channel
```

---

# 11. Shared Mailbox Security

## 11.1 Rule

```text
Shared Mailboxes are controlled resources
```

---

## 11.2 Restrictions

```text
No uncontrolled SendAs
No anonymous ownership
No orphan mailboxes
```

---

## 11.3 Ownership

Each mailbox requires:

```text
Primary Owner
Secondary Backup Owner
```

---

# 12. Teams Security Principle

## 12.1 Rule

```text
Teams access follows operational responsibility
```

---

## 12.2 Restrictions

```text
No unnecessary shared channels
No public sensitive channels
No uncontrolled guest access
```

---

# 13. Lifecycle Security

## 13.1 Principle

```text
Access must evolve with user lifecycle
```

---

## 13.2 Events

| Event | Action |
|------|--------|
| Joiner | provision |
| Mover | adjust |
| Leaver | revoke |

---

# 14. Monitoring Principle

## 14.1 Rule

```text
Critical identities must be auditable
```

---

## 14.2 Examples

```text
Admin logins
Privilege changes
Mailbox delegation
MFA changes
```

---

# 15. Governance Constraints

## 15.1 Simplicity

```text
Security must remain manageable by SMEs
```

---

## 15.2 Scalability

```text
Model must scale:
10 → 50 → 500+ users
```

---

## 15.3 Compatibility

This model must remain compatible with:

```text
ARCH
BLP
OPS
MTX
AUT
```

---

# 16. Output Impact

Feeds:

```text
ARC-SEC-002 — Conditional Access Strategy
ARC-SEC-003 — MFA Enforcement Model
ARC-GOV-001 — Identity Lifecycle Governance

BLP-SEC-001 — Security Blueprint
MTX-SEC-001 — Security Matrix
```

---

# 17. Final Principle

```text
Strong identity security is the foundation of enterprise maturity
```