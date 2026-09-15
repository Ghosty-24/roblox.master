# Flujo Rojo

## Regla principal

Git y los archivos de `src/` son la fuente de verdad del scripting. Los cambios permanentes se hacen en el repositorio y después se sincronizan con Roblox Studio mediante Rojo.

## Mapeo inicial

| Repositorio | Roblox Studio |
|---|---|
| `src/shared/` | `ReplicatedStorage/Shared` |
| `src/server/` | `ServerScriptService/Server` |
| `src/client/` | `StarterPlayer/StarterPlayerScripts/Client` |

## Convenciones

- `*.server.luau`: scripts exclusivos del servidor.
- `*.client.luau`: scripts exclusivos del cliente.
- `*.luau`: módulos compartidos o módulos de servicio según su carpeta.
- No editar manualmente en Studio un script que esté sincronizado por Rojo.
- No guardar secretos, tokens ni credenciales en el proyecto.
- Los assets y configuraciones no cubiertos por Rojo deben documentar su fuente de verdad.

## Preparación futura

1. Instalar Rojo en el entorno de desarrollo.
2. Abrir `default.project.json` desde la carpeta del juego.
3. Conectar Rojo con la instancia correcta de Roblox Studio.
4. Sincronizar y comprobar el árbol antes de implementar gameplay.
5. Ejecutar pruebas únicamente después de que exista una tarea aprobada.

Este hito solo prepara la estructura; Rojo no se ha iniciado y Roblox Studio no se ha modificado.
