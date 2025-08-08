terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.24"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}


resource "kubernetes_namespace" "devops_poc_application_namespace" {
  metadata {
    name = "devops-poc-application-namespace"
  }
}

resource "kubernetes_namespace" "devops_poc_infra_namespace" {
  metadata {
    name = "devops-poc-infra-namespace"
  }
}

# Install Prometheus
resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "27.28.2"
  namespace  = kubernetes_namespace.devops_poc_infra_namespace.metadata[0].name
  create_namespace = false
  values     = [file("${path.module}/values/prometheus-values.yaml")]
}

# Port forward Prometheus (localhost:9090)
resource "null_resource" "port_forward_prometheus" {
  provisioner "local-exec" {
    command     = "nohup kubectl port-forward svc/prometheus-server -n devops-poc-infra-namespace 9090:80 >/dev/null 2>&1 &"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [helm_release.prometheus]
}

# Install Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  version    = "9.3.0"
  namespace  = kubernetes_namespace.devops_poc_infra_namespace.metadata[0].name
  create_namespace = false
  values     = [file("${path.module}/values/grafana-values.yaml")]
}

# Port forward Grafana (localhost:3000)
resource "null_resource" "port_forward_grafana" {
  provisioner "local-exec" {
    command     = "nohup kubectl port-forward svc/grafana -n devops-poc-infra-namespace 3000:80 >/dev/null 2>&1 &"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [helm_release.grafana]
}

# Install Jenkins
resource "helm_release" "jenkins" {
  name       = "jenkins"
  chart      = "jenkins"
  repository = "https://charts.jenkins.io"
  version    = "5.8.72"
  namespace  = kubernetes_namespace.devops_poc_infra_namespace.metadata[0].name
  create_namespace = false

  values = [file("${path.module}/values/jenkins-values.yaml")]
}

# Port forward Jenkins (localhost:8080)
resource "null_resource" "port_forward_jenkins" {
  provisioner "local-exec" {
    command     = "nohup kubectl port-forward svc/jenkins -n devops-poc-infra-namespace 8080:80 >/dev/null 2>&1 &"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [helm_release.jenkins]
}

# Deploy local application (Kubernetes YAML)
resource "kubernetes_manifest" "flask_poc_app_deployment" {
  manifest = yamldecode(file("${path.cwd}/../app/deployment.yaml"))
}

resource "kubernetes_manifest" "flask_poc_app_service" {
  manifest = yamldecode(file("${path.cwd}/../app/service.yaml"))
}

# Port forward Flask App (localhost:5000)
resource "null_resource" "port_forward_flask" {
  provisioner "local-exec" {
    command     = "nohup kubectl port-forward svc/flask-poc-app -n devops-poc-application-namespace 5000:80 >/dev/null 2>&1 &"
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [kubernetes_manifest.flask_poc_app_service]
}
