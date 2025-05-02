FROM python:3.11-slim

# Install Git & Pip
RUN apt-get update && \
    apt-get install -y git curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# Arbeitsverzeichnis
WORKDIR /app

# MCP-Server klonen
RUN git clone https://github.com/team-telnyx/telnyx-mcp-server.git .

# Installiere Abhängigkeiten + MCP-Server
RUN /root/.local/bin/uv pip install -e . --system

# Environment-Variablen
ENV TELNYX_API_KEY=""
ENV PYTHONUNBUFFERED=1

# Expose Port
EXPOSE 8080

# Start: direkt HTTP-Server starten (ohne CLI)
CMD ["python", "src/telnyx_mcp_server/http_server.py", "--host", "0.0.0.0", "--port", "8080"]
