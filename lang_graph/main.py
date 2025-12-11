"""
LangGraph - Local Model Example
===============================
Uses HuggingFacePipeline to run models locally without API calls.

Model: Qwen/Qwen2.5-3B-Instruct (or any HuggingFace model)
"""

import os

# Check required environment variables
if not os.environ.get("HF_HUB_CACHE"):
    raise EnvironmentError("HF_HUB_CACHE is not set. Run: export HF_HUB_CACHE='/path/to/cache'")
if not os.environ.get("HF_HOME"):
    raise EnvironmentError("HF_HOME is not set. Run: export HF_HOME='/path/to/cache'")

from langchain_huggingface import HuggingFacePipeline

# ============================================
# Load a local model (downloads if not cached)
# ============================================
llm = HuggingFacePipeline.from_model_id(
    model_id="Qwen/Qwen2.5-3B-Instruct",
    task="text-generation",
    device_map="auto",
    pipeline_kwargs={
        "max_new_tokens": 512,
        "do_sample": True,
        "temperature": 0.7,
    },
)

# ============================================
# Simple completion example
# ============================================
if __name__ == "__main__":
    print("="*50)
    print("LangGraph Local Model Demo")
    print("="*50)
    
    response = llm.invoke("What is the capital of France?")
    print("\nResponse:")
    print(response)

