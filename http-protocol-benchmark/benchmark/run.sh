#!/bin/bash

echo "HTTP/1.1 test"
wrk -t4 -c100 -d30s http://localhost:8080/data

echo "HTTP/2 test"
h2load -n10000 -c100 https://localhost:8443/data

echo "HTTP/3 test"
h2load --h3 -n10000 -c100 https://localhost:8444/data
