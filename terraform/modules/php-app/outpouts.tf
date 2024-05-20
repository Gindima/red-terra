output "service_name" {
  value = kubernetes_service.php_app.metadata[0].name
}
