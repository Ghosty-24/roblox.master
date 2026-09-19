# RB-023 — Asignación de plots de jugador

## Objetivo

Convertir la base única en cuatro plots independientes y asignar uno por
jugador desde el servidor.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Archivos o instancias afectadas

- `src/server/WorldBuilder.server.luau`
- `src/server/PlotService.server.luau`
- `Workspace.RaiseABeastPlaza.Zone_Spawn.Plots` durante Play

## Criterios de aceptación

- [x] Existen cuatro plots nombrados `Plot1` a `Plot4`.
- [x] Cada plot tiene tres slots de exhibición.
- [x] El servidor asigna el primer plot libre.
- [x] El plot registra `OwnerUserId` y `OwnerName`.
- [x] Las exhibiciones se crean en el plot asignado.
- [x] El plot se libera al salir el jugador.
- [x] Probar asignación del primer jugador.
- [ ] Probar dos jugadores simultáneos.
- [x] Añadir feedback visual del plot asignado.

## Seguridad y rendimiento

- La asignación no depende de datos enviados por el cliente.
- El límite actual es de cuatro plots.
- Las exhibiciones siguen limitadas a tres por jugador.

## Plan de reversión

Restaurar el `PlayerPlot` único y el `PlotService` anterior si la prueba
multijugador detecta problemas de navegación o replicación.

## Evidencia

Playtest completado con el jugador `Ernestplayz24`: recibió `Plot1`, que quedó
marcado con `Occupied=true`, `OwnerUserId=1342229273` y `OwnerName`. La
captura se mostró en `Plot1.DisplayModels`.

En la verificación actual del servidor, los cuatro plots aparecen correctamente
(`Plot1` ocupado y `Plot2`–`Plot4` libres) y `Players.Ernestplayz24` conserva
`PlotName=Plot1`. La prueba de dos jugadores simultáneos queda pendiente porque
la interfaz MCP expuesta solo inicia un cliente y la superficie nativa de
Roblox Studio no fue detectada por Computer Use en esta sesión. El código de
asignación y la validación server-side del plot propio sí están implementados;
falta la evidencia con dos sesiones simultáneas.

El feedback visual sí quedó verificado: `Plot1.Base.OwnerSign.OwnerLabel`
muestra `Ernestplayz24's Base` durante Play y el HUD informa que la base
asignada es `Plot1`.
