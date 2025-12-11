.PHONY: help install sync run clean check-env

# Configuration
HF_CACHE_DIR ?= "/sgoinfre/goinfre/Perso/$USER/huggingface/hub"

help:
	@echo "Commands:"
	@echo "  make install    - Install dependencies"
	@echo "  make sync       - Update dependencies"
	@echo "  make run        - Run main.py"
	@echo "  make check-env  - Check HF environment variables"
	@echo "  make clean      - Remove venv"

install:
	@if ! command -v uv >/dev/null 2>&1; then \
		echo "Installing uv..."; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
		echo "Please restart your shell or run: source ~/.local/bin/env"; \
	fi
	uv venv --python 3.10
	uv sync

sync:
	uv sync

run:
	HF_HUB_CACHE="$(HF_CACHE_DIR)" HF_HOME="$(HF_CACHE_DIR)" uv run python main.py

check-env:
	@echo ""
	@echo "Environment Variables:"
	@echo "======================"
	@if [ -n "$$HF_HUB_CACHE" ]; then echo "✓ HF_HUB_CACHE: $$HF_HUB_CACHE"; else echo "✗ HF_HUB_CACHE not set"; fi
	@if [ -n "$$HF_HOME" ]; then echo "✓ HF_HOME: $$HF_HOME"; else echo "✗ HF_HOME not set"; fi
	@if [ -n "$$HF_TOKEN" ]; then echo "✓ HF_TOKEN: (set)"; else echo "✗ HF_TOKEN not set"; fi
	@echo ""

clean:
	rm -rf .venv __pycache__
