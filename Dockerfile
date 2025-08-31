FROM clickhouse/clickhouse-server:24.8.4
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir
COPY . .
COPY ../src /app/src