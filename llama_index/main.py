"""
LlamaIndex - Local Model Example
================================
Uses HuggingFaceLLM to run models locally without API calls.

Model: Qwen/Qwen2.5-3B-Instruct (or any HuggingFace model)
"""

import os

# Check required environment variables
if not os.environ.get("HF_HUB_CACHE"):
    raise EnvironmentError("HF_HUB_CACHE is not set. Run: export HF_HUB_CACHE='/path/to/cache'")
if not os.environ.get("HF_HOME"):
    raise EnvironmentError("HF_HOME is not set. Run: export HF_HOME='/path/to/cache'")

import torch
from llama_index.llms.huggingface import HuggingFaceLLM

# ============================================
# Load a local model (downloads if not cached)
# ============================================
llm = HuggingFaceLLM(
    model_name="Qwen/Qwen2.5-3B-Instruct",
    tokenizer_name="Qwen/Qwen2.5-3B-Instruct",
    device_map="auto",
    max_new_tokens=1024,
    model_kwargs={
        "dtype": torch.float16 if torch.cuda.is_available() else torch.float32,
    },
    generate_kwargs={
        "do_sample": True,
        "temperature": 0.7,
    },
)

# ============================================
# Simple completion example
# ============================================
if __name__ == "__main__":
    print("="*50)
    print("LlamaIndex Local Model Demo")
    print("="*50)
    
    response = llm.complete("What is the capital of France?")
    print("\nResponse:")
    print(response.text)

