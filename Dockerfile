FROM python:3.10-slim

WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY plex_mcp_server.py watcher.py ./
COPY modules/ ./modules/

# Environment variables that can be overridden at runtime
ENV PLEX_URL=""
ENV PLEX_TOKEN=""
ENV HOST="0.0.0.0"
ENV PORT="3001"
ENV TRANSPORT="sse"

# Expose the port the app will run on
EXPOSE 3001

# Run the application with SSE transport
CMD python plex_mcp_server.py --transport $TRANSPORT --host $HOST --port $PORT