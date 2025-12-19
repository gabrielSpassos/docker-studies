FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir flask prometheus_client
COPY src/app.py .
EXPOSE 5000
CMD ["python", "app.py"]
