# Terraform README

## Overview

This directory contains Terraform configurations for provisioning the infrastructure needed to run Online Boutique on Minikube.

## Prerequisites

- Terraform >= 1.0
- Minikube installed and running
- kubectl configured

## Quick Start

### 1. Start Minikube

```bash
minikube start --cpus=4 --memory=8192 --driver=docker
```

### 2. Initialize Terraform

```bash
cd terraform
terraform init
```

### 3. Plan Infrastructure

For development:
```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
```

For production:
```bash
terraform plan -var-file="environments/prod/terraform.tfvars"
```

### 4. Apply Infrastructure

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### 5. Verify Resources

```bash
kubectl get namespaces
kubectl get configmap -n online-boutique-dev
```

## Structure

```
terraform/
├── main.tf                    # Main configuration
├── variables.tf               # Variable definitions
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars  # Dev environment values
│   └── prod/
│       └── terraform.tfvars  # Prod environment values
└── modules/                   # Reusable modules (future)
```

## Resources Created

- **Kubernetes Namespace**: Isolated namespace for Online Boutique
- **ConfigMap**: Application configuration for microservices
- **Labels**: Proper labeling for resource management

## Cleanup

To destroy all resources:

```bash
terraform destroy -var-file="environments/dev/terraform.tfvars"
```
