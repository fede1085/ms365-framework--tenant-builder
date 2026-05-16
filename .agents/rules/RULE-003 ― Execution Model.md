# RULE-003 ― Execution Model

`.agents` operational behavior must follow SYS semantic authority and CANONICAL schemas/rules/routing/graph constraints.

## Execution Model Layer Hierarchy

SYS → CANONICAL → ARC → BLP → MTX → AUT → INSTANCE/TENANT

1. **SYS (Semantic Control)**: Defines semantic doctrine, authority interpretation, and context meaning.
2. **CANONICAL (Structured Control)**: Defines schemas, rules, routing, and graph constraints.
3. **ARC (Architecture)**: Defines tenant architecture doctrine and rules.
4. **BLP (Blueprint)**: Defines reusable tenant templates. It must NEVER contain real tenant data.
5. **MTX (Matrix)**: Contains concrete instance data. This is the ONLY source of real execution data.
6. **AUT (Automation)**: Execution layer. Executes ONLY validated MTX data.
7. **INSTANCE/TENANT**: Concrete tenant-local runtime state.

## Rules

- BLP must NEVER contain real tenant data.
- MTX is the ONLY source of real execution data.
- AUT executes ONLY MTX data.
- Agents MUST NOT skip MTX layer.
- CANONICAL routing and rules constrain what context agents load and what actions are allowed.
- Root prompts are workflow entrypoints, not authority doctrine.
- Naming must always follow Architecture rules.
- Security rules must always be enforced.

## Forbidden Behaviors

- Generating real emails in BLP.
- Assigning permissions directly from workflows.
- Mixing template and instance data.
