.PHONY: help install sync clean check-env

# Configuration - all in sgoinfre to save home space
SGOINFRE_DIR := /sgoinfre/goinfre/Perso/$(USER)
VENV_DIR := $(SGOINFRE_DIR)/.venv
HF_CACHE_DIR := $(SGOINFRE_DIR)/huggingface/hub

help:
	@echo ""
	@echo "╔═══════════════════════════════════════════════════════════╗"
	@echo "║          HF-Agentic Setup (Shared Environment)            ║"
	@echo "╚═══════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "  Shared venv location: $(VENV_DIR)"
	@echo "  HF cache location:    $(HF_CACHE_DIR)"
	@echo ""
	@echo "  Commands:"
	@echo "    make install    - Install shared venv in sgoinfre"
	@echo "    make sync       - Update dependencies"
	@echo "    make check-env  - Check environment variables"
	@echo "    make clean      - Remove shared venv"
	@echo ""
	@echo "  Run frameworks:"
	@echo "    make run-smolagents"
	@echo "    make run-llama_index"
	@echo "    make run-lang_graph"
	@echo ""

install:
	@echo "Creating shared venv in sgoinfre..."
	@mkdir -p $(SGOINFRE_DIR)
	@mkdir -p $(HF_CACHE_DIR)
	@if ! command -v uv >/dev/null 2>&1; then \
		echo "Installing uv..."; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
		echo "Run: source ~/.local/bin/env"; \
	fi
	uv venv $(VENV_DIR) --python 3.10
	@# Create symlink so uv sync uses the sgoinfre venv
	@rm -f .venv
	@ln -s $(VENV_DIR) .venv
	uv sync
	@echo ""
	@echo "✓ Shared venv created at: $(VENV_DIR)"
	@echo "✓ Symlink .venv -> $(VENV_DIR)"
	@echo "✓ HF cache at: $(HF_CACHE_DIR)"

sync:
	uv sync

check-env:
	@echo ""
	@echo "Environment Variables:"
	@echo "======================"
	@if [ -n "$$HF_HUB_CACHE" ]; then echo "✓ HF_HUB_CACHE: $$HF_HUB_CACHE"; else echo "✗ HF_HUB_CACHE not set"; fi
	@if [ -n "$$HF_HOME" ]; then echo "✓ HF_HOME: $$HF_HOME"; else echo "✗ HF_HOME not set"; fi
	@if [ -n "$$GROQ_API_KEY" ]; then echo "✓ GROQ_API_KEY: (set)"; else echo "✗ GROQ_API_KEY not set"; fi
	@echo ""
	@echo "Shared venv: $(VENV_DIR)"
	@if [ -d "$(VENV_DIR)" ]; then echo "✓ Venv exists"; else echo "✗ Venv not found - run 'make install'"; fi
	@echo ""

clean:
	@echo "Removing shared venv from sgoinfre..."
	rm -rf $(VENV_DIR)
	@echo "✓ Cleaned"

# ===========================================
# Run frameworks using shared venv
# ===========================================

run-smolagents:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	HF_HUB_CACHE=$(HF_CACHE_DIR) HF_HOME=$(HF_CACHE_DIR) \
	$(VENV_DIR)/bin/python smolagents/main.py

run-smolagents-groq:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	$(VENV_DIR)/bin/python smolagents/run_groq.py

run-llama_index:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	HF_HUB_CACHE=$(HF_CACHE_DIR) HF_HOME=$(HF_CACHE_DIR) \
	$(VENV_DIR)/bin/python llama_index/main.py

run-llama_index-groq:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	$(VENV_DIR)/bin/python llama_index/run_groq.py

run-lang_graph:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	HF_HUB_CACHE=$(HF_CACHE_DIR) HF_HOME=$(HF_CACHE_DIR) \
	$(VENV_DIR)/bin/python lang_graph/main.py

run-lang_graph-groq:
	@if [ -f .env ]; then set -a && . ./.env && set +a; fi && \
	$(VENV_DIR)/bin/python lang_graph/run_groq.py
