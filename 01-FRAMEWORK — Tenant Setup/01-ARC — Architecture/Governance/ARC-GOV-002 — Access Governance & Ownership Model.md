# ARC-GOV-002 — Access Governance & Ownership Model

## Layer: Governance
## Type: Architecture Standard

---

# 1. Objective

Define:

```text
ownership
access control
approval authority
delegated administration
review responsibilities
```

across all tenant resources.

---

# 2. Core Principle

```text
Every resource must have:
- owner
- accountability
- review process
```

---

# 3. Scope

Applies to:

- users
- groups
- Teams
- shared mailboxes
- SharePoint sites
- admin roles
- automation identities
- security groups

---

# 4. Governance Model

## 4.1 Core Roles

| Governance Role | Responsibility |
|---|---|
| Owner | Operational responsibility |
| Reviewer | Periodic validation |
| Approver | Access authorization |
| Delegate | Limited management |
| Auditor | Oversight and validation |

---

# 5. Ownership Principles

## 5.1 Mandatory Ownership

```text
No object may exist without ownership
```

---

## 5.2 Minimum Ownership

| Resource Type | Minimum Owners |
|---|---|
| Team | 2 |
| Shared Mailbox | 1 |
| Security Group | 2 |
| Admin Role | 2 |
| Automation Account | 2 |

---

## 5.3 Owner Requirements

Owners must:

- belong to operational area
- understand resource purpose
- review membership periodically
- validate access requests

---

# 6. Ownership Classification

| Type | Description |
|---|---|
| Operational Owner | Daily responsibility |
| Technical Owner | IT/system responsibility |
| Business Owner | Business accountability |
| Security Owner | Security validation |

---

# 7. Access Governance Model

## 7.1 Access Philosophy

```text
Access must be:
- role-based
- minimal
- reviewed
- justified
```

---

## 7.2 Access Categories

| Category | Description |
|---|---|
| STANDARD | Normal operational access |
| SENSITIVE | Business-sensitive access |
| PRIVILEGED | Administrative/security access |
| RESTRICTED | High-risk protected access |

---

# 8. Least Privilege Principle

## 8.1 Rule

```text
Users receive only the minimum access required
```

---

## 8.2 Restrictions

```text
No permanent excessive permissions
```

---

# 9. Approval Governance

## 9.1 Access Approval

| Resource Type | Approval Required |
|---|---|
| Shared Mailbox | Owner |
| Team Membership | Owner |
| Security Group | Owner + IT |
| Admin Role | Security + IT |
| Restricted Access | Security Approval |

---

## 9.2 Approval Rules

```text
Approvals must be traceable
```

```text
Self-approval is forbidden
```

---

# 10. Delegated Administration

## 10.1 Objective

Allow limited management without full administrative access.

---

## 10.2 Allowed Delegation

| Area | Allowed |
|---|---|
| Team Membership | Yes |
| Shared Mailbox Members | Yes |
| Distribution Lists | Yes |
| Security Policies | Restricted |
| Conditional Access | No |

---

## 10.3 Delegation Rules

```text
Delegation must be:
- scoped
- documented
- revocable
```

---

# 11. Privileged Access Governance

## 11.1 Separation

```text
Administrative access must be separated from daily work identities
```

---

## 11.2 Restrictions

```text
No shared admin accounts
No standing Global Admin where avoidable
```

---

## 11.3 Elevated Access

Elevated access should:

- require approval
- be time-limited
- be auditable

---

# 12. Group Governance

## 12.1 Group Ownership

All groups require:

- primary owner
- secondary owner
- periodic review

---

## 12.2 Stale Groups

Groups without:

- activity
- ownership
- purpose

must be reviewed.

---

# 13. Shared Mailbox Governance

## 13.1 Requirements

Shared mailboxes require:

- operational owner
- approved members
- defined purpose

---

## 13.2 SendAs Governance

```text
SendAs allowed only for approved operational use
```

---

# 14. Teams Governance

## 14.1 Teams Ownership

Teams require:

- minimum 2 owners
- lifecycle review
- channel governance

---

## 14.2 Shared Channels

```text
Shared channels require explicit ownership validation
```

---

# 15. External Access Governance

## 15.1 Guest Governance

Guests require:

- sponsor
- review cycle
- expiration logic

---

## 15.2 Restrictions

```text
Guests cannot own privileged resources
```

---

# 16. Access Reviews

## 16.1 Mandatory Reviews

| Review Type | Frequency |
|---|---|
| Team Membership | Quarterly |
| Shared Mailbox Access | Quarterly |
| Security Groups | Monthly |
| Admin Roles | Monthly |
| Guests | Quarterly |

---

## 16.2 Review Actions

Reviews must validate:

- still required
- still justified
- still owned

---

# 17. Orphaned Objects

## 17.1 Detection

Detect:

- resources without owners
- inactive owners
- abandoned groups

---

## 17.2 Critical Rule

```text
Orphaned privileged resources are critical violations
```

---

# 18. Automation Governance

## 18.1 Allowed Automation

```text
Membership sync
Notifications
Review reminders
Ownership validation
```

---

## 18.2 Restricted Automation

```text
Privilege elevation
Owner replacement
Protected object modification
```

require approval.

---

# 19. Compliance Integration

Feeds into:

```text
Audit
Access Reviews
Lifecycle Governance
Security Governance
```

---

# 20. Failure Conditions

## 20.1 Critical Violations

```text
No owner
Self-approved access
Orphaned admin role
Unreviewed privileged access
Expired guest access
```

---

# 21. Final Principle

```text
Access governance = controlled accountability
NOT uncontrolled collaboration
```