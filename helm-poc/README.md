# Helm POC

🛳️ Helm is a package manager for Kubernetes that helps you define, install, and manage Kubernetes applications using reusable, versioned templates called charts.

### Use Cases

- Simplify deployment of complex applications
- Customize configurations using values files
- Upgrade and rollback releases easily
- Share charts via public or private repositories

### Key Concepts

| Term           | Meaning                                                                                       |
| -------------- | --------------------------------------------------------------------------------------------- |
| **Chart**      | A Helm package: contains templates and values to deploy an app on Kubernetes.                 |
| **Release**    | A deployed instance of a chart (e.g., `grafana`, `myapp`).                                    |
| **Repository** | A place where charts are stored (e.g., `https://prometheus-community.github.io/helm-charts`). |
| **Values**     | A YAML file used to customize the chart (like config/parameters).                             |
| **Templates**  | Kubernetes YAML files with Go templating, rendered into actual manifests during install.      |

### Install (linux)

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

```bash
helm version
```

### Basic commands

```
# Add a Helm repo
helm repo add <name> <url>

# Update local chart info
helm repo update

# Search for a chart
helm search repo <name>

# Install a chart
helm install <release-name> <chart> [--values my-values.yaml]

# Uninstall a release
helm uninstall <release-name>

# Upgrade an existing release
helm upgrade <release-name> <chart> --values my-values.yaml

# See installed releases
helm list

# See the Kubernetes resources a release created
helm status <release-name>
```

* Install and unistall chart
```bash
helm install mynginx stable/nginx-ingress

helm list

helm uninstall mynginx
```