# RULE-003 ― Execution Model

## Execution Model Layer Hierarchy

ARCH → BLP → MTX → AUT

1. **ARCH (Architecture)**: Defines the rules and serves as the source of truth.
2. **BLP (Blueprint)**: Defines the template layer. It must NEVER contain real tenant data.
3. **MTX (Matrix)**: Contains instance data. This is the ONLY source of real execution data.
4. **AUT (Automation)**: Execution layer. Executes ONLY MTX data.

## Rules

- BLP must NEVER contain real tenant data.
- MTX is the ONLY source of real execution data.
- AUT executes ONLY MTX data.
- Agents MUST NOT skip MTX layer.
- Naming must always follow Architecture rules.
- Security rules must always be enforced.

## Forbidden Behaviors

- Generating real emails in BLP.
- Assigning permissions directly from workflows.
- Mixing template and instance data.
