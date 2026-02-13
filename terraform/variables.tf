# Variables for Terraform configuration

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "namespace" {
  description = "Kubernetes namespace for Online Boutique"
  type        = string
  default     = "online-boutique"
}

variable "enable_monitoring" {
  description = "Enable monitoring stack (Prometheus/Grafana)"
  type        = bool
  default     = false
}

variable "replica_count" {
  description = "Default number of replicas for each microservice"
  type        = number
  default     = 1
  
  validation {
    condition     = var.replica_count >= 1 && var.replica_count <= 5
    error_message = "Replica count must be between 1 and 5."
  }
}

variable "resource_limits_enabled" {
  description = "Enable resource limits for pods"
  type        = bool
  default     = true
}

variable "cpu_limit" {
  description = "Default CPU limit for containers"
  type        = string
  default     = "200m"
}

variable "memory_limit" {
  description = "Default memory limit for containers"
  type        = string
  default     = "256Mi"
}

variable "cpu_request" {
  description = "Default CPU request for containers"
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Default memory request for containers"
  type        = string
  default     = "128Mi"
}
