# RB-020 — Visual de PrismBloom

## Objetivo

Crear la representación procedural low-poly de la primera criatura fusionada y
mostrarla temporalmente en un `ViewportFrame` cuando el jugador descubre el
resultado.

## Estado

`DONE`

## Propietario

`roblox_master`

## Archivos o instancias afectadas

- `src/shared/CreatureModels.luau`
- `src/client/ClientMain.client.luau`
- `PlayerGui.RaiseABeastHUD.DiscoveryPreview` durante Play

## Criterios de aceptación

- [x] `CreatureModels.Build("PrismBloom", ...)` devuelve un modelo válido.
- [x] El modelo usa piezas low-poly sin assets externos.
- [x] Tiene raíz, cinco pétalos, núcleo luminoso y ojos.
- [x] El HUD muestra un `ViewportFrame` al completar la fusión.
- [x] La vista desaparece automáticamente después de la presentación.
- [x] Revisar que el preview se muestre durante la presentación.
- [ ] Revisar escala en resolución de PC y móvil.

## Seguridad y rendimiento

- El modelo se genera localmente solo para presentación visual.
- No cambia inventario, economía ni persistencia.
- El modelo tiene pocas piezas y no tiene colisión.

## Evidencia

Playtest completado después de sincronización Rojo. El `ViewportFrame` mostró un
modelo `PrismBloom` con 9 piezas, todas ancladas y sin colisión.

## Plan de reversión

Retirar `PrismBloom`, `DiscoveryPreview` y el listener visual sin modificar la
receta ni la validación server-authoritative.
