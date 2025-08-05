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