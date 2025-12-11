#!/bin/bash

# ===========================================
# HuggingFace Model Setup Script
# ===========================================
# Downloads models to sgoinfre (42 shared storage)
# Usage: ./setup_model.sh [MODEL_ID]
#
# Examples:
#   ./setup_model.sh                           # Downloads default model
#   ./setup_model.sh Qwen/Qwen2.5-3B-Instruct  # Downloads specific model
# ===========================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ===========================================
# Configuration
# ===========================================

# Default cache directory - uses sgoinfre for 42 students
# Can be overridden by setting HF_HUB_CACHE env var
DEFAULT_CACHE_DIR="/sgoinfre/$USER/huggingface/hub"
HF_HUB_CACHE="${HF_HUB_CACHE:-$DEFAULT_CACHE_DIR}"
HF_HOME="${HF_HOME:-/sgoinfre/$USER/huggingface}"

# Default model (can be passed as argument)
DEFAULT_MODEL="Qwen/Qwen2.5-0.5B-Instruct"
MODEL_ID="${1:-$DEFAULT_MODEL}"

# Export for child processes
export HF_HUB_CACHE
export HF_HOME

# ===========================================
# Functions
# ===========================================

print_header() {
    echo ""
    echo -e "${BLUE}==========================================${NC}"
    echo -e "${BLUE}  HuggingFace Model Setup Script${NC}"
    echo -e "${BLUE}==========================================${NC}"
    echo ""
}

print_config() {
    echo -e "${YELLOW}Configuration:${NC}"
    echo -e "  Cache directory: ${GREEN}$HF_HUB_CACHE${NC}"
    echo -e "  Model:           ${GREEN}$MODEL_ID${NC}"
    echo ""
}

check_dependencies() {
    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    # Check Python
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}✗ Python3 not found. Please install Python 3.10+${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ Python3 found${NC}"
    
    # Check if huggingface_hub is installed
    if python3 -c "import huggingface_hub" 2>/dev/null; then
        echo -e "${GREEN}✓ huggingface_hub installed${NC}"
    else
        echo -e "${YELLOW}! huggingface_hub not found, will install...${NC}"
        pip3 install huggingface_hub --quiet
        echo -e "${GREEN}✓ huggingface_hub installed${NC}"
    fi
    echo ""
}

setup_cache_dir() {
    echo -e "${YELLOW}Setting up cache directory...${NC}"
    mkdir -p "$HF_HUB_CACHE"
    echo -e "${GREEN}✓ Cache directory ready: $HF_HUB_CACHE${NC}"
    echo ""
}

download_model() {
    echo -e "${YELLOW}Downloading model: $MODEL_ID${NC}"
    echo "This may take a few minutes depending on your connection..."
    echo ""
    
    # Use huggingface-cli if available, otherwise Python
    if command -v huggingface-cli &> /dev/null; then
        huggingface-cli download "$MODEL_ID" --cache-dir "$HF_HUB_CACHE"
    else
        python3 << EOF
from huggingface_hub import snapshot_download
import os

os.environ['HF_HUB_CACHE'] = '$HF_HUB_CACHE'

print(f"Downloading to: $HF_HUB_CACHE")
snapshot_download(
    repo_id='$MODEL_ID',
    cache_dir='$HF_HUB_CACHE'
)
print('Download complete!')
EOF
    fi
    
    echo ""
    echo -e "${GREEN}✓ Model downloaded successfully!${NC}"
}

print_summary() {
    echo ""
    echo -e "${BLUE}==========================================${NC}"
    echo -e "${GREEN}  Setup Complete!${NC}"
    echo -e "${BLUE}==========================================${NC}"
    echo ""
    echo -e "${YELLOW}To use this cache in your scripts, set these environment variables:${NC}"
    echo ""
    echo -e "  ${GREEN}export HF_HUB_CACHE=\"$HF_HUB_CACHE\"${NC}"
    echo -e "  ${GREEN}export HF_HOME=\"$HF_HOME\"${NC}"
    echo ""
    echo -e "${YELLOW}Or add them to your shell profile (~/.zshrc or ~/.bashrc):${NC}"
    echo ""
    echo "  echo 'export HF_HUB_CACHE=\"$HF_HUB_CACHE\"' >> ~/.zshrc"
    echo "  echo 'export HF_HOME=\"$HF_HOME\"' >> ~/.zshrc"
    echo ""
    echo -e "${YELLOW}Available models in cache:${NC}"
    ls -1 "$HF_HUB_CACHE" 2>/dev/null | grep "^models--" | sed 's/models--/  - /' | sed 's/--/\//g' || echo "  (none found)"
    echo ""
}

# ===========================================
# Main
# ===========================================

print_header
print_config
check_dependencies
setup_cache_dir
download_model
print_summary

