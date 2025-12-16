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
docker build -t cpu-burner:latest ./app
```

5. Apply
```bash
minikube kubectl -- apply -f app/infra/deployment.yaml
minikube kubectl -- apply -f app/infra/service.yaml
minikube kubectl -- apply -f app/infra/hpa.yaml
```

6. List pods
```bash
minikube kubectl -- get pods --all-namespaces
```

7. Describe
```bash
minikube kubectl -- describe pod cpu-burner-5868d6cf6c-4r7rv
```

8. Delete 
```bash
minikube kubectl -- delete deployment cpu-burner
minikube kubectl -- delete service cpu-burner
minikube kubectl -- delete hpa cpu-burner-hpa
```

9. Restart
```bash
minikube kubectl -- rollout restart deployment cpu-burner
```

10. Stop cluster
```bash
minikube stop
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