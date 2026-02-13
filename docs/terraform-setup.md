# Guía de Setup de Terraform

## Objetivo

Provisionar la infraestructura necesaria para ejecutar Online Boutique en Minikube utilizando Terraform.

## Prerrequisitos

### 1. Instalar Terraform

**macOS**:
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Verificar instalación**:
```bash
terraform version
# Debe mostrar: Terraform v1.0 o superior
```

### 2. Instalar Minikube

**macOS**:
```bash
brew install minikube
```

**Verificar instalación**:
```bash
minikube version
```

### 3. Iniciar Minikube

```bash
# Iniciar con recursos adecuados
minikube start --cpus=4 --memory=8192 --driver=docker

# Verificar estado
minikube status

# Configurar kubectl
kubectl config use-context minikube
```

## Estructura de Archivos Terraform

```
terraform/
├── main.tf                          # Configuración principal
├── variables.tf                     # Definición de variables
├── README.md                        # Esta guía
└── environments/
    ├── dev/
    │   └── terraform.tfvars        # Valores para desarrollo
    └── prod/
        └── terraform.tfvars        # Valores para producción
```

## Paso a Paso

### 1. Navegar al directorio de Terraform

```bash
cd terraform
```

### 2. Inicializar Terraform

```bash
terraform init
```

**Salida esperada**:
```
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/kubernetes versions matching "~> 2.23"...
- Finding hashicorp/helm versions matching "~> 2.11"...
- Installing hashicorp/kubernetes v2.23.0...
- Installing hashicorp/helm v2.11.0...

Terraform has been successfully initialized!
```

### 3. Validar configuración

```bash
terraform validate
```

**Salida esperada**:
```
Success! The configuration is valid.
```

### 4. Planificar cambios (Desarrollo)

```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
```

**Salida esperada**:
```
Terraform will perform the following actions:

  # kubernetes_namespace.online_boutique will be created
  + resource "kubernetes_namespace" "online_boutique" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "online-boutique-dev"
          + resource_version = (known after apply)
          + uid              = (known after apply)

          + labels = {
              + "app"     = "online-boutique"
              + "env"     = "dev"
              + "managed" = "terraform"
            }
        }
    }

  # kubernetes_config_map.app_config will be created
  + resource "kubernetes_config_map" "app_config" {
      ...
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

### 5. Aplicar infraestructura

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
```

Cuando se solicite confirmación, escribir `yes`.

**Salida esperada**:
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

config_map = "online-boutique-config"
minikube_context = "minikube"
namespace = "online-boutique-dev"
```

### 6. Verificar recursos creados

```bash
# Ver namespaces
kubectl get namespaces | grep online-boutique

# Ver ConfigMap
kubectl get configmap -n online-boutique-dev

# Describir ConfigMap
kubectl describe configmap online-boutique-config -n online-boutique-dev
```

## Recursos Creados

### 1. Namespace de Kubernetes

- **Nombre**: `online-boutique-dev` (o `online-boutique-prod`)
- **Labels**:
  - `app: online-boutique`
  - `env: dev`
  - `managed: terraform`

### 2. ConfigMap

- **Nombre**: `online-boutique-config`
- **Contenido**: Variables de entorno para microservicios
  - Direcciones de servicios
  - Configuración de ambiente
  - Flags de features

## Variables Configurables

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `environment` | Ambiente (dev/staging/prod) | `dev` |
| `namespace` | Namespace de Kubernetes | `online-boutique` |
| `enable_monitoring` | Habilitar monitoreo | `false` |
| `replica_count` | Réplicas por defecto | `1` |
| `cpu_limit` | Límite de CPU | `200m` |
| `memory_limit` | Límite de memoria | `256Mi` |

## Ambientes

### Desarrollo (`environments/dev/terraform.tfvars`)

```hcl
environment     = "dev"
namespace       = "online-boutique-dev"
replica_count   = 1
```

### Producción (`environments/prod/terraform.tfvars`)

```hcl
environment     = "prod"
namespace       = "online-boutique-prod"
replica_count   = 2
```

## Comandos Útiles

### Ver estado actual

```bash
terraform show
```

### Ver outputs

```bash
terraform output
```

### Formatear archivos

```bash
terraform fmt -recursive
```

### Destruir infraestructura

```bash
terraform destroy -var-file="environments/dev/terraform.tfvars"
```

## Troubleshooting

### Error: "context not found"

**Problema**: Terraform no puede conectarse a Minikube.

**Solución**:
```bash
# Verificar que Minikube esté corriendo
minikube status

# Configurar contexto
kubectl config use-context minikube

# Verificar conexión
kubectl cluster-info
```

### Error: "namespace already exists"

**Problema**: El namespace ya fue creado manualmente.

**Solución**:
```bash
# Importar namespace existente
terraform import kubernetes_namespace.online_boutique online-boutique-dev
```

### Error: "insufficient resources"

**Problema**: Minikube no tiene suficientes recursos.

**Solución**:
```bash
# Detener Minikube
minikube stop

# Reiniciar con más recursos
minikube start --cpus=4 --memory=8192 --driver=docker
```

## Próximos Pasos

Una vez aplicada la infraestructura con Terraform:

1. ✅ Desplegar aplicación con Helm
2. ✅ Configurar pipelines CI/CD
3. ✅ Verificar funcionamiento de microservicios

Ver: [README principal](../README.md) para instrucciones de despliegue.
