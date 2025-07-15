#!/usr/bin/python

from flask import Flask, request, jsonify
from prometheus_flask_exporter import PrometheusMetrics
import uuid

app = Flask(__name__)
metrics = PrometheusMetrics(app)

metrics.info('app_info', 'Application info', version='1.0.3')

@app.route('/people', methods=['POST']) 
def create_person_api():
    person = create_person()
    json_response = jsonify(person)
    print(json_response)
    return json_response


def create_person():
    response = {
        "id": uuid.uuid4(),
        "name": "John Doe",
    }
    return response


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
