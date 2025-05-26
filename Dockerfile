FROM python:3.10-slim

# Install dependencies for Chrome and ChromeDriver
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libxss1 \
    libasound2 \
    libgbm1 \
    --no-install-recommends

# Install specific Chrome version 112.0.5615.49 (example)
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_112.0.5615.49-1_amd64.deb && \
    dpkg -i google-chrome-stable_112.0.5615.49-1_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_112.0.5615.49-1_amd64.deb

# Install ChromeDriver 112.0.5615.49
RUN wget https://chromedriver.storage.googleapis.com/112.0.5615.49/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Install Python selenium package
RUN pip install --no-cache-dir selenium

# Copy your scraper code in
COPY . /app
WORKDIR /app

# Set environment variables for Chrome and ChromeDriver, if your script needs them
ENV CHROME_BIN=/usr/bin/google-chrome
ENV CHROMEDRIVER_BIN=/usr/local/bin/chromedriver

# Define volumes for external mapping
VOLUME /config
VOLUME /data

CMD ["python", "script.py"]
