from flask import Flask, Response
from prometheus_client import Counter, generate_latest
import time

app = Flask(__name__)

http_requests_total = Counter(
    "http_requests_total",
    "Total HTTP requests",
    ["method", "path"]
)

@app.route("/")
def home():
    http_requests_total.labels("GET", "/").inc()
    time.sleep(0.05)
    return "OK\n"

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype="text/plain")

if __name__ == "__main__":
    print("Starting Flask HTTP metrics app")
    app.run(host="0.0.0.0", port=5000)
