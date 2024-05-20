resource "kubernetes_deployment" "php_app" {
  metadata {
    name      = "php-app"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "php-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "php-app"
        }
      }
      spec {
        container {
          name  = "php-app"
          image = "yourusername/project_web:latest"
          ports {
            container_port = 80
          }
          env {
            name  = "DATABASE_HOST"
            value = "mysql"
          }
          env {
            name  = "DATABASE_USER"
            value = "root"
          }
          env {
            name  = "DATABASE_PASSWORD"
            value = "root"
          }
          env {
            name  = "DATABASE_NAME"
            value = "redline"
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 20
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "php_app" {
  metadata {
    name      = "php-app"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "php-app"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
