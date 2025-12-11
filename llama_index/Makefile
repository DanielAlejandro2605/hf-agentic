.PHONY: help install sync run run-groq clean check-env

# Configuration
HF_CACHE_DIR ?= /Users/danielnieto/Desktop/perso/42AI/HF-Agentic/hub

help:
	@echo "Commands:"
	@echo "  make install    - Install dependencies"
	@echo "  make sync       - Update dependencies"
	@echo "  make run        - Run main.py (local model)"
	@echo "  make run-groq   - Run groq.py (Groq API)"
	@echo "  make check-env  - Check environment variables"
	@echo "  make clean      - Remove venv"

install:
	uv venv --python 3.10
	uv sync

sync:
	uv sync

run:
	HF_HUB_CACHE="$(HF_CACHE_DIR)" HF_HOME="$(HF_CACHE_DIR)" uv run python main.py

run-groq:
	@if [ -f .env ]; then set -a && . ./.env && set +a && uv run python run_groq.py; else uv run python run_groq.py; fi

check-env:
	@echo ""
	@echo "Environment Variables:"
	@echo "======================"
	@if [ -n "$$HF_HUB_CACHE" ]; then echo "✓ HF_HUB_CACHE: $$HF_HUB_CACHE"; else echo "✗ HF_HUB_CACHE not set"; fi
	@if [ -n "$$HF_HOME" ]; then echo "✓ HF_HOME: $$HF_HOME"; else echo "✗ HF_HOME not set"; fi
	@if [ -n "$$GROQ_API_KEY" ]; then echo "✓ GROQ_API_KEY: (set)"; else echo "✗ GROQ_API_KEY not set"; fi
	@echo ""

clean:
	rm -rf .venv __pycache__
