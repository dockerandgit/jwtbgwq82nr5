# Dockerfile
FROM python:3.9-slim

# Install system deps (including Chromium + Chromedriver)
RUN apt-get update -y && \
    apt-get install -y \
        wget \
        curl \
        unzip \
        ffmpeg \
        chromium \
        chromium-driver && \
    rm -rf /var/lib/apt/lists/*

# Install Python deps
RUN pip install --no-cache-dir \
        selenium

# Env vars for Selenium
ENV CHROME_BIN=/usr/bin/chromium \
    CHROMEDRIVER_BIN=/usr/bin/chromedriver

WORKDIR /app
VOLUME /config
VOLUME /data

CMD ["python", "/config/script.py"]
