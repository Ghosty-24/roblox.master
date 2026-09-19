# RB-026 — Inventario y álbum MVP

## Objetivo

Dar al jugador una vista clara de sus criaturas, crecimiento, comida y
descubrimientos.

## Estado

`IN_REVIEW`

## Archivos afectados

- `games/raise-a-beast/src/client/ClientMain.client.luau`
- `games/raise-a-beast/src/server/CaptureService.server.luau`
- `games/raise-a-beast/src/server/TransportService.server.luau`

## Criterios de aceptación

- [x] El panel tiene pestaña `Inventory`.
- [x] El panel tiene pestaña `Album`.
- [x] Inventory muestra criatura, crecimiento y alimentación.
- [x] Album muestra criatura descubierta y rareza.
- [x] Capturar registra el descubrimiento.
- [x] Transportar registra el descubrimiento.
- [x] Album se guarda mediante `DataService`.
- [x] Panel y modal usan escalado responsive según el ancho del viewport.
- [x] Playtest visual en iPhone 17 Pro (874×402) sin clipping ni solapamiento.
- [ ] Validar interacción táctil completa en móvil.

## Evidencia

Playtest: tras capturar `SleepyBlob`, el inventario mostró
`Creature_002|SleepyBlob` y el álbum creó `SleepyBlob|Common`. Rojo build y
Play arrancaron correctamente. En el simulador iPhone 17 Pro, el HUD mostró
Inventory/Album, joystick, objetivo y modal preparados sin desbordamiento
visible.

## Riesgos

La interacción táctil completa todavía requiere una pasada específica; el
escalado visual responsive ya está implementado.
