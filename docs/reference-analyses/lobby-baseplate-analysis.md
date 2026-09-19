# REFERENCE_ANALYSIS — Lobby interior sobre Baseplate de Zona 1

## Estado

`READY_FOR_APPROVAL`

## Intención del usuario

- Objetivo visual: adaptar el Baseplate actual de `Raise a Beast` para que tenga una lectura equivalente a la imagen `lobby.jpeg`.
- Referencia: `C:\Users\ernes\Downloads\lobby.jpeg`.
- Zona/instancia objetivo: Baseplate y modelo `Workspace.RaiseABeastPlaza` de Zona 1.
- Interpretación: crear un lobby interior amplio, simétrico y de aspecto low-poly/blocky, conservando el gameplay actual de parcelas, criaturas y transporte.
- Alcance: diseño visual y layout; no incluye todavía construcción, cambio de scripts, assets externos ni ejecución en Roblox Studio.

## Lectura de la imagen

### Observado

- Vista interior desde el centro del pasillo, orientada hacia una pared focal del fondo.
- Espacio rectangular largo, simétrico respecto al eje central.
- Pasillo central ancho de color rojo/coral que conduce al fondo.
- Dos bandas laterales de suelo blanco/gris claro.
- Módulos oscuros repetidos a ambos lados, aproximadamente cuatro por lado visible.
- Superficies rectangulares verde lima sobre o junto a los módulos laterales.
- Techo bajo, blanco/crema, con patrón repetitivo tipo studs.
- Vigas perimetrales blancas y molduras grises.
- Grandes aberturas o ventanales laterales que muestran un exterior verde.
- Pared de fondo con un gran marco blanco y panel interior gris/beige.
- Dos pequeños soportes/carteles cerca del fondo y un elemento circular rojo en el eje central.
- Luminarias rectangulares blancas empotradas en el techo.
- Escaleras blancas visibles en el extremo superior derecho y parcialmente en el lado izquierdo.

### Inferido

- Los módulos laterales funcionan como puestos, vitrinas o plataformas de exposición.
- El pasillo rojo es la ruta principal de circulación y foco visual.
- El panel del fondo probablemente es un área de anuncio, portal, selección o showcase.
- La composición busca que el jugador avance visualmente hacia el centro del fondo.
- La repetición lateral puede mapearse a las ocho parcelas existentes: cuatro a cada lado del corredor.

### Supuestos

- El Baseplate actual seguirá siendo la fuente geométrica y funcional del juego.
- Las parcelas actuales se conservarán como espacios de jugador, aunque se les añadirá una fachada visual inspirada en la referencia.
- El estilo será low-poly/blocky usando Parts, WedgeParts y materiales nativos antes de añadir assets externos.
- La estructura será modular y reversible: `ReferenceLobby` como capa visual separada de `RaiseABeastPlaza`.

### Desconocido o ambiguo

- La imagen no proporciona medidas absolutas ni escala Roblox.
- No está claro si las escaleras son accesos funcionales o decoración.
- No está claro si el panel del fondo debe ser interactivo.
- No está claro si el conveyor debe permanecer en el centro, desplazarse a un lateral o integrarse como una cinta dentro del lobby.
- La imagen muestra más detalle de interior que el actual mundo exterior; una réplica literal requeriría decidir cómo conservar montañas, límites y conveyor.

## Cámara y composición

- Tipo de vista: `interior frontal / perspectiva 3/4 suave`.
- Punto focal: panel rectangular grande de la pared del fondo.
- Dirección de vista: longitudinal por el eje central del lobby.
- Altura de cámara: aproximadamente a la altura de los ojos del jugador, no cenital.
- Profundidad: primer plano con alfombra, zona media con plataformas laterales y fondo con panel/portal.
- Simetría: casi completa izquierda-derecha; las escaleras introducen una ligera asimetría.
- Espacio negativo: pasillo central despejado y rutas laterales suficientemente anchas para circular.

