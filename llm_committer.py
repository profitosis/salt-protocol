import os
import subprocess
import requests
from pathlib import Path

# Configuration
REPO_DIR = Path(__file__).parent.absolute()
INDEX_FILE = REPO_DIR / "index.html"
LLM_API = "http://localhost:1234/v1/completions"  # Default local LLM endpoint

def get_llm_edit(content: str, instruction: str) -> str:
    """Get edited content from LLM based on instruction."""
    try:
        payload = {
            "model": "gpt-neo",
            "prompt": f"Here is an HTML file:\n\n{content}\n\nInstruction: {instruction}\n\nReturn the full updated HTML:",
            "max_tokens": 1500,
            "temperature": 0.7,
        }
        response = requests.post(LLM_API, json=payload, timeout=30)
        response.raise_for_status()
        return response.json()["choices"][0]["text"]
    except Exception as e:
        print(f"Error getting LLM edit: {e}")
        return content

def update_index(instruction: str = "Update the content") -> bool:
    """Update index.html based on instruction and push changes."""
    try:
        # Read current content
        if not INDEX_FILE.exists():
            INDEX_FILE.write_text("<html><body><h1>Welcome</h1></body></html>")
            
        with open(INDEX_FILE, "r") as f:
            old_content = f.read()

        # Get updated content from LLM
        new_content = get_llm_edit(old_content, instruction)
        
        # Write changes
        with open(INDEX_FILE, "w") as f:
            f.write(new_content)

        # Git operations
        subprocess.run(["git", "add", "index.html"], cwd=REPO_DIR, check=True)
        subprocess.run(
            ["git", "commit", "-m", f"LLM edit: {instruction[:50]}"],
            cwd=REPO_DIR,
            check=True
        )
        subprocess.run(["git", "push"], cwd=REPO_DIR, check=True)
        
        print("✅ Successfully updated and pushed changes")
        return True
        
    except subprocess.CalledProcessError as e:
        print(f"❌ Git operation failed: {e}")
        return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Update index.html using LLM and push changes")
    parser.add_argument("instruction", nargs="?", 
                      default="Improve the design and content",
                      help="Instruction for the LLM")
    args = parser.parse_args()
    
    update_index(args.instruction)
