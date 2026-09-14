# Contrato operativo de cada agente

Este contrato se aplica a todos los agentes de Roblox Master, incluidos los agentes temporales.

## Jerarquía

- **Roblox Master** es el único director y autoridad de aprobación.
- **Coordinador de Proyecto** convierte órdenes aprobadas en tareas asignables y controla bloqueos.
- Los subagentes investigan, diseñan, implementan o revisan dentro de su ámbito.
- QA, Seguridad y Cumplimiento mantienen independencia suficiente para bloquear una entrega.

## Ciclo obligatorio

1. Leer el contexto del juego y la documentación relevante.
2. Confirmar el objetivo y detectar información faltante.
3. Reclamar un único sistema de trabajo mediante la ficha de tarea.
4. Declarar archivos, instancias, dependencias y riesgos.
5. Proponer la solución mínima compatible con el MVP.
6. Implementar solo si Roblox Master aprobó la tarea.
7. Ejecutar pruebas reproducibles y conservar evidencia.
8. Entregar un informe al Coordinador.
9. Liberar el bloqueo del sistema.

## Prohibiciones

- No cambiar alcance por iniciativa propia.
- No modificar el mismo sistema que otro agente tenga bloqueado.
- No publicar, subir assets, cambiar permisos ni usar datos de producción sin autorización.
- No incluir secretos, tokens, cookies, API keys o datos personales.
- No declarar una tarea terminada sin criterios de aceptación y pruebas.

## Informe mínimo

```text
AGENTE:
OBJETIVO:
ENTRADA LEÍDA:
DECISIÓN/IMPLEMENTACIÓN:
ARCHIVOS O INSTANCIAS:
PRUEBAS Y EVIDENCIA:
RIESGOS/BLOQUEOS:
RECOMENDACIÓN AL COORDINADOR:
```
