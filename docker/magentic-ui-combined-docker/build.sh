#!/bin/bash

# Build script for magentic-ui combined Docker image
# This creates a slim Ubuntu container with VS Code, IntelliJ, and Playwright for UI testing

set -e

# Configuration
IMAGE_NAME="magentic-ui-combined"
TAG="latest"
DOCKERFILE_PATH="."

echo "Building magentic-ui combined Docker image..."
echo "Image: ${IMAGE_NAME}:${TAG}"
echo "Context: ${DOCKERFILE_PATH}"
echo "================================"

# Build the Docker image
docker build \
    --tag "${IMAGE_NAME}:${TAG}" \
    --file "${DOCKERFILE_PATH}/Dockerfile" \
    "${DOCKERFILE_PATH}"

echo "================================"
echo "Build completed successfully!"
echo ""
echo "To run the container:"
echo "  docker run -d -p 5900:5900 -p 6080:6080 -p 8080:8080 --name magentic-ui-test ${IMAGE_NAME}:${TAG}"
echo ""
echo "Access methods:"
echo "  - VNC: localhost:5900"
echo "  - Web VNC: http://localhost:6080"
echo "  - Applications will start automatically"
echo ""
echo "To test the environment:"
echo "  docker exec -it magentic-ui-test python3 /workspace/test-setup.py"
