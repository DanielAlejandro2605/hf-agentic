# Python Project Setup with uv and Makefile

## What is uv?

uv is a fast Python package installer and resolver written in Rust. It serves as a drop-in replacement for pip and pip-tools, offering significantly faster dependency resolution and installation. uv can also manage virtual environments and handle project dependencies defined in `pyproject.toml`.

Key features:
- Fast dependency resolution and installation
- Built-in virtual environment management
- Compatible with PEP 517/518 standards
- Works with `pyproject.toml` files

## What is pyproject.toml?

`pyproject.toml` is the modern standard configuration file for Python projects. It was introduced in PEP 518 and serves as a single source of truth for project metadata and dependencies.

The file contains:
- Project metadata (name, version, description)
- Python version requirements
- Project dependencies
- Build system configuration
- Optional tool configurations

Example structure:
```toml
[project]
name = "my-project"
version = "0.1.0"
description = "My project description"
requires-python = ">=3.10"
dependencies = [
    "package-name>=1.0.0",
]
```

## How to Use This Makefile

### Step 1: Copy the Makefile

Copy the `Makefile` to your project directory where your `pyproject.toml` file is located:

```bash
cp Makefile /path/to/your/project/
```

Make sure your project has a `pyproject.toml` file in the same directory.

### Step 2: Available Commands

Once the Makefile is in your project directory, you can use the following commands:

**Install dependencies:**
```bash
make install
```
This command will:
- Check if uv is installed (and install it if missing)
- Create a virtual environment using Python 3.10
- Install all dependencies from `pyproject.toml`
- Create the virtual environment in `.venv/`

**Sync dependencies:**
```bash
make sync
```
Use this after adding new packages to `pyproject.toml`. It updates the virtual environment with the latest dependencies.

**Run the application:**
```bash
make run
```
Runs `main.py` using the virtual environment. If a `.env` file exists, it will load environment variables from it.

**Clean up:**
```bash
make clean
```
Removes the virtual environment and all Python cache files.

**Setup environment file:**
```bash
make setup-env
```
Creates a `.env` file from `.env.example` template (if it exists).

**Check token configuration:**
```bash
make check-token
```
Verifies if `HF_TOKEN` is properly configured in your `.env` file.

**Show help:**
```bash
make help
```
Displays all available commands.

### Step 3: Activate the Virtual Environment

After running `make install`, you can activate the virtual environment:

```bash
source .venv/bin/activate
```

Alternatively, use `uv run` to execute commands within the virtual environment without activating it:

```bash
uv run python your_script.py
```

## Workflow Example

1. Copy the Makefile to your project directory
2. Ensure you have a `pyproject.toml` file with your dependencies
3. Run `make install` to set up the environment
4. Add or modify dependencies in `pyproject.toml` as needed
5. Run `make sync` to update the environment
6. Use `make run` to execute your application
7. Use `make clean` when you want to start fresh

