FROM python:3.10-slim

# Install OS deps
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      unzip cron \
 && rm -rf /var/lib/apt/lists/*

# Install Python deps
RUN pip install --no-cache-dir psycopg2-binary requests

# Expose where we store our state
VOLUME ["/config"]

# Defaults for DB connection & notify
ENV POSTGRES_HOST=db \
    POSTGRES_PORT=5432 \
    POSTGRES_DB=fda \
    NOTIFY_SCRIPT=/usr/local/emhttp/webGui/scripts/notify

ENTRYPOINT ["/scripts/entrypoint.sh"]

