# AUT-RUL-001 — Idempotency & Retry Rules

## Reusable Tenant Automation Layer

---

# 1. Purpose

Define deterministic execution behavior for repeated runs, retries, propagation delays, and partial failures.

This document standardizes how AUT handles:

- existing objects
- transient failures
- retries
- propagation timing
- safe re-execution
- execution consistency

---

# 2. Layer Declaration

- PRIMARY LAYER: LAYER 4 — Tenant Operational Execution
- ONTOLOGY OWNER: AUT
- SCOPE: Runtime execution governance
- INPUT SOURCE: MTX
- EXECUTION TARGET: Microsoft 365 tenant state

AUT consumes MTX.

AUT does not redefine ARC, BLP, SYS, or CANONICAL governance.

Implementation status:

This document defines target retry/idempotency behavior. Current global scripts include basic existence checks and a minimal mailbox propagation wait, but do not fully implement bounded retry polling or the full state-driven retry model.

---

# 3. Core Principle

Automation must be safe to execute more than once.

Repeated execution must not create uncontrolled duplication or semantic drift.

---

# 4. Idempotency Definition

Idempotent execution means:

same input
→ same tenant result
→ without uncontrolled duplication

Examples:

VALID:
- re-run user validation
- re-run mailbox permission verification
- re-run group membership reconciliation

INVALID:
- duplicate users
- duplicate groups
- duplicate aliases
- duplicated mailbox permissions

---

# 5. Runtime Behavior Priority

Preferred runtime behavior:

VERIFY
→ SKIP or UPDATE
→ CREATE only if missing

Never assume the tenant is empty.

---

# 6. Exists-Check Rule

Before creating any object:

AUT must verify whether the object already exists.

Required checks:

- UserPrincipalName
- GroupName
- MailNickname
- SharedMailbox address
- Alias
- Permission assignment

If object exists:

- validate expected configuration
- validate ownership
- validate naming
- validate department alignment

Then:

- SKIP
or
- UPDATE if explicitly allowed

---

# 7. User Rules

## Existing User

If user already exists:

- verify UPN
- verify DisplayName
- verify Department
- verify License alignment

If compliant:

→ SKIP

If drift exists:

→ WARNING or UPDATE

Do not create duplicate user.

---

# 8. Group Rules

## Existing Group

If group exists:

- verify naming
- verify ownership
- verify type
- verify memberships

If compliant:

→ SKIP

If drift exists:

→ WARNING or UPDATE

Do not create duplicate group.

---

# 9. Shared Mailbox Rules

## Existing Mailbox

If mailbox exists:

- verify alias
- verify ownership
- verify department alignment
- verify permissions

If compliant:

→ SKIP

Mailbox creation must never duplicate SMTP addresses.

---

# 10. Permission Rules

Permissions must be reconciled individually.

Before assigning permission:

verify whether identical permission already exists.

Example:

support@
+ user@domain
+ FullAccess

already exists
→ SKIP

---

# 11. Retry Philosophy

Retries are allowed only for transient failures.

Retries must not hide deterministic failures.

---

# 12. Retryable Conditions

Allowed retry scenarios:

- Graph timeout
- Exchange propagation delay
- temporary throttling
- mailbox not yet available
- delayed group replication
- temporary API unavailable

---

# 13. Non-Retryable Conditions

Do NOT retry:

- invalid UPN
- invalid domain
- missing required MTX fields
- invalid license SKU
- tenant mismatch
- protected object violation
- invalid naming pattern

These require human correction.

---

# 14. Retry Strategy

Recommended retry model:

Attempt 1
→ wait 15 seconds

Attempt 2
→ wait 30 seconds

Attempt 3
→ wait 60 seconds

Maximum recommended retries:

3

After maximum retries:

→ FAILED

or

→ ROLLBACK_REQUIRED

---

# 15. Propagation Wait Rule

Microsoft 365 is eventually consistent.

AUT must allow propagation time after:

- mailbox creation
- group creation
- Teams provisioning
- license assignment
- permission assignment

Do not assume immediate availability.

---

# 16. Safe Re-Execution Rule

Re-running AUT should:

- continue safely
- preserve existing compliant objects
- avoid duplicate creation
- reconcile permissions
- validate state again

Re-run must not corrupt existing tenant structure.

---

# 17. Update Rule

Updates are allowed only when:

- object already exists
- MTX explicitly defines desired state
- update does not violate governance
- protected-object rules are respected

Unsafe automatic overwrite is forbidden.

---

# 18. Delete Rule

Deletion is NOT default behavior.

AUT must never automatically delete:

- users
- groups
- mailboxes
- permissions

unless explicit deletion mode exists.

Deletion requires:

- explicit approval
- execution confirmation
- protected-object validation

---

# 19. Protected Objects

Protected objects must never be modified automatically.

Examples:

- breakglass accounts
- tenant global administrators
- emergency mailboxes
- protected governance groups

Protected objects require explicit override approval.

Protected-object violations are non-retryable.

Automation must stop or skip safely. Retries must never attempt to override protected-object controls.

---

# 20. Logging Requirement

Every retry must log:

- ObjectType
- ObjectName
- AttemptNumber
- FailureReason
- WaitDuration
- FinalState

Example:

ObjectType: SharedMailbox
ObjectName: support@
Attempt: 2
Failure: Mailbox not propagated yet
Wait: 30s
State: WAITING_PROPAGATION

---

# 21. Validation Requirement

After retries complete:

AUT must validate actual tenant state.

Script success alone is insufficient.

Tenant reality must match MTX intent.

---

# 22. Failure Escalation

Escalate immediately if:

- tenant mismatch detected
- protected object violation detected
- invalid MTX structure detected
- naming conflict unresolved
- duplicate SMTP conflict detected

Execution must STOP on critical failures.

---

# 23. Recommended Runtime Order

1. Validate MTX
2. Verify tenant targeting
3. Verify object existence
4. Create missing objects
5. Wait for propagation if needed
6. Re-validate state
7. Apply dependent permissions
8. Generate validation report

---

# 24. Relationship with Execution States

This document extends:

AUT-SYS-001 — Execution State Model

Retry logic interacts with states:

- WAITING_PROPAGATION
- WARNING
- FAILED
- BLOCKED
- ROLLBACK_REQUIRED

---

# 25. Final Principle

AUT must behave predictably under repeated execution.

Retry logic exists to stabilize execution.

Retry logic must never become uncontrolled automation improvisation.
