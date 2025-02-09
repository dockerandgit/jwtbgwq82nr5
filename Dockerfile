FROM python:3.9-slim

# Step 1: Install system dependencies (if needed)
RUN apt-get update -y && \
    apt-get install -y \
    wget \
    curl \
    unzip \
    ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Step 2: Install Python dependencies
RUN pip install --no-cache-dir requests PyYAML

# Set environment variables
ENV CHROME_BIN=/usr/bin/chromium \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Create working directory
WORKDIR /app

# Define volume for external config mapping
VOLUME /config
VOLUME /data

# Run the script from the mapped config directory
CMD ["python", "/config/script.py"]
