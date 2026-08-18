# ADR-002: Estrategia de contenedores

## Estado

Aceptado

## Contexto

El Home Lab utilizará Docker como una de las bases para ejecutar
servicios de infraestructura y componentes aislados.

Sin embargo, no todos los elementos del laboratorio tienen las mismas
necesidades.

Algunos servicios se benefician claramente de ejecutarse en contenedores,
mientras que determinadas herramientas de desarrollo, agentes o
componentes que necesitan acceso directo al sistema pueden requerir otra
forma de ejecución.

Convertir todo en contenedores desde el principio añadiría complejidad
innecesaria y podría dificultar el acceso a recursos como Git, SSH,
filesystem, Docker, GPU o herramientas del sistema.

## Decisión

Docker será el mecanismo principal para contenerizar servicios cuando
aporte un beneficio claro de aislamiento, despliegue, mantenimiento o
reconstrucción.

No se establece la regla de que todos los componentes del Home Lab deban
ejecutarse dentro de contenedores.

La decisión de contenerizar cada componente se tomará según sus
necesidades reales.

## Criterios

Un componente será candidato a ejecutarse en Docker cuando:

- sea un servicio independiente;
- necesite aislamiento del sistema;
- tenga dependencias propias;
- deba poder levantarse y detenerse de forma independiente;
- requiera una instalación reproducible;
- pueda beneficiarse de una configuración declarativa;
- su persistencia pueda gestionarse mediante volúmenes o servicios
  externos.

Un componente podrá ejecutarse directamente en WSL cuando:

- necesite acceso frecuente al filesystem del proyecto;
- requiera interacción directa con Git o SSH;
- necesite herramientas de desarrollo del usuario;
- el aislamiento del contenedor no aporte un beneficio significativo;
- el uso de Docker introduzca una complejidad innecesaria.

## Ejemplos iniciales

Los siguientes componentes son candidatos naturales para Docker:

- bases de datos;
- caches;
- servicios de observabilidad;
- APIs propias;
- servicios MCP;
- servicios auxiliares.

Los siguientes componentes se evaluarán individualmente:

- OpenCode;
- Claude Code;
- herramientas de desarrollo;
- agentes que necesiten acceso amplio al entorno;
- componentes que utilicen GPU.

La lista no constituye una decisión definitiva sobre la implementación
de cada herramienta.

## Principios derivados

- Docker por servicio, no Docker por dogma.
- Aislar cuando aporte valor.
- Evitar complejidad artificial.
- Mantener separados los servicios de la plataforma y las herramientas
  de desarrollo.
- Evaluar el acceso a filesystem, Git, SSH, Docker y GPU antes de
  contenerizar un agente.
- Mantener las decisiones reversibles cuando sea razonablemente posible.

## Consecuencias

La arquitectura tendrá una combinación controlada de componentes
contenedorizados y componentes ejecutados directamente sobre el entorno
de trabajo.

Esto puede aumentar ligeramente la variedad de mecanismos de ejecución,
pero evita forzar todos los componentes dentro de una misma tecnología.

La estructura de infraestructura podrá utilizar Docker para los servicios
que lo necesiten sin convertir Docker en una dependencia obligatoria de
cada herramienta o agente.

## Estado de la decisión

Aceptada para `feat-002-infrastructure`.
