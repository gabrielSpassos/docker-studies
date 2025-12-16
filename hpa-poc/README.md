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
minikube kubectl top nodes
```

4. Build app docker image
```bash
eval $(minikube docker-env) 
docker build -t cpu-burner ./app
```

5. Apply
```bash
minikube kubectl -- apply -f app/infra/deployment.yaml
minikube kubectl -- apply -f app/infra/service.yaml
```

6. List pods
```bash
minikube kubectl -- get pods --all-namespaces
```

7. Delete 
```bash
minikube kubectl -- delete deployment cpu-burner
minikube kubectl -- delete service cpu-burner
```