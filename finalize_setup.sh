#!/bin/bash

# Final setup script for Salt Protocol Auto-Deploy

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Finalizing Salt Protocol Auto-Deploy Setup${NC}"

# Make scripts executable
echo -e "\n${GREEN}Making scripts executable...${NC}"
chmod +x setup.sh setup_github.sh
chmod +x llm_committer.py test_llm_committer.py

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

# Create .env from .env.example if it doesn't exist
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    echo -e "\n${GREEN}Creating .env file from example...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓ Created .env file${NC}"
    echo -e "${YELLOW}ℹ️ Please update the .env file with your configuration${NC}"
else
    echo -e "${YELLOW}✓ .env file already exists${NC}"
fi

# Install Python dependencies
echo -e "\n${GREEN}Installing Python dependencies...${NC}"
pip install requests python-dotenv > /dev/null 2>&1

# Verify setup
echo -e "\n${GREEN}Verifying setup...${NC}"
if [ -f "llm_committer.py" ] && [ -f "index.html" ]; then
    echo -e "${GREEN}✓ Core files are in place${NC}"
else
    echo -e "${YELLOW}❌ Some core files are missing${NC}"
    exit 1
fi

echo -e "\n${GREEN}✅ Setup complete!${NC}"
echo -e "\nNext steps:"
echo "1. Update the .env file with your configuration"
echo "2. Run './setup_github.sh' to set up your GitHub repository"
echo "3. Set up GitHub Secrets in your repository settings"
echo "4. Test the setup with: python test_llm_committer.py"
echo "5. Make your first update: python llm_committer.py \"Your update instruction\""

echo -e "\n${YELLOW}For help, check the README.md file${NC}"
