output "service_name" {
  value = kubernetes_service.mysql.metadata[0].name
}
