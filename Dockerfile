FROM clickhouse/clickhouse-server:24.8.4
WORKDIR /app
COPY . .
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install -r requirements.txt --no-cache-dir