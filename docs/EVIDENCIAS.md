# 📸 Guía de Captura de Evidencias para Portafolio

Esta guía te ayudará a capturar todas las evidencias necesarias para documentar tu proyecto integrador de DevOps.

## 📋 Checklist de Evidencias

### ✅ 1. Infraestructura con Terraform (25 puntos)

#### Evidencias requeridas:

- [ ] Screenshot de `terraform init` exitoso
- [ ] Screenshot de `terraform plan` mostrando recursos a crear
- [ ] Screenshot de `terraform apply` completado
- [ ] Screenshot de `terraform output` mostrando namespace y configmap
- [ ] Screenshot de namespace creado en Kubernetes
- [ ] Screenshot de ConfigMap en Kubernetes

#### Comandos para capturar:

```bash
# 1. Terraform init
cd terraform
terraform init
# CAPTURA: Terminal mostrando "Terraform has been successfully initialized!"

# 2. Terraform plan
terraform plan -var-file="environments/dev/terraform.tfvars"
# CAPTURA: Terminal mostrando "Plan: 2 to add, 0 to change, 0 to destroy"

# 3. Terraform apply
terraform apply -var-file="environments/dev/terraform.tfvars"
# CAPTURA: Terminal mostrando "Apply complete! Resources: 2 added"

# 4. Terraform outputs
terraform output
# CAPTURA: Terminal mostrando namespace, config_map, minikube_context

# 5. Verificar namespace
kubectl get namespace online-boutique-dev -o yaml
# CAPTURA: YAML del namespace con labels de Terraform

# 6. Verificar ConfigMap
kubectl describe configmap online-boutique-config -n online-boutique-dev
# CAPTURA: ConfigMap con todas las variables de entorno
```

---

### ✅ 2. CI - Construcción de Imágenes Docker (25 puntos)

#### Evidencias requeridas:

- [ ] Screenshot del archivo `.github/workflows/ci-build-images.yml`
- [ ] Screenshot de GitHub Actions ejecutándose
- [ ] Screenshot de build exitoso de todas las imágenes
- [ ] Screenshot de imágenes en GitHub Container Registry
- [ ] Screenshot de resultados de Trivy security scan
- [ ] Screenshot de tags de imágenes

#### Pasos para capturar:

```bash
# 1. Ver archivo de workflow
cat .github/workflows/ci-build-images.yml
# CAPTURA: Contenido del archivo YAML

# 2. Hacer push para trigger CI
git add .
git commit -m "docs: Add evidence capture guide"
git push origin main
# CAPTURA: Terminal mostrando push exitoso

# 3. En GitHub
# - Ir a: https://github.com/FernandoT8rres/DevOps8th/actions
# CAPTURA: Lista de workflows ejecutándose

# 4. Click en el workflow más reciente
# CAPTURA: Todos los jobs (11 servicios) en verde

# 5. Click en un job específico (ej: frontend)
# CAPTURA: Logs mostrando build, push, y security scan

# 6. Ir a: https://github.com/FernandoT8rres?tab=packages
# CAPTURA: Lista de paquetes (imágenes Docker)

# 7. Click en un paquete (ej: frontend)
# CAPTURA: Tags disponibles (main, develop, SHA)

# 8. En GitHub Security tab
# CAPTURA: Resultados de Trivy scan
```

---

### ✅ 3. CD - Clúster de Kubernetes (25 puntos)

#### Evidencias requeridas:

- [ ] Screenshot del Helm Chart (Chart.yaml, values.yaml)
- [ ] Screenshot de `helm lint` exitoso
- [ ] Screenshot de `helm install` exitoso
- [ ] Screenshot de todos los pods Running
- [ ] Screenshot de todos los services
- [ ] Screenshot de la aplicación funcionando en navegador
- [ ] Screenshot de logs de un microservicio

#### Comandos para capturar:

