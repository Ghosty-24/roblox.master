# Plan de pruebas

## Estado

Planificado. No se han ejecutado pruebas en este hito.

## Puertas de aceptación

- [ ] Captura inicial en menos de 90 segundos.
- [ ] El tutorial explica captura, alimentación y fusión.
- [ ] Fusión válida consume exactamente tres criaturas.
- [ ] Fusión inválida no consume inventario.
- [ ] Criaturas protegidas no se venden ni fusionan accidentalmente.
- [ ] Monedas y criaturas solo se conceden desde servidor.
- [ ] Llamadas remotas repetidas tienen límite.
- [ ] Guardado y carga sobreviven a reconexión controlada.
- [ ] No hay duplicación en acciones concurrentes.
- [ ] La interfaz se lee y opera en móvil.
- [ ] No hay P0/P1 abiertos.

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
