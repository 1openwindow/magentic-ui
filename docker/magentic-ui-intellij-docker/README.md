# Magentic UI IntelliJ IDEA Docker Container

This Docker container provides IntelliJ IDEA Community Edition running in a browser-accessible environment using noVNC.

## Features

- IntelliJ IDEA Community Edition 2024.2.4
- Java 17 JDK
- Web-based access via noVNC
- Python 3, Node.js, and npm pre-installed
- Shared workspace directory

## Building the Container

### Using the build script (Linux/macOS):
```bash
./build.sh
```

### Using the PowerShell script (Windows):
```powershell
./build.ps1
```

### Manual build:
```bash
docker build -t magentic-ui-intellij .
```

## Running the Container

```bash
docker run -d -p 6080:6080 --name magentic-ui-intellij  ghcr.io/microsoft/magentic-ui-intellij:0.0.1
```

## Accessing IntelliJ IDEA

1. Open your web browser
2. Navigate to `http://localhost:6080`
3. IntelliJ IDEA will be running in the browser window

## Environment Variables

- `DISPLAY=:99` - X11 display for the GUI
- `JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64` - Java home directory

## Ports

- `6080` - noVNC web interface

## Volume Mounts

- `/workspace` - Main workspace directory for your projects
- `/root/.config/JetBrains` - IntelliJ configuration directory

## Troubleshooting

### IntelliJ doesn't start
- Check that the container has enough memory allocated (minimum 2GB recommended)
- Wait a few moments after starting the container for all services to initialize

### Can't see the interface
- Ensure port 6080 is properly mapped and not blocked by firewall
- Try refreshing the browser page

### Performance issues
- Increase Docker resource limits
- Use local volumes instead of bind mounts when possible

## Development

To modify the container:

1. Make changes to the Dockerfile or scripts
2. Rebuild using `./build.sh` or `./build.ps1`
3. Test your changes locally before pushing

## License

This project follows the same license as the main Magentic UI project.
