# RB-027 — Expansión espacial de Zona 1

## Objetivo

Convertir la primera zona en una plaza amplia inspirada en el boceto del
diseño: bases distribuidas a ambos lados de un corredor central, plataformas
para criaturas y recorrido largo de transporte.

## Estado

`IN_REVIEW`

## Decisiones

- Zona 1: `150×120` studs.
- Ocho parcelas disponibles, cuatro a cada lado del corredor.
- Diez plataformas por parcela, organizadas en dos filas de cinco.
- Conveyor ampliado a `124` studs.
- Se conserva el catálogo de Zona 1; actualmente contiene 21 diseños y el
  inicio guiado utiliza tres criaturas iniciales.
- Las criaturas de zonas futuras no se activan todavía.

## Criterios de aceptación

- [x] Rojo compila el proyecto.
- [x] Studio crea ocho parcelas.
- [x] Cada parcela crea diez plataformas.
- [x] El jugador puede recorrer el corredor y acceder a las parcelas.
- [x] El conveyor ocupa el nuevo ancho de la plaza.
- [x] La captura se desplaza a un punto libre del corredor.
- [ ] Añadir arte final, decoración y señalización de la plaza.
- [ ] Integrar el NPC y la compra de comida cuando se implemente la economía.

## Evidencia

Playtest en Studio: `bounds=150x120 studs`, `plots=8`, `slots=10` en cada
parcela, `conveyor=124` studs. Captura visual realizada en Play; no se
detectaron errores de script propios del mapa.
