"""
Smolagents - Groq API Example
=============================
Uses LiteLLMModel with Groq's fast inference API.

Requires: GROQ_API_KEY environment variable
Get your key at: https://console.groq.com
"""

import os

# Check required environment variable
if not os.environ.get("GROQ_API_KEY"):
    raise EnvironmentError("GROQ_API_KEY is not set. Get your key at: https://console.groq.com")

from smolagents import WebSearchTool, LiteLLMModel, CodeAgent

search_tool = WebSearchTool()

model = LiteLLMModel("groq/llama-3.1-8b-instant")

agent = CodeAgent(
    model=model,
    tools=[search_tool],
    max_steps=3
)

response = agent.run(
    """
    I need to prepare for the party. Here are the tasks:
    1. Prepare the drinks - 30 minutes
    2. Decorate the mansion - 60 minutes
    3. Set up the menu - 45 minutes
    4. Prepare the music and playlist - 45 minutes

    If we start right now, at what time will the party be ready?
    """
)
print(response)

