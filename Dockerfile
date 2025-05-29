FROM python:3.11-slim

# Install zstandard
RUN pip install --no-cache-dir zstandard

# Create working directory
WORKDIR /app

# Define volume for external config mapping
VOLUME /config
VOLUME /data
VOLUME /archive

# Run the script from the mapped config directory
CMD ["python", "/config/script.py"]
