FROM python:3.10-slim

# Update and install dependencies for Chrome + ChromeDriver
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y gnupg
RUN apt-get install -y ca-certificates
RUN apt-get install -y fonts-liberation
RUN apt-get install -y libatk-bridge2.0-0
RUN apt-get install -y libatk1.0-0
RUN apt-get install -y libcups2
RUN apt-get install -y libdrm2
RUN apt-get install -y libxkbcommon0
RUN apt-get install -y libxcomposite1
RUN apt-get install -y libxdamage1
RUN apt-get install -y libxrandr2
RUN apt-get install -y libgbm1
RUN apt-get install -y libasound2
RUN apt-get install -y libpangocairo-1.0-0
RUN apt-get install -y libpango-1.0-0
RUN apt-get install -y libxcb1
RUN apt-get install -y libx11-xcb1
RUN apt-get install -y libxshmfence1
RUN apt-get install -y libnss3
RUN apt-get install -y libxss1
RUN apt-get install -y libxtst6
RUN rm -rf /var/lib/apt/lists/*

# Download Chrome 112 .deb
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_112.0.5615.49-1_amd64.deb

# Install Chrome 112 package (ignore errors to fix in next step)
RUN dpkg -i google-chrome-stable_112.0.5615.49-1_amd64.deb || true

# Fix broken dependencies
RUN apt-get update
RUN apt-get install -f -y

# Clean up Chrome .deb
RUN rm google-chrome-stable_112.0.5615.49-1_amd64.deb

# Download ChromeDriver 112
RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/112.0.5615.49/linux64/chromedriver-linux64.zip

# Unzip and move ChromeDriver binary
RUN unzip chromedriver-linux64.zip
RUN mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
RUN chmod +x /usr/local/bin/chromedriver

# Clean up ChromeDriver zip and folder
RUN rm -rf chromedriver-linux64 chromedriver-linux64.zip

# Install Python Selenium 4.9.0
RUN pip install selenium==4.9.0

# Create working directory
WORKDIR /app

# Define volumes
VOLUME /config
VOLUME /data

# Default command to run your script
CMD ["python", "script.py"]
