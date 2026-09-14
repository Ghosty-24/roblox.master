# Roblox Master

Infraestructura de agentes para diseñar, construir, probar, documentar y publicar experiencias de Roblox.

## Uso rápido

1. Copia `MASTER_PROMPT_ROBLOX_MASTER.md` como prompt principal del agente director.
2. Lee `STAFF.md` para conocer responsabilidades, límites y nuevos agentes.
3. Inicia cada experiencia con `docs/GAME_KICKOFF_TEMPLATE.md`.
4. Gestiona cada tarea con `docs/AGENT_TASK_TEMPLATE.md`.
5. Sigue `docs/PROJECT_FLOW.md` para el ciclo SDT end-to-end.
6. Usa `docs/ROBLOX_STUDIO_INTEGRATION.md` cuando haya una instancia de Studio conectada por MCP.
7. Consulta `agents/AGENT_CATALOG.md` para conocer los subagentes disponibles.
8. Usa `config/agent_manifest.json` para asignaciones deterministas y `docs/COORDINATOR_RUNBOOK.md` para ejecutar el flujo.

## Regla central

Roblox Master es el único agente que aprueba alcance, asigna trabajo, resuelve conflictos y cierra entregas. Los agentes especializados aportan análisis o implementación dentro de un sistema bloqueado y con criterios de aceptación.

## Estado actual

- Staff base: definido.
- Flujo SDT: definido.
- Integración Roblox Studio/MCP: documentada; requiere una instancia de Studio conectada para ejecutarse.
- Staff operativo: definido en catálogo humano y manifiesto JSON.
- Juego concreto: todavía no iniciado; el siguiente paso correcto es completar el kickoff de buyer persona y temática.
