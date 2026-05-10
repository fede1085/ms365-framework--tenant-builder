# ARC-STD-007b — Naming Convention Emoji Guide (Visual/Emoji Extension)

## Display Name Visual Tagging Standard

### Purpose
Agregar una capa visual consistente para identificación rápida de usuarios por departamento sin afectar la lógica técnica del tenant.

---

### DisplayName Format

[EMOJI] [DEPT]-Nombre Apellido

---

### Examples

⚙️ OPS-John Carter  
📦 WH-Tom Vermeer  
🎧 SUPPORT-Anna Smith  
💵 SALES-Chris Walker  
📊 FINANCE-Eva Morgan  
👥 HR-Nina Brooks  
💻 IT-Diego Tapie  

---

### Rules

- 1 emoji por departamento (definido en Department Matrix)
- Prefijo DEPT obligatorio (OPS, WH, HR, IT, etc.)
- El emoji SIEMPRE precede al prefijo
- Formato fijo: `[EMOJI] [DEPT]-Nombre Apellido`
- NO usar emojis en:
  - UserPrincipalName (UPN)
  - Email
  - SamAccountName

---

### Mapping Source of Truth

El mapeo oficial de emojis se define en:

BLP-TMP-002 — Department Matrix

Ejemplo:

OPS → ⚙️  
WH → 📦  
SUPPORT → 🎧  
HR → 👥  

---

### Validation Logic

Para automatización:

- Detectar DEPT por prefijo (ej: "OPS-")
- Validar que el emoji coincide con el DEPT
- Ignorar emoji para lógica crítica (solo visual)

---

### Automation Considerations

- El campo clave para lógica es:
  - Department (Azure AD)
  - Prefijo DEPT en DisplayName

- El emoji es:
  - Solo visual
  - No debe ser usado como única fuente de decisión

---

### Governance Notes

- No se permite variación de emojis dentro del mismo departamento
- Cambios deben actualizar:
  - Department Matrix
  - Naming Convention
  - Scripts de automatización (si aplican)

---

## Naming Hierarchy

- **ARC-STD-007:** Base Standard
- **ARC-STD-007a:** Usage Guide
- **ARC-STD-007b:** Visual/Emoji Extension (This document)

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- ARC-STD-007 — Naming Convention Standard
- ARC-STD-007a — Naming Convention Standard Guide