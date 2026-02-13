# 🚀 Guía de Inicio Rápido

Esta guía te llevará desde cero hasta tener Online Boutique corriendo en tu máquina local en **menos de 30 minutos**.

## ✅ Prerrequisitos

Antes de comenzar, instala las siguientes herramientas:

### macOS

```bash
# Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Docker Desktop
brew install --cask docker

# Minikube
brew install minikube

# kubectl
brew install kubectl

# Helm
brew install helm

# Terraform
brew install terraform
```

### Verificar instalaciones

```bash
docker --version          # Docker version 20.10+
minikube version         # minikube version v1.30+
kubectl version --client # Client Version v1.28+
helm version            # Version v3.13+
terraform version       # Terraform v1.0+
```

---

## 📦 Paso 1: Clonar el Repositorio

```bash
# Clonar el proyecto
git clone https://github.com/FernandoT8rres/DevOps8th.git
cd DevOps8th

# Verificar estructura
ls -la
```

**Deberías ver**:
```
.github/
docs/
helm-chart/
terraform/
microservices-demo/
README.md
```

---

## 🎯 Paso 2: Iniciar Minikube

```bash
# Iniciar Minikube con recursos adecuados
minikube start --cpus=4 --memory=8192 --driver=docker

# Verificar que esté corriendo
minikube status
```

**Salida esperada**:
```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

---

## 🏗️ Paso 3: Aplicar Infraestructura con Terraform

```bash
# Navegar a directorio de Terraform
cd terraform

# Inicializar Terraform
terraform init

# Ver plan de infraestructura
terraform plan -var-file="environments/dev/terraform.tfvars"

# Aplicar infraestructura
terraform apply -var-file="environments/dev/terraform.tfvars" -auto-approve

# Volver al directorio raíz
cd ..
```

**Recursos creados**:
- ✅ Namespace: `online-boutique-dev`
- ✅ ConfigMap: `online-boutique-config`

---

## 🐳 Paso 4: Construir Imágenes Docker (Opcional)

**Nota**: Las imágenes ya están disponibles en GHCR. Este paso es opcional si quieres construirlas localmente.

```bash
# Construir imagen de frontend (ejemplo)
cd microservices-demo/src/frontend
docker build -t ghcr.io/fernandot8rres/frontend:local .
cd ../../..
```

**Para usar imágenes de GHCR** (recomendado):
- Las imágenes se descargarán automáticamente al desplegar con Helm
- No necesitas construir nada localmente

---

## ⎈ Paso 5: Desplegar con Helm

```bash
# Instalar Online Boutique
helm upgrade --install online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev \
  --create-namespace \
  --wait \
  --timeout 5m
```

**Salida esperada**:
```
Release "online-boutique" has been upgraded. Happy Helming!
NAME: online-boutique
LAST DEPLOYED: ...
NAMESPACE: online-boutique-dev
STATUS: deployed
```

---

## 🔍 Paso 6: Verificar Despliegue

```bash
# Ver todos los pods
kubectl get pods -n online-boutique-dev

# Esperar a que todos estén Running (puede tardar 2-3 minutos)
kubectl wait --for=condition=ready pod \
  --all \
  -n online-boutique-dev \
  --timeout=300s
```

**Salida esperada** (todos en Running):
```
NAME                                     READY   STATUS    RESTARTS
adservice-xxx                           1/1     Running   0
cartservice-xxx                         1/1     Running   0
checkoutservice-xxx                     1/1     Running   0
currencyservice-xxx                     1/1     Running   0
emailservice-xxx                        1/1     Running   0
frontend-xxx                            1/1     Running   0
paymentservice-xxx                      1/1     Running   0
productcatalogservice-xxx               1/1     Running   0
recommendationservice-xxx               1/1     Running   0
shippingservice-xxx                     1/1     Running   0
```

---

## 🌐 Paso 7: Acceder a la Aplicación

### Opción A: Minikube Service (Más fácil)

```bash
# Abrir frontend en navegador
minikube service frontend -n online-boutique-dev
```

Esto abrirá automáticamente tu navegador en la URL correcta.

### Opción B: Port Forward

```bash
# Forward del puerto
kubectl port-forward -n online-boutique-dev svc/frontend 8080:80

# Abrir en navegador
open http://localhost:8080
```

---

## 🎉 ¡Listo!

Deberías ver la tienda Online Boutique funcionando:

- 🛍️ Catálogo de productos
- 🛒 Carrito de compras
- 💳 Proceso de checkout
- 📧 Confirmación de orden

---

## 🔧 Comandos Útiles

### Ver logs de un servicio

```bash
kubectl logs -n online-boutique-dev deployment/frontend --tail=50
```

### Reiniciar un servicio

```bash
kubectl rollout restart deployment/frontend -n online-boutique-dev
```

### Ver todos los recursos

```bash
kubectl get all -n online-boutique-dev
```

### Acceder al dashboard de Kubernetes

```bash
minikube dashboard
```

---

## 🧹 Limpieza

Cuando termines de probar:

```bash
# Desinstalar aplicación
helm uninstall online-boutique -n online-boutique-dev

# Destruir infraestructura Terraform
cd terraform
terraform destroy -var-file="environments/dev/terraform.tfvars" -auto-approve
cd ..

# Detener Minikube
minikube stop

# (Opcional) Eliminar cluster completamente
minikube delete
```

---

## ❓ Troubleshooting

### Pods en estado Pending

```bash
# Ver eventos
kubectl get events -n online-boutique-dev --sort-by='.lastTimestamp'

# Solución: Minikube necesita más recursos
minikube stop
minikube start --cpus=4 --memory=8192
```

### Error "ImagePullBackOff"

```bash
# Ver detalles del pod
kubectl describe pod -n online-boutique-dev <pod-name>

# Solución: Verificar que las imágenes existan en GHCR
# O construir localmente y actualizar values.yaml
```

### Frontend no accesible

```bash
# Verificar que el servicio esté corriendo
kubectl get svc -n online-boutique-dev frontend

# Verificar que el pod esté Ready
kubectl get pods -n online-boutique-dev | grep frontend

# Ver logs
kubectl logs -n online-boutique-dev deployment/frontend
```

---

## 📚 Siguiente Paso

Una vez que tengas todo funcionando:

1. ✅ Explora la aplicación
2. ✅ Revisa los logs de diferentes servicios
3. ✅ Prueba escalar servicios
4. ✅ Experimenta con el pipeline CI/CD

Ver documentación completa en:
- [README principal](../README.md)
- [Arquitectura](./arquitectura.md)
- [Proceso CI](./ci-process.md)
- [Proceso CD](./cd-process.md)

---

## 🎓 Para el Proyecto Integrador

Asegúrate de capturar evidencias de:

- ✅ Terraform apply exitoso
- ✅ Pods corriendo en Kubernetes
- ✅ Aplicación funcionando en navegador
- ✅ Pipelines CI/CD ejecutándose
- ✅ Imágenes en GHCR

¡Buena suerte! 🚀
