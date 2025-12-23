FROM python:3.12-slim
WORKDIR /app
RUN pip install kafka-python
COPY src/app.py .
CMD ["python", "app.py"]