## Relación con el Baseplate actual

El código actual define una plaza de `180×140` studs, ocho parcelas —cuatro al norte y cuatro al sur—, un `MainPath` central de `162×10` studs y un conveyor en `z = -8`. Esta estructura encaja parcialmente con la repetición lateral de la referencia, pero el conveyor y el carácter exterior actual no aparecen en la imagen.

### Decisión de diseño recomendada

Construir una capa visual interior alrededor de la plaza existente, sin borrar ni reemplazar los sistemas actuales:

1. Mantener las ocho parcelas como módulos laterales repetidos.
2. Convertir visualmente el `MainPath` en un corredor central rojo/coral mediante una superficie reversible o una variante visual.
3. Crear suelos laterales blancos/gris claro alrededor de las parcelas.
4. Crear techo, vigas, marcos y ventanales como `ReferenceLobby`.
5. Crear un panel focal en el fondo, alineado con el eje central.
6. Mantener el conveyor como sistema funcional, pero decidir su ubicación tras una prueba visual; no desplazarlo automáticamente.
7. Mantener las montañas exteriores solo si quedan visibles a través de los ventanales; no deben dominar la vista interior.

## Descomposición espacial

| ID | Elemento | Estado | Posición relativa | Tamaño/proporción | Repetición | Prioridad |
|---|---|---|---|---|---|---|
| R-01 | Corredor rojo/coral | Observado | Eje central, desde cámara hasta fondo | Dominante, aprox. 35–45% del ancho útil | 1 | Obligatorio |
| R-02 | Suelo lateral claro | Observado | A ambos lados del corredor | Bandas simétricas | 2 | Obligatorio |
| R-03 | Módulos oscuros de exposición | Observado/inferido | Laterales, alineados con el corredor | Bajos, rectangulares, repetidos | 8 como objetivo adaptado a parcelas | Obligatorio |
| R-04 | Plataformas verde lima | Observado | Asociadas a módulos laterales | Más pequeñas que los módulos oscuros | Varias por lado | Obligatorio visual |
| R-05 | Techo cerrado | Observado | Sobre toda la plaza | Plano horizontal continuo | 1 | Obligatorio |
| R-06 | Luminarias rectangulares | Observado | Techo, alineadas con el eje | Pequeñas respecto al techo | Varias | Recomendado |
| R-07 | Vigas/marcos blancos | Observado | Perímetro y fondo | Gruesos, contrastados | Repetidos por lado | Obligatorio |
| R-08 | Ventanales laterales | Observado | Muros laterales | Grandes aberturas | 2 bandas | Obligatorio |
| R-09 | Panel focal de fondo | Observado | Centro del muro posterior | Muy ancho y alto | 1 | Obligatorio |
| R-10 | Carteles/soportes | Observado | Delante del panel focal | Pequeños | 2 | Recomendado |
| R-11 | Plataforma circular roja | Observado | Centro, cerca del fondo | Pequeña | 1 | Recomendado |
| R-12 | Escaleras | Observado | Laterales superiores | Elemento vertical | 1–2 | Opcional hasta confirmar función |

## Estilo visual

- Paleta principal: blanco/crema, gris claro, gris oscuro, rojo/coral y verde lima.
- Materiales: Plastic/SmoothPlastic para arquitectura; Neon solo en acentos, plataformas y luminarias.
- Iluminación: interior clara, homogénea, con ligera calidez central y contraste suave.
- Sombras/reflejos: sombras moderadas; evitar una escena completamente plana.
- Nivel de detalle: low-poly/blocky, repetitivo y legible a distancia.
- Forma predominante: rectángulos, marcos, plataformas bajas y planos limpios.
- Escala: proporciones amplias para que el jugador vea el fondo y circule sin obstrucciones.

## Circulación e interacción observable

