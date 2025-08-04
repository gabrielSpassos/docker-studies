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
