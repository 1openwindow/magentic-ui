# Magentic UI Combined Docker Container

This Docker container provides a complete UI testing environment with VS Code, IntelliJ IDEA, and Playwright browser support in a slim Ubuntu 22.04 base image.

## Features

- **Ubuntu 22.04 LTS** - Slim base image
- **VS Code** - Latest stable version with UI testing extensions
- **IntelliJ IDEA Community Edition** - Latest version with Java 17 support
- **Playwright** - Latest version with Chromium browser
- **Google Chrome** - Stable version for web testing
- **VNC Access** - Remote desktop access via VNC and web interface
- **X11 Support** - Full GUI application support

## Quick Start

### Build the Container

```bash
# Using bash (Linux/Mac/WSL)
./build.sh

# Using PowerShell (Windows)
.\build.ps1
```

### Run the Container

```bash
docker run -d \
  -p 5900:5900 \
  -p 6080:6080 \
  -p 8080:8080 \
  --name magentic-ui-test \
  magentic-ui-combined:latest
```

### Access the Environment

1. **Web VNC** (Recommended): Open http://localhost:6080 in your browser
2. **VNC Client**: Connect to localhost:5900
3. **Direct Shell**: `docker exec -it magentic-ui-test bash`

## Applications

### VS Code
- Starts automatically on container launch
- Pre-installed extensions for UI testing:
  - Playwright Test for VS Code
  - Python
  - Test Adapter Converter
- Access via GUI or command line: `code`

### IntelliJ IDEA
- Available via command: `intellij`
- Java 17 pre-configured
- Suitable for Java-based UI testing projects

### Playwright
- Pre-installed with Chromium browser
- Python bindings available
- Command line: `playwright`

### Google Chrome
- Stable version installed
- Available as: `/usr/bin/google-chrome`
- Chrome wrapper: `/usr/local/bin/chrome-wrapper`

## Testing the Environment

Run the built-in environment test:

```bash
docker exec -it magentic-ui-test python3 /workspace/test-setup.py
```

This will verify all components are properly installed and functional.

## Volume Mounting

Mount your test projects to work on them:

```bash
docker run -d \
  -p 5900:5900 \
  -p 6080:6080 \
  -p 8080:8080 \
  -v /path/to/your/project:/workspace/project \
  --name magentic-ui-test \
  magentic-ui-combined:latest
```

## Environment Variables

- `DISPLAY=:99` - X11 display
- `HOME=/root` - User home directory
- `JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64` - Java installation

## Ports

- `5900` - VNC server
- `6080` - NoVNC web interface
- `8080` - Available for your applications

## Troubleshooting

### Applications not appearing in VNC
- Wait 10-15 seconds after container start for all services to initialize
- Check supervisor status: `docker exec -it magentic-ui-test supervisorctl status`

### VS Code not starting
- Restart VS Code service: `docker exec -it magentic-ui-test supervisorctl restart vscode`

### IntelliJ startup issues
- Start manually: `docker exec -it magentic-ui-test intellij`
- Check Java installation: `docker exec -it magentic-ui-test java -version`

### Playwright tests failing
- Verify browser installation: `docker exec -it magentic-ui-test playwright install --dry-run`
- Check display: `docker exec -it magentic-ui-test echo $DISPLAY`

## Development

The container is designed for UI testing workflows and includes:
- Python 3 with pip
- Node.js with npm
- Git with basic configuration
- All necessary GUI libraries

## Image Size Optimization

This image is optimized for size by:
- Using Ubuntu 22.04 as base (smaller than desktop variants)
- Installing packages in single layers
- Cleaning apt cache after installations
- Using specific application versions to avoid unnecessary dependencies

## Security Notes

- Container runs as root (required for X11 and VNC)
- No authentication on VNC (suitable for development/testing only)
- Chrome runs with `--no-sandbox` for container compatibility

For production use, consider implementing proper authentication and user management.
