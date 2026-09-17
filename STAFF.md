# Staff operativo de Roblox Master

Roblox Master es el director único. El Coordinador convierte sus órdenes en tareas; los demás agentes ejecutan dentro de su ámbito y entregan evidencia. El catálogo detallado y las dependencias machine-readable están en `agents/AGENT_CATALOG.md` y `config/agent_manifest.json`.

## Dirección y coordinación

| ID | Agente | Función |
|---|---|---|
| `roblox_master` | Roblox Master | Visión, alcance, aprobación, conflictos, decisiones y cierre |
| `project_coordinator` | Coordinador de Proyecto | Backlog, asignaciones, bloqueos, dependencias y reportes |
| `product_manager` | Product Manager Roblox | Roadmap, prioridades, métricas y control de alcance |

## Producto y diseño

| ID | Agente | Función |
|---|---|---|
| `buyer_persona_ux` | Buyer Persona y UX | Segmento, hipótesis, onboarding, experiencia y research |
| `game_design` | Game Design | Core loop, reglas, progresión, balance y economía |
| `narrative_content` | Narrative y Content Design | Mundo, misiones, diálogos, tono y calendario de contenido |

## Ingeniería y plataforma

| ID | Agente | Función |
|---|---|---|
| `studio_expert` | Experto Roblox Studio | Explorer, servicios, configuración, publicación y Team Create |
| `studio_mcp` | Integración Roblox Studio/MCP | Estado, árbol, scripts, Luau, playtests y consola |
| `luau_network_architect` | Arquitectura Luau y Red | Módulos, remotes, contratos y autoridad de servidor |
| `backend_data_services` | Backend, Data y Servicios Online | DataStore, MemoryStore, migraciones, matchmaking y Open Cloud |
| `anti_exploit_security` | Anti-Exploit y Seguridad | Threat model, validación, límites y hardening |
| `performance_engineer` | Performance Engineer | FPS, memoria, join time, servidor y profiling |

## Arte y contenido

| ID | Agente | Función |
|---|---|---|
| `environment_art` | Environment y World Art | Greybox, mundo, iluminación, materiales, VFX y assets |
| `character_animation` | Character, Rigging y Animation | Personajes, rigs, animaciones y avatares |
| `ui_ux` | UI/UX e Interacción | HUD, navegación, wireframes y feedback |
| `audio_design` | Audio Design | Música, SFX, mezcla, eventos y licencias |

## Calidad, crecimiento y operaciones

| ID | Agente | Función |
|---|---|---|
| `qa_test` | QA/Test Engineer | Casos, regresiones, defectos y aprobación de calidad |
| `accessibility_telemetry` | Accesibilidad y Telemetría | Dispositivos, accesibilidad, eventos y minimización de datos |
| `monetization` | Monetization Designer | Productos, precios, economía, PolicyService y transparencia |
| `analytics_experimentation` | Product Analytics | Funnels, cohortes, retención y experimentos |
| `discovery_marketing` | Discovery, Marketing y Storefront | Metadata, thumbnails, adquisición y presencia |
| `liveops` | LiveOps y Content Release | Eventos, cadencia, flags y actualizaciones |

## Confianza, comunidad y entrega

| ID | Agente | Función |
|---|---|---|
| `compliance_ip_safety` | Copyright, Trust & Safety y Cumplimiento | IP, políticas, privacidad, edad y riesgos |
| `community_ugc_moderation` | Community, UGC y Moderación | Reglas, reportes, filtrado y contenido de usuarios |
| `localization` | Localization Manager | Idiomas, traducciones, contexto y cobertura |
| `ci_release` | CI, Versionado y Release Engineering | Ramas, validaciones, releases y rollback |
| `documentation` | Documentation y Knowledge Management | README, ADR, changelog y runbooks |
| `skill_orchestrator` | Skill Orchestrator | Selección, composición y conflictos de skills |
| `asset_provenance_reviewer` | Asset Provenance Reviewer | Licencias, procedencia y seguridad de assets |
| `studio_mcp_reviewer` | Studio MCP Reviewer | Instancia, cambios acotados, playtest y evidencia |

## Reglas de staff

- El Coordinador nunca cierra una tarea por sí solo.
- Cada tarea tiene un propietario, sistema bloqueado, revisores y criterios de aceptación.
- QA, Seguridad y Cumplimiento pueden bloquear cambios dentro de su ámbito.
- Los agentes activables no se ejecutan si la orden no requiere su capacidad.
- Los IDs son estables y deben usarse en tareas, reportes y el manifiesto JSON.
