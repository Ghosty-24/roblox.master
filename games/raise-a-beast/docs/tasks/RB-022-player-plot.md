# RB-022 — Base personal del jugador

## Objetivo

Convertir la base del MVP en un espacio personal con tres slots de exhibición y
actualización automática a partir del inventario temporal.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Archivos o instancias afectadas

- `src/server/WorldBuilder.server.luau`
- `src/server/PlotService.server.luau`
- `Workspace.RaiseABeastPlaza.Zone_Spawn.PlayerPlot` durante Play
- `Workspace.RaiseABeastPlaza.Zone_Spawn.PlayerPlot.DisplayModels` durante Play

## Criterios de aceptación

- [x] La base contiene tres pedestales.
- [x] El servicio usa modelos procedurales internos.
- [x] Una captura crea una exhibición en el primer slot.
- [x] Una fusión elimina las tres exhibiciones antiguas y muestra `PrismBloom`.
- [ ] Probar una segunda sesión de jugador.
- [ ] Revisar escala y lectura visual desde la cámara del jugador.

## Seguridad y rendimiento

- Las exhibiciones se generan desde el inventario validado por servidor.
- No se aceptan nombres de criaturas desde el cliente para crear modelos.
- Se limitan las exhibiciones a tres slots y no hay colisión.

## Plan de reversión

Retirar `PlotService.server.luau` y la carpeta `PlayerPlot`; la captura y la
fusión seguirán funcionando sin representación física.

## Evidencia

Playtest completado: `Creature_001_Display` apareció en el primer slot tras la
captura; tras la fusión se reemplazó por `Creature_003_Display` con el modelo
`PrismBloom`, 9 piezas y 0 errores de anclaje.