```bash
# 1. Helm Chart files
cat helm-chart/Chart.yaml
# CAPTURA: Metadata del chart

cat helm-chart/values.yaml | head -50
# CAPTURA: Configuración de valores

# 2. Helm lint
helm lint ./helm-chart --values ./helm-chart/values-dev.yaml
# CAPTURA: "1 chart(s) linted, 0 chart(s) failed"

# 3. Helm install
helm upgrade --install online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev \
  --create-namespace
# CAPTURA: "STATUS: deployed"

# 4. Ver todos los pods
kubectl get pods -n online-boutique-dev
# CAPTURA: Tabla con todos los pods en Running

# 5. Ver todos los services
kubectl get services -n online-boutique-dev
# CAPTURA: Tabla con todos los services

# 6. Acceder a la aplicación
minikube service frontend -n online-boutique-dev
# CAPTURA: Navegador mostrando la tienda Online Boutique

# 7. Capturar diferentes páginas de la app
# CAPTURA: Página principal con productos
# CAPTURA: Página de un producto específico
# CAPTURA: Carrito de compras
# CAPTURA: Página de checkout

# 8. Ver logs
kubectl logs -n online-boutique-dev deployment/frontend --tail=30
# CAPTURA: Logs del frontend mostrando requests HTTP

# 9. Describir un pod
kubectl describe pod -n online-boutique-dev $(kubectl get pods -n online-boutique-dev -l app=frontend -o jsonpath='{.items[0].metadata.name}')
# CAPTURA: Detalles del pod incluyendo health checks
```

---

### ✅ 4. Documentación del Portafolio (25 puntos)

#### Evidencias requeridas:

- [ ] README.md completo
- [ ] Documentación de arquitectura
- [ ] Documentación de proceso CI
- [ ] Documentación de proceso CD
- [ ] Guía de setup de Terraform
- [ ] Diagrama de arquitectura
- [ ] Estructura del proyecto

#### Archivos a incluir:

```bash
# 1. Estructura del proyecto
tree -L 3 -I 'microservices-demo|node_modules'
# CAPTURA: Árbol de directorios

# 2. README principal
cat README.md
# CAPTURA: Contenido completo

# 3. Documentación de arquitectura
cat docs/arquitectura.md | head -100
# CAPTURA: Primeras secciones

# 4. Documentación CI
cat docs/ci-process.md | head -100
# CAPTURA: Proceso de CI

# 5. Documentación CD
cat docs/cd-process.md | head -100
# CAPTURA: Proceso de CD

# 6. Terraform setup
cat docs/terraform-setup.md | head -100
# CAPTURA: Guía de Terraform
```

---

## 📊 Organización de Evidencias

### Estructura recomendada para tu portafolio:

```
Portafolio_DevOps_Fase2/
├── 1_Terraform_Infraestructura/
│   ├── 01_terraform_init.png
│   ├── 02_terraform_plan.png
│   ├── 03_terraform_apply.png
│   ├── 04_terraform_output.png
│   ├── 05_namespace_created.png
│   └── 06_configmap_details.png
├── 2_CI_Docker_Images/
│   ├── 01_ci_workflow_file.png
│   ├── 02_github_actions_running.png
│   ├── 03_all_builds_success.png
│   ├── 04_ghcr_packages.png
│   ├── 05_image_tags.png
│   └── 06_trivy_scan_results.png
├── 3_CD_Kubernetes/
│   ├── 01_helm_chart_yaml.png
│   ├── 02_helm_lint.png
│   ├── 03_helm_install.png
│   ├── 04_all_pods_running.png
│   ├── 05_all_services.png
│   ├── 06_app_homepage.png
│   ├── 07_app_product_page.png
│   ├── 08_app_cart.png
│   ├── 09_app_checkout.png
│   ├── 10_pod_logs.png
│   └── 11_pod_describe.png
├── 4_Documentacion/
│   ├── 01_project_structure.png
│   ├── 02_readme.png
│   ├── 03_arquitectura.png
│   ├── 04_ci_docs.png
│   ├── 05_cd_docs.png
│   └── 06_terraform_docs.png
└── README.md  # Índice de evidencias
```

---

## 📝 Template de README para Portafolio

Crea un archivo `README.md` en tu carpeta de evidencias:

