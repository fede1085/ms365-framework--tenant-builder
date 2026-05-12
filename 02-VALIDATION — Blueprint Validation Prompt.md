# 02-VAL — Blueprint Validation Prompt

## Purpose

Validate the generated Blueprint layer before Matrix generation.

This phase audits:

- semantic consistency
- governance consistency
- naming consistency
- authority integrity
- ontology boundaries
- operational realism
- permission logic
- collaboration logic
- escalation logic
- workflow coherence

The goal is to prevent semantic contamination propagation into MTX and AUT layers.

---

## Validation Scope

Audit ONLY:

- tenant Blueprint documents
- tenant operational logic
- generated BLP files

Use:

@00-SYSTEM
@00-CANONICAL
@01-FRAMEWORK

as READ-ONLY validation references.

Do NOT modify framework architecture.

---

## Validation Objectives

Detect:

- naming drift
- authority conflicts
- operational inconsistencies
- governance gaps
- invalid ownership
- permission conflicts
- invalid escalation paths
- cross-layer contamination
- unsupported blueprint assumptions
- semantic contradictions

---

## Output Requirements

Generate:

- structured validation report
- categorized findings
- severity classification
- recommended corrections
- ontology integrity verification

Examples:

- CLEAN
- WARNING
- CRITICAL

---

## Important Rules

- READ-ONLY mode.
- Do NOT modify files automatically.
- Do NOT generate MTX.
- Do NOT generate AUT.
- Do NOT expand architecture.
- Do NOT create new governance models unless explicitly requested.

Only audit and report.

---

## Final Objective

Ensure the Blueprint layer is:

- semantically stable
- operationally realistic
- governance-aligned
- canonically consistent
- ready for Matrix generation