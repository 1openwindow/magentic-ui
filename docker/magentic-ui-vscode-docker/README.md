# Magentic UI VS Code Docker

A containerized VS Code environment with web-based access through noVNC. This Docker image provides a full VS Code development environment that can be accessed through any web browser.

## Features

- 🖥️ **Web-based VS Code**: Access VS Code through your browser via noVNC
- 🔧 **Full Extension Support**: Install and use VS Code extensions
- 📁 **File System Access**: Mount local directories or work with container storage
- 🎯 **Optimized Display**: 1440x1440 resolution with proper scaling
- 🐳 **Container Ready**: Runs reliably in Docker with all dependencies included

## Quick Start

### Build the Image

```bash
# Navigate to the VS Code docker directory
cd docker/magentic-ui-vscode-docker

# Build the image
./build.sh

# Or use PowerShell on Windows
.\build.ps1
```

### Run the Container

#### Basic Usage (Empty Workspace)
```bash
docker run -d -p 6080:6080 --name magentic-vscode ghcr.io/microsoft/magentic-ui-vscode:latest
```

#### With Local Directory Mount
```bash
# Mount your project directory
docker run -d -p 6080:6080 \
  -v "/path/to/your/project:/workspace" \
  --name magentic-vscode \
  ghcr.io/microsoft/magentic-ui-vscode:latest
```

#### Windows PowerShell Example
```powershell
# Mount Windows directory
docker run -d -p 6080:6080 `
  -v "C:\Users\YourName\Projects:/workspace" `
  --name magentic-vscode `
  ghcr.io/microsoft/magentic-ui-vscode:latest
```

### Access VS Code

1. Open your web browser
2. Navigate to: `http://localhost:6080/vnc.html`
3. Click "Connect" 
4. VS Code will be running in fullscreen mode

## Container Management

### Check Container Status
```bash
docker ps
```

### View Logs
```bash
docker logs magentic-vscode
```

### Stop Container
```bash
docker stop magentic-vscode
```

### Start Existing Container
```bash
docker start magentic-vscode
```

### Remove Container
```bash
docker rm magentic-vscode
```

## Configuration

### Environment Variables

The container supports these environment variables:

- `DISPLAY` - X11 display (default: `:99`)
- `HOME` - User home directory (default: `/root`)
- `DONT_PROMPT_WSL_INSTALL` - Disable WSL prompts (default: `1`)

### Ports

- **6080** - noVNC web interface

### Volume Mounts

- `/workspace` - Default working directory for projects
- `/root/.vscode-server` - VS Code user data and extensions

## Advanced Usage

### Run with Custom Configuration
```bash
docker run -d -p 6080:6080 \
  -v "/path/to/project:/workspace" \
  -v "vscode-data:/root/.vscode-server" \
  -e "CUSTOM_VAR=value" \
  --name magentic-vscode \
  ghcr.io/microsoft/magentic-ui-vscode:latest
```

### Multiple VS Code Instances
```bash
# First instance on port 6080
docker run -d -p 6080:6080 --name vscode-1 ghcr.io/microsoft/magentic-ui-vscode:latest

# Second instance on port 6081
docker run -d -p 6081:6080 --name vscode-2 ghcr.io/microsoft/magentic-ui-vscode:latest
```

### Interactive Debugging
```bash
# Run interactively for troubleshooting
docker run -it -p 6080:6080 --name vscode-debug ghcr.io/microsoft/magentic-ui-vscode:latest bash
```

## Troubleshooting

### VS Code Won't Start
```bash
# Check logs for errors
docker logs magentic-vscode

# Try interactive mode
docker exec -it magentic-vscode bash
```

### Display Issues
The container is configured for 1440x1440 resolution. If you experience scaling issues:
- Try refreshing the browser
- Check your browser zoom level
- Verify the container logs for X11 setup messages

### Performance Optimization
```bash
# Allocate more memory to the container
docker run -d -p 6080:6080 -m 4g --name magentic-vscode ghcr.io/microsoft/magentic-ui-vscode:latest

# Use tmpfs for better performance
docker run -d -p 6080:6080 --tmpfs /tmp --name magentic-vscode ghcr.io/microsoft/magentic-ui-vscode:latest
```

### Customization
You can customize the container by:
- Modifying the `Dockerfile` to add additional tools
- Updating `supervisord.conf` to change service configuration
- Editing `x11-setup.sh` for display customization
- Modifying `openbox-rc.xml` for window management behavior

## Related Containers

This VS Code container is part of the Magentic UI Docker suite:
- [`magentic-ui-browser-docker`](../magentic-ui-browser-docker/) - Browser automation with Playwright
- [`magentic-ui-python-env`](../magentic-ui-python-env/) - Python development environment

## License

MIT License - see the main repository for details.