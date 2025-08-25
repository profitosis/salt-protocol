#!/bin/bash

# Setup script for Salt Protocol Auto-Deploy

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Setting up Salt Protocol Auto-Deploy${NC}"

# Check for Python
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}❌ Python 3 is required but not installed. Please install it and try again.${NC}"
    exit 1
fi

# Install Python dependencies
echo -e "\n${GREEN}Installing Python dependencies...${NC}"
pip install requests python-dotenv

# Initialize Git if not already
echo -e "\n${GREEN}Initializing Git repository...${NC}"
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit: Set up auto-deploy system"
    echo -e "${GREEN}✓ Git repository initialized${NC}"
else
    echo -e "${YELLOW}✓ Git repository already exists${NC}"
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo -e "\n${GREEN}Creating .env file...${NC}"
    cat > .env <<EOL
# LLM Configuration
LLM_API=http://localhost:1234/v1/completions

# Deployment Configuration
# NETLIFY_AUTH_TOKEN=your_netlify_token_here
# NETLIFY_SITE_ID=your_site_id_here
# HF_TOKEN=your_huggingface_token_here
EOL
    echo -e "${GREEN}✓ Created .env file${NC}"
    echo -e "${YELLOW}ℹ️ Please update the .env file with your configuration${NC}"
else
    echo -e "${YELLOW}✓ .env file already exists${NC}"
fi

# Make scripts executable
chmod +x llm_committer.py test_llm_committer.py

echo -e "\n${GREEN}✅ Setup complete!${NC}"
echo -e "\nNext steps:"
echo "1. Update the .env file with your configuration"
echo "2. Test the setup with: python test_llm_committer.py"
echo "3. Push to your GitHub repository to trigger deployment"
