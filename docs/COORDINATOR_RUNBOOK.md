# Runbook del agente coordinador

## Objetivo

Convertir cada orden aprobada por Roblox Master en trabajo trazable, no solapado y verificable para los subagentes.

## Entrada de una orden

El Coordinador debe registrar:

- Objetivo del usuario.
- Estado actual del juego.
- Segmento y buyer persona.
- Alcance aprobado y fuera de alcance.
- Riesgos conocidos.
- Agentes activados.
- Sistemas que deben bloquearse.

## Algoritmo de asignación

1. Clasificar la orden en producto, diseño, ingeniería, arte, calidad, confianza, crecimiento u operaciones.
2. Consultar `config/agent_manifest.json`.
3. Activar solo los agentes necesarios para ese objetivo.
4. Verificar dependencias y que ningún sistema esté bloqueado por otra tarea.
5. Crear una ficha basada en `docs/AGENT_TASK_TEMPLATE.md` por cada subagente.
6. Definir un agente propietario y revisores independientes.
7. Entregar primero especificación y criterios de aceptación.
8. Esperar evidencia de implementación y pruebas.
9. Solicitar revisión de QA, Seguridad y Cumplimiento cuando aplique.
10. Presentar el informe consolidado a Roblox Master.

## Matriz de revisores obligatorios

| Tipo de cambio | Revisores mínimos |
|---|---|
| Gameplay | Game Design + QA |
| Luau/remotes | Arquitectura + Anti-Exploit + QA |
| Persistencia | Backend/Data + QA + CI/Release |
| Assets | Arte + Copyright/Compliance |
| Monetización | Monetización + Compliance + Product |
| UGC/chat | Community/UGC + Trust & Safety + QA |
| UI multiplataforma | UI/UX + Accesibilidad + QA |
| Publicación | CI/Release + Compliance + Roblox Master |

## Reglas de cierre

El Coordinador no cierra tareas. Solo puede proponer `DONE` cuando existen criterios satisfechos, pruebas reproducibles, evidencia y revisiones requeridas. Roblox Master decide el cierre.

## Reglas de escalado

Escalar inmediatamente a Roblox Master si:

- falta información del buyer persona o del alcance;
- hay conflicto entre agentes;
- se necesita acceso a producción, permisos o secretos;
- aparece un riesgo P0/P1;
- una política de Roblox o legalidad no está clara;
- el cambio puede afectar datos persistentes o monetización;
- Studio y Git tienen fuentes de verdad divergentes.
