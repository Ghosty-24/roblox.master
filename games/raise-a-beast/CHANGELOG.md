# Changelog

## 0.2.0 — 2026-09-19

- Añadidos cuatro plots con asignación server-side.
- Añadido transporte de criaturas por conveyor, carga con `E` y depósito en
  plataforma libre.
- Añadida pose de brazos hacia delante con `AnimationConstraint`.
- Añadida persistencia MVP con esquema versionado, autosave, reintentos y
  separación de claves Studio/producción.
- Añadido feedback visual de propietario en cada base y mensaje de HUD con el
  plot asignado.
- Añadidas pestañas `Inventory` y `Album`, con descubrimientos registrados al
  capturar o transportar criaturas.
- Verificados builds Rojo y playtests de arranque e interacción.

## 0.1.0 — 2026-09-14

- Añadido charter operativo de Raise a Beast.
- Definidos visión, buyer persona, GDD ligero y alcance MVP.
- Añadidas arquitectura técnica, cumplimiento, matriz de assets y plan de pruebas.
- Añadido backlog por agente y sincronización del staff.
- Añadida configuración inicial de Rojo y estructura `src/` para scripting Luau.
- La reconexión real de DataStore y el playtest multicliente siguen pendientes.
# Unreleased

- Adaptadas las 8 bases de Zona 1 al recurso gratuito Creator Store `138263847127429` (`Steal a brainrot base! PBR Tycoon Army P Brain`).
- Sanitizada la plantilla para eliminar scripts, cámaras, humanoides y elementos de prueba antes de clonar la geometría.
- Conservados conveyor, parcelas, plataformas de depósito, perímetro de césped y transporte de criaturas.
