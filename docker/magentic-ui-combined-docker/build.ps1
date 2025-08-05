# PowerShell build script for magentic-ui combined Docker image
# This creates a slim Ubuntu container with VS Code, IntelliJ, and Playwright for UI testing

# Configuration
$IMAGE_NAME = "magentic-ui-combined"
$TAG = "0.0.1"
$DOCKERFILE_PATH = "."

Write-Host "Building magentic-ui combined Docker image..." -ForegroundColor Green
Write-Host "Image: ${IMAGE_NAME}:${TAG}"
Write-Host "Context: ${DOCKERFILE_PATH}"
Write-Host "================================"

try {
    # Build the Docker image
    docker build `
        --tag "${IMAGE_NAME}:${TAG}" `
        --file "${DOCKERFILE_PATH}/Dockerfile" `
        "${DOCKERFILE_PATH}"

    Write-Host "================================" -ForegroundColor Green
    Write-Host "Build completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "To run the container:" -ForegroundColor Yellow
    Write-Host "  docker run -d -p 5900:5900 -p 6080:6080 -p 8080:8080 --name magentic-ui-test ${IMAGE_NAME}:${TAG}" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Access methods:" -ForegroundColor Yellow
    Write-Host "  - VNC: localhost:5900" -ForegroundColor Cyan
    Write-Host "  - Web VNC: http://localhost:6080" -ForegroundColor Cyan
    Write-Host "  - Applications will start automatically" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To test the environment:" -ForegroundColor Yellow
    Write-Host "  docker exec -it magentic-ui-test python3 /workspace/test-setup.py" -ForegroundColor Cyan
}
catch {
    Write-Host "Build failed: $_" -ForegroundColor Red
    exit 1
}
