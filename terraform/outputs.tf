output "php_app_url" {
  value = "http://${kubernetes_service.php_app.metadata.0.name}.${var.namespace}.svc.cluster.local"
}
