# 01-BLP — Blueprint Generation Prompt

## Purpose

Transform the approved:

@PRJ-BLUEPRINT-MASTER-DOC

into specialized domain blueprint documents.

This phase decomposes the operational semantic truth into structured blueprint layers.

---

## Source Of Truth

Use ONLY:

PRJ-BLUEPRINT-MASTER-DOC

as the tenant operational source of truth.

Use:

@00-SYSTEM
@01-FRAMEWORK

as READ-ONLY governance and semantic references only.

Do NOT modify framework files.

---

## Goal

Generate specialized Blueprint documents by operational domain.

Examples:

- Governance Blueprints
- Collaboration Blueprints
- Security Blueprints
- Compliance Blueprints
- Operational Workflow Blueprints

Examples include:

- BLP-OPS-001
- BLP-GOV-001
- BLP-SEC-001
- BLP-COMP-001

Generate only documents justified by the operational requirements defined in the MASTER document.

---

## Execution Rules

- Preserve semantic consistency.
- Preserve naming conventions.
- Preserve authority hierarchy.
- Preserve ontology boundaries.
- Do NOT generate MTX.
- Do NOT generate AUT.
- Do NOT create deployment logic.
- Do NOT invent architecture not justified by the MASTER document.

---

## Validation Expectations

Blueprints must remain:

- operationally realistic
- governance-aligned
- internally consistent
- scalable for SME environments
- semantically deterministic

---

## Important

This phase is HUMAN-SUPERVISED.

Stop after Blueprint generation and wait for validation approval.