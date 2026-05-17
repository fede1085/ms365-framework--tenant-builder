# MTX Data Matrices

This layer contains lightweight sample/reference matrices for reusable tenant modeling.

These files are not tenant runtime truth. Active tenant runtime MTX belongs under:

```text
02-INSTANCES — Projects/<Tenant>/03-MTX — Data Matrices/
```

Purpose:

- show expected runtime MTX column shapes
- provide small SME-scale examples
- demonstrate relationships between identity, collaboration, and security data
- support future generation, validation, discovery, and remediation work

AUT executes runtime-normalized MTX only. BLP may guide MTX generation, but BLP is not runtime input.

## Folders

```text
Identity/
Collaboration/
Security/
```

## Protected Objects Matrix

`MTX-PROTECTED-OBJECTS.sample.csv` defines the reference shape for tenant-local protected identity objects.

Active protected object data belongs inside each tenant instance:

```text
02-INSTANCES — Projects/<Tenant>/03-MTX — Data Matrices/MTX-PROTECTED-OBJECTS.csv
```

This matrix protects critical identities such as:

Global Administrator accounts
break-glass accounts
tenant owner accounts
automation operator accounts
security administrator accounts

This file is not a provisioning target. It is a safety control list used by AUT before mutation operations.


---

# 3. `AUT-SCH-001 — Runtime Matrix Contract.md`

**Archivo:**

```text
01-FRAMEWORK — Tenant Setup/04-AUT — Automation Executables/AUT-SCH-001 — Runtime Matrix Contract.md
```

---

## Scope

These are reference examples only. They do not add runtime behavior, provisioning logic, license assignment, security engines, or tenant-specific data.
