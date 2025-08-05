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

# Expose Prometheus service
resource "kubernetes_ingress_v1" "prometheus" {
  metadata {
    name      = "prometheus-ingress"
    namespace = kubernetes_namespace.devops_poc_infra_namespace.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    rule {
      host = "prometheus.local"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "prometheus-server"
              port {
                number = 9090
              }
            }
          }
        }
      }
    }
  }
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

resource "null_resource" "port_forward_grafana" {
  provisioner "local-exec" {
    command = "nohup kubectl port-forward svc/grafana -n devops-poc-infra-namespace 3000:80 >/dev/null 2>&1 &"
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

# Deploy local application (Kubernetes YAML)
resource "kubernetes_manifest" "flask_poc_app_deployment" {
  manifest = yamldecode(file("${path.cwd}/../app/deployment.yaml"))
}

resource "kubernetes_manifest" "flask_poc_app_service" {
  manifest = yamldecode(file("${path.cwd}/../app/service.yaml"))
}
