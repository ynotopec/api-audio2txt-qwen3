.PHONY: help maintain format lint test ci

help:
	@echo "Available targets:"
	@echo "  make maintain  - remove temporary/build artifacts"
	@echo "  make format    - run formatter if available"
	@echo "  make lint      - run linters if available"
	@echo "  make test      - run tests if available"
	@echo "  make ci        - run maintain + lint + test"

maintain:
	./scripts/maintain.sh

format:
	@if command -v ruff >/dev/null 2>&1; then ruff format .; else echo "ruff not installed; skipping"; fi

lint:
	@if command -v ruff >/dev/null 2>&1; then ruff check .; else echo "ruff not installed; skipping"; fi

test:
	@if command -v pytest >/dev/null 2>&1; then \
		pytest -q; status=$$?; \
		if [ $$status -eq 5 ]; then echo "pytest: no tests discovered; skipping"; \
		elif [ $$status -ne 0 ]; then exit $$status; fi; \
	else echo "pytest not installed; skipping"; fi

ci: maintain lint test
