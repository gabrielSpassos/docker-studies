# Kubernetes and Minikube

☸️ **Kubernetes** is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

🧭 **Minikube** is a local Kubernetes environment that runs a single-node cluster on your machine, ideal for development and testing. It allows you to simulate real-world Kubernetes workflows without needing a full cloud setup.

🛳️ **Helm** is a package manager for Kubernetes that helps you define, install, and manage Kubernetes applications using reusable, versioned templates called charts.

## Usage

* Start minikub
```bash
minikube start --driver=docker
```

* Read local docker
```bash
eval $(minikube docker-env)
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

* Get deployments
```bash
kubectl get deployments -A
```

* Get services
```bash
kubectl get services -A
```

* Get statefulset
```bash
kubectl get statefulsets -A
```

* Get daemonset
```bash
kubectl get daemonset -A
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

* Expose app
```bash
kubectl expose deployment flask-poc-app --type=NodePort --port=5000
minikube service flask-poc-app
minikube service list
```

* Create helm chart
```bash
helm create flask-poc-app
```

* Install app
```bash
helm install flask-poc-app ./flask-poc-app
```

* Install prometheus
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus
```

* Get prometheus scrape config
```bash
kubectl get configmap prometheus-server -o yaml
```

* Edit prometheus scrape config with nano
```bash
KUBE_EDITOR="nano" kubectl edit configmap prometheus-server
```

```yml
- job_name: flask-poc-app
    metrics_path: /metrics
    static_configs:
    - targets: ['flask-poc-app:5000']
```

* Install grafana
```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana grafana/grafana \
  --set adminPassword=admin
```

* Port forward
```bash
kubectl port-forward svc/grafana 3000:80
kubectl port-forward svc/prometheus-server 9090:80
kubectl port-forward service/flask-poc-app 5000:5000
```

* Access grafana at http://localhost:3000 with admin/admin
* Access prometheus at http://localhost:9090 query `{job="flask-poc-app"}`

* Delete
```bash
kubectl delete deployment grafana
kubectl delete deployment prometheus-server
kubectl delete deployment prometheus-kube-state-metrics
kubectl delete deployment prometheus-prometheus-pushgateway
kubectl delete deployment flask-poc-app
kubectl delete service grafana
kubectl delete service prometheus-server
kubectl delete service prometheus-alertmanager
kubectl delete service prometheus-alertmanager-headless 
kubectl delete service prometheus-kube-state-metrics
kubectl delete service prometheus-prometheus-node-exporter
kubectl delete service prometheus-prometheus-pushgateway 
kubectl delete service flask-poc-app
kubectl delete statefulset prometheus-alertmanager
kubectl delete daemonset prometheus-prometheus-node-exporter
```