FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies in a single layer
RUN apt-get update && apt-get install -y \
    # Core utilities
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    procps \
    unzip \
    # X11 and display
    xvfb \
    x11vnc \
    openbox \
    x11-xserver-utils \
    xdg-utils \
    # Audio and GUI libraries
    libasound2 \
    libgtk-3-0 \
    libxss1 \
    libgconf-2-4 \
    libxtst6 \
    libxrandr2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libcairo-gobject2 \
    libgdk-pixbuf2.0-0 \
    fontconfig \
    # Development tools
    python3 \
    python3-pip \
    python3-xdg \
    openjdk-17-jdk \
    # Process management
    supervisor \
    websockify \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x (required for Playwright)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC (same way as working version)
RUN git clone --depth 1 --branch v1.6.0 https://github.com/novnc/noVNC.git /usr/local/novnc \
    && git clone --depth 1 --branch v0.13.0 https://github.com/novnc/websockify /usr/local/novnc/utils/websockify

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV DISPLAY=:99
ENV HOME=/root

# Install Google Chrome for Playwright
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list \
    && apt-get update \
    && apt-get install -y code \
    && rm -rf /var/lib/apt/lists/*

# Install IntelliJ IDEA Community Edition
RUN wget -O /tmp/ideaIC.tar.gz "https://download.jetbrains.com/idea/ideaIC-2024.2.4.tar.gz" \
    && tar -xzf /tmp/ideaIC.tar.gz -C /opt/ \
    && mv /opt/idea-IC-* /opt/intellij \
    && ln -s /opt/intellij/bin/idea.sh /usr/local/bin/intellij \
    && rm /tmp/ideaIC.tar.gz

# Install Playwright
RUN npm install -g playwright@latest \
    && playwright install chromium \
    && playwright install-deps

# Create chrome wrapper for better compatibility
RUN echo '#!/bin/bash\nexec /usr/bin/google-chrome --no-sandbox --disable-dev-shm-usage --disable-gpu "$@"' > /usr/local/bin/chrome-wrapper \
    && chmod +x /usr/local/bin/chrome-wrapper

# Setup X11 configuration script
COPY x11-setup.sh /usr/local/bin/x11-setup.sh
RUN chmod +x /usr/local/bin/x11-setup.sh

# Setup Openbox configuration
COPY openbox-rc.xml /etc/xdg/openbox/rc.xml

# Setup supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose ports
EXPOSE 5900 6080 8080

# Set working directory
WORKDIR /workspace

# Start supervisor
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
