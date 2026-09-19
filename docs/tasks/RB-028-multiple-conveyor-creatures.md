# RB-028 — Flujo de varias criaturas en el conveyor

## Objetivo

Hacer que el conveyor muestre un flujo continuo de criaturas, como en la
referencia visual, manteniendo separación, prompts independientes y carga de
la criatura más cercana.

## Estado

`IN_REVIEW`

## Implementación

- Cuatro criaturas aparecen separadas al iniciar la ronda.
- El límite simultáneo es cinco.
- Cada criatura mantiene su propio progreso y conexión de interacción.
- La tecla `E` selecciona la criatura más cercana al jugador.
- Las criaturas siguen siendo autoridad del servidor.

## Criterios de aceptación

- [x] Aparecen varias criaturas simultáneamente.
- [x] Mantienen separación visual sobre el conveyor.
- [x] Cada criatura tiene su propio `CarryPrompt`.
- [x] El conveyor continúa generando criaturas al liberar espacios.
- [x] Rojo compila correctamente.
- [x] Playtest confirmó cuatro modelos activos.
- [ ] Verificar carga de dos criaturas distintas con dos jugadores.

## Evidencia

Playtest en Studio: `count=4` con criaturas en posiciones distintas del
conveyor (`x=-46.5`, `-15.9`, `8.6`, `39.1`). Captura visual muestra varias
criaturas visibles simultáneamente.
