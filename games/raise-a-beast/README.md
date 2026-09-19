# Raise a Beast

Estado: `IMPLEMENTATION/TEST`

Juego social de Roblox para jugadores de 9–12 años basado en descubrir, cuidar, fusionar y coleccionar criaturas extrañas. La primera versión prioriza claridad, sesiones cortas, progresión visible, móvil y protección del progreso.

## Fuente de verdad

- Scripting y jerarquía sincronizable: `default.project.json` y `src/`
- Flujo Rojo: `ROJO_WORKFLOW.md`
- Visión: `VISION.md`
- Buyer persona: `BUYER_PERSONA.md`
- Diseño: `GDD.md`
- Arquitectura: `ARCHITECTURE.md`
- Cumplimiento: `COMPLIANCE.md`
- Pruebas: `TEST_PLAN.md`
- Backlog y asignaciones: `BACKLOG.md`
- Sincronización del staff: `STAFF_SYNC.md`

El scripting se gestiona con Rojo: el repositorio es la fuente de verdad y Roblox Studio es el entorno de sincronización y prueba. El servidor Rojo se ejecuta desde `games/raise-a-beast` en `localhost:34872` cuando se conecta el plugin.

Se han ejecutado builds con Rojo y playtests de captura, alimentación, fusión,
plots, transporte, pose de carga y expansión espacial de Zona 1. La persistencia ya tiene implementación
server-only, pero la reconexión con DataStore permanece pendiente de validación
con API Services habilitado.

## Zona 1

La primera zona es una plaza de `150×120` studs con ocho parcelas, diez
plataformas por parcela, un corredor central y un conveyor extendido. El
catálogo de Zona 1 contiene 21 criaturas low-poly; el onboarding comienza con
Angry Potato, Sleepy Blob y Tiny Cloud.

## Modelos 3D iniciales

La primera tanda de criaturas está en `src/shared/CreatureModels.luau`. Son modelos low-poly procedurales sin meshes externos: `AngryPotato`, `SleepyBlob` y `TinyCloud`, cada uno con una variante mutada. El script `src/server/CreatureShowcase.server.luau` crea una galería temporal en `Workspace/CreatureShowcase` al iniciar el servidor.

Para probarlos, sincroniza el proyecto con Rojo y ejecuta el juego en Roblox
Studio. Las criaturas del conveyor reutilizan `CreatureModels.Build(id, cframe,
mutated)` y el showcase temporal permanece desactivado.
