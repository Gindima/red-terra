# Fichier : main.tf

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}



provider "kubernetes" {
  config_path = "C:\\Users\\HP\\.kube\\config"
}


# Récupération du contenu YAML pour le déploiement PHP
resource  "kubernetes_manifest" "php_deployment" {
  manifest = yamldecode(file("../php-deployment.yaml"))
}