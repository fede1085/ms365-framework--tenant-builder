# @SYS-MAP-004 - Authority Map

> **Purpose:** Detect authority documents to help AI prioritize source-of-truth documents.

## 1. Architecture Authority (Absolute Truth)
*These documents define the unchangeable rules for the framework.*
- **@ARC-SYS-000:** Master System Rules (Overrides all conflicting logic)
- **@ARC-STD-007:** Master Naming Authority
- **@ARC-STD-014:** Master Security Posture

## 2. Governance Documents (Policy Truth)
*These documents dictate the "why" behind the architecture.*
- **@ARC-GOV-016:** Identity Lifecycle Policy
- **@BLP-TMP-015:** Licensing and Cost Control Policy

## 3. Blueprint Authority (Structural Truth)
*These documents define the shape of instances, but not the specific data.*
- **@BLP-SYS-000:** Master Blueprint Control
- **@BLP-TMP-002:** Canonical Department Structure

## 4. Matrix Authority (Instance Data Truth)
*These are the source of truth for a specific deployment/project.*
- **@MTX-USR-001:** Definitive list of Users for deployment.
- **@MTX-GRP-001:** Definitive list of Groups for deployment.

## AI Resolution Hierarchy
If there is a conflict in instructions or data, the AI must resolve using this order of precedence:
1. @ARC (Architecture) overrides @BLP
2. @BLP (Blueprint) overrides @MTX
3. @MTX (Matrix) is the only valid source for @AUT (Automation)
