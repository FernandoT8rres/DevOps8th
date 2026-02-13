#!/bin/bash

# Script de Validación y Captura de Evidencias
# Proyecto Integrador DevOps - Fase II

set -e  # Exit on error

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorio de evidencias
EVIDENCE_DIR="docs/evidencias"
mkdir -p "$EVIDENCE_DIR"/{terraform,ci,cd,docs}

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Validación y Captura de Evidencias${NC}"
echo -e "${BLUE}  Proyecto DevOps - Fase II${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Función para capturar screenshot (manual)
capture_evidence() {
    local category=$1
    local filename=$2
    local description=$3
    
    echo -e "${YELLOW}📸 CAPTURA REQUERIDA:${NC}"
    echo -e "   Categoría: ${category}"
    echo -e "   Archivo: ${filename}"
    echo -e "   Descripción: ${description}"
    echo -e "   Guardar en: ${EVIDENCE_DIR}/${category}/${filename}\n"
    read -p "Presiona ENTER cuando hayas capturado la evidencia..."
}

# 1. VERIFICAR HERRAMIENTAS
echo -e "${GREEN}=== 1. Verificando Herramientas ===${NC}\n"

echo "Docker version:"
docker --version || echo -e "${RED}❌ Docker no instalado${NC}"

echo -e "\nMinikube version:"
minikube version | head -1

echo -e "\nKubectl version:"
kubectl version --client --short 2>/dev/null || kubectl version --client

echo -e "\nHelm version:"
helm version --short

echo -e "\nTerraform version:"
terraform version | head -1

echo -e "\n${GREEN}✅ Verificación de herramientas completada${NC}\n"
read -p "Presiona ENTER para continuar..."

# 2. TERRAFORM - INFRAESTRUCTURA
echo -e "\n${GREEN}=== 2. Terraform - Infraestructura (25 pts) ===${NC}\n"

cd terraform

echo -e "${BLUE}Paso 1: Terraform Init${NC}"
terraform init
capture_evidence "terraform" "01_terraform_init.png" "Salida de terraform init exitoso"

echo -e "\n${BLUE}Paso 2: Terraform Plan${NC}"
terraform plan -var-file="environments/dev/terraform.tfvars"
capture_evidence "terraform" "02_terraform_plan.png" "Plan mostrando recursos a crear"

echo -e "\n${BLUE}Paso 3: Terraform Apply${NC}"
read -p "¿Deseas aplicar la infraestructura? (y/n): " apply_terraform
if [ "$apply_terraform" = "y" ]; then
    terraform apply -var-file="environments/dev/terraform.tfvars" -auto-approve
    capture_evidence "terraform" "03_terraform_apply.png" "Apply completado con recursos creados"
    
    echo -e "\n${BLUE}Paso 4: Terraform Output${NC}"
    terraform output
    capture_evidence "terraform" "04_terraform_output.png" "Outputs de Terraform"
fi

cd ..

echo -e "\n${BLUE}Paso 5: Verificar Namespace${NC}"
kubectl get namespace online-boutique-dev -o yaml
capture_evidence "terraform" "05_namespace_created.png" "Namespace con labels de Terraform"

echo -e "\n${BLUE}Paso 6: Verificar ConfigMap${NC}"
kubectl describe configmap online-boutique-config -n online-boutique-dev
capture_evidence "terraform" "06_configmap_details.png" "ConfigMap con variables de entorno"

echo -e "\n${GREEN}✅ Evidencias de Terraform capturadas${NC}\n"
read -p "Presiona ENTER para continuar..."

# 3. CI - DOCKER IMAGES
echo -e "\n${GREEN}=== 3. CI - Construcción de Imágenes Docker (25 pts) ===${NC}\n"

echo -e "${BLUE}Paso 1: Ver Workflow CI${NC}"
cat .github/workflows/ci-build-images.yml | head -50
capture_evidence "ci" "01_ci_workflow_file.png" "Archivo de workflow CI completo"

echo -e "\n${YELLOW}📋 EVIDENCIAS MANUALES REQUERIDAS:${NC}"
echo "   2. GitHub Actions ejecutándose"
echo "      URL: https://github.com/FernandoT8rres/DevOps8th/actions"
echo "      Archivo: ${EVIDENCE_DIR}/ci/02_github_actions_running.png"
echo ""
echo "   3. Builds exitosos de todos los servicios"
echo "      Archivo: ${EVIDENCE_DIR}/ci/03_all_builds_success.png"
echo ""
echo "   4. Paquetes en GHCR"
echo "      URL: https://github.com/FernandoT8rres?tab=packages"
echo "      Archivo: ${EVIDENCE_DIR}/ci/04_ghcr_packages.png"
echo ""
echo "   5. Tags de imágenes"
echo "      Archivo: ${EVIDENCE_DIR}/ci/05_image_tags.png"
echo ""
echo "   6. Resultados de Trivy scan"
echo "      URL: https://github.com/FernandoT8rres/DevOps8th/security"
echo "      Archivo: ${EVIDENCE_DIR}/ci/06_trivy_scan_results.png"
echo ""

read -p "Presiona ENTER cuando hayas capturado todas las evidencias de CI..."

echo -e "\n${GREEN}✅ Evidencias de CI documentadas${NC}\n"

# 4. CD - KUBERNETES
echo -e "\n${GREEN}=== 4. CD - Clúster de Kubernetes (25 pts) ===${NC}\n"

echo -e "${BLUE}Paso 1: Ver Helm Chart${NC}"
cat helm-chart/Chart.yaml
echo ""
cat helm-chart/values.yaml | head -50
capture_evidence "cd" "01_helm_chart_yaml.png" "Chart.yaml y values.yaml"

