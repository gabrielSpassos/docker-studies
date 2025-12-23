# Kubernetes Horizontal Pod Autoscaler (HPA) based on Apache Kafka POC

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
```

6. Install kafka with [Strimzi](https://strimzi.io/)
```bash
kubectl create namespace kafka
kubectl apply -n kafka \
  -f https://strimzi.io/install/latest?namespace=kafka
kubectl apply -n kafka -f infra/kafka-nodepool.yaml
kubectl apply -n kafka -f infra/kafka.yaml
kubectl apply -n kafka -f infra/kafka-exporter-deployment.yaml
kubectl apply -n kafka -f infra/kafka-exporter-service.yaml

kubectl -n kafka get pods
kubectl -n kafka get svc
```

7. Validate metrics
```bash
kubectl -n kafka port-forward svc/kafka-exporter 9308:9308
curl http://localhost:9308/metrics
```

7. Build docker image
```bash
eval $(minikube docker-env)
docker build -t kafka-consumer:latest ./app
```

8. Apply
```bash
kubectl apply -f app/infra/deployment.yaml
kubectl apply -f app/infra/hpa.yaml
kubectl get pods
```

9. Install Prometheus
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install monitoring prometheus-community/kube-prometheus-stack
kubectl get pods
kubectl -n kafka get svc kafka-exporter --show-labels
kubectl apply -f infra/kafka-exporter-servicemonitor.yaml
kubectl get servicemonitor
kubectl port-forward svc/monitoring-kube-prometheus-stack-prometheus 9090
```

metrics: `kafka_consumergroup_lag`

10. Generate load
```bash
kubectl -n kafka exec -it poc-kafka-kafka-0 -- \
  bin/kafka-producer.sh \
  --broker-list localhost:9092 \
  --topic poc-topic
```

11. Observe hpa
```bash
kubectl get hpa
kubectl get pods -w
```

## Clean up

1. Destroy all cluster
```bash
minikube delete --all --purge
```