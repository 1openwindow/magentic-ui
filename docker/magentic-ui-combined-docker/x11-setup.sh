#!/bin/bash

# Exit on any error
set -e

echo "Starting X11 setup..."

# Set display
export DISPLAY=:99

# Wait for X server to be ready
echo "Waiting for X server to start..."
timeout=30
while [ $timeout -gt 0 ]; do
    if xdpyinfo -display :99 >/dev/null 2>&1; then
        echo "X server is ready"
        break
    fi
    sleep 1
    timeout=$((timeout - 1))
done

if [ $timeout -eq 0 ]; then
    echo "X server failed to start within 30 seconds"
    exit 1
fi

# Set up X11 authentication
echo "Setting up X11 authentication..."
xhost +local:root > /dev/null 2>&1 || true

# Configure display settings
echo "Configuring display settings..."
xrandr --output default --mode 1440x1440 > /dev/null 2>&1 || true

# Set window manager properties
echo "Setting window manager properties..."
xsetroot -solid grey > /dev/null 2>&1 || true

echo "X11 setup completed successfully"
