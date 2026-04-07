#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$SCRIPT_DIR")"
VENV_PATH="$HOME/venv/$PROJECT_NAME"

if [ ! -d "$VENV_PATH" ]; then
    echo "Virtual environment not found at $VENV_PATH. Run install.sh first."
    return 1 2>/dev/null || exit 1
fi

if [ ! -x "$VENV_PATH/bin/vllm" ]; then
    echo "vLLM executable not found at $VENV_PATH/bin/vllm. Re-run install.sh."
    return 1 2>/dev/null || exit 1
fi

# Load .env if exists
if [ -f "$SCRIPT_DIR/.env" ]; then
    set -a
    source "$SCRIPT_DIR/.env"
    set +a
fi

# Positional args: source run.sh [HOST] [PORT]
HOST="${1:-$HOST}"
PORT="${2:-$PORT}"

MODEL="${MODEL:-Qwen/Qwen3-ASR-1.7B}"
SERVED_MODEL_NAME="${SERVED_MODEL_NAME:-whisper-1}"
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8000}"
GPU_MEMORY_UTILIZATION="${GPU_MEMORY_UTILIZATION:-0.35}"
MAX_NEW_TOKENS="${MAX_NEW_TOKENS:-256}"

echo "Starting Qwen3-ASR server..."
echo "Model: $MODEL"
echo "Served as: $SERVED_MODEL_NAME"
echo "URL: http://$HOST:$PORT"

exec "$VENV_PATH/bin/vllm" serve "$MODEL" \
    --served-model-name "$SERVED_MODEL_NAME" \
    --host "$HOST" \
    --port "$PORT" \
    --gpu-memory-utilization "$GPU_MEMORY_UTILIZATION" \
    --override-generation-config "{\"max_new_tokens\": $MAX_NEW_TOKENS}" \
    --api-key "${VLLM_API_KEY:-my-secret-key}"
