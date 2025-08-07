### Run

```
kubectl config use-context minikube # Switch context to minikube
tofu init                           # Sets up providers
tofu plan                           # Previews what will be created
tofu apply                          # Deploys infrastructure
tofu destroy                        # Deletes infrastructure
```

Flask App → http://localhost:30001

Grafana → http://localhost:30002

Jenkins → http://localhost:30003

Prometheus → http://localhost:30004

* Get nodes
```bash
kubectl get nodes -A
```

* Get pods
```bash
kubectl get pods -n devops-poc-infra-namespace
```

* Get deployments
```bash
kubectl get deployments -A
```

* Get services
```bash
kubectl get services -n devops-poc-infra-namespace
```

* Get details on services
```bash
kubectl describe service grafana -n devops-poc-infra-namespace
kubectl describe service prometheus-server -n devops-poc-infra-namespace
```

* Get statefulset
```bash
kubectl get statefulsets -A
```

* Get daemonset
```bash
kubectl get daemonset -A
```

minikube service grafana -n devops-poc-infra-namespace --url