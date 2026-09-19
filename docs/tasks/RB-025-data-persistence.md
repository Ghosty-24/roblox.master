# RB-025 — Persistencia del inventario MVP

## Objetivo

Guardar y restaurar el inventario server-authoritative de Raise a Beast sin
mezclar las pruebas de Studio con los datos de producción.

## Estado

`IN_REVIEW`

## Propietario

`roblox_master`

## Agentes consultados

`luau_network_architect`, `backend_data_services`, `anti_exploit_security`,
`qa_test`, `ci_release`

## Sistema bloqueado

Inventario, captura, alimentación, fusión, transporte y plots.

## Archivos afectados

- `games/raise-a-beast/src/server/DataService.luau`
- `games/raise-a-beast/src/server/CaptureService.server.luau`

## Dependencias

- `DataStoreService` habilitado para pruebas de Studio.
- Rojo sincronizado desde `games/raise-a-beast`.

## Criterios de aceptación

- [x] Existe un esquema versionado de datos.
- [x] Studio usa una clave separada de producción.
- [x] El servidor carga Food, contadores, criaturas y álbum.
- [x] El servidor guarda con `UpdateAsync` y reintentos.
- [x] Existe autosave periódico.
- [x] Existe guardado en `BindToClose`.
- [x] Verificar carga tras reconexión en un entorno con API Services habilitado.
- [ ] Verificar migración cuando cambie `schemaVersion`.

## Seguridad y rendimiento

El cliente no decide el payload guardado. Los datos se reconstruyen desde
Instances server-side y se escribe una vez por autosave o salida. La clave de
Studio es `RaiseABeast_MVP_Studio_v1`; la clave publicada es
`RaiseABeast_MVP_v1`.

## Plan de reversión

Retirar el `require(DataService)` y las llamadas de carga/guardado de
`CaptureService`; el inventario volverá a ser temporal durante la sesión.

## Pruebas pendientes

La migración de `schemaVersion` sigue pendiente. La persistencia fue verificada
en Studio con API Services habilitado: `Food=7` sobrevivió una salida y nueva
entrada; después se restauró `Food=9`. También se capturó `AngryPotato` como
`Creature_001`, se cerró Play, se inició una nueva sesión y se restauró con el
mismo ID y `Growth=0`.
