# Flask APP

* Install deps 
```bash
pip3 install -r requirements.txt
```

* Unit test
```bash
python3 -m unittest -v app/test/test_server.py
```

* It test + Unit tests
```bash
pytest app/test
```

* Run server
```bash
python3 -m flask --app src/server.py run --host 0.0.0.0
```

* Execute operation
```bash
curl --location --request POST 'http://localhost:5000/people'
```

* Get prometheus metrics
```bash
curl --location 'http://localhost:5000/metrics'
```

* Build docker image
```bash
docker build -t flask-poc-app .
```

* Run container
```bash
docker run -d -p 5000:5000 --name flask-app-poc-container flask-poc-app
```
