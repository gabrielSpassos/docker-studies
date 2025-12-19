# Kubernetes Horizontal Pod Autoscaler (HPA) based on HTTP Metrics POC

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

3. Start Cluster
```bash
minikube start --cpus=2 --memory=4096 --driver=docker
```

4. Enable metrics
```bash
minikube addons enable metrics-server
minikube kubectl top nodes
```

5. Install Prometheus
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack
helm install prometheus-adapter prometheus-community/prometheus-adapter
minikube kubectl -- get pods --namespace default
```

6. Build app docker image
```bash
eval $(minikube docker-env)
docker build -t http-metrics-app:latest ./app
```

7. Apply
```bash
minikube kubectl -- apply -f app/infra/deployment.yaml
minikube kubectl -- apply -f app/infra/service.yaml
helm upgrade prometheus-adapter prometheus-community/prometheus-adapter \
  --values app/infra/adapter-config.yaml
```

8. List pods
```bash
minikube kubectl -- get pods --all-namespaces
```

9. Describe
```bash
minikube kubectl -- describe pod http-metrics-app-5d84dd7b7b-cn5xm
```

10. Get Logs
```bash
minikube kubectl logs deployment/http-metrics-app
```

11. Fetch service url
```bash
minikube service cpu-burner --url
```

12. Stress service
* `-n 50000` => 50k HTTP requests
* `-c 20` => 20 simultaneous clients
```bash
ab -n 50000 -c 20 http://192.168.49.2:30080/
```

13. Observe HPA
```bash
minikube kubectl get pods -w
minikube kubectl top pods
minikube kubectl describe hpa cpu-burner-hpa
```

### Clean Up 

1. Delete 
```bash
minikube kubectl -- delete deployment http-metrics-app
minikube kubectl -- delete service http-metrics-app
```

2. Restart
```bash
kubectl -- rollout restart deployment http-metrics-app
kubectl rollout restart deployment prometheus-adapter
kubectl rollout status deployment prometheus-adapter
```

3. Stop cluster
```bash
minikube stop
```

4. Destroy all cluster
```bash
minikube delete --all --purge
```