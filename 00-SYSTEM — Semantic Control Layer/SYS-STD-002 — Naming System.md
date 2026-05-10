# @SYS-STD-002 - Naming System

> **Purpose:** Global naming convention map to help AI understand prefixes, semantic roles, and structural logic.

## 1. System Prefixes (Layers)
- **ARC (Architecture):** Foundational rules, non-executory, global constraints.
- **BLP (Blueprint):** Standardized templates, agnostic structure, bridges rules to data.
- **MTX (Matrix):** Specific instance data, tabular format, feeds automation.
- **AUT (Automation):** Executable scripts, CSV outputs, active deployment tools.
- **SYS (System):** Control layer, metadata, AI semantic maps.

## 2. Category Prefixes (Domains/Modules)
- **NAM:** Naming conventions and taxonomy (Legacy reference, often merged into STD).
- **STD:** Standards and baseline rules.
- **SEC:** Security baselines and rules (Merged into STD).
- **GOV:** Governance and compliance.
- **DOC:** Documentation and definitions.
- **USR:** User identities and objects.
- **GRP:** Groups (Security, M365).
- **MBX:** Mailboxes (Shared, Resource).
- **PRM:** Permissions and access control.
- **OPS:** Operational procedures.

## 3. Naming Logic (Files)
Pattern: `PREFIX-CATEGORY-###` or `PREFIX-CATEGORY — Human Name.md`
Ejemplos:
- `@ARC-STD-007` (Architecture layer, Standard category, item 007 — Naming)
- `@BLP-TMP-003` (Blueprint layer, Doc/Matrix category, item 003 — Users)

## 4. Semantic Structure
- Files ending in `-000` indicate a control or master file for that category/layer (e.g., `@BLP-SYS-000`).
- The left side of a hyphenated name denotes system logic, the right side implies human-readable context when applicable.

## 5. Known Inconsistencies to Monitor
- Ensure "Department" abbreviations (e.g., IT, HR, OPS) are strictly maintained when transitioning from @BLP to @MTX.
- Prevent arbitrary naming in script variables that do not map back to these prefixes.
