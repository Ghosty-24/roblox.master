# Flujo de referencias visuales, estilo y recursos

Este documento define el proceso obligatorio para cualquier petición que incluya una imagen de referencia o requiera recursos 3D/audiovisuales de Roblox Studio.

## Regla permanente de dirección visual

Todos los recursos 3D, visuales y audiovisuales deben mantener el lenguaje del juego actual: low-poly/blocky, colorido, legible, estilizado y compatible con el Baseplate existente. No se incorporarán recursos realistas o de estilo incompatible solo porque sean gratuitos.

## Principio

Una imagen no se convierte directamente en geometría. Primero se interpreta, después se valida con una muestra conceptual y finalmente se implementa en el Baseplate mediante una tarea aprobada.

## Flujo obligatorio

### 1. Interpretación

`image_reference_interpreter` analiza la imagen y entrega un `REFERENCE_ANALYSIS` con:

- composición y cámara;
- masas principales y proporciones;
- elementos repetidos;
- colores, materiales e iluminación;
- circulación e interacción visible;
- relación con el mapa existente;
- elementos obligatorios, opcionales y prohibidos;
- observaciones, inferencias, supuestos y desconocidos.

### 2. Muestra conceptual

Se crea una visual previa para validar la dirección artística. Esta muestra no es una escena jugable ni autoriza cambios en Studio.

El usuario debe confirmar que la composición, el punto de vista y los elementos principales son correctos.

### 3. Descomposición de la petición

Tras la aprobación, `project_coordinator` divide el trabajo en tareas independientes:

- layout/greybox;
- arquitectura visual;
- recursos y assets;
- scripts o interacciones;
- integración con el Baseplate;
- QA y comparación visual.

Cada tarea declara propietario, archivos/instancias, dependencias, criterios de aceptación y rollback.

### 4. Recursos gratuitos de Creator Store

Cuando una tarea necesite un recurso 3D, el agente de Studio puede buscarlo en la caja de herramientas/Creator Store usando una consulta concreta. Antes de insertarlo:

1. Confirmar que el recurso es gratuito.
2. Registrar nombre, creador, asset ID, URL o referencia de Creator Store y fecha.
3. Revisar licencia, permiso de uso, redistribución y modificaciones.
4. Inspeccionar scripts, RemoteEvents, módulos, conexiones HTTP y comportamiento oculto.
5. Revisar escala, número de partes, texturas, colisiones y coste aproximado.
6. Marcarlo `approved`, `approved-with-conditions`, `pending-evidence` o `rejected`.
7. Insertarlo solo si `asset_provenance_reviewer` lo aprueba y la tarea tiene alcance autorizado.

La matriz obligatoria es `games/raise-a-beast/ASSET_LICENSES.md`. Un asset gratuito no se considera automáticamente seguro, original ni redistribuible.

### 4.1. Qué hacer si el recurso es de pago

Si el recurso necesario es de pago:

1. No se compra ni se inserta automáticamente.
2. Se documenta qué función visual o técnica debía resolver.
3. `image_reference_interpreter` descompone su apariencia en formas, proporciones, materiales, colores y detalles observables.
4. `environment_art` prepara una alternativa propia, procedural o low-poly similar, sin copiar el asset ni sus elementos protegidos.
5. Se prioriza una versión hecha con Parts, WedgeParts, materiales nativos, texturas propias o recursos gratuitos aprobados.
6. Si no existe una alternativa viable, se presenta el recurso de pago como opción separada con precio, creador, licencia y justificación.
7. La compra requerirá autorización explícita del usuario; el agente no realizará compras.

El objetivo es replicar la función y el lenguaje visual del recurso, no copiarlo de forma idéntica.

### 5. Preferencia de implementación

El orden recomendado es:

1. Parts, materiales y geometría nativa de Roblox.
2. Generación procedural o módulos propios.
3. Recursos gratuitos de Creator Store con procedencia aprobada.
4. Recursos externos solo con evidencia adicional y aprobación explícita.

En todos los niveles se aplica la comprobación de estilo: silueta, paleta, escala, materiales, iluminación y densidad visual deben encajar con `Raise a Beast`.

### 6. Construcción

La implementación utiliza Rojo como fuente de verdad para scripts y estructura sincronizable. Studio MCP se utiliza para inspección, inserción autorizada, ejecución controlada y capturas.

Los cambios visuales deben agruparse en un modelo o carpeta reversible, por ejemplo `ReferenceLobby`, y no deben borrar sistemas funcionales existentes sin aprobación.

### 7. Verificación

QA debe comprobar:

- captura desde un encuadre comparable;
- composición y proporciones;
- circulación del jugador;
- interacción con parcelas, criaturas y conveyor;
- Output sin errores nuevos;
- rendimiento razonable;
- ausencia de assets no registrados;
- rollback documentado.

## Estados de aprobación

```text
ANALYSIS_PENDING
CONCEPT_READY
CONCEPT_APPROVED
ASSETS_PENDING_REVIEW
IMPLEMENTATION_APPROVED
IN_TEST
VISUAL_REVIEW
DONE
BLOCKED
```

## Regla de seguridad

Una imagen o prompt puede describir una intención, pero no autoriza por sí mismo borrar contenido, publicar, cambiar permisos, usar datos persistentes o insertar recursos de procedencia dudosa.
