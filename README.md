# HF-Agentic Setup

AI agent frameworks with **local models** and **Groq API** support.

## 📁 What's Included

```
hf-agentic-setup/
├── Makefile           # All commands (shared venv)
├── pyproject.toml     # All dependencies
├── setup_model.sh     # Download models to sgoinfre
├── .env               # API keys (create this)
├── smolagents/
│   ├── main.py        # Local model (TransformersModel)
│   └── run_groq.py    # Groq API (LiteLLMModel)
├── llama_index/
│   ├── main.py        # Local model (HuggingFaceLLM)
│   └── run_groq.py    # Groq API (LiteLLM)
└── lang_graph/
    ├── main.py        # Local model (HuggingFacePipeline)
    └── run_groq.py    # Groq API (ChatGroq)
```

## ⚠️ Important: 42 Students - Use sgoinfre!

Your home has **5GB limit**. Models + venv can be **10GB+**.

The Makefile automatically installs everything in sgoinfre:
- **Venv:** `/sgoinfre/goinfre/Perso/$USER/.venv`
- **Models:** `/sgoinfre/goinfre/Perso/$USER/huggingface/hub`

## 🚀 Quick Start

### 1. Install (creates shared venv in sgoinfre)

```bash
make install
```

### 2. Run with Local Model

```bash
# Choose your framework
make run-smolagents
make run-llama_index
make run-lang_graph
```

### 3. Run with Groq API (Free & Fast)

```bash
# First, set your Groq API key
echo 'GROQ_API_KEY=gsk_your_key_here' > .env

# Then run
make run-smolagents-groq
make run-llama_index-groq
make run-lang_graph-groq
```

## ⚡ Groq API (Recommended for 42)

**Why Groq?**
- ✅ **Free tier** - No credit card needed
- ✅ **Fast** - ~10x faster than local models
- ✅ **No GPU needed** - Works on any Mac
- ✅ **No disk space** - Models run in the cloud

### Setup Groq

1. Go to **https://console.groq.com**
2. Sign up (free)
3. Create API key
4. Add to `.env` file:

```bash
echo 'GROQ_API_KEY=gsk_your_key_here' > .env
```

### Groq Models Available

| Model | Speed | Quality |
|-------|-------|---------|
| `llama-3.1-8b-instant` | ⚡ Fastest | Good |
| `llama-3.1-70b-versatile` | Fast | Best |
| `mixtral-8x7b-32768` | Fast | Great |

## 📦 All Commands

| Command | Description |
|---------|-------------|
| `make install` | Create shared venv in sgoinfre |
| `make sync` | Update dependencies |
| `make check-env` | Check environment variables |
| `make clean` | Remove shared venv |
| | |
| `make run-smolagents` | Run smolagents (local model) |
| `make run-llama_index` | Run llama_index (local model) |
| `make run-lang_graph` | Run lang_graph (local model) |
| | |
| `make run-smolagents-groq` | Run smolagents (Groq API) |
| `make run-llama_index-groq` | Run llama_index (Groq API) |
| `make run-lang_graph-groq` | Run lang_graph (Groq API) |

## 🤖 Local Models

Default: `Qwen/Qwen2.5-3B-Instruct`

| Model | Size | RAM |
|-------|------|-----|
| Qwen/Qwen2.5-0.5B-Instruct | ~1GB | 4GB |
| Qwen/Qwen2.5-3B-Instruct | ~6GB | 8GB |
| Qwen/Qwen2.5-7B-Instruct | ~14GB | 16GB |

Download models manually:
```bash
./setup_model.sh Qwen/Qwen2.5-3B-Instruct
```

## 📚 Framework Comparison

| Framework | Local Model | Groq Model | Best For |
|-----------|-------------|------------|----------|
| **smolagents** | `TransformersModel` | `LiteLLMModel` | Code agents, tools |
| **llama_index** | `HuggingFaceLLM` | `LiteLLM` | RAG, document QA |
| **lang_graph** | `HuggingFacePipeline` | `ChatGroq` | Stateful workflows |

## 🔧 Troubleshooting

### "GROQ_API_KEY is not set"
```bash
echo 'GROQ_API_KEY=gsk_your_key' > .env
```

### "HF_HUB_CACHE is not set"
The Makefile sets this automatically. If running scripts directly:
```bash
export HF_HUB_CACHE="/sgoinfre/goinfre/Perso/$USER/huggingface/hub"
export HF_HOME="/sgoinfre/goinfre/Perso/$USER/huggingface"
```

### Venv not found
```bash
make install
```

## 🔗 Resources

- [Groq Console](https://console.groq.com) - Get free API key
- [HuggingFace Models](https://huggingface.co/models)
- [Smolagents Docs](https://huggingface.co/docs/smolagents)
- [LlamaIndex Docs](https://docs.llamaindex.ai)
- [LangGraph Docs](https://langchain-ai.github.io/langgraph/)
