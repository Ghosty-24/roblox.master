# Arquitectura técnica inicial

## Flujo de scripting

El proyecto usa **Rojo**. Los archivos Luau del repositorio son la fuente de verdad; Roblox Studio no debe convertirse en una segunda fuente de cambios para los mismos scripts. La configuración está en `default.project.json` y el código vive en `src/`.

## Autoridad

El cliente solicita acciones; el servidor valida contexto, propiedad, tipos, rangos, frecuencia, costes, recompensas y persistencia. No se acepta del cliente el precio, rareza, resultado de fusión, saldo ni identidad de una criatura.

## Estructura prevista

```text
games/raise-a-beast/
  default.project.json
  src/
    shared/
    server/
    client/
```

## Módulos previstos

- `CreatureDefinitions`: recetas, rarezas y evolución declarativas.
- `InventoryService`: propiedad y estados protegidos.
- `CaptureService`: validación de capturas.
- `GrowthService`: alimentación y crecimiento.
- `FusionService`: recetas, consumo y recompensa atómica.
- `EconomyService`: Coins y transacciones.
- `PlotService`: bases, capacidad y escudos.
- `DataService`: sesiones, guardado, migraciones y recuperación.
- `RateLimiter`: límites por jugador y acción.

## Persistencia mínima

Versión de esquema, monedas, inventario, criaturas únicas, criaturas protegidas, mejoras, álbum y timestamps. Separar datos de prueba y producción.

## Riesgos técnicos

- Duplicación de criaturas o monedas.
- Fusiones concurrentes.
- Guardado parcial.
- Remotes abusables.
- Exceso de instancias y efectos en móvil.

## Persistencia implementada

`src/server/DataService.luau` reconstruye el inventario desde un esquema
versionado y guarda Food, contadores, criaturas, slots y álbum. Usa
`RaiseABeast_MVP_Studio_v1` en Studio y `RaiseABeast_MVP_v1` fuera de Studio.
Un fallo de carga no permite sobrescribir datos con defaults; la sesión queda
solo en memoria hasta que el siguiente join cargue correctamente.
