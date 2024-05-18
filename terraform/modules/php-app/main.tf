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
          image = "moouhamed888/red-line-web"
          ports {
            container_port = 80
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
