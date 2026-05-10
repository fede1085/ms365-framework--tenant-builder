# ARC-GOV-016 — User Lifecycle Model

## SME Logistics Tenant Blueprint

---

# 1. Purpose

Define the complete lifecycle of a user account inside Microsoft 365.

Goal:

Control every stage of identity management:

- joiners
- movers
- leavers
- temporary users
- rehires
- contractors

This reduces:

- security risk
- license waste
- permission chaos
- onboarding delays

---

# 2. Lifecycle Philosophy

Use:

- standardized processes
- least privilege access
- fast provisioning
- clean deprovisioning
- documented ownership
- automation first

Rule:

Every user account must have an owner and business purpose.

---

# 3. Lifecycle Stages

| Stage | Meaning |
|---|---|
| Request | Need for account is submitted |
| Approval | Manager / HR approves |
| Provision | Account is created |
| Active | User works normally |
| Change | Role / department changes |
| Suspension | Temporary hold |
| Exit | User leaves company |
| Archive | Data retained if needed |
| Remove | Final cleanup |

---

# 4. Joiner Process (New Employee)

## Input Required

- full name
- start date
- department
- manager
- job title
- location
- license tier
- required access

## Actions

1. Create user account
2. Assign username / UPN
3. Assign license
4. Add to groups
5. Grant mailbox access if needed
6. Create Teams membership
7. Set manager field
8. Enforce MFA registration
9. Send welcome instructions

## Example

Ana Costa joins Finance.

Result:

- ana.finance@
- Premium license
- Finance Team
- finance@ access if required

---

# 5. Mover Process (Role Change)

Examples:

- Sales -> Finance
- Warehouse -> Support
- Analyst -> Manager

## Actions

1. Update department
2. Change groups
3. Remove old permissions
4. Grant new permissions
5. Recalculate license
6. Update title / manager
7. Review mailbox access

## Critical Rule

Always remove old access first or during transition.

---

# 6. Leaver Process (Exit)

## Immediate Actions

1. Block sign-in
2. Reset sessions
3. Remove privileged roles
4. Notify owner / manager

## Short-Term Actions

5. Convert mailbox if needed
6. Delegate mailbox access
7. Transfer OneDrive/files
8. Remove licenses

## Final Actions

9. Retain data per policy
10. Delete account after retention period

---

# 7. Temporary Users

Examples:

- interns
- seasonal staff
- consultants

## Rules

- expiry date required
- limited permissions
- minimum license tier
- review before renewal

---

# 8. Contractors / External Users

Use guest access when possible instead of full user account.

Rules:

- sponsor owner required
- limited access
- review quarterly
- remove when project ends

---

# 9. Rehire Process

If former employee returns:

1. Check old account status
2. Restore if appropriate
3. Validate permissions from zero
4. Assign current license
5. Do not reuse old excessive access blindly

---

# 10. Ownership Model

Every account should have:

- direct manager
- department owner
- IT/admin support owner

No orphan accounts.

---

# 11. License Lifecycle Rules

## Joiner

Assign role-based license.

## Mover

Upgrade / downgrade as needed.

## Leaver

Remove immediately.

## Inactive User

Review after inactivity threshold.

---

# 12. Access Review Integration

Review periodically:

- mailbox permissions
- group memberships
- admin roles
- guest accounts
- stale disabled accounts

Frequency:

- monthly quick review
- quarterly formal review

---

# 13. Naming Integration

Accounts should follow tenant naming standard.

Examples:

juan.sales@  
ana.finance@  
luis.operations@

Display names:

SALES-Juan Perez  
FINANCE-Ana Costa

---

# 14. Automation Opportunities

Can automate:

- onboarding from CSV
- group assignment by department
- license assignment
- offboarding checklist
- stale account reports
- manager approval flows

---

# 15. SLA Targets (Suggested)

| Action | Target |
|---|---|
| New starter account | Same day / before start |
| Password reset | Immediate |
| Role change updates | 1 business day |
| Leaver block access | Immediate |
| License reclaim | 24h |

---

# 16. Governance Rules

*Note: Master governance rules and enforcement principles are centralized in ARC-SYS-000 — Architecture Control Map.*

- No shared accounts unless justified
- No dormant enabled users
- No user without manager
- No permanent excess permissions
- Every change logged
- Quarterly lifecycle review

---

# 17. Example Lifecycle States

## User: Carlos Vega

Start:

Warehouse user -> F3

Promotion:

Operations coordinator -> Standard

Transfer:

IT support trainee -> Premium

Exit:

Account blocked -> data archived -> removed

---

# 18. Priority Implementation Order

1. Joiner checklist
2. Leaver checklist
3. Role-change workflow
4. License automation
5. Quarterly reviews
6. Full reporting

---

# 19. Final Principle

Accounts are not static objects.

They are living business identities that must be managed from start to finish.

---

# 20. Next Document

BLP-TMP-017 — Operational Runbook Template

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map