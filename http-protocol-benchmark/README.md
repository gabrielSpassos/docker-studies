# http protocol benchmark

> Compare HTTP/1 vs HTTP/2 vs HTTP/3

### Install

```bash
sudo apt install wrk
sudo apt install nghttp2-client
sudo apt install curl
```

### Usage

1. Generate certs
```bash
mkdir certs

openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout certs/key.pem \
  -out certs/cert.pem \
  -days 365 \
  -subj "/CN=localhost"
```

2. Build 
```
docker compose up --build
```

3. Validate
```
curl http://localhost:8080/data
curl -k https://localhost:8443/data
curl -k --http3 https://localhost:8444/data
```