FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    xvfb \
    x11vnc \
    openbox \
    supervisor \
    python3 \
    python3-pip \
    nodejs \
    npm \
    novnc \
    websockify \
    procps \
    xdg-utils \
    python3-xdg \
    x11-xserver-utils \
    libasound2 \
    libgtk-3-0 \
    libxss1 \
    libgconf-2-4 \
    libxtst6 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcairo-gobject2 \
    libgtk-3-0 \
    libgdk-pixbuf2.0-0 \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN git clone --depth 1 --branch v1.6.0 https://github.com/novnc/noVNC.git /usr/local/novnc \
    && git clone --depth 1 --branch v0.13.0 https://github.com/novnc/websockify /usr/local/novnc/utils/websockify

# Set up working directory
WORKDIR /app

# Set up supervisord configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy scripts
COPY start.sh /app/start.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY x11-setup.sh /usr/local/bin/x11-setup.sh
COPY openbox-rc.xml /etc/xdg/openbox/rc.xml

# Make scripts executable
RUN chmod +x /app/start.sh /usr/local/bin/entrypoint.sh /usr/local/bin/x11-setup.sh

# Create VS Code user data directory and workspace
RUN mkdir -p /root/.vscode-server /workspace

# Expose ports: noVNC web interface
EXPOSE 6080

# Set the display environment variable
ENV DISPLAY=:99

WORKDIR /workspace

LABEL org.opencontainers.image.source=https://github.com/microsoft/magentic-ui
LABEL org.opencontainers.image.description="Magentic UI VS Code Docker container with noVNC"
LABEL org.opencontainers.image.licenses=MIT

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/app/start.sh"]
