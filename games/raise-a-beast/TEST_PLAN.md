# Plan de pruebas

## Estado

En ejecución. Se han validado builds Rojo, arranque de Play, captura,
alimentación, fusión, plots, transporte y pose de carga. La persistencia y la
prueba multicliente aún requieren una matriz dedicada.

## Puertas de aceptación

- [x] Captura inicial en menos de 90 segundos en Playtest.
- [ ] El tutorial explica captura, alimentación y fusión.
- [x] Fusión válida consume exactamente tres criaturas.
- [ ] Fusión inválida no consume inventario.
- [x] Criaturas protegidas no se fusionan accidentalmente en el flujo validado.
- [ ] Monedas y criaturas solo se conceden desde servidor.
- [ ] Llamadas remotas repetidas tienen límite.
- [ ] Guardado y carga sobreviven a reconexión controlada.
- [ ] No hay duplicación en acciones concurrentes.
- [ ] La interfaz se lee y opera en móvil.
- [ ] No hay P0/P1 abiertos.

## Estado actual

- [x] Rojo construye `default.project.json`.
- [x] Studio refleja `DataService` como ModuleScript server-only.
- [x] Play crea inventario temporal seguro cuando no hay datos cargados.
- [x] Reconexión con datos guardados usando API Services habilitado; `Food=7`
  sobrevivió a una salida y nueva entrada de Play.
- [x] Una criatura capturada (`AngryPotato`, `Creature_001`, `Growth=0`) se
  restauró tras reconectar.
- [x] El álbum registra una criatura capturada con su rareza.
- [ ] Server & Clients con dos jugadores.

## Matriz

| Área | Casos |
|---|---|
| Gameplay | captura, alimentación, crecimiento, fusión, venta |
| Multijugador | cuatro bases, visitas, estados aislados |
| Seguridad | inputs inválidos, spam, propiedad, duplicación |
| Persistencia | carga, reintentos, migración, fallo parcial |
| UX | tutorial, móvil, confirmaciones, feedback |
| Rendimiento | join time, FPS, memoria, efectos |

## Evidencia requerida

Logs de prueba, capturas, versión del entorno, dispositivo, pasos reproducibles y resultado por caso.
