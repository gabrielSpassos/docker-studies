FROM python:3.12-slim
WORKDIR /app
RUN pip3 install websockets
COPY src/client.py .
CMD ["python3", "client.py"]
