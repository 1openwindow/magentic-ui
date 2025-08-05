#!/bin/bash

echo "Starting VS Code Docker container..."
echo "Setting up environment..."

# Start supervisord which will start all services
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
