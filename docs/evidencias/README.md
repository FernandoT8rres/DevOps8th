# 📸 Evidencias del Proyecto - Fase II

Este directorio contiene todas las evidencias capturadas durante la validación del proyecto.

## Estructura

```
evidencias/
├── terraform/          # 6 evidencias (25 pts)
├── ci/                 # 6 evidencias (25 pts)
├── cd/                 # 11 evidencias (25 pts)
└── docs/               # 6 evidencias (25 pts)
```

## Checklist de Captura

### Terraform (25 pts)
- [ ] 01_terraform_init.png - Terraform init exitoso
- [ ] 02_terraform_plan.png - Plan mostrando recursos
- [ ] 03_terraform_apply.png - Apply completado
- [ ] 04_terraform_output.png - Outputs de Terraform
- [ ] 05_namespace_created.png - Namespace en Kubernetes
- [ ] 06_configmap_details.png - ConfigMap con variables

### CI - Docker (25 pts)
- [ ] 01_ci_workflow_file.png - Archivo workflow CI
- [ ] 02_github_actions_running.png - Actions ejecutándose
- [ ] 03_all_builds_success.png - Builds exitosos
- [ ] 04_ghcr_packages.png - Paquetes en GHCR
- [ ] 05_image_tags.png - Tags de imágenes
- [ ] 06_trivy_scan_results.png - Resultados de Trivy

### CD - Kubernetes (25 pts)
- [ ] 01_helm_chart_yaml.png - Chart.yaml y values
- [ ] 02_helm_lint.png - Helm lint exitoso
- [ ] 03_helm_install.png - Helm install exitoso
- [ ] 04_all_pods_running.png - Pods en Running
- [ ] 05_all_services.png - Services creados
- [ ] 06_app_homepage.png - Página principal
- [ ] 07_app_product_page.png - Página de producto
- [ ] 08_app_cart.png - Carrito de compras
- [ ] 09_app_checkout.png - Checkout
- [ ] 10_pod_logs.png - Logs del pod
- [ ] 11_pod_describe.png - Detalles del pod

### Documentación (25 pts)
- [ ] 01_project_structure.png - Estructura del proyecto
- [ ] 02_readme.png - README principal
- [ ] 03_arquitectura.png - Documentación arquitectura
- [ ] 04_ci_docs.png - Documentación CI
- [ ] 05_cd_docs.png - Documentación CD
- [ ] 06_terraform_docs.png - Documentación Terraform

## Total: 29 evidencias

## Instrucciones

1. Ejecuta el script `validate-and-capture.sh` desde la raíz del proyecto
2. El script te guiará paso a paso
3. Captura cada screenshot cuando se te indique
4. Guarda en la carpeta correspondiente con el nombre exacto
5. Marca cada item cuando esté completo

## Tips para Screenshots

- Usa resolución alta
- Captura ventana completa o área relevante
- Asegúrate que el texto sea legible
- Incluye fecha/hora si es posible
- Usa nombres exactos de archivo
