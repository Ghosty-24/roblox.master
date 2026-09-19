# RB-018 — Alimentación y crecimiento inicial

## Objetivo

Permitir que el jugador alimente una criatura desde el HUD y avance su progreso
de crecimiento con autoridad del servidor.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Agentes consultados

- `luau_network_architect`
- `studio_mcp`
- `qa_test`

## Sistema bloqueado

Alimentación temporal y estado de crecimiento del inventario.

## Archivos o instancias afectadas

- `src/server/CaptureService.server.luau`
- `src/client/ClientMain.client.luau`
- `Workspace.CaptureZone` durante Play
- `Player.RaiseABeastInventory.Food` durante Play
- `Player.RaiseABeastInventory.Creature_*` durante Play

## Criterios de aceptación

- [x] El HUD muestra las criaturas capturadas y la comida disponible.
- [x] El cliente solo envía el nombre de la entrada del inventario.
- [x] El servidor valida propiedad, comida, crecimiento y cooldown.
- [x] Alimentar descuenta exactamente una unidad de comida.
- [x] Tres alimentaciones marcan la criatura como madura.
- [ ] Rechazo visual probado con comida agotada.
- [ ] Prueba multijugador.

## Seguridad y rendimiento

- La comida y el crecimiento solo se modifican en servidor.
- El servidor ignora nombres de criaturas no pertenecientes al jugador.
- El RemoteEvent tiene un límite de frecuencia de 0.75 segundos por jugador.
- No se usa DataStore en esta iteración.

## Plan de reversión

Retirar el evento `FeedRequest`, las funciones de alimentación y el panel de
inventario; conservar el flujo de captura aprobado.

## Evidencia

- Captura de tres criaturas verificada en Play.
- Botón `Feed AngryPotato [0/3]` probado desde el HUD.
- Resultado verificado: `Growth=3`, `Mature=true`, `Food` descontada.

## Problemas y riesgos

- El progreso es temporal y se reinicia al salir.
- La fusión aún no está implementada.

## Aprobación de Roblox Master

Aprobado por la orden del usuario: continuar con el desarrollo del MVP.
