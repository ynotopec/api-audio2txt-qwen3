# api-audio2txt-qwen3

A lean project scaffold focused on low-maintenance automation.

## What was simplified

- Reduced `.gitignore` to practical, high-signal patterns.
- Added `scripts/maintain.sh` to clean common local artifacts in one command.
- Added a `Makefile` with simple automation targets (`maintain`, `format`, `lint`, `test`, `ci`).

## Quick start

```bash
make help
make maintain
make ci
```
