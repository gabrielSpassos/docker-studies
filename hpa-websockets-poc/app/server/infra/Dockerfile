FROM python:3.12-slim
WORKDIR /app
RUN pip3 install websockets
COPY src/server.py .
CMD ["python3", "server.py"]
