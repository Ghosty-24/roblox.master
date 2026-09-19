# Diseños de criaturas - Zona 1: Pradera

## Dirección visual

Estética de meme 3D original para Roblox: criaturas compactas, proporciones exageradas, ojos grandes, expresiones legibles a distancia, colores saturados y un accesorio visual fácil de recordar. La referencia es el tono absurdo y coleccionable de los juegos de memes 3D, sin copiar personajes, logos, nombres, texturas o modelos de otra experiencia.

Materiales base: `SmoothPlastic` para cuerpos, `Neon` solo para detalles raros, y transparencias suaves únicamente en burbujas o gelatinas. Cada criatura debe tener una silueta que se reconozca en menos de un segundo.

## Catálogo

| Rareza | Criatura | Diseño visual | Acento de textura/material |
|---|---|---|---|
| Común | Angry Potato | Patata ovalada con hojas, cejas inclinadas y boca enfadada | SmoothPlastic naranja tostado, manchas marrones |
| Común | Sleepy Blob | Gelatina azul con orejas blandas y ojos cerrados | SmoothPlastic azul húmedo, brillo claro |
| Común | Tiny Cloud | Nube de cuatro bultos, sonrisa mínima y chispa | SmoothPlastic blanco azulado, transparencia ligera |
| Común | Wobble Worm | Gusano corto segmentado con antenas torcidas | Segmentos rosa, puntos de tierra |
| Común | Bubble Bug | Bicho redondo con caparazón de burbuja | Cian translúcido y reflejos blancos |
| Común | Toasty Toad | Sapo rechoncho con una tostada sobre el lomo | Marrón tostado, borde crujiente dorado |
| Común | Mini Mushroom | Cabeza de hongo enorme sobre dos patitas | Rojo mate, lunares crema |
| Común | Dust Bunny | Conejo-polvo con orejas gigantes | Beige mate, remolino de partículas |
| Común | Button Bat | Murciélago pequeño con alas de botones | Morado textil, ojos tipo costura |
| Común | Jelly Bean | Frijol de gelatina con envoltorio arrugado | Rosa brillante, highlight blanco |
| Poco común | Trash Goblin | Goblin verde con cubo de basura como casco | Verde sucio, metal gris en el casco |
| Poco común | Cactus Crab | Cangrejo con caparazón y pinzas de cactus | Verde satinado, espinas crema redondeadas |
| Poco común | Frosty Frog | Rana helada con mini corona de hielo | Azul hielo, cristal blanco en la corona |
| Poco común | Robo Chick | Pollito robot con antena y placas | Amarillo plástico, metal gris y LED |
| Poco común | Thunder Puff | Nube morada con rayos amarillos | Morado suave, rayos `Neon` amarillos |
| Raro | Sewer Slime | Charco viscoso con cara y burbujas tóxicas | Verde translúcido, burbujas `Neon` |
| Raro | Neon Bat | Murciélago con gafas y alas luminosas | Azul oscuro, líneas cian `Neon` |
| Raro | Crystal Croc | Cocodrilo bajo y ancho con lomo facetado | Azul cristal, dientes blancos brillantes |
| Épico | Lava Duck | Pato con grietas de lava y pico incandescente | Rojo volcánico, detalles naranja `Neon` |
| Épico | Shadow Mecha | Mecha compacto con visor y reactor central | Gris carbón, visor rojo `Neon` |
| Legendario | Dumpster King | Rey goblin sentado sobre un contenedor-trono | Dorado, metal oxidado y aura `Neon` |

## Reglas de producción

- Mantener entre 8 y 18 piezas por criatura en el MVP.
- Mantener un `Root` como `PrimaryPart` y todos los atributos de identidad en el `Model`.
- Las variantes mutadas cambian color y un accesorio, pero conservan la silueta.
- El color de rareza no sustituye el diseño: cada criatura necesita un rasgo propio.
- No usar texturas o modelos extraídos de otras experiencias; generar materiales propios dentro de Roblox.

La implementación inicial procedural se encuentra en `games/raise-a-beast/src/shared/CreatureModels.luau` y el catálogo de datos en `games/raise-a-beast/src/shared/Zone1CreatureCatalog.luau`.
