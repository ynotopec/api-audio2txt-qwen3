# Qwen3-ASR API

OpenAI-compatible ASR API using Qwen3-ASR-1.7B with vLLM.

## Setup

```bash
./install.sh
```

## Run

```bash
./run.sh
```

## Environment Variables

Copy `.env.example` to `.env` and adjust as needed:

- `MODEL` - Model ID (default: Qwen/Qwen3-ASR-1.7B)
- `HOST` - Server host (default: 0.0.0.0)
- `PORT` - Server port (default: 8000)
- `GPU_MEMORY_UTILIZATION` - GPU memory fraction (default: 0.35)
- `MAX_NEW_TOKENS` - Max tokens to generate (default: 256)
- `VLLM_API_KEY` - API key (default: my-secret-key)

## API Usage

### Transcription (OpenAI SDK)

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8000/v1",
    api_key="my-secret-key"
)

transcription = client.audio.transcriptions.create(
    model="whisper-1",
    file=open("audio.wav", "rb"),
)
print(transcription.text)
```

### Transcription (curl)

```bash
curl -X POST http://localhost:8000/v1/audio/transcriptions \
    -H "Authorization: Bearer $VLLM_API_KEY" \
    -F "file=@audio.wav" \
    -F "model=whisper-1"
```

### Chat Completions API

```bash
curl http://localhost:8000/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "messages": [{
            "role": "user",
            "content": [{
                "type": "audio_url",
                "audio_url": {"url": "https://example.com/audio.wav"}
            }]
        }]
    }'
```

## Systemd Service

```ini
[Unit]
Description=Qwen3-ASR API Server
After=network.target

[Service]
Type=simple
User=ailab
WorkingDirectory=/home/ailab/api-audio2txt-qwen3
ExecStart=/home/ailab/api-audio2txt-qwen3/run.sh
Restart=always
Environment=PORT=8000

[Install]
WantedBy=multi-user.target
```
