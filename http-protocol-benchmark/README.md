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
# 1000 requests / 100 concurrent tasks
cargo run --release -- http1 10000 100
cargo run --release -- http2 10000 100
```

* HTTP 1
```
=================================
Requests: 10000
Concurrency: 100
Total Duration: 12.92s
Requests/sec: 773.89
Average latency: 128.04 ms
P95 latency: 185 ms
P99 latency: 188 ms
=================================
```

* HTTP 2
```
=================================
Requests: 10000
Concurrency: 100
Total Duration: 12.47s
Requests/sec: 801.86
Average latency: 123.48 ms
P95 latency: 158 ms
P99 latency: 187 ms
=================================
```