- Entrada/salida: cámara/jugador entra por el extremo frontal del corredor.
- Ruta principal: corredor rojo hacia el panel del fondo.
- Zonas transitables: corredor central y bandas laterales.
- Puntos de interacción visibles: módulos laterales, dos carteles del fondo y plataforma central.
- Obstáculos o límites: bordes de plataformas, muros laterales, techo y posibles escaleras.
- Elementos de gameplay existentes a preservar: parcelas, plataformas de criaturas, conveyor, captura, transporte y depósito.

## Propuesta de layout Roblox

- Contenedor raíz sugerido: `Workspace.RaiseABeastPlaza.ReferenceLobby`.
- Carpetas/modelos principales:
  - `Architecture`: techo, vigas, paredes y marcos.
  - `Flooring`: corredor central y bandas laterales.
  - `SideShowcases`: fachadas y plataformas visuales de las ocho parcelas.
  - `Windows`: aberturas y paneles de fondo exterior.
  - `Lighting`: luminarias y acentos no funcionales.
  - `FocalWall`: panel y soportes del fondo.
  - `Stairs`: escaleras, inicialmente decorativas si no se aprueba interacción.
- Ejes y orientación: eje longitudinal coincidente con el corredor actual; mantener el centro de `RaiseABeastPlaza` como referencia.
- Escala: usar las dimensiones existentes de `180×140` como límite; no ampliar el Baseplate en esta primera integración.
- Atributos sugeridos: `ReferenceStyle = "LobbyInterior"`, `ReferenceSource = "user-provided:lobby.jpeg"`, `VisualLayer = true`.
- Elementos fuera de alcance: nuevos sistemas de economía, teletransporte, monetización, trading o assets externos.

## Prioridades

### Obligatorio para parecerse a la referencia

- Corredor rojo/coral dominante.
- Simetría lateral con módulos repetidos.
- Techo interior y marcos blancos/grises.
- Grandes ventanales laterales.
- Panel focal amplio al fondo.
- Paleta clara con acentos verde lima.

### Recomendado

- Luminarias rectangulares.
- Dos soportes/carteles en el fondo.
- Plataforma circular roja.
- Escaleras laterales como decoración modular.
- Decoración exterior visible a través de los ventanales.

### No inventar sin aprobación

- Función del panel del fondo.
- Teleportación o tienda nueva.
- Cambio de ubicación del conveyor.
- Nuevas criaturas o NPCs.
- Copia exacta de marcas, assets o elementos protegidos de la referencia.

## Criterios de aceptación visual

- [ ] La cámara del jugador puede encuadrar el corredor y el panel del fondo.
- [ ] El corredor central es el foco visual dominante.
- [ ] Hay cuatro módulos visuales a cada lado, alineados con las ocho parcelas actuales.
- [ ] El techo y los marcos convierten la plaza en un interior reconocible.
- [ ] Los ventanales permiten leer el exterior sin romper la composición.
- [ ] El panel focal queda centrado y visible desde la entrada.
- [ ] La paleta respeta blanco/crema, gris, coral y verde lima.
- [ ] Las rutas de jugador y los sistemas actuales siguen siendo accesibles.
- [ ] No se eliminan parcelas, plataformas, conveyor ni lógica existente.
- [ ] La captura de verificación se realiza desde un encuadre comparable al de la referencia.

## Plan de verificación

1. Generar primero un greybox reversible bajo `ReferenceLobby`.
2. Inspeccionar la escena en Studio sin Playtest.
3. Capturar una vista desde el eje central y otra lateral.
4. Comparar masas grandes: techo, corredor, módulos, panel y ventanales.
5. Ejecutar Playtest para confirmar circulación, captura, transporte y depósito.
6. Revisar Output y confirmar que no hay errores nuevos.
7. Solo después pulir colores, luces y detalles.

## Aprobación

- Aprobado por usuario: pendiente.
- Aprobado por Roblox Master: pendiente.
- Fecha: 2026-09-19.
- Observaciones: esta entrega es análisis visual; no se ha ejecutado ninguna modificación en Roblox Studio.
