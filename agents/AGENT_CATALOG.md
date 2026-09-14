# Catálogo operativo de agentes

Cada agente tiene un ID estable para asignación, un ámbito y entregables esperados. El manifiesto machine-readable está en `config/agent_manifest.json`.

## Dirección y producto

| ID | Agente | Entregables |
|---|---|---|
| `roblox_master` | Roblox Master | Decisiones, aprobaciones, alcance, resolución de conflictos y cierre |
| `project_coordinator` | Coordinador de Proyecto | Épicas, tareas, bloqueos, dependencias, estados y reportes |
| `product_manager` | Product Manager Roblox | Product Charter, roadmap, prioridades, métricas y control de alcance |
| `buyer_persona_ux` | Buyer Persona y UX | Persona, hipótesis, onboarding, experiencia y research |
| `game_design` | Game Design | GDD, core loop, progresión, balance, economía y reglas |
| `narrative_content` | Narrative y Content Design | Mundo narrativo, diálogos, misiones, tono y calendario de contenido |

## Ingeniería y plataforma

| ID | Agente | Entregables |
|---|---|---|
| `studio_expert` | Experto Roblox Studio | Jerarquía Studio, configuración, herramientas y workflow |
| `studio_mcp` | Integración Studio/MCP | Estado de Studio, lecturas, cambios controlados, playtests y evidencia |
| `luau_network_architect` | Arquitectura Luau y Red | Arquitectura, módulos, remotes, contratos y autoridad servidor |
| `backend_data_services` | Backend, Data y Servicios Online | DataStore, MemoryStore, migraciones, sesiones, matchmaking y Open Cloud |
| `anti_exploit_security` | Anti-Exploit y Seguridad | Threat model, validaciones, límites, abuso de remotes y hardening |
| `performance_engineer` | Performance Engineer | Presupuesto de FPS/memoria, join time, servidor, profiling y optimización |

## Arte y experiencia

| ID | Agente | Entregables |
|---|---|---|
| `environment_art` | Environment y World Art | Greybox, mundo, iluminación, materiales, VFX y assets |
| `character_animation` | Character, Rigging y Animation | Personajes, rigs, animaciones, attachments y compatibilidad de avatares |
| `ui_ux` | UI/UX e Interacción | Wireframes, HUD, navegación, feedback y componentes de interfaz |
| `audio_design` | Audio Design | Música, SFX, mezcla, eventos sonoros y licencias |

## Calidad, crecimiento y operaciones

| ID | Agente | Entregables |
|---|---|---|
| `qa_test` | QA/Test Engineer | Planes, casos, regresiones, defectos, severidad y aprobación |
| `accessibility_telemetry` | Accesibilidad y Telemetría | Pruebas por dispositivo, accesibilidad, eventos y minimización de datos |
| `monetization` | Monetization Designer | Productos, precios, economía, PolicyService y transparencia |
| `analytics_experimentation` | Product Analytics | Funnels, cohortes, D1/D7/D30, experimentos y decisiones basadas en datos |
| `discovery_marketing` | Discovery, Marketing y Storefront | Metadata, thumbnails, adquisición, campañas y presencia |
| `liveops` | LiveOps y Content Release | Cadencia, eventos, actualizaciones, flags y operaciones post-lanzamiento |

## Confianza, comunidad y entrega

| ID | Agente | Entregables |
|---|---|---|
| `compliance_ip_safety` | Copyright, Trust & Safety y Cumplimiento | Matriz IP, políticas, privacidad, edad, riesgo y aprobación |
| `community_ugc_moderation` | Community, UGC y Moderación | Reglas, reportes, filtrado, abuso, soporte y contenido de usuarios |
| `localization` | Localization Manager | Idioma fuente, tablas, traducciones, contexto y cobertura |
| `ci_release` | CI, Versionado y Release Engineering | Ramas, validaciones, releases, rollback y sincronización |
| `documentation` | Documentation y Knowledge Management | README, ADR, changelog, runbooks y documentación vigente |

## Reglas de activación

- Siempre activos: `roblox_master`, `project_coordinator`, `product_manager`, `game_design`, `luau_network_architect`, `qa_test`, `compliance_ip_safety`, `ci_release`, `documentation`.
- Activados por implementación: `studio_expert`, `studio_mcp`, `backend_data_services`, `anti_exploit_security`, `performance_engineer`.
- Activados por contenido: `buyer_persona_ux`, `narrative_content`, `environment_art`, `character_animation`, `ui_ux`, `audio_design`, `localization`.
- Activados por lanzamiento o monetización: `monetization`, `analytics_experimentation`, `discovery_marketing`, `liveops`, `accessibility_telemetry`, `community_ugc_moderation`.
