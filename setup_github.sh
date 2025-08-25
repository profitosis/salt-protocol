#!/bin/bash

# Setup GitHub repository and configure remote

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 GitHub Repository Setup${NC}"

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}❌ Git is not installed. Please install Git and try again.${NC}"
    exit 1
fi

# Check if already a Git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}❌ Not a Git repository. Please run setup.sh first.${NC}"
    exit 1
fi

# Get repository URL
echo -e "\n${GREEN}Enter your GitHub repository URL (e.g., https://github.com/username/salt-protocol.git):${NC}"
read -r repo_url

if [ -z "$repo_url" ]; then
    echo -e "${YELLOW}❌ Repository URL cannot be empty.${NC}"
    exit 1
fi

# Configure remote
echo -e "\n${GREEN}Configuring Git remote...${NC}"
git remote add origin "$repo_url" 2> /dev/null || git remote set-url origin "$repo_url"

# Verify remote
if ! git remote -v | grep -q "origin"; then
    echo -e "${YELLOW}❌ Failed to set up remote repository.${NC}"
    exit 1
fi

# Push to GitHub
echo -e "\n${GREEN}Pushing to GitHub...${NC}"
git branch -M main
git push -u origin main

echo -e "\n${GREEN}✅ GitHub repository configured successfully!${NC}"
echo -e "\nNext steps:"
echo "1. Go to your GitHub repository settings"
echo "2. Set up GitHub Secrets for deployment"
echo "3. Your site will be deployed automatically on push"
