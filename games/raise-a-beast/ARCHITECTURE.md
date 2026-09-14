# Arquitectura técnica inicial

## Autoridad

El cliente solicita acciones; el servidor valida contexto, propiedad, tipos, rangos, frecuencia, costes, recompensas y persistencia. No se acepta del cliente el precio, rareza, resultado de fusión, saldo ni identidad de una criatura.

## Estructura prevista

```text
ReplicatedStorage/
  Shared/
  Remotes/
ServerScriptService/
  Services/
ServerStorage/
  Definitions/
StarterPlayer/StarterPlayerScripts/
StarterGui/
Workspace/
  Map/
  PlayerPlots/
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
