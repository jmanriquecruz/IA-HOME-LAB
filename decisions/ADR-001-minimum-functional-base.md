# ADR-001: Base funcional mínima antes de abstraer

## Estado

Aceptado

## Contexto

El Home Lab deberá poder utilizar diferentes proveedores y
modelos de IA a medida que evolucione.

Intentar soportar múltiples proveedores desde el inicio
aumentaría la complejidad antes de conocer las necesidades
reales del sistema.

## Decisión

Construiremos inicialmente una implementación funcional
con un proveedor concreto.

Las abstracciones para múltiples proveedores sólo se
introducirán cuando exista una necesidad real que las
justifique.

## Principios derivados

- Evitar abstracciones prematuras.
- Mantener las decisiones reversibles cuando sea posible.
- Construir verticalmente antes de ampliar horizontalmente.
- Cada nueva capa debe responder a una necesidad real.

## Consecuencia

La primera versión tendrá mayor acoplamiento a su proveedor,
pero menor complejidad inicial.

Cuando aparezca una necesidad real de incorporar otro
proveedor, evaluaremos el coste de introducir una abstracción.

## Estado de la decisión

Aceptada para `feat-001`.
