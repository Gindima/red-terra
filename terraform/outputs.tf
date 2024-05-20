output "php_app_url" {
  value = "http://${module.php_app.service_name}.${var.namespace}.svc.cluster.local"
}
