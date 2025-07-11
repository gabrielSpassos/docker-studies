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
python3 -m flask --app src/server.py run
```

* Execute operation
```bash
curl --location --request POST 'http://localhost:5000/people'
```
