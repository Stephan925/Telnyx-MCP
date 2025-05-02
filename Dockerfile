FROM python:3.11-slim

# Install git & uv (optional)
RUN apt-get update && \
    apt-get install -y curl git && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# Set Arbeitsverzeichnis
WORKDIR /app

# Clone Telnyx MCP Server direkt
RUN git clone https://github.com/team-telnyx/telnyx-mcp-server.git .

# Installiere Abhängigkeiten manuell
RUN /root/.local/bin/uv pip install -r requirements.txt --system

# Setze Umgebungsvariable (wird in Coolify überschrieben)
ENV TELNYX_API_KEY=""

# Exponiere den Port
EXPOSE 8080

# Starte direkt das Modul mit HTTP
CMD ["python", "-m", "telnyx_mcp_server.server", "--transport", "http", "--host", "0.0.0.0", "--port", "8080"]
