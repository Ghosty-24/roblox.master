# RB-017 — Onboarding y captura inicial

## Objetivo

Crear el primer vertical slice jugable del MVP: el jugador entra, encuentra una
zona de captura y obtiene una de las tres criaturas iniciales mediante una
interacción validada por el servidor.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Agentes consultados

- `luau_network_architect`
- `studio_mcp`
- `qa_test`

## Sistema bloqueado

Captura inicial y HUD de onboarding.

## Archivos o instancias afectadas

- `src/shared/CaptureConfig.luau`
- `src/server/CaptureService.server.luau`
- `src/client/ClientMain.client.luau`
- `Workspace.CaptureZone` durante Play
- `ReplicatedStorage.RaiseABeastRemotes` durante Play
- `Player.RaiseABeastInventory` durante Play

## Dependencias

- Rojo activo.
- `ReplicatedStorage.Shared` sincronizado.
- Studio MCP conectado.
- Sin persistencia real en esta iteración.

## Criterios de aceptación

- [x] La zona de captura se crea en servidor.
- [x] La captura se procesa en servidor mediante `ProximityPrompt`.
- [x] El servidor limita frecuencia y distancia.
- [x] El inventario temporal replica al jugador.
- [x] El cliente muestra instrucciones en inglés.
- [ ] Playtest de interacción física con teclado `E`.
- [ ] Revisión de cuatro jugadores y adaptación de UI.

## Implementación prevista

La primera captura entrega, en orden, `AngryPotato`, `SleepyBlob` y `TinyCloud`.
Cada entrada queda protegida por defecto y todavía no se guarda en DataStore.

## Pruebas reproducibles

1. Iniciar Play en Roblox Studio.
2. Localizar el pad verde `Mystery Habitat`.
3. Acercarse y mantener `E`.
4. Confirmar el mensaje de captura y el valor en
   `Players.<player>.RaiseABeastInventory`.
5. Repetir dos veces y confirmar que se entregan criaturas distintas.
6. Intentar una cuarta captura y confirmar que no se crea otra entrada.

## Seguridad y rendimiento

- No se acepta un identificador de criatura desde el cliente.
- El servidor controla orden, distancia y cooldown.
- No se usan assets externos ni persistencia de producción.
- El sistema crea una sola zona y un solo listener de interacción.

## Plan de reversión

Eliminar los tres archivos añadidos/restaurar `ClientMain.client.luau` y retirar
`CaptureService.server.luau` del proyecto. La carpeta runtime `CaptureZone` se
limpia al detener Play.

## Evidencia

Pendiente de playtest de interacción después de sincronizar los archivos con Rojo.

## Problemas y riesgos

- El grupo de Roblox todavía no existe; no bloquea el desarrollo local.
- El inventario es temporal hasta diseñar `DataService`.

## Aprobación de Roblox Master

Aprobado por la orden del usuario: continuar con el desarrollo del MVP.
