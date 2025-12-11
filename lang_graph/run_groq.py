"""
LangGraph - Groq API Example
============================
Uses Groq's fast inference API via ChatGroq.

Requires: GROQ_API_KEY environment variable
Get your key at: https://console.groq.com
"""

import os

# Check required environment variable
if not os.environ.get("GROQ_API_KEY"):
    raise EnvironmentError("GROQ_API_KEY is not set. Get your key at: https://console.groq.com")

from langchain_groq import ChatGroq

# ============================================
# Load Groq model
# ============================================
llm = ChatGroq(model="llama-3.1-8b-instant")

# ============================================
# Simple completion example
# ============================================
if __name__ == "__main__":
    print("="*50)
    print("LangGraph Groq API Demo")
    print("="*50)
    
    response = llm.invoke("What is the capital of France?")
    print("\nResponse:")
    print(response.content)

