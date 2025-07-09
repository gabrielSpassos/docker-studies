#!/usr/bin/python

from flask import Flask, request, jsonify
import uuid

app = Flask(__name__)

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
