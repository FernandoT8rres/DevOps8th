# Reporte Final: Proyecto Integrador de Metodología DevOps
**Proyecto:** Online Boutique (Arquitectura de Microservicios)
**Fases Completadas:** I (Planeación), II (Planteamiento e Infraestructura), III (Ejecución y Seguridad)
**Estado del Sprint / Tablero Jira:** 100% Completado (23/23 Tareas Finalizadas)

---

## 1. Resumen Ejecutivo
El presente documento certifica la implementación completa y exitosa de la metodología DevOps para el proyecto **Online Boutique**, una aplicación de comercio electrónico basada en 11 microservicios. A través del uso de herramientas declarativas y de automatización, se logró establecer un ciclo de vida de desarrollo ágil, seguro y escalable.

Se completaron exitosamente todas las actividades planificadas en Jira (PD-1 a PD-23), garantizando la sinergia entre los equipos de desarrollo (Dev) y operaciones (Ops), e inyectando seguridad desde el diseño (DevSecOps).

## 2. Gestión Ágil y Control de Versiones (Fase I)
* **Tablero Kanban:** Se estructuró y completó el seguimiento a través de Jira, logrando finalizar las 23 tareas épicas y de mantenimiento en tiempo y forma (PD-1 a PD-23).
* **Git Flow Adoptado:** Se centralizó el código en GitHub bajo el repositorio `DevOps8th`. Se utilizaron las ramas `main` para código productivo, `develop` para integración y ramas `feature/hotfix` para el trabajo modular, protegiendo así el entorno estable.

## 3. Infraestructura y Pipelines CI/CD (Fase II)
Con el objetivo de automatizar la entrega y el escalamiento:
1. **Infraestructura como Código (IaC):** Se orquestó la infraestructura principal empleando `Terraform`, aislando los recursos y preparando el entorno del clúster de Kubernetes para la recepción de los microservicios.
2. **Integración Continua (CI):** Se programó un flujo en GitHub Actions (`ci-build-images.yml`) que compila dinámicamente cada microservicio usando Docker Buildx y los publica en el GitHub Container Registry (GHCR). 
3. **Despliegue Continuo (CD):** El pipeline de despliegue (`cd-deploy-k8s.yml`) automatiza la carga de las imágenes frescas hacia el clúster usando un *Helm Chart* personalizado que renderiza y empaqueta los manifiestos de Kubernetes de todos los componentes de la tienda.

## 4. Ciberseguridad y Configuration Management (Fase III)
La ciberseguridad se integró como un habilitador y no como un bloqueador operativo (PD-15, PD-16, PD-17, PD-18).
1. **Ansible para Aprovisionamiento:** Se desarrolló un playbook de Ansible con roles definidos para instalar y configurar de forma completamente automatizada un servidor de seguridad externo (AWS EC2).
2. **HashiCorp Vault:** Se instaló como gestor de secretos con interfaz UI web habilitada. Las llaves de acceso, tokens y credenciales sensibles fueron removidas del código de GitHub.
3. **Políticas CI/CD (DevSecOps):** Se inyectó una política de mínimo privilegio (`cicd-policy`) dentro de Vault, generando un token único y exclusivo (`VAULT_TOKEN`). El pipeline CI/CD ahora se conecta mediante el protocolo `v1/sys/health` al motor de claves (`secret/ KV V2`) alojado en la IP externa de EC2 para recuperar de manera efímera los secretos de autenticación de red.

## 5. Conclusiones y Trazabilidad (PD-23)
La implementación del ciclo DevOps transformó la entrega del proyecto *Online Boutique* de un esquema manual a uno 100% automatizado, altamente auditable y resiliente. 
La validación del clúster y la comprobación de las prácticas *DevSecOps* marcan un hito organizativo que asegura implementaciones estables de aquí al futuro. El proyecto ha concluido exitosamente el desarrollo de todas sus 23 historias de usuario, declarándose la versión final estable y lista para ser auditada por las partes interesadas.

---
*Documento generado automáticamente como entregable de las Fases I, II y III.*
