FROM python:3.11-slim

# Install git & uv
RUN apt-get update && \
    apt-get install -y curl git && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# Arbeitsverzeichnis
WORKDIR /app

# Repo klonen
RUN git clone https://github.com/team-telnyx/telnyx-mcp-server.git .

# Projekt installieren
RUN /root/.local/bin/uv pip install -e . --system

# Umgebungsvariablen
ENV TELNYX_API_KEY=""
ENV MCP_TRANSPORT=http
ENV MCP_PORT=8080
ENV MCP_HOST=0.0.0.0

# Expose Port
EXPOSE 8080

# Start
CMD ["python", "-m", "telnyx_mcp_server.server"]
