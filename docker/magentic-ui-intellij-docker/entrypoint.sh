#!/bin/bash

echo "Entrypoint: Starting Magentic UI IntelliJ IDEA container..."

# Ensure the workspace directory exists
mkdir -p /workspace

# Set proper permissions
chmod 755 /workspace

echo "Workspace directory set up at /workspace"
echo "Starting services..."

exec "$@"
