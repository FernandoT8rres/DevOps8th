# ✅ Checklist de Validación - Fase II

## Estado de Herramientas

| Herramienta | Versión | Estado |
|-------------|---------|--------|
| Minikube | v1.35.0 | ✅ Instalado |
| kubectl | v1.32.3 | ✅ Instalado |
| Helm | v3.17.1 | ✅ Instalado |
| Terraform | v1.9.6 | ✅ Instalado |
| Docker | - | ❌ Pendiente instalación |

## Pasos de Validación

### 1. Instalación de Docker ❌

- [ ] Instalar Docker Desktop
- [ ] Verificar `docker --version`
- [ ] Iniciar Docker Desktop
- [ ] Verificar `docker ps`

**Guía**: Ver [`docs/INSTALL_DOCKER.md`](./INSTALL_DOCKER.md)

---

### 2. Terraform - Infraestructura (25 pts) ⏳

- [ ] `terraform init` exitoso
- [ ] `terraform plan` muestra recursos
- [ ] `terraform apply` crea infraestructura
- [ ] Namespace `online-boutique-dev` creado
- [ ] ConfigMap creado con variables
- [ ] Outputs de Terraform visibles

**Evidencias a capturar**: 6 screenshots

---

### 3. CI - Docker Images (25 pts) ⏳

- [ ] Workflow CI visible en `.github/workflows/ci-build-images.yml`
- [ ] Push a GitHub trigger pipeline
- [ ] GitHub Actions ejecuta builds
- [ ] 11 microservicios construidos exitosamente
- [ ] Imágenes en GitHub Container Registry
- [ ] Trivy scan ejecutado
- [ ] Tags de imágenes correctos

**Evidencias a capturar**: 6 screenshots

**URLs importantes**:
- Actions: https://github.com/FernandoT8rres/DevOps8th/actions
- Packages: https://github.com/FernandoT8rres?tab=packages
- Security: https://github.com/FernandoT8rres/DevOps8th/security

---

### 4. CD - Kubernetes (25 pts) ⏳

- [ ] Minikube iniciado con recursos adecuados
- [ ] Helm Chart válido (lint exitoso)
- [ ] Despliegue con Helm exitoso
- [ ] Todos los pods en estado Running
- [ ] Services creados correctamente
- [ ] Aplicación accesible vía navegador
- [ ] Funcionalidades probadas:
  - [ ] Ver catálogo de productos
  - [ ] Agregar producto al carrito
  - [ ] Ver carrito
  - [ ] Proceso de checkout
- [ ] Logs de pods visibles
- [ ] Health checks funcionando

**Evidencias a capturar**: 11 screenshots

---

### 5. Documentación (25 pts) ✅

- [x] README.md completo
- [x] docs/arquitectura.md
- [x] docs/ci-process.md
- [x] docs/cd-process.md
- [x] docs/terraform-setup.md
- [x] docs/QUICKSTART.md
- [x] docs/EVIDENCIAS.md

**Evidencias a capturar**: 6 screenshots

---

## Script de Validación Automatizada

Ejecutar:

```bash
./validate-and-capture.sh
```

Este script:
1. ✅ Verifica todas las herramientas
2. ✅ Guía paso a paso por Terraform
3. ✅ Documenta evidencias de CI
4. ✅ Ejecuta despliegue con Helm
5. ✅ Captura todas las evidencias necesarias
6. ✅ Organiza screenshots en carpetas

---

## Estructura de Evidencias

```
docs/evidencias/
├── terraform/
│   ├── 01_terraform_init.png
│   ├── 02_terraform_plan.png
│   ├── 03_terraform_apply.png
│   ├── 04_terraform_output.png
│   ├── 05_namespace_created.png
│   └── 06_configmap_details.png
├── ci/
│   ├── 01_ci_workflow_file.png
│   ├── 02_github_actions_running.png
│   ├── 03_all_builds_success.png
│   ├── 04_ghcr_packages.png
│   ├── 05_image_tags.png
│   └── 06_trivy_scan_results.png
├── cd/
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
└── docs/
    ├── 01_project_structure.png
    ├── 02_readme.png
    ├── 03_arquitectura.png
    ├── 04_ci_docs.png
    ├── 05_cd_docs.png
    └── 06_terraform_docs.png
```

**Total**: 29 evidencias

---

## Cronograma

| Actividad | Tiempo Estimado | Fecha Límite |
|-----------|-----------------|--------------|
| Instalar Docker | 15 min | Hoy |
| Ejecutar validación | 30-45 min | 13-14 Feb |
| Capturar evidencias | 1-2 horas | 15-16 Feb |
| Organizar portafolio | 1 hora | 17-18 Feb |
| Revisión final | 30 min | 20-25 Feb |
| **Entrega** | - | **27 Feb 23:59** |

---

## Próximos Pasos

1. **Instalar Docker Desktop**
   ```bash
   brew install --cask docker
   open -a Docker
   ```

2. **Ejecutar script de validación**
   ```bash
   ./validate-and-capture.sh
   ```

3. **Capturar evidencias faltantes**
   - Screenshots de GitHub Actions
   - Screenshots de GHCR
   - Screenshots de la aplicación funcionando

4. **Organizar portafolio**
   - Crear README del portafolio
   - Comprimir evidencias
   - Preparar entrega

---

## Contacto de Soporte

Si encuentras problemas:

1. Revisa [`docs/terraform-setup.md`](./terraform-setup.md) - Troubleshooting de Terraform
2. Revisa [`docs/cd-process.md`](./cd-process.md) - Troubleshooting de Kubernetes
3. Revisa [`docs/QUICKSTART.md`](./QUICKSTART.md) - Guía paso a paso

---

**Última actualización**: 12 de febrero, 2026
**Estado general**: ⏳ Pendiente de validación local
**Código**: ✅ 100% completo y en GitHub
