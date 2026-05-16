# BLP-SEC-004 — Access Control Policies

## Layer: Security  
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Define the structured access control policy model used to regulate:

```text
Who can access what
Under which conditions
With which level of privilege
```

This blueprint translates the security architecture into:

```text
Operational, scalable, automation-ready access governance
```

---

# 2. Core Principle

```text
Access is granted by operational necessity
```

NOT by convenience.

---

# 3. Access Control Philosophy

## 3.1 Principle

```text
Least privilege by default
```

---

## 3.2 Goal

Reduce unnecessary exposure while preserving:

```text
Operational efficiency
```

---

# 4. Access Assignment Model

## 4.1 Assignment Logic

Access decisions are based on:

| Factor | Description |
|-------|-------------|
| Role | operational responsibility |
| Department | business scope |
| Sensitivity | resource criticality |
| Workflow dependency | collaboration requirement |
| Security tier | identity trust level |

---

# 5. Access Categories

## 5.1 Categories

| Category | Purpose |
|----------|---------|
| Administrative | tenant control |
| Operational | daily business work |
| Collaborative | Teams / mailboxes |
| Sensitive | finance / HR / management |
| External | guest collaboration |

---

# 6. Administrative Access Policies

## 6.1 Principle

```text
Administrative access must remain isolated
```

---

## 6.2 Requirements

Mandatory:

```text
Dedicated admin accounts
MFA enabled
Trusted devices
Conditional Access protection
```

---

## 6.3 Restrictions

```text
No operational work from admin accounts
No shared admin identities
No excessive privileges
```

---

# 7. Department Access Policies

## 7.1 Rule

```text
Departments are isolated by default
```

---

## 7.2 Exceptions

Cross-access allowed ONLY when:

```text
Operational dependency exists
```

Example:

```text
Warehouse Lead → Operations coordination channel
```

---

# 8. Teams Access Policies

## 8.1 Principle

```text
Teams access follows operational responsibility
```

---

## 8.2 Rules

```text
No duplicate Teams
No uncontrolled shared channels
No unrestricted guest collaboration
```

---

## 8.3 Access Types

| Type | Description |
|------|-------------|
| Standard | department members |
| Shared | cross-department collaboration |
| Private | sensitive collaboration |

---

# 9. Shared Mailbox Access Policies

## 9.1 Principle

```text
Shared Mailboxes are controlled operational resources
```

---

## 9.2 Access Types

| Permission | Purpose |
|------------|---------|
| FullAccess | operational handling |
| SendAs | controlled communication |
| Owner | accountability |

---

## 9.3 Restrictions

```text
No uncontrolled SendAs
No orphan mailboxes
No anonymous ownership
```

---

## 9.4 Rule

```text
SendAs allowed ONLY when operationally justified
```

---

# 10. Cross-Department Access Policies

## 10.1 Principle

```text
Cross-access increases exposure
```

---

## 10.2 Requirements

Cross-department access requires:

```text
Operational dependency
Defined ownership
Traceability
```

---

## 10.3 Examples

| Source | Target | Reason |
|--------|-------|--------|
| Support | Operations | customer issue escalation |
| Operations | Warehouse | physical coordination |
| Finance | Sales | invoicing coordination |

---

# 11. Guest Access Policies

## 11.1 Principle

```text
Guest access must remain restricted and controlled
```

---

## 11.2 Requirements

Guests may require:

```text
MFA
Approved domains
Limited collaboration scope
```

---

## 11.3 Restrictions

```text
No privileged access
No sensitive admin access
No unrestricted sharing
```

---

# 12. Sensitive Resource Policies

## 12.1 Examples

Sensitive areas include:

```text
Finance
HR
Executive collaboration
Administrative systems
```

---

## 12.2 Requirements

Sensitive resources require:

```text
Higher trust
MFA
Restricted sessions
Trusted devices
```

---

# 13. Lifecycle Access Governance

## 13.1 Principle

```text
Access must evolve with the user lifecycle
```

---

## 13.2 Events

| Event | Action |
|------|--------|
| Joiner | provision |
| Mover | adjust |
| Leaver | revoke |

---

## 13.3 Rule

```text
Unused access should not persist
```

---

# 14. Ownership Model

## 14.1 Rule

```text
Every controlled resource requires ownership
```

---

## 14.2 Applies To

```text
Teams
Channels
Mailboxes
Security groups
Policies
```

---

## 14.3 Ownership Structure

Each resource requires:

```text
Primary Owner
Secondary Backup Owner
```

---

# 15. Monitoring & Audit

## 15.1 Principle

```text
Critical access changes must remain auditable
```

---

## 15.2 Examples

```text
Privilege changes
Mailbox delegation
Guest invitations
Permission escalation
```

---

# 16. Governance Rules

## 16.1 Naming Convention

Policies should follow:

```text
ACP-<CATEGORY>-<PURPOSE>
```

Examples:

```text
ACP-ADM-TIER0
ACP-OPS-CROSSACCESS
ACP-MBX-SENDAS
```

---

## 16.2 Simplicity Principle

```text
Minimal complexity
Clear access boundaries
```

---

## 16.3 Operational Clarity

```text
Users should understand why access exists
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

Must support:

```text
Office users
Warehouse users
Cross-department collaboration
External coordination
```

---

# 18. Integration Model

This blueprint must align with:

```text
Conditional Access
MFA enforcement
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
MTX-SEC-006 — Access Control Matrix
MTX-SEC-007 — Cross-Department Access Matrix

AUT-SEC-004 — Access Governance Deployment Script
```

---

# 21. Final Principle

```text
Access should be intentional, minimal, and traceable
```
