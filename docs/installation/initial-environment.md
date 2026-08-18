# AI Home Lab — Initial Environment

## 1. Objetivo

Documentar el entorno base utilizado para construir el AI Home Lab.

Este documento registra únicamente componentes, comandos y resultados
que fueron ejecutados y verificados durante la instalación inicial.

---

## 2. Host

| Componente | Estado |
|---|---|
| Sistema operativo | Windows 10 Home |
| CPU | Intel Core i7 |
| RAM física | 64 GB |
| GPU | NVIDIA GeForce RTX 4060 |
| VRAM | 8 GB |

---

## 3. WSL2

### Distribución

Ubuntu 24.04.4 LTS.

Verificación realizada:

```bash
lsb_release -a
```

Resultado verificado:

```text
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.4 LTS
Release:        24.04
Codename:       noble
```

Estado: **VERIFICADO**

---

## 4. Recursos disponibles en WSL

Verificación:

```bash
free -h
```

Resultado observado:

```text
Mem: 31Gi total
Swap: 8.0Gi
```

El entorno WSL dispone actualmente de aproximadamente 31 GiB visibles para la instancia.

Estado: **VERIFICADO**

---

## 5. NVIDIA GPU en WSL

Verificación:

```bash
nvidia-smi
```

Resultado observado:

```text
GPU: NVIDIA GeForce RTX 4060
VRAM: 8188 MiB
Driver Version: 596.08
CUDA Version: 13.2
```

Estado: **VERIFICADO**

---

## 6. Docker

Docker Desktop está integrado con la distribución Ubuntu mediante WSL2.

Inicialmente `docker version` produjo un error de permisos sobre:

```text
/var/run/docker.sock
```

El socket pertenece a:

```text
root:docker
```

El usuario fue agregado al grupo `docker`.

Después de reiniciar la instancia WSL se verificó que el usuario pertenece al grupo `docker`.

Estado: **VERIFICADO**

---

## 7. Docker Engine

Verificación:

```bash
docker version
```

Resultado:

```text
Client Version: 26.1.1
Server Docker Desktop
Engine Version: 26.1.1
API Version: 1.45
```

Estado: **VERIFICADO**

---

## 8. GPU desde Docker

Se validó acceso de un contenedor a la GPU mediante:

```bash
docker run --rm --gpus all nvidia/cuda:12.6.3-base-ubuntu24.04 nvidia-smi
```

El contenedor pudo detectar:

```text
NVIDIA GeForce RTX 4060
8188 MiB VRAM
Driver Version: 596.08
CUDA Version: 13.2
```

Estado: **VERIFICADO**

Esto confirma que la GPU puede ser utilizada desde contenedores Docker.

---

## 9. GitHub mediante SSH

Se verificó la identidad del host GitHub mediante SSH.

Durante la primera conexión se validó el fingerprint ED25519 de GitHub
y se almacenó el host en:

```text
~/.ssh/known_hosts
```

Se generó una clave dedicada para el Home Lab:

```bash
ssh-keygen -t ed25519 -C "ai-home-lab"
```

La clave privada permanece en:

```text
~/.ssh/id_ed25519
```

La clave pública:

```text
~/.ssh/id_ed25519.pub
```

fue registrada en GitHub.

Verificación:

```bash
ssh -T git@github.com
```

Resultado:

```text
Hi jmanriquecruz! You've successfully authenticated,
but GitHub does not provide shell access.
```

Estado: **VERIFICADO**

La passphrase de la clave privada no se almacena en este repositorio.

---

## 10. Repositorio

Repositorio:

```text
git@github.com:jmanriquecruz/IA-HOME-LAB.git
```

Ubicación local:

```text
/home/jmanriquec/github/projects/IA-HOME-LAB
```

---

## 11. Estrategia de ramas

La estrategia definida para el proyecto es:

```text
feature/*
    |
    v
development
    |
    v
main
```

No se utilizará una rama QA.

La primera rama creada es:

```text
feature/feat-001-home-lab-foundation
```

---

## 12. Convención de documentación

La documentación del proyecto distinguirá entre:

- **VERIFICADO** — probado durante la construcción.
- **DECISIÓN** — decisión estratégica tomada.
- **PROPUESTA** — alternativa todavía no implementada.
- **PENDIENTE** — trabajo futuro.

La documentación debe describir el sistema real y no una arquitectura hipotética.

---

## 13. Estado del entorno inicial

| Componente | Estado |
|---|---|
| WSL2 | VERIFICADO |
| Ubuntu | VERIFICADO |
| NVIDIA GPU en WSL | VERIFICADO |
| Docker | VERIFICADO |
| Docker sin sudo | VERIFICADO |
| GPU en Docker | VERIFICADO |
| GitHub SSH | VERIFICADO |
| Repositorio Git | VERIFICADO |
| Rama feature/feat-001 | VERIFICADO |

---

## 14. Próximos pasos

Los siguientes componentes todavía no forman parte del entorno base:

- Observabilidad
- Backup y recuperación
- Gestión de secretos
- Seguridad de herramientas
- Runtime de agentes
- Memoria
- MCP / herramientas
- Control de costes
- Primer agente funcional

Estos componentes se incorporarán de forma incremental y serán documentados cuando sean implementados y verificados.

---

## 15. Principio de construcción

El Home Lab se construirá incrementalmente.

No se introducirán abstracciones o componentes únicamente porque podrían ser útiles.

Cada nueva pieza deberá responder a una necesidad real y ser validada antes de considerarse parte del entorno.
