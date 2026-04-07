#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

printf 'Cleaning repository artifacts...\n'

# Remove common transient files/directories.
rm -rf \
  .pytest_cache \
  .ruff_cache \
  .mypy_cache \
  .tox \
  .coverage \
  htmlcov \
  dist \
  build \
  .eggs

# Remove Python bytecode files.
find . -type d -name '__pycache__' -prune -exec rm -rf {} +
find . -type f \( -name '*.pyc' -o -name '*.pyo' \) -delete

# Remove empty directories except .git internals.
find . -type d -empty -not -path './.git*' -delete

printf 'Done.\n'
