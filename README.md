# Online Boutique - Implementación DevOps Completa (Fases I, II y III)

Este proyecto representa la implementación **End-to-End** de la metodología DevOps para la aplicación web de comercio electrónico **Online Boutique** (basada en 11 microservicios), abarcando desde la planificación ágil hasta la seguridad integrada en un ciclo de vida completamente automatizado.

---

## 🎯 Visión Estratégica
La implementación opta por los cuatro pilares fundamentales del desarrollo moderno:
1. **Automatización del Ciclo de Vida:** CI/CD para construcción, prueba y despliegue rápido.
2. **Escalabilidad de Microservicios:** Despliegue modular en Kubernetes.
3. **Sinergia Dev & Ops:** Integración y repositorios limpios usando estrategias de GitFlow.
4. **Ciberseguridad (DevSecOps):** Aislamiento de secretos y configuración automatizada con Ansible y Vault.

---

## 📈 Fases del Proyecto

### Fase I: Planeación e Introspección
* **Gestión Ágil:** Uso de un tablero Kanban (Jira) para coordinar 23 historias/tareas (PD-1 a PD-23).
* **Control de Versiones:** Estrategia adaptada de *Git Flow* con ramas protectoras `main`, `develop`, y subramas `feature/hotfix`.
* **Metodología DevOps:** Fomento de la colaboración en un flujo de trabajo continuo para agilizar el proceso de *Time-to-Market*.

### Fase II: Planteamiento (IaC & CI/CD)
* **Terraform (Infraestructura como Código):** Configuración del base foundation para el orquestador (`kubernetes` / `minikube`) de manera automatizada.
* **Integración Continua (CI):** Construcción y push dinámico de contenedores Docker hacia *GitHub Container Registry* mediante GitHub Actions.
* **Despliegue Continuo (CD):** Empaquetado y aplicación del sistema mediante *Helm Charts* iterativos controlando los 11 microservicios con una sola actualización.

### Fase III: Ejecución y Seguridad (Configuration Management)
* **Aprovisionamiento Ansible:** Configuración declarativa e instalación automatizada de un servidor externo mediante Ansible playbooks y roles.
* **HashiCorp Vault Externo:** Implementación de un gestor de secretos alojado en Linux/AWS (EC2) operativamente fuera del clúster de Kubernetes para prevenir brechas de seguridad.
* **DevSecOps Vault Policies:** Autenticación de GH Actions (`vault-action`) consumiendo el motor secreto **KV V2** con un token único de corto alcance, garantizando la anonimización de contraseñas.

---

## 📋 Estructura del Repositorio

```text
.
├── .github/workflows/          # Pipelines CI/CD automatizados (build y deploy)
├── ansible/                    # Configuration management
│   ├── roles/vault/            # Automatización de Vault server
│   ├── inventory.ini           # Configuración de los hosts objetivo (EC2)
│   └── playbook.yml            # Orquestador del aprovisionamiento
├── docs/                       # Documentación técnica, anexos y reportes
├── helm-chart/                 # Helm Chart maestro para los microservicios
├── microservices-demo/         # Código fuente multilingüe de Online Boutique
└── terraform/                  # Definición de infraestructura
```

---

## 🚀 Puesta en Marcha

### 1. Levantar Clúster Local
```bash
minikube start --cpus=4 --memory=8192 --driver=docker
```

### 2. Infraestructura Terraform
```bash
cd terraform
terraform init
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### 3. Aprovisionamiento EC2 del Vault Security (Ansible)
Edita la IP en `ansible/inventory.ini` y ejecuta el aprovisionamiento para el gestor de secretos:
```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```
Para inicializar el motor Vault y asignar la política CI/CD automáticamente, corre:
```bash
VAULT_ADDR=http://<IP-EC2>:8200 bash ansible/vault-init.sh
```

### 4. Despliegue de Helm Local
```bash
helm upgrade --install online-boutique ./helm-chart \
  --values ./helm-chart/values-dev.yaml \
  --namespace online-boutique-dev \
  --create-namespace
```

---

## 👨‍💻 Autor
**Fernando Torres**
* GitHub: [@FernandoT8rres](https://github.com/FernandoT8rres)
* Estado Académico: Finalizado con 100% de Tareas Kanban Completadas (23/23).
* Proyecto: Integrador de Metodología DevOps 8th Semester
