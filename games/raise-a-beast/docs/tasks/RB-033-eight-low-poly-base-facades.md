# RB-033 — Ocho bases con fachadas low-poly

## Objetivo

Eliminar el lobby visual temporal y crear ocho fachadas low-poly diferentes, cuatro a cada lado del conveyor, conservando la estructura funcional de las parcelas.

## Estado

`TEST`

## Propietario

`environment_art`

## Agentes consultados

- `roblox_master`
- `image_reference_interpreter`
- `studio_mcp`
- `qa_test`
- `performance_engineer`

## Archivos/instancias afectados

- Eliminado: `games/raise-a-beast/src/server/ReferenceLobby.server.luau`.
- Añadido: `games/raise-a-beast/src/server/BaseFacades.server.luau`.
- Runtime: `Workspace.RaiseABeastPlaza.Zone_Spawn.Plots.Plot1..Plot8.LowPolyFacade`.

## Criterios de aceptación

- [x] Se elimina la capa `ReferenceLobby`.
- [x] Se conservan Baseplate, conveyor, parcelas, slots, transporte e inventario.
- [x] Se crean ocho fachadas, una por parcela.
- [x] Existen cuatro fachadas a cada lado del conveyor.
- [x] Cada fachada tiene un estilo visual diferente.
- [x] Las fachadas usan Parts nativas, sin assets externos.
- [x] Las fachadas son visuales y no bloquean las interacciones existentes.
- [x] Playtest confirma que las ocho fachadas se generan.
- [x] Playtest confirma visibilidad inicial y circulación central.
- [ ] QA confirma que carry/deposit y criaturas siguen funcionando.

## Evidencia de ejecución

- Studio conectado: `¡Raise a Beast! (placeId: 139413938995014)`.
- `Workspace.ReferenceLobby`: ausente tras reiniciar Playtest.
- Parcelas: `8`.
- Fachadas: `8` bajo `Plot1..Plot8.LowPolyFacade`.
- Estilos registrados: `WindowShowroom`, `NeonGate`, `StripedShop`, `TwinWindow`, `CornerCanopy`, `TallSign`, `OpenGarage`, `DoubleFrame`.
- Conveyor: presente.
- Captura: `EightBaseFacades_Initial`.
- Consola: sin errores de compilación del nuevo script; permanecen avisos previos de backend local no conectado.

## Rollback

Eliminar `BaseFacades.server.luau` y volver a sincronizar; no se modifica la geometría funcional de `WorldBuilder.server.luau`.
