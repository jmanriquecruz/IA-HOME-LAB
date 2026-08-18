# AI Home Lab

## Qué estamos construyendo

AI Home Lab es un entorno personal para aprender, construir y operar
soluciones basadas en inteligencia artificial, agentes, herramientas y
automatización.

El laboratorio se construye de forma incremental sobre una base que prioriza seguridad, 
resiliencia, observabilidad, control de costes y capacidad de reconstrucción.

El objetivo no es construir una plataforma abstracta desde el primer día.
Primero buscamos una base funcional y verificable. Las nuevas capacidades
y abstracciones se incorporan cuando existe una necesidad real.

## Para qué

El Home Lab debe permitirnos:

- aprender construyendo;
- experimentar con IA y agentes;
- automatizar tareas;
- reutilizar capacidades entre proyectos;
- medir costes y comportamiento;
- documentar las decisiones y el camino recorrido;
- recuperar el entorno ante fallos o pérdida de infraestructura;
- evolucionar hacia soluciones que puedan tener valor práctico y comercial.

## Principios

### Construir antes de abstraer

No introducimos una abstracción sólo porque podría ser útil en el futuro.
Primero construimos una solución funcional y, cuando aparece una necesidad
real, evaluamos si la abstracción aporta suficiente valor.

### Seguridad desde el diseño

Las credenciales, secretos, herramientas y permisos deben tratarse como
parte de la arquitectura y no como una preocupación posterior.

### Instalación y reconstrucción

Lo importante del Home Lab debe quedar documentado de forma que podamos volver a instalarlo, reconstruirlo o recuperarlo cuando sea necesario.

### Observabilidad

Debemos poder entender qué está haciendo el sistema, detectar problemas
y medir su comportamiento.

### Resiliencia

El laboratorio debe evolucionar hacia un entorno que pueda recuperarse
ante fallos, pérdida de una máquina o indisponibilidad de componentes.

### Costes

Las decisiones de IA deben considerar coste, rendimiento y utilidad.
El uso de modelos y servicios externos debe poder medirse y evaluarse.

### Evidencia antes que suposiciones

La documentación distingue entre lo que fue verificado, lo que decidimos,
lo que proponemos y lo que todavía está pendiente.

## Arquitectura evolutiva

El Home Lab se organiza conceptualmente como una plataforma y los
proyectos que utilizan sus capacidades.

```text
                         AI HOME LAB
                              |
             +----------------+----------------+
             |                |                |
        Infraestructura      Agentes         Tools
             |                |                |
             +----------------+----------------+
                              |
                         Capacidades
                              |
             +----------------+----------------+
             |                |                |
         Proyecto A       Proyecto B       Proyecto C
```

La implementación concreta evolucionará a medida que aparezcan
necesidades reales.

No asumimos desde el inicio que todos los proyectos tendrán los mismos
recursos. La arquitectura deberá permitir evolucionar hacia escenarios
locales, Cloud o híbridos cuando exista una razón para hacerlo.

## Estado actual

### Fundación

- WSL2 + Ubuntu 24.04.4 LTS — VERIFICADO
- Docker Desktop / Docker Engine 26.1.1 — VERIFICADO
- NVIDIA GeForce RTX 4060 accesible desde WSL — VERIFICADO
- GPU accesible desde Docker — VERIFICADO
- GitHub mediante SSH — VERIFICADO
- Repositorio organizado bajo Git — VERIFICADO
- Flujo `feature/* -> development -> main` — DECISIÓN
- Sin rama QA — DECISIÓN

### Próximamente

- Observabilidad
- Backup y recuperación
- Gestión de secretos
- Runtime de agentes
- Herramientas y MCP
- Memoria
- Primer agente funcional
- Control de costes
- Presentación interactiva del Home Lab

## Estructura del repositorio

```text
IA-HOME-LAB/
|
├── README.md
├── docs/
|   ├── architecture/
|   ├── installation/
|   ├── operations/
|   └── security/
|
├── decisions/
|
├── infrastructure/
|   ├── docker/
|   ├── observability/
|   └── backup/
|
├── agents/
├── tools/
├── scripts/
└── projects/
```

### `docs/`

Documentación técnica y operativa del laboratorio.

### `decisions/`

Registro de decisiones arquitectónicas mediante ADRs.

### `infrastructure/`

Componentes que forman la plataforma compartida.

### `agents/`

Agentes reutilizables.

### `tools/`

Herramientas que los agentes podrán utilizar de forma controlada.

### `scripts/`

Automatizaciones y utilidades operativas.

### `projects/`

Proyectos que consumen capacidades del Home Lab.

## Flujo de evolución

El laboratorio se construye mediante iteraciones pequeñas:

```text
Necesidad
   |
   v
Análisis
   |
   v
Decisión
   |
   v
Implementación
   |
   v
Verificación
   |
   v
Documentación
   |
   v
Git
```

Las decisiones importantes quedan registradas antes de que se pierda
el contexto que las originó.

## Versionado

El flujo inicial es:

```text
feature/*
     |
     v
development
     |
     v
main
```

`main` representa el estado estable del proyecto.

`development` integra cambios que todavía están evolucionando.

Las ramas `feature/*` se utilizan para construir capacidades concretas.

No se utilizará una rama QA.

## Roadmap

El roadmap no representa una lista cerrada de tecnología. Evolucionará
con las necesidades reales del Home Lab.

### Fundación

Construir un entorno reproducible y seguro.

### Agentes

Construir el primer agente capaz de utilizar herramientas.

### Orquestación

Aprender cómo coordinar agentes, tareas, permisos y resultados.

### Memoria

Diseñar mecanismos para conservar conocimiento útil sin depender
únicamente del contexto de una conversación.

### Observabilidad

Medir ejecuciones, errores, latencia, consumo y costes.

### Resiliencia

Diseñar mecanismos de backup, recuperación y reconstrucción.

### Monetización

Evaluar qué capacidades construidas pueden convertirse en productos,
servicios o automatizaciones con valor económico.

## Estado del documento

Este README describe el estado actual del proyecto y evolucionará junto
con el Home Lab.

Las afirmaciones técnicas deben estar respaldadas por documentación de
instalación, pruebas o decisiones registradas en el repositorio.

