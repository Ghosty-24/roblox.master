# Flujo end-to-end de Roblox Master

## 0. Control previo

El Director lee el estado del repositorio, documentos y decisiones. El Coordinador comprueba que no exista otra tarea con bloqueo sobre el mismo sistema.

## 1. Discovery

Se recopilan temática, edad, buyer persona, mercados, plataforma, referencias, alcance, recursos y definición SDT del repositorio. Resultado: `PROJECT_CHARTER` aprobado.

## 2. Specification

Game Design, Buyer Persona, Cumplimiento, Arquitectura y QA producen requisitos, hipótesis, riesgos, criterios de aceptación y plan de prueba. Resultado: backlog priorizado del MVP.

## 3. Design

Se define GDD ligero, core loop, mapa de sistemas, jerarquía de instancias, contratos cliente-servidor, UX, arte, balance, telemetría y matriz de assets/licencias. Resultado: diseño aprobado.

Para referencias visuales se aplica además `docs/REFERENCE_WORKFLOW.md`: análisis de imagen, muestra conceptual, aprobación, descomposición, revisión de assets, implementación y comparación visual.

## 4. Implementation

El Coordinador entrega tareas no solapadas. Cada tarea declara propietario, sistema bloqueado, archivos/instancias, dependencias, aceptación y rollback. Arquitectura revisa código y Studio/MCP solo actúa sobre la instancia indicada.

Los recursos de Creator Store se buscan únicamente cuando la tarea los necesita. Deben ser gratuitos, registrarse en `games/<game-id>/ASSET_LICENSES.md`, inspeccionarse y aprobarse antes de insertarse.

## 5. Test

QA ejecuta pruebas de lógica, cliente-servidor, multicliente, persistencia, dispositivos, red, seguridad, accesibilidad y regresión. El agente de Studio/MCP aporta estado, consola, capturas y resultados de playtest.

## 6. Review

Se revisan defectos, seguridad, rendimiento, copyright, políticas y documentación. P0/P1 bloquean el avance.

## 7. Release

CI/Release verifica commit, versión, changelog, rollback, configuración, permisos, experiencia privada/beta y checklist de publicación. Roblox Master autoriza el release.

## 8. LiveOps

Se monitorizan métricas agregadas, errores, feedback, economía, moderación y retención saludable. Todo cambio vuelve a entrar por el mismo flujo.
