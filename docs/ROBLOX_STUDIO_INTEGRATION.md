# Integración con Roblox Studio

## Hallazgos verificados

La documentación oficial de Roblox indica que Studio puede funcionar como servidor MCP local para que un cliente de IA se comunique con una sesión abierta. La integración permite seleccionar una instancia mediante `studio_id` y trabajar de forma explícita cuando hay varias sesiones.

Capacidades relevantes para Roblox Master:

- Leer, buscar y editar scripts.
- Buscar e inspeccionar el árbol de instancias.
- Ejecutar Luau en modos Edit, Client y Server.
- Iniciar y detener playtests.
- Leer la salida de consola.
- Capturar la pantalla de Studio.
- Simular navegación, teclado y ratón.
- Buscar e insertar assets.
- Generar modelos, materiales y contenido procedural.
- Lanzar subagentes de exploración y playtest.
- Consultar documentación permitida de Roblox.

## Flujo seguro

1. Abrir y actualizar Roblox Studio.
2. Activar Assistant → … → Manage MCP Servers → Enable Studio as MCP Server.
3. Confirmar el indicador verde de conexión.
4. Ejecutar `list_roblox_studios`.
5. Seleccionar la instancia correcta por `studio_id`.
6. Ejecutar `get_studio_state` y explorar el árbol.
7. Leer scripts antes de editarlos.
8. Aplicar cambios mínimos y registrar rutas afectadas.
9. Ejecutar playtest y revisar consola.
10. Capturar evidencia y actualizar la ficha de tarea.

## Límites

- La conexión puede leer y modificar lugares abiertos: solo se deben conectar clientes confiables.
- Ningún agente debe ejecutar Luau destructivo, insertar assets no revisados o cambiar datos persistentes sin aprobación.
- Los cambios en Studio no sustituyen Git; debe definirse una fuente de verdad y un flujo de sincronización.
- No hay una instancia de Roblox Studio conectada durante esta auditoría, por lo que no se ha inspeccionado un juego real ni ejecutado un playtest.

## Conclusión

El staff ampliado es suficiente para coordinar un MVP y un flujo de producción inicial. Para proyectos grandes pueden añadirse agentes temporales especializados, pero no conviene convertirlos en roles permanentes antes de conocer la temática, el buyer persona y la arquitectura del juego.
