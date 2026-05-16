# BLP-SEC-003 — Device Compliance Model

## Layer: Security  
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Define the tenant device compliance model used to determine:

```text
Which devices are trusted
Which devices may access sensitive resources
Which controls apply to different device types
```

This blueprint translates the security architecture into:

```text
Operational, scalable, automation-ready device governance
```

---

# 2. Core Principle

```text
Trusted identity + trusted device
```

Identity protection alone is not sufficient.

Device trust becomes part of the security boundary.

---

# 3. Device Compliance Philosophy

## 3.1 Principle

```text
Higher privilege = stronger device requirements
```

---

## 3.2 Goal

Protect sensitive access while remaining:

```text
SME-operable
```

---

# 4. Device Classification Model

## 4.1 Device Types

| Type | Description |
|------|-------------|
| Corporate Managed | company-controlled |
| Personal Managed | BYOD under management |
| Unmanaged | unknown / untrusted |
| Shared Device | operational shared workstation |

---

# 4.2 Trust Levels

| Level | Description |
|------|-------------|
| TRUSTED | fully compliant |
| LIMITED | partial trust |
| UNTRUSTED | blocked or restricted |

---

# 5. Compliance Requirements

## 5.1 Minimum Requirements

Trusted devices should meet:

```text
Supported OS
Encryption enabled
Password / PIN enabled
Screen lock enabled
Security updates active
```

---

## 5.2 Recommended Requirements

```text
EDR / Defender enabled
Device management enabled
Compliance reporting enabled
```

---

# 6. Administrative Device Model

## 6.1 Tier 0 Accounts

Administrative access requires:

```text
Trusted managed devices only
```

---

## 6.2 Restrictions

```text
No admin access from unmanaged devices
No sensitive administration from shared devices
```

---

# 6.3 Principle

```text
Privileged access requires highest device trust
```

---

# 7. Operational User Device Model

## 7.1 Standard Users

Operational users may use:

```text
Corporate managed devices
Controlled personal devices
```

---

## 7.2 Goal

```text
Balance usability + security
```

---

# 8. Warehouse & Shared Device Strategy

## 8.1 Shared Devices

Operational environments may use:

```text
Shared warehouse workstations
Shared kiosks
Shared operational terminals
```

---

## 8.2 Restrictions

Shared devices should NOT allow:

```text
Administrative access
Sensitive finance access
Privileged operations
```

---

## 8.3 Principle

```text
Shared devices = operational access only
```

---

# 9. BYOD (Bring Your Own Device) Model

## 9.1 Principle

```text
Personal devices require controlled trust
```

---

## 9.2 Requirements

Examples:

```text
App protection
MFA required
Limited access scope
Conditional Access controls
```

---

## 9.3 Restrictions

```text
No Tier 0 administration
No unrestricted access to sensitive systems
```

---

# 10. Device Access Matrix

| Device Type | Access Level |
|-------------|-------------|
| Corporate Managed | Full |
| Personal Managed | Limited |
| Shared Operational | Operational Only |
| Unmanaged | Restricted / Blocked |

---

# 11. Compliance Evaluation Model

## 11.1 Evaluation Criteria

Compliance checks may include:

```text
OS version
Encryption status
Antivirus state
Management status
Risk level
```

---

## 11.2 Principle

```text
Non-compliant devices reduce trust
```

---

# 12. Conditional Access Integration

## 12.1 Rule

```text
Conditional Access policies evaluate device trust
```

---

## 12.2 Examples

| Device State | Action |
|--------------|--------|
| Trusted | Allow |
| Limited | Restrict |
| Untrusted | Block |

---

# 13. Teams & Collaboration Protection

## 13.1 Principle

```text
Cross-department collaboration increases exposure
```

---

## 13.2 Examples

Sensitive Teams access may require:

```text
Trusted device
MFA
Managed session
```

---

# 14. Shared Mailbox Protection

## 14.1 Rule

```text
Mailbox sensitivity affects device requirements
```

---

## 14.2 Examples

| Mailbox Type | Device Requirement |
|--------------|-------------------|
| Finance | Trusted only |
| External-facing | Managed preferred |
| Operations | Standard compliance |

---

# 15. Monitoring & Audit

## 15.1 Principle

```text
Critical device events must remain auditable
```

---

## 15.2 Examples

```text
Non-compliant devices
Blocked sign-ins
Compliance changes
Management removal
```

---

# 16. Governance Rules

## 16.1 Simplicity Principle

```text
Minimal device categories
Clear trust boundaries
```

---

## 16.2 Ownership

Each managed device requires:

```text
Assigned owner
Lifecycle tracking
```

---

## 16.3 Lifecycle

```text
Enroll → Operate → Review → Retire
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

## 17.3 Operational Reality

The model must support:

```text
Office users
Warehouse users
Shared operational devices
Remote users
```

---

# 18. Integration Model

This blueprint must align with:

```text
Conditional Access
Identity security
Admin tiering
Operational workflows
Lifecycle governance
```

---

# 19. Automation Compatibility

This blueprint must remain compatible with:

```text
ARC
BLP
OPS
MTX
AUT
```

---

# 20. Output Mapping

Feeds into:

```text
MTX-SEC-004 — Device Compliance Matrix
MTX-SEC-005 — Managed Device Inventory

AUT-SEC-003 — Device Compliance Deployment Script
```

This mapping is framework-capable/future-capable unless active AUT runtime contracts and scripts exist for device compliance deployment.

---

# 21. Final Principle

```text
Device trust is part of identity trust
```
