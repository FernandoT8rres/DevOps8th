# ✅ Minikube Iniciado Exitosamente

## Estado Actual

✅ **Minikube está corriendo**

```
Cluster: minikube
Driver: QEMU (qemu2)
Kubernetes: v1.32.0
CPUs: 4
Memory: 6144 MB
Network: user mode
```

## Próximos Pasos

### 1. Continuar con el Script de Validación

Ahora que Minikube está corriendo, puedes continuar con el script:

```bash
./validate-and-capture.sh
```

El script continuará desde donde lo dejaste y ahora podrá:
- ✅ Ejecutar `terraform plan` exitosamente
- ✅ Ejecutar `terraform apply` para crear recursos
- ✅ Desplegar con Helm
- ✅ Capturar todas las evidencias

### 2. O Continuar Manualmente

Si prefieres hacerlo paso a paso:

#### Terraform

```bash
cd terraform

# Plan
terraform plan -var-file="environments/dev/terraform.tfvars"
# 📸 Captura: docs/evidencias/terraform/02_terraform_plan.png

# Apply
terraform apply -var-file="environments/dev/terraform.tfvars" -auto-approve
# 📸 Captura: docs/evidencias/terraform/03_terraform_apply.png

# Outputs
terraform output
# 📸 Captura: docs/evidencias/terraform/04_terraform_output.png

cd ..
```

#### Verificar Recursos

```bash
# Namespace
kubectl get namespace online-boutique-dev -o yaml
# 📸 Captura: docs/evidencias/terraform/05_namespace_created.png

# ConfigMap
kubectl describe configmap online-boutique-config -n online-boutique-dev
# 📸 Captura: docs/evidencias/terraform/06_configmap_details.png
```

#### Helm Deploy

```bash
# Lint
helm lint ./helm-chart --values ./helm-chart/values-dev.yaml
# 📸 Captura: docs/evidencias/cd/02_helm_lint.png

# Install
helm upgrade --install online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev \
  --create-namespace \
  --wait \
  --timeout 5m
# 📸 Captura: docs/evidencias/cd/03_helm_install.png

# Ver Pods
kubectl get pods -n online-boutique-dev
# 📸 Captura: docs/evidencias/cd/04_all_pods_running.png

# Ver Services
kubectl get services -n online-boutique-dev
# 📸 Captura: docs/evidencias/cd/05_all_services.png
```

#### Acceder a la Aplicación

⚠️ **Nota Importante**: Como Minikube está usando el modo "user network", los comandos `minikube service` y `minikube tunnel` **NO funcionarán**.

**Alternativa - Port Forward**:

```bash
# Forward del puerto del frontend
kubectl port-forward -n online-boutique-dev svc/frontend 8080:80
```

Luego abre en tu navegador: http://localhost:8080

📸 Captura screenshots de:
- Página principal
- Página de producto
- Carrito
- Checkout

### 3. Evidencias de GitHub (Manual)

Abre tu navegador y captura:

1. **GitHub Actions**
   - URL: https://github.com/FernandoT8rres/DevOps8th/actions
   - Captura: Workflows ejecutándose

2. **GHCR Packages**
   - URL: https://github.com/FernandoT8rres?tab=packages
   - Captura: Lista de imágenes

3. **Security**
   - URL: https://github.com/FernandoT8rres/DevOps8th/security
   - Captura: Resultados de Trivy

## Verificación Rápida

```bash
# Ver estado de Minikube
minikube status

# Ver nodos de Kubernetes
kubectl get nodes

# Ver todos los namespaces
kubectl get namespaces
```

## Troubleshooting

### Si Minikube se detiene

```bash
minikube start
```

### Si necesitas reiniciar

```bash
minikube stop
minikube start
```

### Ver logs de Minikube

```bash
minikube logs
```

## Resumen de Evidencias Pendientes

- [x] 01_terraform_init.png ✅ **CAPTURADO**
- [ ] 02_terraform_plan.png
- [ ] 03_terraform_apply.png
- [ ] 04_terraform_output.png
- [ ] 05_namespace_created.png
- [ ] 06_configmap_details.png
- [ ] CI evidencias (6 screenshots de GitHub)
- [ ] CD evidencias (11 screenshots)
- [ ] Docs evidencias (6 screenshots)

**Total pendiente**: 28 evidencias

---

**¡Minikube está listo! Continúa con la validación.** 🚀
