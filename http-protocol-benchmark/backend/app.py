from flask import Flask, jsonify
import time

app = Flask(__name__)

@app.route("/data")
def data():
    return jsonify({
        "message": "test",
        "timestamp": time.time()
    })

@app.route("/payload/<int:size>")
def payload(size):
    return "x" * size

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)