echo -e "\n${BLUE}Paso 2: Helm Lint${NC}"
helm lint ./helm-chart --values ./helm-chart/values-dev.yaml
capture_evidence "cd" "02_helm_lint.png" "Helm lint exitoso"

echo -e "\n${BLUE}Paso 3: Helm Install${NC}"
read -p "¿Deseas instalar con Helm? (y/n): " install_helm
if [ "$install_helm" = "y" ]; then
    helm upgrade --install online-boutique ./helm-chart \
      --values ./helm-chart/values-dev.yaml \
      --namespace online-boutique-dev \
      --create-namespace \
      --wait \
      --timeout 5m
    capture_evidence "cd" "03_helm_install.png" "Helm install exitoso"
    
    echo -e "\n${BLUE}Paso 4: Ver Pods${NC}"
    kubectl get pods -n online-boutique-dev
    capture_evidence "cd" "04_all_pods_running.png" "Todos los pods en Running"
    
    echo -e "\n${BLUE}Paso 5: Ver Services${NC}"
    kubectl get services -n online-boutique-dev
    capture_evidence "cd" "05_all_services.png" "Todos los services creados"
    
    echo -e "\n${BLUE}Paso 6: Acceder a la Aplicación${NC}"
    echo "Ejecuta en otra terminal: minikube service frontend -n online-boutique-dev"
    echo ""
    echo -e "${YELLOW}📸 CAPTURAS REQUERIDAS DE LA APLICACIÓN:${NC}"
    echo "   6. Página principal: ${EVIDENCE_DIR}/cd/06_app_homepage.png"
    echo "   7. Página de producto: ${EVIDENCE_DIR}/cd/07_app_product_page.png"
    echo "   8. Carrito de compras: ${EVIDENCE_DIR}/cd/08_app_cart.png"
    echo "   9. Página de checkout: ${EVIDENCE_DIR}/cd/09_app_checkout.png"
    echo ""
    read -p "Presiona ENTER cuando hayas capturado las evidencias de la app..."
    
    echo -e "\n${BLUE}Paso 7: Ver Logs${NC}"
    FRONTEND_POD=$(kubectl get pods -n online-boutique-dev -l app=frontend -o jsonpath='{.items[0].metadata.name}')
    kubectl logs -n online-boutique-dev "$FRONTEND_POD" --tail=30
    capture_evidence "cd" "10_pod_logs.png" "Logs del frontend"
    
    echo -e "\n${BLUE}Paso 8: Describir Pod${NC}"
    kubectl describe pod -n online-boutique-dev "$FRONTEND_POD"
    capture_evidence "cd" "11_pod_describe.png" "Detalles del pod con health checks"
fi

echo -e "\n${GREEN}✅ Evidencias de CD capturadas${NC}\n"
read -p "Presiona ENTER para continuar..."

# 5. DOCUMENTACIÓN
echo -e "\n${GREEN}=== 5. Documentación (25 pts) ===${NC}\n"

echo -e "${BLUE}Paso 1: Estructura del Proyecto${NC}"
tree -L 3 -I 'microservices-demo|node_modules' || find . -maxdepth 3 -type d | grep -v microservices-demo | head -30
capture_evidence "docs" "01_project_structure.png" "Estructura de directorios"

echo -e "\n${BLUE}Paso 2: README Principal${NC}"
cat README.md | head -100
capture_evidence "docs" "02_readme.png" "README.md principal"

echo -e "\n${BLUE}Paso 3: Arquitectura${NC}"
cat docs/arquitectura.md | head -100
capture_evidence "docs" "03_arquitectura.png" "Documentación de arquitectura"

echo -e "\n${BLUE}Paso 4: Proceso CI${NC}"
cat docs/ci-process.md | head -100
capture_evidence "docs" "04_ci_docs.png" "Documentación de CI"

echo -e "\n${BLUE}Paso 5: Proceso CD${NC}"
cat docs/cd-process.md | head -100
capture_evidence "docs" "05_cd_docs.png" "Documentación de CD"

echo -e "\n${BLUE}Paso 6: Terraform Setup${NC}"
cat docs/terraform-setup.md | head -100
capture_evidence "docs" "06_terraform_docs.png" "Documentación de Terraform"

echo -e "\n${GREEN}✅ Evidencias de Documentación capturadas${NC}\n"

# RESUMEN FINAL
echo -e "\n${BLUE}========================================${NC}"
echo -e "${BLUE}  RESUMEN DE EVIDENCIAS CAPTURADAS${NC}"
echo -e "${BLUE}========================================${NC}\n"

echo -e "${GREEN}Terraform (25 pts):${NC}"
echo "  ✅ 6 evidencias capturadas en ${EVIDENCE_DIR}/terraform/"

echo -e "\n${GREEN}CI - Docker (25 pts):${NC}"
echo "  ✅ 6 evidencias capturadas en ${EVIDENCE_DIR}/ci/"

echo -e "\n${GREEN}CD - Kubernetes (25 pts):${NC}"
echo "  ✅ 11 evidencias capturadas en ${EVIDENCE_DIR}/cd/"

echo -e "\n${GREEN}Documentación (25 pts):${NC}"
echo "  ✅ 6 evidencias capturadas en ${EVIDENCE_DIR}/docs/"

echo -e "\n${BLUE}Total: 29 evidencias para el portafolio${NC}\n"

echo -e "${YELLOW}📋 Próximos pasos:${NC}"
echo "  1. Organizar evidencias en carpetas"
echo "  2. Crear README.md del portafolio"
echo "  3. Comprimir en archivo .zip"
echo "  4. Preparar entrega para el 27 de febrero"

echo -e "\n${GREEN}✅ Validación y captura de evidencias completada${NC}\n"
