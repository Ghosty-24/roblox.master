# RB-032 — Mayor frecuencia y velocidad del conveyor

## Objetivo

Aumentar la presencia de criaturas en la cinta transportadora y acelerar su recorrido a `1.25x`.

## Estado

`TEST`

## Propietario

`luau_network_architect`

## Agentes consultados

- `game_design`
- `qa_test`
- `performance_engineer`

## Archivos/instancias afectados

- `games/raise-a-beast/src/shared/TransportConfig.luau`
- Runtime: `Workspace.RaiseABeastPlaza.ConveyorZone.ConveyorCreatures`

## Cambios aprobados

- Travel time: 20 s → 16 s, equivalente a `1.25x`.
- Spawn interval: 5 s → 3 s.
- Initial creatures: 4 → 6.
- Maximum active conveyor creatures: 5 → 8.

## Criterios de aceptación

- [x] La velocidad se configura en un único archivo compartido.
- [x] La velocidad efectiva es 1.25 veces la anterior.
- [x] La cinta mantiene más criaturas visibles.
- [x] El límite de criaturas evita crecimiento ilimitado.
- [x] Playtest confirma que se crean múltiples criaturas en el conveyor.
- [x] Playtest confirma configuración `TravelSeconds = 16` y `SpawnIntervalSeconds = 3`.
- [x] Playtest confirma límite `MaxConveyorCreatures = 8`.
- [ ] Playtest confirma el recorrido y la interacción E/carry.
- [ ] Playtest confirma que no se rompen captura, transporte ni depósito.
- [ ] QA revisa legibilidad y rendimiento.

## Evidencia de ejecución

- Studio conectado: `¡Raise a Beast! (placeId: 139413938995014)`.
- Modo: Play, después detenido y devuelto a Edit.
- Runtime observado: 5 criaturas activas distribuidas por la cinta durante la lectura; la configuración permite hasta 8.
- Posiciones observadas en el eje del conveyor: aproximadamente `-52.12`, `-21.58`, `8.96`, `39.51`, `70.05`.
- Captura visual: `Conveyor_1_25x_Density`.
- Consola: sin errores de compilación del cambio; permanecen mensajes previos de backend local no conectado, ajenos a esta prueba.

## Rollback

Restaurar `TravelSeconds = 20`, `SpawnIntervalSeconds = 5`, `InitialCreatureCount = 4` y `MaxConveyorCreatures = 5`.
