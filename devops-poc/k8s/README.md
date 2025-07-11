* Start minikub
```bash
minikube start --driver=docker
```

* Check status
```bash
minikube status
```

* Get nodes
```bash
kubectl get nodes -A
```

* Get pods
```bash
kubectl get pods -A
```

* Describe
```bash
kubectl describe pod <pod-name>
```

* Load docker image
```bash
minikube image load flask-poc-app:latest
```

* Deploy
```bash
kubectl apply -f deployment.yaml
```

* Delete
```bash
kubectl delete deployment flask-poc-app
```

* Expose app
```bash
kubectl expose deployment flask-poc-app --type=NodePort --port=5000
minikube service flask-poc-app
```


