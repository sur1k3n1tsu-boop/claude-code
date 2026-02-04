# ============================================
# Cloudbot/Moldbot Docker Image
# ============================================
# Multi-stage build for smaller final image

# Stage 1: Builder
FROM python:3.11-slim as builder

WORKDIR /build

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Create virtual environment and install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim as runtime

# Create non-root user
RUN groupadd -r cloudbot && useradd -r -g cloudbot cloudbot

WORKDIR /app

# Install runtime dependencies only
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY --chown=cloudbot:cloudbot . .

# Create necessary directories
RUN mkdir -p /app/data /app/logs /app/config && \
    chown -R cloudbot:cloudbot /app

# Switch to non-root user
USER cloudbot

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Expose web UI port
EXPOSE 3000

# Default command
CMD ["python", "-m", "cloudbot", "--config", "/app/config/config.yaml"]
