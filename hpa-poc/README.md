# Kubernetes Horizontal Pod Autoscaler (HPA) POC

## Steps

1. Install minikube
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
```

2. Start Cluster
```bash
minikube start --cpus=2 --memory=4096 --driver=docker
```

3. Enable metrics
```bash
minikube addons enable metrics-server
kubectl top nodes
```

```bash
```