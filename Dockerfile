# Dockerfile für Telnyx MCP Server (Coolify Deploy)

FROM python:3.11-slim

# Install uvx
RUN apt-get update && \
    apt-get install -y curl git && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    export PATH="$PATH:/root/.local/bin"

# Set Arbeitsverzeichnis
WORKDIR /app

# Repository klonen
RUN git clone https://github.com/team-telnyx/telnyx-mcp-server.git /app

# Setze API-Key als Umgebungsvariable (wird in Coolify übergeben)
ENV TELNYX_API_KEY=""

# Installiere MCP-Server mit uvx
RUN /root/.local/bin/uv pip install -e /app --system

# Exponiere den Port
EXPOSE 8080

# Startkommando
CMD ["/root/.local/bin/uvx", "--from", "/app", "telnyx-mcp-server"]
