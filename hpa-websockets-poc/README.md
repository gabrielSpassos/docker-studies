# Kubernetes Horizontal Pod Autoscaler (HPA) for WebSockets application POC

## Steps

1. Install minikube
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
```

2. Install helm
```bash
curl -fsSL https://get.helm.sh/helm-v3.16.3-linux-amd64.tar.gz -o helm.tar.gz
tar -xzf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
helm version
```

3. Install kubectl
```bash
curl -LO https://dl.k8s.io/release/v1.34.0/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version --client
```

4. Start Cluster
```bash
minikube start --cpus=2 --memory=4096 --driver=docker
```

5. Enable metrics
```bash
minikube addons enable metrics-server
kubectl top pods
```

6. Build websocket server docker image
```bash
eval $(minikube docker-env)
docker build -t ws-server:latest -f app/server/infra/Dockerfile app/server
```

7. Apply Server
```bash
kubectl apply -f app/server/infra/deployment.yaml
kubectl apply -f app/server/infra/service.yaml
kubectl apply -f app/server/infra/hpa.yaml
```

8. Build websocket client docker image
```bash
eval $(minikube docker-env)
docker build -t ws-client:latest -f app/client/infra/Dockerfile app/client
```

9. Apply Client
```bash
kubectl apply -f app/client/infra/client-job.yaml
```

10. Observe autoscaling
```bash
kubectl get pods
kubectl top pods
kubectl describe hpa ws-server-hpa
```

11. Destroy all cluster
```bash
minikube delete --all --purge
```