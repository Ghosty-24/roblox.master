# RB-030 — Agente de interpretación de referencias visuales

## Objetivo

Crear un agente especializado que convierta imágenes de referencia en análisis visuales estructurados y aprobables antes de construir en Roblox.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Agentes consultados

- `project_coordinator`
- `environment_art`
- `qa_test`
- `compliance_ip_safety`
- `documentation`

## Sistema bloqueado

Ningún sistema de Roblox Studio. La implementación del mundo queda bloqueada hasta aprobar un análisis visual concreto.

## Archivos afectados

- `config/agent_manifest.json`
- `agents/AGENT_CATALOG.md`
- `agents/prompts/image_reference_interpreter.md`
- `docs/REFERENCE_ANALYSIS_TEMPLATE.md`
- `docs/tasks/RB-030-image-reference-interpreter.md`

## Dependencias

- Prompt maestro Roblox Master.
- Contrato operativo de agentes.
- Flujo SDT.
- Contexto del juego que reciba la referencia.

## Criterios de aceptación

- [x] El agente tiene un ID estable y dependencias declaradas.
- [x] El agente aparece en el manifiesto y catálogo.
- [x] Existe un prompt con separación entre observado, inferido, supuesto y desconocido.
- [x] Existe una plantilla de salida reutilizable.
- [x] El agente no puede ejecutar cambios en Studio por su contrato.
- [x] Se define una puerta de aprobación antes de construir.
- [x] Se incluyen criterios de comparación visual y riesgos de IP.

## Implementación prevista

En esta fase solo se crea el contrato documental. La siguiente fase utilizará el agente con una imagen real y generará un `REFERENCE_ANALYSIS` sin modificar Studio.

## Pruebas reproducibles

1. Validar JSON del manifiesto.
2. Confirmar que existen el prompt, la plantilla y esta ficha.
3. Ejecutar una prueba de análisis documental con una imagen de referencia, sin herramientas de escritura ni Studio MCP.
4. Revisar que la salida incluya estado, incertidumbres y criterios de aceptación.

## Seguridad y rendimiento

- No se introducen scripts, remotes, assets ni cambios en el juego.
- No se accede a datos persistentes.
- Las imágenes se tratan como referencias de diseño, no como autorización de copiar contenido protegido.

## Plan de reversión

Revertir los cinco archivos añadidos/modificados de esta tarea mediante Git si Roblox Master lo solicita. No hay cambios de Studio que revertir.

## Evidencia

- Fase documental creada en el repositorio local.
- Pendiente ejecutar validación automática y revisión del usuario.

### Análisis ejecutado

- `docs/reference-analyses/lobby-baseplate-analysis.md`
- Entrada: `C:\Users\ernes\Downloads\lobby.jpeg`
- Resultado: `READY_FOR_APPROVAL`
- Studio MCP/Rojo: no utilizados para escribir ni modificar la escena.

## Problemas y riesgos

- El agente no puede deducir medidas absolutas de una única imagen sin escala.
- La fidelidad dependerá del ángulo, iluminación y claridad de la referencia.
- La integración posterior requerirá aprobación separada.

## Aprobación de Roblox Master

La creación fue autorizada por el usuario en la conversación actual. El cierre de la tarea queda pendiente de validación de archivos y de la primera prueba con una imagen real.
