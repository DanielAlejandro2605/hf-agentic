.PHONY: help install sync run clean test check-env check-token

# Default target
help:
	@echo "Available commands:"
	@echo "  install     - Create virtual environment and install dependencies"
	@echo "  sync        - Update existing virtual environment with new packages from pyproject.toml"
	@echo "  run         - Run the application"
	@echo "  clean       - Remove virtual environment and cache files"
	@echo "  check-token - Check if HF_TOKEN is set in .env file"

# Check if virtual environment exists
check-env:
	@if [ ! -d ".venv" ]; then \
		echo "Virtual environment not found. Run 'make install' first."; \
		exit 1; \
	fi

# Install dependencies
install: check-uv
	@echo "Creating virtual environment with uv..."
	uv venv --python 3.10
	@echo "Installing dependencies..."
	uv sync
	@echo "Installation complete!"
	@echo "To activate the environment, run: source .venv/bin/activate"

# Sync/Update dependencies (use this after adding packages to pyproject.toml)
sync: check-uv check-env
	@echo "Updating virtual environment with packages from pyproject.toml..."
	uv sync
	@echo "Sync complete!"

# Check if uv is available
check-uv:
	@if ! command -v uv >/dev/null 2>&1; then \
		echo "uv is not installed. Installing uv..."; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
		echo "Please restart your shell or run: source ~/.local/bin/env"; \
		exit 1; \
	fi

# Run the application
run: check-env
	@if [ -f .env ]; then \
		export $$(cat .env | xargs) && uv run python main.py; \
	else \
		echo "Warning: .env file not found. Make sure HF_TOKEN is set in your environment."; \
		uv run python main.py; \
	fi
# Clean up
clean:
	@echo "Cleaning up..."
	rm -rf .venv
	rm -rf __pycache__
	rm -rf .pytest_cache
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	@echo "Cleanup complete!"

# Show activation command
activate:
	@echo "To activate the virtual environment, run:"
	@echo "source .venv/bin/activate"
	@echo ""
	@echo "Or use uv run for individual commands:"
	@echo "uv run python app.py"

# Setup environment file
setup-env:
	@if [ ! -f ".env" ]; then \
		cp .env.example .env; \
		echo ".env file created from template."; \
		echo "Please edit .env file and add your HF_TOKEN"; \
		echo "Get your token from: https://huggingface.co/settings/tokens"; \
	else \
		echo ".env file already exists."; \
	fi

# Check if HF_TOKEN is set
check-token:
	@if [ -f ".env" ]; then \
		if grep -q "HF_TOKEN=" .env && ! grep -q "HF_TOKEN=your_huggingface_token_here" .env; then \
			echo "HF_TOKEN is configured in .env file"; \
		else \
			echo "HF_TOKEN not properly configured in .env file"; \
			echo "Please edit .env file and add your actual HF_TOKEN"; \
		fi; \
	else \
		echo ".env file not found. Run 'make setup-env' first."; \
	fi
