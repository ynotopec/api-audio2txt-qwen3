#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$SCRIPT_DIR")"
VENV_PATH="$HOME/venv/$PROJECT_NAME"

echo "Setting up $PROJECT_NAME..."

if ! command -v uv >/dev/null 2>&1; then
    echo "Error: uv is not installed. Install it first: https://docs.astral.sh/uv/"
    exit 1
fi

mkdir -p "$HOME/venv"
uv venv "$VENV_PATH"
source "$VENV_PATH/bin/activate"

uv pip install -U vllm --pre \
    --extra-index-url https://wheels.vllm.ai/nightly/cu129 \
    --extra-index-url https://download.pytorch.org/whl/cu129 \
    --index-strategy unsafe-best-match

uv pip install "vllm[audio]"

echo "Installation complete. Activate with: source $VENV_PATH/bin/activate"
