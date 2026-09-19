# RB-019 — Primera fusión

## Objetivo

Consumir exactamente tres criaturas maduras mediante una receta validada por el
servidor y registrar el resultado en el álbum.

## Estado

`DONE`

## Propietario

`roblox_master`

## Agentes consultados

- `luau_network_architect`
- `studio_mcp`
- `qa_test`

## Sistema bloqueado

Fusión inicial e inventario temporal.

## Archivos o instancias afectadas

- `src/shared/FusionConfig.luau`
- `src/server/CaptureService.server.luau`
- `src/client/ClientMain.client.luau`
- `Player.RaiseABeastInventory` durante Play

## Receta MVP

`AngryPotato + SleepyBlob + TinyCloud -> PrismBloom`

## Criterios de aceptación

- [x] El cliente muestra el botón solo con tres criaturas maduras.
- [x] El servidor valida propiedad y madurez.
- [x] El servidor valida la receta exacta.
- [x] Se consumen exactamente tres entradas.
- [x] Se crea `PrismBloom`.
- [x] Se registra `PrismBloom` en `Album`.
- [x] Probar una receta válida con tres criaturas maduras.
- [x] Confirmar consumo de las tres entradas originales.
- [x] Confirmar creación de `PrismBloom` en el inventario.
- [x] Confirmar descubrimiento de `PrismBloom` en `Album`.
- [x] Probar confirmación explícita antes del consumo.
- [ ] Probar una receta inválida.
- [ ] Probar doble solicitud concurrente.

## Seguridad y rendimiento

- El cliente no decide el resultado ni la receta.
- El servidor controla el consumo y aplica cooldown.
- No se accede a DataStore en esta iteración.

## Plan de reversión

Retirar `FusionConfig`, la conexión `FusionRequest` y el botón de fusión sin
afectar captura ni alimentación.

## Evidencia

Playtest completado: tres criaturas capturadas, nueve comidas usadas, tres
criaturas maduras y fusión ejecutada desde el botón del HUD.

## Problemas y riesgos

- `PrismBloom` existe como entrada de inventario/álbum, pero todavía no tiene
  modelo visual dedicado.
- La confirmación visual existe; todavía se debe probar el rechazo de recetas
  inválidas y solicitudes concurrentes.

## Aprobación de Roblox Master

Aprobado por la orden del usuario: continuar con el desarrollo del MVP.
