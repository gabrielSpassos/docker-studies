#!/usr/bin/python

import pytest
from app.src.server import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_create_person_api(client):
    response = client.post('/people')
    assert response.status_code == 200
    data = response.get_json()
    assert data["name"] == "John Doe"
    assert "id" in data
    assert data["id"] is not None