# RB-021 — Greybox de Monster Plaza

## Objetivo

Crear la primera zona jugable del MVP con una ruta clara desde el spawn hasta
la captura y el regreso a la base del jugador.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Archivos o instancias afectadas

- `src/server/WorldBuilder.server.luau`
- `Workspace.RaiseABeastPlaza` durante Play
- `Workspace.RaiseABeastPlaza.Spawns.PlayerSpawn` durante Play

## Layout

- Plaza: 80x80 studs.
- Spawn: zona sur, en z=31.
- Base del jugador: z=25.
- Camino principal: eje central hacia z=-18.
- Captura: `Workspace.CaptureZone.CapturePad`.
- Límites bajos en los cuatro lados.

## Criterios de aceptación

- [x] Root de mapa con `Origin`.
- [x] Suelo, camino, base, límites y landmark de captura.
- [x] Spawn navegable y separado del límite.
- [x] Todas las piezas estructurales ancladas.
- [x] Sin assets externos.
- [x] Validar recorrido con cámara del jugador.
- [ ] Revisar escala en PC y móvil.

## Seguridad y rendimiento

- El greybox usa piezas nativas y una cantidad acotada de instancias.
- No se crean criaturas ni datos persistentes.
- El builder evita duplicar el root si ya existe.

## Plan de reversión

Retirar `WorldBuilder.server.luau`; el root runtime desaparecerá al detener
Play sin afectar los sistemas de captura, alimentación o fusión.

## Evidencia

Playtest completado: el jugador aparece sobre `PlayerSpawn`, la navegación al
`CapturePad` y al `PlayerBase` funcionó. El navegador automático no acepta el
`SpawnLocation` como destino de ruta, pero la posición inicial del personaje se
confirmó sobre el spawn.
