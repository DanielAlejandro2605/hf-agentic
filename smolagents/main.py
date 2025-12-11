"""
Smolagents - Local Model Example
================================
Uses TransformersModel to run models locally without API calls.

Model: Qwen/Qwen2.5-3B-Instruct (or any HuggingFace model)
"""

import os

# Check required environment variables
if not os.environ.get("HF_HUB_CACHE"):
    raise EnvironmentError("HF_HUB_CACHE is not set. Run: export HF_HUB_CACHE='/path/to/cache'")
if not os.environ.get("HF_HOME"):
    raise EnvironmentError("HF_HOME is not set. Run: export HF_HOME='/path/to/cache'")

from smolagents import TransformersModel, CodeAgent

# ============================================
# Load a local model (downloads if not cached)
# ============================================
model = TransformersModel(
    model_id="Qwen/Qwen2.5-3B-Instruct",
    max_new_tokens=512,
    device_map="auto",
)

# ============================================
# Simple completion example
# ============================================
agent = CodeAgent(
    model=model,
    tools=[],  # Add tools as needed
    max_steps=3,
    add_base_tools=True,  # Adds basic tools like calculator
)

# ============================================
# Run the agent
# ============================================
if __name__ == "__main__":
    response = agent.run(
        """
        Calculate the total time needed for these tasks:
        1. Prepare drinks - 30 minutes
        2. Decorate - 60 minutes
        3. Set up menu - 45 minutes
        4. Prepare music - 45 minutes
        
        What's the total time in hours and minutes?
        """
    )
    print("\n" + "="*50)
    print("RESULT:")
    print("="*50)
    print(response)



