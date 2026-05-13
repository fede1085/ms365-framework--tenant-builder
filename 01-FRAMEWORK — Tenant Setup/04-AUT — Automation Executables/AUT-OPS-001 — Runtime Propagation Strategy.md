# AUT-OPS-001 — Runtime Propagation Strategy

## Reusable Tenant Automation Layer

---

# 1. Purpose

Define runtime propagation behavior for Microsoft 365 tenant automation.

Microsoft 365 services are eventually consistent.

Objects created through Graph, Exchange Online, Teams, or Entra ID may not become immediately available across all services.

This document defines:

- propagation expectations
- wait behavior
- retry timing
- validation timing
- dependency sequencing
- runtime stabilization rules

for AUT execution.

---

# 2. Layer Declaration

- PRIMARY LAYER: LAYER 4 — Tenant Operational Execution
- ONTOLOGY OWNER: AUT
- SCOPE: Runtime orchestration behavior
- INPUT SOURCE: MTX
- EXECUTION DOMAIN: Microsoft 365 cloud services

AUT consumes MTX.

AUT must not redefine ARCH, BLP, SYS, or CAN governance.

---

# 3. Core Principle

Successful API execution does not guarantee immediate service availability.

AUT must validate propagated tenant state before continuing dependent operations.

---

# 4. Runtime Reality

Microsoft 365 services operate asynchronously.

Common behavior includes:

- delayed mailbox availability
- delayed Teams provisioning
- delayed license propagation
- delayed group visibility
- delayed permission activation
- delayed directory replication

Automation must account for this behavior.

---

# 5. Eventual Consistency Rule

AUT must assume eventual consistency by default.

Never assume:

Create object
→ object instantly available everywhere

This assumption is unsafe.

---

# 6. Common Propagation Delays

Typical propagation expectations:

| Object Type | Typical Delay |
|---|---|
| Entra ID User | seconds to minutes |
| Group visibility | seconds to minutes |
| License assignment | seconds to minutes |
| Shared mailbox availability | 30s to several minutes |
| Exchange mailbox permissions | minutes |
| Teams provisioning | several minutes to 15+ minutes |
| Teams channel availability | delayed after Team creation |

These are operational expectations, not guaranteed SLA timings.

---

# 7. Dependency Sequencing Rule

AUT must process dependencies in stable order.

Recommended order:

1. Users
2. Licenses
3. Groups
4. Group memberships
5. Teams provisioning
6. Shared mailboxes
7. Mailbox permissions
8. Validation

Dependent objects must not execute before prerequisites are validated.

---

# 8. Propagation States

AUT-SYS-001 execution states apply.

Relevant runtime states:

- WAITING_PROPAGATION
- VALIDATING_RESULT
- WARNING
- FAILED

WAITING_PROPAGATION is a normal operational state.

It is not automatically an error.

---

# 9. Wait Philosophy

Waits must be:

- explicit
- controlled
- logged
- bounded
- retry-aware

Do not use uncontrolled infinite waiting loops.

---

# 10. Polling Strategy

Preferred runtime behavior:

CREATE
→ WAIT
→ VERIFY
→ CONTINUE

Avoid:

CREATE
→ immediately continue dependent operation

---

# 11. Verification Rule

After propagation wait:

AUT must verify actual object availability.

Examples:

User:
- resolvable through Graph

Mailbox:
- resolvable through Exchange

Group:
- retrievable by alias or ObjectId

Team:
- visible and provisioned

Permission:
- assignment visible

---

# 12. Shared Mailbox Strategy

Shared mailbox provisioning may take longer than user creation.

Recommended behavior:

Create mailbox
→ WAITING_PROPAGATION
→ poll mailbox availability
→ apply permissions only after validation

Do not assign permissions before mailbox validation succeeds.

---

# 13. Teams Provisioning Strategy

Teams creation is asynchronous.

Recommended behavior:

Create Team-enabled group
→ wait for Team provisioning
→ validate Team existence
→ create channels only after validation

Teams channels must not be created immediately after Team creation without validation.

---

# 14. License Assignment Strategy

License propagation may not be immediate.

Recommended behavior:

Assign license
→ wait
→ validate assigned SKU
→ continue dependent operations

Mailbox-dependent operations should not assume mailbox readiness immediately after license assignment.

---

# 15. Exchange Permission Strategy

Mailbox permission propagation may be delayed.

Recommended behavior:

Assign permission
→ wait
→ validate permission visibility

Repeated permission assignment without validation may create inconsistent state assumptions.

---

# 16. Retry Coordination

Retry logic is governed by:

AUT-RUL-001 — Idempotency & Retry Rules

Propagation waits must coordinate with retry behavior.

Retries must remain bounded.

---

# 17. Timeout Rule

Every propagation wait must have a maximum timeout.

Recommended model:

- short wait
- verification
- retry
- final validation
- failure escalation

Infinite waiting is forbidden.

---

# 18. Validation Requirement

Before dependent execution:

AUT must validate propagated tenant state.

Script success is insufficient.

Tenant state must be observable.

---

# 19. Failure Escalation

Escalate if:

- propagation exceeds timeout
- object remains unavailable
- dependency chain breaks
- mailbox never appears
- Team provisioning fails
- permission validation fails repeatedly

Escalation may result in:

- WARNING
- FAILED
- ROLLBACK_REQUIRED

---

# 20. Runtime Logging

Propagation events should log:

- ObjectType
- ObjectName
- Operation
- WaitDuration
- VerificationAttempt
- ValidationResult
- FinalState

Example:

ObjectType: SharedMailbox
ObjectName: operations@
Operation: ProvisionMailbox
WaitDuration: 60s
ValidationResult: Success
FinalState: COMPLETED

---

# 21. Dry-Run Behavior

Dry-run mode must simulate:

- dependency order
- propagation expectations
- validation checkpoints

Dry-run must not:

- connect to services
- wait on real propagation
- execute retries against production services

---

# 22. Human Supervision Rule

Propagation handling remains human-supervised.

AUT must not silently continue through unresolved propagation failures.

Critical unresolved states require human review.

---

# 23. Relationship with Runtime Doctrine

This document extends:

- AUT-SYS-001 — Execution State Model
- AUT-RUL-001 — Idempotency & Retry Rules
- AUT-SYS-000 — Automation Control Layer

This document governs runtime orchestration behavior only.

It does not redefine architecture or tenant design.

---

# 24. Final Principle

Cloud execution is asynchronous.

AUT must stabilize tenant state before continuing execution.

Validated propagation is required for deterministic automation behavior.