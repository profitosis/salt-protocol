# Salt Protocol - Auto-Deploy System

[![Netlify Status](https://api.netlify.com/api/v1/badges/YOUR_DEPLOY_ID/deploy-status)](https://app.netlify.com/sites/YOUR_SITE_NAME/deploys)

An automated deployment system for the Salt Protocol frontend, featuring LLM-powered content updates and seamless deployment to Netlify and Hugging Face Spaces.

## ✨ Features

- 🤖 **AI-Powered Updates**: Automatically update content using LLM instructions
- 🚀 **Zero-Config Deployment**: Deploy to Netlify and Hugging Face with a single push
- 🔄 **Continuous Integration**: GitHub Actions workflow for automated deployments
- 📱 **Responsive Design**: Single HTML file that works on all devices
- 🔒 **Secure**: No API keys required for basic functionality

## 🚀 Quick Start

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/salt-protocol.git
   cd salt-protocol
   ```

2. **Run the setup script**

   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Configure your environment**

   - Edit `.env` with your configuration
   - Set up GitHub Secrets for deployment (see below)

4. **Make your first update**

   ```bash
   python llm_committer.py "Add a modern hero section with a call-to-action button"
   ```

## 🛠 Configuration

### Environment Variables

Create a `.env` file with the following variables:

```env
# Required for LLM integration
LLM_API=http://localhost:1234/v1/completions  # Your LLM API endpoint

# Required for Netlify deployment
NETLIFY_AUTH_TOKEN=your_netlify_token
NETLIFY_SITE_ID=your_site_id

# Required for Hugging Face Spaces
HF_TOKEN=your_huggingface_token
```

### GitHub Secrets

Set up the following secrets in your GitHub repository settings:

1. `NETLIFY_AUTH_TOKEN`: Your Netlify API token
2. `NETLIFY_SITE_ID`: Your Netlify site ID
3. `HF_TOKEN`: Your Hugging Face API token

## 🤖 Usage

### Update Content

```bash
python llm_committer.py "Your update instruction here"
```

### Test Changes

```bash
python test_llm_committer.py
```

### Manual Deployment

```bash
git add .
git commit -m "Your commit message"
git push origin main
```

## 🔄 Deployment Workflow

1. **Local Development**
   - Make changes using the LLM committer or manually
   - Test changes locally

2. **Version Control**
   - Commit and push changes to GitHub
   - GitHub Actions automatically triggers the deployment workflow

3. **Automated Deployment**
   - Builds the project
   - Deploys to Netlify
   - Updates Hugging Face Space

4. **Verification**
   - Check deployment status in GitHub Actions
   - Verify updates on both platforms

## 📦 Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions workflow
├── index.html               # Main HTML file
├── llm_committer.py         # LLM update script
├── test_llm_committer.py    # Test script
├── setup.sh                 # Setup script
├── .env.example            # Example environment variables
└── README.md               # This file
```

## 📝 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- Built with ❤️ for the Salt Protocol community
- Uses GitHub Actions for CI/CD
- Deploys to Netlify and Hugging Face Spaces
