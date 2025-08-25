import os
import subprocess
import sys
from pathlib import Path

def test_llm_committer():
    """Test the LLM committer with a sample instruction."""
    test_instruction = "Add a welcome message with a modern, clean design"
    
    print("🚀 Testing LLM Committer...")
    print(f"Instruction: {test_instruction}")
    
    # Run the LLM committer
    result = subprocess.run(
        [sys.executable, "llm_committer.py", test_instruction],
        capture_output=True,
        text=True
    )
    
    # Print results
    print("\n=== Test Results ===")
    print(f"Exit Code: {result.returncode}")
    print("\nOutput:")
    print(result.stdout)
    
    if result.returncode != 0:
        print("\nError:")
        print(result.stderr)
        return False
    
    # Verify the file was updated
    if not Path("index.html").exists():
        print("❌ index.html was not created")
        return False
    
    print("\n✅ Test completed successfully")
    print("Check the changes in index.html and commit them if they look good")
    return True

if __name__ == "__main__":
    test_llm_committer()
