# ARC-SYS-000 — Architecture Control Map

## Architecture Control & Governance Master

---

### 🟢 LAYER DECLARATION
- **PRIMARY LAYER:** LAYER 2 — Framework Meta-Architecture
- **SECONDARY LAYER:** LAYER 3 — Tenant Conceptual Modeling
- **ONTOLOGY OWNER:** `@ARC`
- **SCOPE:** Global Framework Control & Execution Model

---

# 1. Purpose

This document serves as the **Single Source of Truth** for the entire Microsoft 365 Tenant Blueprint Architecture. It establishes the foundational rules, layer structure, centralized governance, and document relationships that govern the environment.

It acts as the bridge between **LAYER 2 (Meta-Architecture)** logic and the **Execution Lifecycle** (ARCH/BLP/MTX/AUT).

---

# 2. Architecture Principles

1. **Scalability:** The architecture must scale linearly without breaking existing structures.
2. **Consistency:** All names, tags, and processes must follow defined standards.
3. **Clarity:** Systems must be readable by both humans and automation tools.
4. **Security by Default:** Least privilege and zero-trust principles apply across all layers.
5. **Lifecycle Management:** Every object (user, group, tag) has a defined birth, active phase, and retirement.

---

# 3. Layer Model

The framework is divided into four sequential execution layers:

1. **ARCH (Architecture):** Defines the strategic rules, governance principles, architecture standards, system-level controls, and foundational models that govern the entire framework (e.g., ARC-SYS, ARC-STD, ARC-GOV, ARC-SEC, ARC-OPS).
2. **BLP (Blueprint):** Defines reusable blueprint templates, abstract operational structures, implementation models, and tenant design patterns inherited from the Architecture layer.
3. **MTX (Matrix):** Generates project-specific implementation data including real users, UPNs, departments, groups, mailboxes, permissions, IDs, and structured deployment mappings derived from Blueprint structures.
4. **AUTO (Automation):** The execution layer consisting of PowerShell scripts, Microsoft Graph integrations, validation tooling, and deployment automation that translates Matrix data into the live Microsoft 365 tenant.

---

## 3.1 Source of Truth Hierarchy

The framework follows a strict inheritance and execution hierarchy:

```text
ARCH → BLP → MTX → AUTO
```

### ARCH

Defines:

- rules
- governance
- principles
- architecture standards
- security baselines
- operational doctrine

ARCH is the strategic source of truth for the entire framework.

---

### BLP

Defines:

- reusable templates
- abstract operational models
- tenant blueprint structures
- implementation logic
- reusable deployment patterns

BLP must inherit Architecture rules and may NOT redefine governance or security principles established by ARCH.

---

### MTX

Generates:

- project-specific identities
- real users
- UPNs
- departments
- groups
- mailbox assignments
- permissions
- IDs
- deployment-ready mappings

MTX represents the real implementation state for each individual project.

---

### AUTO

Executes:

- deployment
- automation
- PowerShell
- Microsoft Graph
- validation
- provisioning
- tenant build operations

AUTO consumes MTX data only and must never modify ARCH or BLP layers directly.

---

## 3.2 Layer Boundary Rules (Semantic Safety)

### ARCH Layer (LAYER 2 Focus)
```text
Defines policy and framework logic.
Must NOT contain project-specific instance data.
```

---

### BLP Layer (LAYER 3 Focus)
```text
Defines reusable business models and templates.
Must NOT contain real tenant identities or UPNs.
```

---

### MTX Layer (LAYER 4 Focus)
```text
Contains project-specific deployment data.
Generated dynamically per project instance.
```

---

### AUTO Layer (LAYER 4 Focus)
```text
Executes deployment logic via script and API.
Must remain idempotent and validation-driven.
```

---

## 3.3 Transformation Flow

The framework operates through progressive transformation:

```text
Architecture Rules
        ↓
Blueprint Templates
        ↓
Project Matrices
        ↓
Automation Execution
        ↓
Live Microsoft 365 Tenant
```

---

## 3.4 Core Separation Principle

The framework enforces strict separation between:

```text
Framework Logic
vs
Project Instance Data
```

This separation guarantees:

- scalability
- reusability
- governance consistency
- automation safety
- tenant portability
- reduced configuration drift

---

# 4. Naming System Definition

The central naming framework relies on the `CODE-TYPE-001 — Human Name` standard. 

- **Left side:** System logic and sorting.
- **Right side:** Human clarity.

For comprehensive details, refer to the Naming Convention Standards hierarchy:
- `ARC-STD-007 — Naming Convention Standard`
- `ARC-STD-007a — Naming Convention Standard Guide`
- `ARC-STD-007b — Naming Convention Emoji Guide`

---

# 5. Governance Model (Central Reference)

This section centralizes governance logic extracted across the architecture to provide a unified control standard.

## 5.1 Identity & Access Governance
- No shared accounts or credentials unless explicitly justified and documented.
- No personal accounts used for business data.
- Every privileged role must have a defined owner.
- No user account exists without an assigned manager.
- No dormant enabled users; block access immediately for leavers.
- No permanent excess permissions; use least privilege.

## 5.2 Category & Tag Governance
- Keep names short, consistent, and use searchable English words.
- One meaning per tag; avoid duplicate concepts.
- Folders store location, tags store meaning, mailboxes store ownership.

## 5.3 Audit & Review Cycles
- **Quarterly Reviews:** Conduct mandatory quarterly reviews of access rights, role memberships, tag relevance, guest accounts, and lifecycle states.
- **Logging:** Every change to roles or critical access must be logged.
- **Exceptions:** All governance exceptions must be documented.

*Detailed policies are maintained in their respective domain documents (ARC-GOV-013, ARC-STD-014, ARC-GOV-016).*

---

# 6. Lifecycle Summary

Every system object (User, Group, Device, Tag) must follow a managed lifecycle:
- **Joiner/Creation:** Provisioned with minimal necessary access and standard naming.
- **Mover/Change:** Access is updated proactively; old access is revoked.
- **Leaver/Retirement:** Access is blocked immediately, data retained as needed, and objects eventually removed to prevent stale attack surfaces.

---

# 7. Document Relationships

This master document links to the following core architectural layers:

- **Design:** `ARC-DES-001 — Architecture Development Layer`
- **Strategy:** `ARC-STR-002 — Tenant Blueprint Factory Strategy`
- **Standards:** `ARC-STD-007`, `ARC-STD-007a`, `ARC-STD-007b`, `ARC-STD-014`, `ARC-STD-017`
- **Governance:** `ARC-GOV-013`, `ARC-GOV-016`

---

## Related Documents

- All `ARC-` architecture documents reference this file as the primary control map.
