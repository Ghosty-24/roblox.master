# GDD ligero

## MVP

- Monster Plaza compacta.
- Ocho parcelas de Zona 1, cuatro a cada lado del corredor central.
- Diez plataformas de criaturas por parcela, ampliables en iteraciones futuras.
- Tres criaturas iniciales: Angry Potato, Sleepy Blob y Tiny Cloud.
- Una zona de aparición.
- Captura mediante interacción breve.
- Alimentación y crecimiento por recurso.
- Fusión de tres criaturas.
- Una mutación visual por criatura.
- Puesto de venta de recursos no protegidos.
- Moneda única: Coins.
- Inventario y álbum.
- Tres mejoras de base.
- Escudo de protección.
- Tutorial guiado.

## Reglas de seguridad del jugador

- Las criaturas raras se bloquean por defecto o requieren confirmación explícita.
- No existe robo permanente en el MVP.
- No se consume una criatura sin pantalla de confirmación.
- El jugador nuevo recibe protección inicial.

## Fusión

- Entrada: tres criaturas válidas.
- Validación: propiedad, estado protegido, capacidad y receta.
- Resultado: criatura definida por receta; las mutaciones pueden ser una variante limitada y claramente comunicada.
- Feedback: cuenta atrás breve, luz, sonido, resultado y actualización del álbum.

## Progresión

1. Captura inicial.
2. Alimentación.
3. Primera fusión.
4. Segundo espacio de criatura.
5. Primera mejora de base.
6. Descubrimiento de una mutación.

## Desbloqueo y precio de las zonas

El coste de cada zona se valida en el servidor. Para avanzar, el jugador debe cumplir tanto el requisito de
Coins como el requisito mínimo de Rebirths cuando se indique.

| Zona | Requisito |
|---|---|
| 1. Pradera | Gratis |
| 2. Bosque | Coins |
| 3. Desierto | Coins |
| 4. Pantano | Coins + 1 Rebirth |
| 5. Montaña | Coins + 1 Rebirth |
| 6. Volcán | Coins + 2 Rebirths |
| 7. Celestial | Coins + 2 Rebirths |
| 8. Oscura | Coins + 3 Rebirths |
| 9. Galáctica | Coins + 4 Rebirths |
| 10. Caja Fuerte | Coins + 5 Rebirths |

Las zonas 4 y 5 requieren el primer Rebirth; las zonas 6 y 7 requieren dos; la zona 8 requiere tres; la zona 9
requiere cuatro; y la zona 10 requiere cinco. El cliente solo solicita el desbloqueo: el servidor comprueba Coins,
Rebirths, zona anterior y estado guardado antes de descontar el precio y marcar la zona como desbloqueada.

## Contenido posterior al MVP

Retos de plaza, jefe cooperativo, eventos estacionales, nuevas zonas, visitas de bases y competición no destructiva.
