#!/usr/bin/env bash

# ============================================================
# Home Lab IA - Creación de Workspaces
# ============================================================
#
# Este script crea la estructura base para separar los
# diferentes contextos de uso del Home Lab IA:
#
#   - Personal
#   - Work
#   - Family
#
# La infraestructura compartida se mantiene en:
#
#   ~/ai/shared/
#
# Los contextos independientes se mantienen en:
#
#   ~/ai/contexts/
#
# Ollama y sus modelos NO son administrados por este script.
# Tampoco modifica la configuración actual de OpenCode.
#
# ============================================================

# ------------------------------------------------------------
# Activar modo estricto de Bash
# ------------------------------------------------------------
#
# -e : detener el script si ocurre un error.
# -u : tratar variables no definidas como errores.
# -o pipefail : detectar errores dentro de pipelines.
#
set -euo pipefail


# ------------------------------------------------------------
# Definir directorios principales
# ------------------------------------------------------------
#
# BASE    : raíz de nuestro Home Lab IA.
# SHARED  : recursos compartidos entre contextos.
# CONTEXTS: espacios aislados Personal / Work / Family.
#
BASE="$HOME/ai"
SHARED="$BASE/shared"
CONTEXTS="$BASE/contexts"
# Directorio raíz del repositorio IA-HOME-LAB.
# El script utiliza las plantillas oficiales de los agentes
# almacenadas y versionadas dentro del repositorio.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Directorio que contiene las plantillas AGENTS.md.
AGENTS="$REPO_ROOT/agents"

# ------------------------------------------------------------
# Mostrar información inicial
# ------------------------------------------------------------

echo "=========================================="
echo "       Home Lab IA - Workspace Setup"
echo "=========================================="
echo
echo "Directorio principal: $BASE"
echo


# ------------------------------------------------------------
# Crear infraestructura compartida
# ------------------------------------------------------------
#
# shared/scripts:
#   Scripts administrativos del Home Lab.
#
# shared/config:
#   Configuración global que pueda ser compartida.
#
# shared/docs:
#   Documentación general de la infraestructura.
#
# IMPORTANTE:
#   No ponemos logs aquí porque los logs pertenecen
#   a cada contexto individual.
#
echo "[1/4] Creando infraestructura compartida..."

mkdir -p "$SHARED/scripts"
mkdir -p "$SHARED/config"
mkdir -p "$SHARED/docs"


# ------------------------------------------------------------
# Crear los tres contextos
# ------------------------------------------------------------
#
# Cada contexto tendrá exactamente la misma estructura:
#
#   <contexto>/
#   ├── AGENTS.md
#   ├── logs/
#   └── projects/
#
# Esto permite mantener una separación consistente entre:
#
#   Personal
#   Work
#   Family
#
echo "[2/4] Creando contextos..."

for context in personal work family; do

    # Directorio raíz del contexto.
    CONTEXT="$CONTEXTS/$context"

    # Crear carpeta donde estarán los proyectos.
    mkdir -p "$CONTEXT/projects"

    # Crear carpeta exclusiva para los logs del contexto.
    mkdir -p "$CONTEXT/logs"

    # Crear el archivo de instrucciones específico del contexto.
    #
    # Más adelante aquí definiremos reglas diferentes para:
    #
    #   Personal -> proyectos personales
    #   Work     -> Azure DevOps / Outlook laboral
    #   Family   -> información familiar
    #
    # Copiar la plantilla oficial solamente si el AGENTS.md
    # todavía no existe.
    #
    # Esto permite ejecutar el script nuevamente sin perder
    # modificaciones locales realizadas posteriormente.

    if [ ! -f "$CONTEXT/AGENTS.md" ]; then
       cp "$AGENTS/$context/AGENTS.md" "$CONTEXT/AGENTS.md"
    else
       echo "  AGENTS.md ya existe para $context. No se modifica."
    fi

done


# ------------------------------------------------------------
# Crear README principal
# ------------------------------------------------------------
#
# Este README documenta la estructura general del Home Lab.
#
# Solo se crea si todavía no existe.
# De esta manera el script no sobrescribe documentación
# que hayamos creado posteriormente.
#
echo "[3/4] Creando documentación principal..."

README="$BASE/README.md"

if [ ! -f "$README" ]; then

cat > "$README" <<'EOF'
# Home Lab IA

Infraestructura local para trabajar con agentes de IA.

## Estructura

### shared/

Recursos compartidos entre los diferentes contextos.

- scripts/
- config/
- docs/

### contexts/

Contiene los contextos independientes del Home Lab.

#### personal/

Entorno para proyectos y actividades personales.

#### work/

Entorno para actividades laborales.

#### family/

Entorno para actividades familiares.

## Modelos

Los modelos son administrados por Ollama.

Los modelos pueden ser compartidos físicamente entre
los diferentes contextos, pero cada contexto puede
tener una configuración diferente sobre qué modelos
y herramientas puede utilizar.

## Seguridad

Los contextos deben mantenerse separados.

Las credenciales y herramientas específicas de Work
no deben estar disponibles desde Personal o Family.
EOF

else

    echo "README.md ya existe. No se modifica."

fi


# ------------------------------------------------------------
# Mostrar estructura final
# ------------------------------------------------------------
#
# Mostramos los directorios creados para poder verificar
# visualmente que la estructura es la esperada.
#
echo
echo "[4/4] Verificando estructura..."
echo

find "$BASE" -maxdepth 3 -type d | sort


# ------------------------------------------------------------
# Finalización
# ------------------------------------------------------------

echo
echo "=========================================="
echo " Workspace creados correctamente."
echo "=========================================="
echo
echo "Contextos:"
echo "  Personal -> $CONTEXTS/personal"
echo "  Work     -> $CONTEXTS/work"
echo "  Family   -> $CONTEXTS/family"
echo
echo "Infraestructura compartida:"
echo "  Shared   -> $SHARED"
echo
