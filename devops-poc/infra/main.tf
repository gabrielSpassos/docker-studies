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

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "devops_poc_application_namespace" {
  metadata {
    name = "devops_poc_application_namespace"
  }
}

resource "kubernetes_namespace" "devops_poc_infra_namespace" {
  metadata {
    name = "devops_poc_infra_namespace"
  }
}

# Install Prometheus
resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "25.21.0"
  namespace  = kubernetes_namespace.devops_poc_infra_namespace.metadata[0].name
  create_namespace = false
  values     = [file("${path.module}/values/prometheus-values.yaml")]
}

# Install Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  version    = "7.3.9"
  namespace  = "monitoring"
  create_namespace = true
  values     = [file("${path.module}/values/grafana-values.yaml")]
}

# Deploy local application (Kubernetes YAML)
resource "kubernetes_manifest" "my_app_deployment" {
  manifest = yamldecode(file("${path.module}/app/deployment.yaml"))
}

resource "kubernetes_manifest" "my_app_service" {
  manifest = yamldecode(file("${path.module}/app/service.yaml"))
}
