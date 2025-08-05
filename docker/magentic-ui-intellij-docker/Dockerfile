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
    fontconfig \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install OpenJDK 17 (required for recent IntelliJ versions)
RUN apt-get update && apt-get install -y openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Install IntelliJ IDEA Community Edition
RUN wget -O intellij.tar.gz "https://download.jetbrains.com/idea/ideaIC-2024.2.4.tar.gz" \
    && tar -xzf intellij.tar.gz -C /opt/ \
    && mv /opt/idea-IC-* /opt/intellij \
    && rm intellij.tar.gz \
    && ln -s /opt/intellij/bin/idea /usr/local/bin/idea

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

# Create IntelliJ config directory and workspace
RUN mkdir -p /root/.config/JetBrains /workspace

# Expose ports: noVNC web interface
EXPOSE 6080

# Set the display environment variable
ENV DISPLAY=:99

WORKDIR /workspace

LABEL org.opencontainers.image.source=https://github.com/microsoft/magentic-ui
LABEL org.opencontainers.image.description="Magentic UI IntelliJ IDEA Docker container with noVNC"
LABEL org.opencontainers.image.licenses=MIT

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/app/start.sh"]
