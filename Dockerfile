FROM python:3.9-slim

# Install zstandard
RUN pip install --no-cache-dir zstandard

# Create working directory
WORKDIR /app

# Define volume for external config mapping
VOLUME /config
VOLUME /archive

# Run the script from the mapped config directory
CMD ["python", "/config/script.py"]
