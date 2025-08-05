#!/bin/bash

# Exit on any error
set -e

echo "Starting magentic-ui combined container..."

# Create necessary directories
mkdir -p /root/.vscode-server
mkdir -p /root/.config
mkdir -p /workspace
mkdir -p /var/log

# Set proper permissions
chmod 755 /root/.vscode-server
chmod 755 /root/.config
chmod 755 /workspace

# Configure git (if not already configured)
if [ ! -f /root/.gitconfig ]; then
    git config --global user.name "Container User"
    git config --global user.email "user@container.local"
    git config --global init.defaultBranch main
fi

# Setup Python environment
echo "Setting up Python environment..."
pip3 install --upgrade pip
pip3 install playwright pytest selenium

# Install VS Code extensions for UI testing
echo "Installing VS Code extensions..."
code --install-extension ms-playwright.playwright --force > /dev/null 2>&1 || true
code --install-extension ms-python.python --force > /dev/null 2>&1 || true
code --install-extension ms-vscode.test-adapter-converter --force > /dev/null 2>&1 || true

# Setup Playwright browsers
echo "Setting up Playwright browsers..."
playwright install chromium --with-deps > /dev/null 2>&1 || true

# Create a simple test script
cat > /workspace/test-setup.py << 'EOF'
#!/usr/bin/env python3
"""
Simple test to verify the UI testing environment is working
"""
import subprocess
import sys

def test_chrome():
    """Test Chrome installation"""
    try:
        result = subprocess.run(['/usr/bin/google-chrome', '--version'], 
                              capture_output=True, text=True, timeout=10)
        print(f"✓ Chrome: {result.stdout.strip()}")
        return True
    except Exception as e:
        print(f"✗ Chrome test failed: {e}")
        return False

def test_playwright():
    """Test Playwright installation"""
    try:
        result = subprocess.run(['playwright', '--version'], 
                              capture_output=True, text=True, timeout=10)
        print(f"✓ Playwright: {result.stdout.strip()}")
        return True
    except Exception as e:
        print(f"✗ Playwright test failed: {e}")
        return False

def test_vscode():
    """Test VS Code installation"""
    try:
        result = subprocess.run(['code', '--version'], 
                              capture_output=True, text=True, timeout=10)
        version_lines = result.stdout.strip().split('\n')
        print(f"✓ VS Code: {version_lines[0] if version_lines else 'Unknown version'}")
        return True
    except Exception as e:
        print(f"✗ VS Code test failed: {e}")
        return False

def test_intellij():
    """Test IntelliJ installation"""
    try:
        if subprocess.run(['test', '-f', '/opt/intellij/bin/idea.sh'], 
                         capture_output=True).returncode == 0:
            print("✓ IntelliJ: Installation found")
            return True
        else:
            print("✗ IntelliJ: Installation not found")
            return False
    except Exception as e:
        print(f"✗ IntelliJ test failed: {e}")
        return False

if __name__ == "__main__":
    print("Testing UI environment setup...")
    print("=" * 40)
    
    tests = [test_chrome, test_playwright, test_vscode, test_intellij]
    results = [test() for test in tests]
    
    print("=" * 40)
    if all(results):
        print("✓ All tests passed! Environment is ready for UI testing.")
        sys.exit(0)
    else:
        print("✗ Some tests failed. Check the output above.")
        sys.exit(1)
EOF

chmod +x /workspace/test-setup.py

echo "Container initialization completed successfully!"
echo "Access methods:"
echo "  - VNC: localhost:5900"
echo "  - Web VNC: localhost:6080"
echo "  - VS Code will start automatically"
echo "  - IntelliJ available via: intellij command"
echo "  - Test environment: python3 /workspace/test-setup.py"

# Execute the provided command
exec "$@"
