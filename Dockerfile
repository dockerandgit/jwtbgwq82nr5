FROM python:3.10-slim

# Install dependencies for Chrome + ChromeDriver
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libxcb1 \
    libx11-xcb1 \
    libxshmfence1 \
    libnss3 \
    libxss1 \
    libxtst6 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install Chrome 112
RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/112.0.5615.49/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip && \
    mv chrome-linux64 /usr/local/chrome && \
    rm chrome-linux64.zip

# Symlink the chrome binary
RUN ln -s /usr/local/chrome/chrome /usr/bin/google-chrome-stable

# Install matching ChromeDriver 112
RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/112.0.5615.49/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf chromedriver-linux64 chromedriver-linux64.zip

# Install Python Selenium 4.9.0
RUN pip install selenium==4.9.0

# Set environment variables for Chrome and ChromeDriver binaries
ENV CHROME_BIN=/usr/bin/google-chrome-stable
ENV CHROMEDRIVER_BIN=/usr/local/bin/chromedriver

# Create working directory
WORKDIR /app

# Define volumes for config and data
VOLUME /config
VOLUME /data

# Run your script by default
CMD ["python", "/config/script.py"]
