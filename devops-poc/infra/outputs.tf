output "prometheus_host" {
  value       = "http://localhost:30001"
  description = "NodePort URL to access Prometheus"
}

output "grafana_host" {
  value       = "http://localhost:30002"
  description = "NodePort URL to access Grafana"
}

output "jenkins_host" {
  value       = "http://localhost:30003"
  description = "NodePort URL to access Jenkins"
}

output "flask_host" {
  value       = "http://localhost:30004/health"
  description = "NodePort URL to access Flask Application"
}
