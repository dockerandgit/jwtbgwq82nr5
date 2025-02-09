FROM python:3.9-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    ffmpeg \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir yt-dlp selenium requests

# Set environment variables
ENV CHROME_BIN=/usr/bin/chromium \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver

# Create working directory
WORKDIR /app

# Define volume for external config mapping
VOLUME /config
VOLUME /data

# Run the script from the mapped config directory
CMD ["python", "/config/archive_trailers.py"]
