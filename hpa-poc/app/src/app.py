from flask import Flask
import math

app = Flask(__name__)

@app.route("/")
def burn_cpu():
    x = 0
    for i in range(1, 200000):
        x += math.sqrt(i)
    return "OK\n"

app.run(host="0.0.0.0", port=8080)
