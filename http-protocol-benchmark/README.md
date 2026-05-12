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

3. Run Client
```bash
cd http-client
cargo run -- http1
cargo run -- http2
# 1000 requests / 100 concurrent tasks
cargo run -- http1 1000 100
cargo run -- http2 1000 100
```
