# RB-034 — Bases tycoon de colores y perímetro de césped

## Objetivo

Convertir las ocho parcelas en bases tipo tycoon con color propio y añadir muros verdes con césped alrededor del espacio de juego.

## Estado

`TEST`

## Propietario

`environment_art`

## Agentes consultados

- `roblox_master`
- `studio_mcp`
- `qa_test`
- `performance_engineer`

## Archivos/instancias afectados

- `games/raise-a-beast/src/server/WorldBuilder.server.luau`
- `games/raise-a-beast/src/server/TycoonPerimeter.server.luau`
- Runtime: `Plot1..Plot8.Base` y `RaiseABeastPlaza.TycoonPerimeter`.

## Criterios de aceptación

- [x] Cada base tiene un color propio.
- [x] Las fachadas low-poly existentes se conservan.
- [x] Las fachadas se sustituyen por 8 bases adaptadas del asset `138263847127429`.
- [x] Se añaden muros exteriores con tierra, césped y remate verde.
- [x] Se añaden montículos low-poly en las esquinas.
- [x] No se desplazan las parcelas ni el conveyor.
- [x] Playtest confirma circulación y visibilidad.
- [ ] QA confirma carry/deposit y transporte.
- [x] Playtest confirma 8 `StealABrainrotBase` y 0 `LowPolyFacade`.

## Evidencia de ejecución

- Studio conectado: `¡Raise a Beast! (placeId: 139413938995014)`.
- Parcelas verificadas: `8`.
- Colores de base únicos verificados: `8`.
- Perímetro `TycoonPerimeter`: creado con `20` piezas entre muros, remates y montículos.
- Conveyor conservado y visible.
- Capturas: `TycoonBases_GrassPerimeter` y `TycoonBases_Inside`.
- Consola: sin errores de compilación de los cambios; permanecen avisos previos de backend local no conectado.
- Captura adicional: `StealABrainrotBases_Playtest` muestra las 8 bases alrededor del conveyor.
- Runtime: `storeBases=8`, `oldFacades=0`, `scripts=0` dentro de `RaiseABeastPlaza`.

## Creator Store

Se revisaron dos resultados gratuitos relacionados con `Tycoon Walls Grass`.
Ambos fueron rechazados como inserción directa por tamaño excesivo y scripts
internos. Se conservaron sus referencias en `ASSET_LICENSES.md` y se aplicó una
recreación nativa low-poly/blocky del lenguaje visual.

Se aprobó para adaptación el recurso gratuito `138263847127429`,
`Steal a brainrot base! PBR Tycoon Army P Brain`, del creador `z6_o8`.
El modelo se conserva como plantilla limpia en
`ServerStorage.CreatorStoreAssets.StealABrainrotBaseTemplate`; sus scripts,
interfaces de prueba, cámaras, humanoides y valores internos se eliminan antes
de clonar la geometría en cada parcela.

## Rollback

Eliminar `ServerStorage.CreatorStoreAssets.StealABrainrotBaseTemplate`, quitar el
bloque `StealABrainrotBase` de `BaseFacades.server.luau` y restaurar el fallback
`LowPolyFacade` anterior. El perímetro y el conveyor no forman parte de este
rollback.
