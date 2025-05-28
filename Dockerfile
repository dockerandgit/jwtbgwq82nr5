FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --no-cache-dir fastapi uvicorn[standard] jinja2 \
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Set the default working directory (optional)
WORKDIR /config

# Expose port 8000 for FastAPI
EXPOSE 8000

# Run the FastAPI script
CMD ["uvicorn", "script:app", "--host", "0.0.0.0", "--port", "8000"]
