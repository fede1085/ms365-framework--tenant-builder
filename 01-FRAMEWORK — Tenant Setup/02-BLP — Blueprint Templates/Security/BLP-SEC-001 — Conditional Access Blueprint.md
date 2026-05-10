# BLP-SEC-001 — Conditional Access Blueprint

## Layer: Security  
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Translate the Conditional Access Strategy (ARC-SEC-002) into:

```text
Structured, repeatable, automation-ready security policies
```

This blueprint defines:

- Conditional Access policy structure
- target groups
- enforcement logic
- operational restrictions
- implementation boundaries

---

# 2. Scope

Applies to:

```text
Microsoft 365 identities
Administrative access
Remote access
Sensitive workloads
```

---

# 3. Core Principle

```text
Access evaluation must be adaptive
```

Access decisions should evaluate:

- user role
- device trust
- location
- privilege level
- risk level

---

# 4. Policy Structure Model

## 4.1 Standard Policy Components

Each policy must define:

| Component | Description |
|----------|-------------|
| Target | users / groups |
| Cloud Apps | protected resources |
| Conditions | risk / device / location |
| Controls | MFA / block / restrictions |
| Exceptions | approved exclusions |

---

# 5. Policy Categories

## 5.1 Identity Protection Policies

Purpose:

```text
Protect privileged and sensitive identities
```

Examples:

```text
Require MFA for admins
Block risky sign-ins
```

---

## 5.2 Device Protection Policies

Purpose:

```text
Restrict sensitive access to trusted devices
```

Examples:

```text
Require compliant device
Block unmanaged admin access
```

---

## 5.3 Session Protection Policies

Purpose:

```text
Reduce persistent exposure
```

Examples:

```text
Short admin sessions
Reauthentication requirements
```

---

# 6. Administrative Protection Policies

## 6.1 Tier 0 Accounts

Applies to:

```text
Global Admin
Security Admin
Privileged Role Admin
```

---

## 6.2 Controls

Required:

```text
MFA
Trusted device
Restricted sign-in
```

---

## 6.3 Restrictions

```text
No unmanaged devices
No risky sign-ins
No weak MFA methods
```

---

# 7. Operational User Policies

## 7.1 Standard Users

Goal:

```text
Balanced protection + usability
```

---

## 7.2 Controls

Examples:

```text
MFA for remote access
Session controls
Basic risk protection
```

---

# 8. Finance & Executive Protection

## 8.1 Scope

Applies to:

```text
Finance roles
Management roles
Sensitive departments
```

---

## 8.2 Controls

Required:

```text
MFA mandatory
Risk-based protection
Restricted sessions
```

---

# 9. Guest Access Policies

## 9.1 Principle

```text
Guest access must remain controlled
```

---

## 9.2 Controls

Examples:

```text
Require MFA
Restrict Teams sharing
Limit external collaboration
```

---

## 9.3 Restrictions

```text
No unrestricted guest access
No sensitive admin access
```

---

# 10. Geographic Policies

## 10.1 Principle

```text
Access should align with operational geography
```

---

## 10.2 Examples

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

# 11. Risk-Based Policies

## 11.1 Sign-In Risk

| Risk Level | Action |
|------------|--------|
| Low | Allow |
| Medium | Require MFA |
| High | Block |

---

## 11.2 User Risk

```text
High-risk identities require remediation
```

---

# 12. Device Compliance Policies

## 12.1 Principle

```text
Sensitive access requires trusted devices
```

---

## 12.2 Approved Devices

Examples:

```text
Intune compliant
Hybrid joined
Managed company devices
```

---

# 12.3 Restrictions

```text
Block admin access from unknown devices
```

---

# 13. Session Control Policies

## 13.1 Goal

Reduce long-term exposure.

---

## 13.2 Controls

Examples:

```text
Short admin sessions
Limited persistence
Frequent reauthentication
```

---

# 14. Exception Model

## 14.1 Approved Exceptions

Allowed ONLY for:

```text
Break-glass accounts
Approved recovery scenarios
```

---

## 14.2 Rule

```text
All exceptions must be documented and monitored
```

---

# 15. Rollout Strategy

## 15.1 Principle

```text
Deploy progressively
```

---

## 15.2 Recommended Phases

| Phase | Scope |
|------|------|
| Phase 1 | Admins |
| Phase 2 | Finance / Management |
| Phase 3 | Standard users |
| Phase 4 | Guests |

---

# 16. Governance Rules

## 16.1 Simplicity

```text
Minimal policy count
Maximum clarity
```

---

## 16.2 Naming

Policies must follow:

```text
CA-<CATEGORY>-<PURPOSE>
```

Examples:

```text
CA-ADM-MFA
CA-OPS-REMOTE
CA-GUEST-ACCESS
```

---

## 16.3 Ownership

Each policy requires:

```text
Primary owner
Secondary reviewer
```

---

# 17. Operational Constraints

## 17.1 SME Compatibility

The model must remain:

```text
manageable by small IT teams
```

---

## 17.2 Scalability

Must support:

```text
10 → 50 → 500+ users
```

---

# 18. Integration Model

Conditional Access policies must align with:

```text
Identity tiers
MFA model
Admin tiering
Lifecycle governance
```

---

# 19. Automation Compatibility

This blueprint must remain compatible with:

```text
ARCH
BLP
OPS
MTX
AUT
```

---

# 20. Output Mapping

Feeds into:

```text
MTX-SEC-001 — Conditional Access Matrix
MTX-SEC-002 — MFA Assignment Matrix

AUT-SEC-001 — Conditional Access Deployment Script
```

---

# 21. Final Principle

```text
Conditional Access should adapt protection to operational risk
```