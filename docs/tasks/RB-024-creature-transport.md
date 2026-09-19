# RB-024 — Transporte de criaturas por conveyor

## Objetivo

Permitir que el jugador recoja una criatura salvaje que pasa por el conveyor
con `E`, la transporte visualmente en sus manos y la deposite en una plataforma
libre al azar de su propio plot.

## Estado

`IN_REVIEW`

## Archivos/instancias afectadas

- `games/raise-a-beast/src/shared/TransportConfig.luau`
- `games/raise-a-beast/src/server/TransportService.server.luau`
- `games/raise-a-beast/src/server/WorldBuilder.server.luau`
- `games/raise-a-beast/src/server/PlotService.server.luau`
- `games/raise-a-beast/src/client/ClientMain.client.luau`
- `Workspace.RaiseABeastPlaza.ConveyorZone`
- `Workspace.RaiseABeastPlaza.Zone_Spawn.Plots.Plot*.DepositTrigger`

## Criterios de aceptación

- [x] El conveyor existe en la plaza y muestra criaturas low-poly móviles.
- [x] La interacción de recogida usa `ProximityPrompt` con tecla `E`.
- [x] El servidor valida distancia, estado de la criatura y jugador portador.
- [x] La criatura queda soldada a la mano/brazo del jugador durante el transporte.
- [x] Solo se puede depositar en el plot propio.
- [x] El depósito selecciona aleatoriamente una plataforma libre.
- [x] El depósito añade la criatura al inventario y actualiza la exhibición.
- [x] Playtest completo recogida → recorrido → depósito en Roblox Studio.
- [ ] Prueba multicliente de aislamiento de plots.

## Seguridad y rollback

Toda la transición de estado vive en `TransportService.server.luau`; el cliente
solo recibe feedback visual. Para revertir, retirar el servicio y la carpeta
`ConveyorZone`, y conservar el flujo de captura/plots anterior.

## Riesgos

- Un personaje que desaparece mientras carga una criatura provoca que la
  criatura se destruya; se puede cambiar posteriormente por un respawn en el
  conveyor si se desea recuperar el contenido.
- La plataforma libre se calcula a partir de `SlotIndex`; los objetos antiguos
  sin atributo siguen usando asignación secuencial de compatibilidad.

## Evidencia de verificación

En Playtest, `Ernestplayz24` recogió una `TinyCloud`. El modelo quedó bajo el
personaje con offset relativo `0, -0.8, -2.3`, centrado delante del torso, y al
entrar en el `DepositTrigger` de `Plot1` se creó `Creature_001` con
`Transported=true` y `SlotIndex=1`. `Plot1.DisplayModels` mostró
`Creature_001_Display`.
