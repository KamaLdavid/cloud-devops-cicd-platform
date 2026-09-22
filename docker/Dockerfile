FROM python:3.12-slim
RUN apt update && apt install curl -y && rm -rf /var/lib/apt/lists/* 
WORKDIR /app
COPY app/requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
EXPOSE 5000
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD response=$(curl -fsS http://localhost:5000/health) && test "$response" = "OK" || exit 1
CMD ["python", "app.py"]


