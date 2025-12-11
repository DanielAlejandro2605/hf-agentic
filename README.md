# HF-Agentic Setup

Local model templates for AI agent frameworks using HuggingFace models.

## 📁 What's Included

```
hf-agentic-setup/
├── smolagents/      # HuggingFace's smolagents framework
│   ├── main.py      # Uses TransformersModel + CodeAgent
│   ├── pyproject.toml
│   └── Makefile
├── llama_index/     # LlamaIndex framework
│   ├── main.py      # Uses HuggingFaceLLM
│   ├── pyproject.toml
│   └── Makefile
├── lang_graph/      # LangGraph framework
│   ├── main.py      # Uses HuggingFacePipeline
│   ├── pyproject.toml
│   └── Makefile
├── setup_model.sh   # Script to download models
└── Makefile         # Global setup commands
```

## ⚠️ Important: Environment Variables for 42 Students

### Why Use sgoinfre?

HuggingFace models are **large files** (500MB - 15GB+). Storing them in your home directory will:
- ❌ Fill up your limited disk quota
- ❌ Cause download failures
- ❌ Slow down your system

**Solution:** Store models in `sgoinfre` (shared storage with more space).

### Required Environment Variables

Add these to your `~/.zshrc`:

```bash
# HuggingFace Cache Configuration - IMPORTANT FOR 42!
export HF_HUB_CACHE="/sgoinfre/students/$USER/huggingface/hub"
export HF_HOME="/sgoinfre/students/$USER/huggingface"
```

Then reload your shell:

```bash
source ~/.zshrc
```

### Verify Setup

```bash
echo $HF_HUB_CACHE
# Should output: /sgoinfre/students/YOUR_LOGIN/huggingface/hub
```

Or use the Makefile:

```bash
make check-env
```

## 🚀 Quick Start

### 1. Set Up Environment Variables

```bash
# Create the cache directory
mkdir -p /sgoinfre/students/$USER/huggingface/hub

# Add to your shell profile
echo 'export HF_HUB_CACHE="/sgoinfre/students/$USER/huggingface/hub"' >> ~/.zshrc
echo 'export HF_HOME="/sgoinfre/students/$USER/huggingface"' >> ~/.zshrc
source ~/.zshrc
```

### 2. Download a Model (Optional, auto-downloads on first run)

```bash
./setup_model.sh Qwen/Qwen2.5-3B-Instruct
```

### 3. Run a Framework

```bash
# Choose your framework
cd smolagents   # or llama_index, lang_graph

# Install dependencies
make install

# Run
make run
```

## 📦 Available Commands (per framework)

| Command | Description |
|---------|-------------|
| `make install` | Create venv and install dependencies |
| `make sync` | Update dependencies |
| `make run` | Run main.py with HF cache configured |
| `make check-env` | Verify environment variables |
| `make clean` | Remove venv |

## 🤖 Models

Default model: `Qwen/Qwen2.5-3B-Instruct`

You can change the model in each `main.py` file. Recommended models:

| Model | Size | RAM Needed |
|-------|------|------------|
| Qwen/Qwen2.5-0.5B-Instruct | ~1GB | 4GB |
| Qwen/Qwen2.5-3B-Instruct | ~6GB | 8GB |
| Qwen/Qwen2.5-7B-Instruct | ~14GB | 16GB |

## 🔧 Troubleshooting

### "HF_HUB_CACHE is not set" Error

You haven't set the environment variables. Follow the setup above.

### Model keeps re-downloading

The cache directory might be wrong. Check:
```bash
ls $HF_HUB_CACHE
```

### Out of disk space

Make sure you're using sgoinfre, not your home directory:
```bash
echo $HF_HUB_CACHE
# GOOD: /sgoinfre/students/...
# BAD:  /Users/... or ~/.cache/...
```

## 📚 Framework Comparison

| Framework | Model Class | Best For |
|-----------|-------------|----------|
| **smolagents** | `TransformersModel` | Code agents, tool use |
| **llama_index** | `HuggingFaceLLM` | RAG, document QA |
| **lang_graph** | `HuggingFacePipeline` | Stateful workflows |

## 🔗 Resources

- [HuggingFace Models](https://huggingface.co/models)
- [Smolagents Docs](https://huggingface.co/docs/smolagents)
- [LlamaIndex Docs](https://docs.llamaindex.ai)
- [LangGraph Docs](https://langchain-ai.github.io/langgraph/)