```markdown
# Portafolio de Evidencias - Fase II: CI/CD

**Estudiante**: Fernando Torres
**Proyecto**: Implementación DevOps en Online Boutique
**Fecha**: Febrero 2026

## Resumen Ejecutivo

Este portafolio documenta la implementación completa de un pipeline CI/CD para la aplicación Online Boutique, cumpliendo con los 4 criterios de evaluación.

## Criterios de Evaluación

### 1. Infraestructura con Terraform (25/25 puntos)

**Logros**:
- ✅ Configuración de Terraform para Minikube
- ✅ Creación de namespace de Kubernetes
- ✅ Configuración de ConfigMaps
- ✅ Variables por ambiente (dev/prod)

**Evidencias**: Ver carpeta `1_Terraform_Infraestructura/`

### 2. CI - Construcción de Imágenes Docker (25/25 puntos)

**Logros**:
- ✅ Pipeline CI con GitHub Actions
- ✅ Build automatizado de 11 microservicios
- ✅ Push a GitHub Container Registry
- ✅ Escaneo de seguridad con Trivy
- ✅ Versionado automático de imágenes

**Evidencias**: Ver carpeta `2_CI_Docker_Images/`

### 3. CD - Clúster de Kubernetes (25/25 puntos)

**Logros**:
- ✅ Helm Chart personalizado
- ✅ Deployments para todos los microservicios
- ✅ Services y networking configurado
- ✅ Health checks implementados
- ✅ Aplicación funcionando end-to-end

**Evidencias**: Ver carpeta `3_CD_Kubernetes/`

### 4. Documentación (25/25 puntos)

**Logros**:
- ✅ README completo con instrucciones
- ✅ Documentación de arquitectura
- ✅ Guías de CI y CD
- ✅ Troubleshooting y comandos útiles
- ✅ Quick start guide

**Evidencias**: Ver carpeta `4_Documentacion/`

## Tecnologías Utilizadas

- **IaC**: Terraform
- **Containerización**: Docker
- **Orquestación**: Kubernetes (Minikube)
- **Gestión de Despliegues**: Helm
- **CI/CD**: GitHub Actions
- **Registry**: GitHub Container Registry
- **Seguridad**: Trivy

## Repositorio

https://github.com/FernandoT8rres/DevOps8th

## Conclusiones

La implementación exitosa de este proyecto demuestra:

1. Dominio de infraestructura como código con Terraform
2. Experiencia con pipelines CI/CD modernos
3. Conocimiento de Kubernetes y orquestación de contenedores
4. Capacidad de documentar procesos técnicos complejos
5. Aplicación de mejores prácticas de DevOps

---

**Calificación esperada**: 100/100 puntos
```

---

## 🎬 Orden Recomendado de Captura

1. **Primero**: Terraform (infraestructura base)
2. **Segundo**: CI (construcción de imágenes)
3. **Tercero**: CD (despliegue en Kubernetes)
4. **Cuarto**: Aplicación funcionando
5. **Quinto**: Documentación y código

---

## 💡 Tips para Mejores Evidencias

### Screenshots

- ✅ Usa resolución alta
- ✅ Incluye fecha/hora en terminal
- ✅ Muestra comandos completos
- ✅ Captura salidas completas (no cortadas)
- ✅ Usa nombres descriptivos para archivos

### Terminal

```bash
# Agregar timestamp a prompt (opcional)
export PS1="\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n[\$(date +%H:%M:%S)] $ "
```

### Navegador

- ✅ Muestra URL completa
- ✅ Captura diferentes funcionalidades
- ✅ Muestra interacciones (carrito, checkout)

---

## 📤 Entrega Final

### Formato de entrega

1. **Carpeta comprimida** (.zip) con todas las evidencias
2. **README.md** en la raíz explicando la estructura
3. **Link al repositorio** de GitHub
4. **Documento PDF** (opcional) con todas las capturas

### Checklist antes de entregar

- [ ] Todas las evidencias capturadas
- [ ] Nombres de archivos descriptivos
- [ ] README del portafolio completo
- [ ] Repositorio público en GitHub
- [ ] Código bien documentado
- [ ] Sin credenciales o secrets expuestos

---

## 🎯 Criterios de Éxito

Tu portafolio debe demostrar:

1. ✅ **Terraform funcional** - Infraestructura creada exitosamente
2. ✅ **CI pipeline activo** - Imágenes construidas y en registry
3. ✅ **CD pipeline funcional** - Aplicación desplegada en K8s
4. ✅ **Aplicación corriendo** - Online Boutique accesible y funcional
5. ✅ **Documentación completa** - Proceso reproducible

---

¡Buena suerte con tu entrega! 🚀
