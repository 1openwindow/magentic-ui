# PowerShell version of build script
$IMAGE_NAME = "magentic-ui-vscode"
$IMAGE_VERSION = "0.0.1"
$REGISTRY = "ghcr.io/microsoft"

# Check if --push flag is provided or PUSH environment variable is set
$PUSH_FLAG = ""
if (($args[0] -eq "--push") -or ($env:PUSH -eq "true")) {
    $PUSH_FLAG = "--push"
    Write-Host "Building and pushing images..."
} else {
    Write-Host "Building images locally..."
}

# Build the Docker image
# docker build `
#     -t "${REGISTRY}/${IMAGE_NAME}:latest" `
#     -t "${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}" `
#     .

# Push images if requested
# if (($args[0] -eq "--push") -or ($env:PUSH -eq "true")) {
#     Write-Host "Pushing images to registry..."
#     docker push "${REGISTRY}/${IMAGE_NAME}:latest"
#     docker push "${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}"
# }

docker build `
    -t "${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}" `
    .

if (($args[0] -eq "--push") -or ($env:PUSH -eq "true")) {
    Write-Host "Pushing images to registry..."
    docker push "${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}"
}
