# Backlog inicial por agente

Estado global: `SPEC/DESIGN`

## P0 — antes de implementar gameplay

| ID | Propietario | Entrega | Revisores | Dependencias |
|---|---|---|---|---|
| RB-001 | product_manager | Charter, objetivos y límites MVP | roblox_master, project_coordinator | ninguna |
| RB-002 | buyer_persona_ux | Persona, onboarding e hipótesis | product_manager, ui_ux, qa_test | RB-001 |
| RB-003 | game_design | GDD, recetas, progresión y economía | product_manager, qa_test | RB-002 |
| RB-004 | compliance_ip_safety | Matriz IP, edad, comunicación y monetización | roblox_master | RB-001 |
| RB-005 | luau_network_architect | Contratos servidor/cliente y estructura modular | game_design, anti_exploit_security | RB-003 |

## P1 — preparación de producción

| ID | Propietario | Entrega | Revisores | Dependencias |
|---|---|---|---|---|
| RB-006 | environment_art | Greybox Monster Plaza y bases | game_design, performance_engineer | RB-003 |
| RB-007 | character_animation | Tres criaturas provisionales y evoluciones | environment_art, compliance_ip_safety | RB-004 |
| RB-008 | ui_ux | Wireframes de tutorial, inventario y fusión | buyer_persona_ux, accessibility_telemetry | RB-002 |
| RB-009 | backend_data_services | Diseño de esquema y guardado | luau_network_architect, qa_test | RB-005 |
| RB-010 | anti_exploit_security | Threat model y checklist de remotes | luau_network_architect | RB-005 |
| RB-011 | performance_engineer | Presupuesto móvil y límites de instancia | studio_expert, environment_art | RB-006 |
| RB-012 | qa_test | Casos de prueba MVP y criterios de bloqueo | luau_network_architect, game_design | RB-003, RB-005 |

## P2 — fase posterior al prototipo

| ID | Propietario | Entrega | Revisores | Dependencias |
|---|---|---|---|---|
| RB-013 | monetization | Propuesta cosmética y revisión de políticas | compliance_ip_safety, product_manager | RB-004 |
| RB-014 | analytics_experimentation | Eventos de funnel y cohortes | accessibility_telemetry, product_manager | RB-002 |
| RB-015 | liveops | Calendario de contenido posterior | analytics_experimentation, ci_release | RB-014 |
| RB-016 | localization | Tabla de textos y cobertura inicial | buyer_persona_ux | RB-008 |

## Regla de transición

Ningún P1 pasa a implementación sin aprobación de Roblox Master y sin criterios de aceptación. Las pruebas reales quedan pendientes hasta disponer de Roblox Studio conectado.
