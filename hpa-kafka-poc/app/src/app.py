# app.py
from kafka import KafkaConsumer
import time

consumer = KafkaConsumer(
    "poc-topic",
    bootstrap_servers="poc-kafka-kafka-bootstrap.kafka:9092",
    group_id="poc-consumer",
    auto_offset_reset="earliest"
)

for msg in consumer:
    time.sleep(0.5)  # simulate work
    print(f"Consumed message: {msg.value.decode('utf-8')}")
