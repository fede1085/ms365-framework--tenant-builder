# AUT-SYS-000 — Automation Control Layer

## Reusable Tenant Automation Layer

---

# 1. Purpose of Automation Layer

The Automation layer (AUT) provides the execution engine for the Microsoft 365 tenant deployment. It contains generic, reusable scripts that build the environment based on structural templates and matrix data.

# 2. Layer Relationship

Automation reads MTX files.
Automation does not use BLP as execution data.
BLP explains the model.
MTX provides the data.
AUT executes the data.

**Execution Hierarchy:**
`ARC (Strategy & Rules) → BLP (Template) → MTX (Data Instance) → AUT (Execution)`

# 3. Required Matrix Input Files

The automation scripts require the following Matrix files for execution:
- `MTX-USERS.csv`
- `MTX-GROUPS.csv`
- `MTX-MAILBOXES.csv`
- `MTX-PERMISSIONS.csv`
- `MTX-LICENSES.csv`
- `MTX-PROTECTED-OBJECTS.csv`(for production-safe tenant execution)
- `MTX-LICENSES.csv` (is required as an input contract. License runtime execution is not yet implemented.)

**Current global script implementation:**

The global scripts are baseline/reference implementations. They partially implement AUT doctrine, use simpler field names for some current script paths, do not implement protected-object enforcement, and do not implement Teams, SharePoint, non-mailbox permissions, license assignment, full retry orchestration, or full validation reports.

# 4. Execution Rules

## 4.1 Dry-run first rule
Always execute scripts in a dry-run or what-if mode before committing changes to ensure the script actions match expectations.

## 4.2 Idempotency rule
Scripts must be safe to run multiple times. If an object exists, the script should detect it and either skip it safely or update it cleanly without errors.

## 4.3 No-delete-by-default rule
Scripts must not delete resources automatically. Removals or deletions should require explicit parameters and confirmations.

## 4.4 Protected objects rule
Core administrative accounts and critical systems are protected and must not be altered, removed, or used as regular user accounts in the automation data.

Before any create, update, delete, disable, password, role, license, group, ownership, or alias operation, AUT must check protected-object rules.

If an object is protected:

- do not mutate it
- return SKIPPED_PROTECTED or BLOCKED
- log the protected-object reason
- continue only when safe

## 4.5 Validation-before-execute rule
Always validate the structure and content of the Matrix CSV inputs before passing them to the execution scripts.

**Protected-object rules should be loaded from the tenant-local matrix when available:**

02-INSTANCES — Projects/<Tenant>/03-MTX — Data Matrices/MTX-PROTECTED-OBJECTS.csv

This matrix must be checked before any mutation to users, groups, mailboxes, roles, aliases, ownership, permissions, or licenses.


---

## Execution Flow

1. Load Matrix files
2. Validate structure
3. Resolve dependencies (users, groups, mailboxes)
4. Apply changes (create/update only)
5. Validate results
6. Log execution

---

## Related Documents

- AUT-SYS-000 — Automation Control Layer.md
- BLP-SYS-000 — Blueprint Control Layer.md
- ARC-SYS-000 — Architecture Control Map.md


## Execution Path Expectations
- Scripts assume framework-relative paths as documented in `scripts/Run-Project.ps1`.
- Preferred execution directory is `01-FRAMEWORK — Tenant Setup/04-AUT — Automation Executables/scripts`.
- `-ProjectPath` can be provided explicitly to avoid path-resolution ambiguity.
- Path conventions are ontology-dependent and must not be renamed in hardening passes.
