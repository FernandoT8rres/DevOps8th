# Terraform Configuration for Minikube + Online Boutique
# This creates a local Kubernetes environment using Minikube

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
  
  # Local backend for state management
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Kubernetes provider configured for Minikube
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# Helm provider for chart deployments
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

# Create namespace for Online Boutique
resource "kubernetes_namespace" "online_boutique" {
  metadata {
    name = var.namespace
    
    labels = {
      app     = "online-boutique"
      env     = var.environment
      managed = "terraform"
    }
  }
}

# Create ConfigMap for application configuration
resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "online-boutique-config"
    namespace = kubernetes_namespace.online_boutique.metadata[0].name
  }

  data = {
    ENVIRONMENT           = var.environment
    ENABLE_PROFILER       = "0"
    DISABLE_TRACING       = "1"
    DISABLE_DEBUGGER      = "1"
    CURRENCY_SERVICE_ADDR = "currencyservice:7000"
    PRODUCT_CATALOG_SERVICE_ADDR = "productcatalogservice:3550"
    CART_SERVICE_ADDR     = "cartservice:7070"
    RECOMMENDATION_SERVICE_ADDR = "recommendationservice:8080"
    SHIPPING_SERVICE_ADDR = "shippingservice:50051"
    CHECKOUT_SERVICE_ADDR = "checkoutservice:5050"
    AD_SERVICE_ADDR       = "adservice:9555"
    EMAIL_SERVICE_ADDR    = "emailservice:5000"
    PAYMENT_SERVICE_ADDR  = "paymentservice:50051"
  }
}

# Output important information
output "namespace" {
  description = "Kubernetes namespace for Online Boutique"
  value       = kubernetes_namespace.online_boutique.metadata[0].name
}

output "config_map" {
  description = "ConfigMap name for application configuration"
  value       = kubernetes_config_map.app_config.metadata[0].name
}

output "minikube_context" {
  description = "Kubernetes context for Minikube"
  value       = "minikube"
}
