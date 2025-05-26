# Dockerfile
FROM python:3.9-slim

# Step 1: Install system dependencies (including Chromium + Chromedriver)
RUN apt-get update -y && \
    apt-get install -y \
        wget \
        curl \
        unzip \
        ffmpeg \
        chromium \
        chromium-driver && \
    rm -rf /var/lib/apt/lists/*

# Step 2: Install Python dependencies
RUN pip install --no-cache-dir \
        selenium

# Set environment variables for Selenium
ENV CHROME_BIN=/usr/bin/chromium \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Create working directory (optional, not directly used by script)
WORKDIR /app

# Define volumes for external mapping
VOLUME /config
VOLUME /data

CMD ["python", "/config/script.py"]
