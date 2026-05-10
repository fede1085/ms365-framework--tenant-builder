# ARC-SEC-002 — Conditional Access Strategy

## Layer: Security  
## Type: Architecture (Source of Truth)

---

# 1. Objective

Define the tenant Conditional Access strategy used to protect:

- identities
- administrative access
- remote access
- sensitive resources

The model must remain:

```text
Enterprise-grade
+
SME-operable
```

---

# 2. Core Principle

```text
Access is never automatically trusted
```

Access decisions must evaluate:

- identity
- device
- location
- risk
- role

---

# 3. Conditional Access Philosophy

## 3.1 Principle

```text
Verify explicitly
```

---

## 3.2 Goal

Reduce risk without creating operational friction.

---

# 4. Security Scope

Conditional Access applies to:

```text
Microsoft 365 services
Administrative portals
Remote authentication
Sensitive applications
```

---

# 5. Identity Protection Model

## 5.1 Rule

```text
Higher privilege = higher protection
```

---

## 5.2 Protection Priority

| Priority | Target |
|----------|--------|
| Critical | Global Admin |
| High | IT / Finance / Management |
| Standard | Operational users |

---

# 6. MFA Enforcement Policies

## 6.1 Mandatory MFA

Required for:

```text
- all admin accounts
- finance roles
- executive roles
- external access
```

---

## 6.2 Rule

```text
No privileged access without MFA
```

---

# 7. Administrative Access Policy

## 7.1 Tier 0 Protection

Global Admin access requires:

```text
MFA
Trusted device
Controlled access
```

---

## 7.2 Restrictions

```text
No admin access from unmanaged devices
No permanent browser sessions
No risky sign-ins
```

---

# 8. Device Compliance Strategy

## 8.1 Principle

```text
Sensitive access requires trusted devices
```

---

## 8.2 Trusted Devices

Examples:

```text
Intune compliant devices
Hybrid joined devices
Managed company laptops
```

---

## 8.3 Restrictions

```text
Block sensitive access from unknown devices
```

---

# 9. Geographic Access Strategy

## 9.1 Rule

```text
Access should follow operational geography
```

---

## 9.2 Examples

Allowed:

```text
Belgium
Netherlands
Approved travel locations
```

Blocked:

```text
Unexpected high-risk regions
```

---

# 10. Risk-Based Access

## 10.1 Principle

```text
Higher sign-in risk = stricter controls
```

---

## 10.2 Examples

| Risk | Action |
|------|--------|
| Low | allow |
| Medium | require MFA |
| High | block |

---

# 11. Session Control Strategy

## 11.1 Goal

Reduce persistent exposure.

---

## 11.2 Rules

```text
Shorter admin sessions
Reauthentication for sensitive actions
Limited persistent sessions
```

---

# 12. Guest Access Protection

## 12.1 Principle

```text
Guest access is controlled, not open
```

---

## 12.2 Restrictions

```text
No unrestricted guest sharing
No anonymous collaboration
No sensitive access for guests
```

---

## 12.3 Requirements

Guest users may require:

```text
MFA
Approved domains
Restricted Teams access
```

---

# 13. Teams Conditional Access

## 13.1 Rule

```text
Operational collaboration must remain protected
```

---

## 13.2 Examples

| Area | Protection |
|------|------------|
| Shared channels | controlled membership |
| Sensitive Teams | restricted access |
| External Teams | guest limitations |

---

# 14. Mailbox Protection Strategy

## 14.1 Rule

```text
Mailbox access follows security tier
```

---

## 14.2 Examples

| Mailbox Type | Protection |
|-------------|------------|
| Finance | MFA required |
| Admin | restricted access |
| External-facing | monitored |

---

# 15. Emergency Access Exception

## 15.1 Break-Glass Accounts

Conditional Access exclusions allowed ONLY for:

```text
Emergency recovery accounts
```

---

## 15.2 Rule

```text
Break-glass accounts must remain isolated and monitored
```

---

# 16. Operational Constraints

## 16.1 SME Compatibility

The model must:

```text
Remain manageable by small IT teams
```

---

## 16.2 Simplicity Principle

```text
Minimal policies
Maximum clarity
```

---

## 16.3 Scalability

Must support:

```text
10 → 50 → 500+ users
```

---

# 17. Governance Integration

Conditional Access must align with:

```text
Identity lifecycle
Role model
Ownership model
Operational workflows
```

---

# 18. Automation Compatibility

This strategy must remain compatible with:

```text
ARCH
BLP
OPS
MTX
AUT
```

---

# 19. Output Impact

Feeds:

```text
ARC-SEC-003 — MFA Enforcement Model
ARC-GOV-001 — Identity Lifecycle Governance

BLP-SEC-001 — Security Blueprint
BLP-SEC-002 — Conditional Access Blueprint

MTX-SEC-001 — Conditional Access Matrix
```

---

# 20. Final Principle

```text
Conditional Access = adaptive trust control layer
```