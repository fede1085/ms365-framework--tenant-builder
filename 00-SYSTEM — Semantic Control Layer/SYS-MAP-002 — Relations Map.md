# @SYS-MAP-002 — Relations Map

> **Purpose:** Global relationship map to allow AI systems to navigate document relationships.
> **Role note:** Human-semantic relationship source; CANONICAL graph YAML files are structured projections.

## Architecture to Blueprint
@ARC-STD-007
depends_on:
  - @ARC-SYS-000
feeds:
  - @BLP-SYS-000
  - @BLP-TMP-002
governed_by:
  - @ARC-GOV-016

## Blueprint to Matrix
@BLP-TMP-003
depends_on:
  - @ARC-STD-007
feeds:
  - @MTX-USR-001
  - @MTX-GRP-001
related_to:
  - @BLP-TMP-002
impacts:
  - @BLP-TMP-004

## Matrix to Automation
@MTX-USR-001
depends_on:
  - @BLP-TMP-003
  - @BLP-TMP-006
feeds:
  - @AUT-DOC-009
governed_by:
  - @BLP-TMP-015

## Prompt Orchestration Relationships

@00-START — Initialization Prompt
feeds:
  - @PRJ-BLUEPRINT-MASTER-DOC
hands_off_to:
  - @01-GENERATION — Blueprint Generation Prompt
governed_by:
  - @SYS-MAP-006
  - @SYS-MAP-000

@01-GENERATION — Blueprint Generation Prompt
depends_on:
  - @PRJ-BLUEPRINT-MASTER-DOC
feeds:
  - @02-BLP
hands_off_to:
  - @02-VALIDATION — Blueprint Validation Prompt
governed_by:
  - @ARC-SYS-000

@02-VALIDATION — Blueprint Validation Prompt
depends_on:
  - @02-BLP
feeds:
  - @03-MTX
hands_off_to:
  - @03-MTX — Matrix Generation Prompt
related_to:
  - @SYS-MAP-006

@03-MTX — Matrix Generation Prompt
depends_on:
  - @02-BLP
feeds:
  - @03-MTX
hands_off_to:
  - @04-AUT-DEPLOYMENT — Controlled Execution Prompt
governed_by:
  - @ARC-STD-007
  - @BLP-TMP-003

@04-AUT-DEPLOYMENT — Controlled Execution Prompt
depends_on:
  - @03-MTX
related_to:
  - @AUT-DOC-011
  - @AUT-DOC-012
governed_by:
  - @SYS-MAP-006

## Global Security
@ARC-STD-014
impacts:
  - @BLP-TMP-006
  - @BLP-TMP-002
related_to:
  - @ARC-SYS-000
