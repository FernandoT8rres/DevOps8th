# Online Boutique - DevOps Implementation

## 🎯 Proyecto Integrador - Fase II: CI/CD

Este proyecto implementa la metodología DevOps completa para la aplicación **Online Boutique** de Google, utilizando:

- **Terraform** para infraestructura como código
- **Docker** para containerización
- **Kubernetes (Minikube)** para orquestación
- **Helm** para gestión de despliegues
- **GitHub Actions** para CI/CD
- **GitHub Container Registry** para almacenamiento de imágenes

---

## 📋 Estructura del Proyecto

```
.
├── terraform/                    # Infraestructura como código
│   ├── main.tf                  # Configuración principal
│   ├── variables.tf             # Variables de Terraform
│   └── environments/            # Configuraciones por ambiente
├── helm-chart/                  # Helm Chart personalizado
│   ├── Chart.yaml              # Metadata del chart
│   ├── values.yaml             # Valores por defecto
│   ├── values-dev.yaml         # Valores de desarrollo
│   ├── values-prod.yaml        # Valores de producción
│   └── templates/              # Templates de Kubernetes
├── .github/workflows/          # Pipelines CI/CD
│   ├── ci-build-images.yml    # Pipeline de CI
│   └── cd-deploy-k8s.yml      # Pipeline de CD
├── microservices-demo/         # Código fuente de Online Boutique
└── docs/                       # Documentación del proyecto
```

---

## 🚀 Quick Start

### Prerrequisitos

Asegúrate de tener instalado:

```bash
# Docker
docker --version

# Minikube
minikube version

# Kubectl
kubectl version --client

# Helm
helm version

# Terraform
terraform version
```

### 1. Iniciar Minikube

```bash
minikube start --cpus=4 --memory=8192 --driver=docker
minikube status
```

### 2. Aplicar Infraestructura con Terraform

```bash
cd terraform
terraform init
terraform plan -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### 3. Desplegar con Helm

```bash
# Instalar Online Boutique
helm upgrade --install online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev \
  --create-namespace

# Verificar despliegue
kubectl get pods -n online-boutique-dev
kubectl get services -n online-boutique-dev
```

### 4. Acceder a la Aplicación

```bash
# Obtener URL de acceso
minikube service frontend -n online-boutique-dev

# O usar port-forward
kubectl port-forward -n online-boutique-dev svc/frontend 8080:80
# Abrir http://localhost:8080
```

---

## 🔄 CI/CD Pipelines

### Pipeline de CI (Construcción de Imágenes)

**Trigger**: Push a `main`, `develop`, o `feature/*`

**Proceso**:
1. ✅ Checkout del código
2. ✅ Build de imágenes Docker para cada microservicio
3. ✅ Escaneo de seguridad con Trivy
4. ✅ Push a GitHub Container Registry
5. ✅ Versionado automático con tags

**Ubicación**: `.github/workflows/ci-build-images.yml`

### Pipeline de CD (Despliegue)

**Trigger**: Push a `main` o manual

**Proceso**:
1. ✅ Lint del Helm Chart
2. ✅ Template y validación
3. ✅ Empaquetado del chart
4. ✅ Generación de instrucciones de despliegue

**Ubicación**: `.github/workflows/cd-deploy-k8s.yml`

---

## 🏗️ Arquitectura de Microservicios

Online Boutique consta de **11 microservicios**:

| Servicio | Puerto | Lenguaje | Descripción |
|----------|--------|----------|-------------|
| **frontend** | 8080 | Go | Interfaz web del usuario |
| **adservice** | 9555 | Java | Servicio de anuncios |
| **cartservice** | 7070 | C# | Carrito de compras |
| **checkoutservice** | 5050 | Go | Proceso de checkout |
| **currencyservice** | 7000 | Node.js | Conversión de monedas |
| **emailservice** | 5000 | Python | Envío de emails |
| **paymentservice** | 50051 | Node.js | Procesamiento de pagos |
| **productcatalogservice** | 3550 | Go | Catálogo de productos |
| **recommendationservice** | 8080 | Python | Recomendaciones |
| **shippingservice** | 50051 | Go | Cálculo de envío |
| **loadgenerator** | - | Python | Generador de carga |

---

## 📊 Comandos Útiles

### Terraform

```bash
# Ver estado actual
terraform show

# Destruir infraestructura
terraform destroy -var-file="environments/dev/terraform.tfvars"

# Formatear archivos
terraform fmt -recursive
```

### Kubernetes

```bash
# Ver todos los recursos
kubectl get all -n online-boutique-dev

# Ver logs de un servicio
kubectl logs -n online-boutique-dev deployment/frontend

# Describir un pod
kubectl describe pod -n online-boutique-dev <pod-name>

# Escalar un servicio
kubectl scale deployment frontend --replicas=2 -n online-boutique-dev
```

### Helm

```bash
# Ver releases instalados
helm list -n online-boutique-dev

# Ver valores aplicados
helm get values online-boutique -n online-boutique-dev

# Actualizar despliegue
helm upgrade online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev

# Desinstalar
helm uninstall online-boutique -n online-boutique-dev
```

### Minikube

```bash
# Ver dashboard
minikube dashboard

# Ver servicios
minikube service list

# Detener Minikube
minikube stop

# Eliminar cluster
minikube delete
```

---

## 📝 Documentación Adicional

- [Terraform Setup](./docs/terraform-setup.md)
- [CI Process](./docs/ci-process.md)
- [CD Process](./docs/cd-process.md)
- [Arquitectura](./docs/arquitectura.md)

---

## 🎓 Criterios de Evaluación

| Criterio | Puntaje | Estado |
|----------|---------|--------|
| Construcción de infraestructura en Terraform | 25 | ✅ |
| Construcción de imágenes Docker (CI) | 25 | ✅ |
| Clúster de Kubernetes (CD) | 25 | ✅ |
| Documentación en portafolio | 25 | 🔄 En progreso |

---

## 👨‍💻 Autor

**Fernando Torres**
- GitHub: [@FernandoT8rres](https://github.com/FernandoT8rres)
- Proyecto: DevOps 8th Semester

---

## 📚 Referencias

- [Online Boutique - Google](https://github.com/GoogleCloudPlatform/microservices-demo)
- [Terraform Documentation](https://www.terraform.io/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs)
- [Helm Documentation](https://helm.sh/docs)
- [GitHub Actions](https://docs.github.com/en/actions)
