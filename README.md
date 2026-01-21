# DevOps8th

# Propuesta Comercial

## Implementación de Metodología DevOps en la aplicación **Online Boutique**

---

## 1. Introducción

El presente proyecto integrador tiene como objetivo el diseño, planificación y justificación de la implementación de la metodología **DevOps** en una aplicación web de comercio electrónico basada en microservicios, utilizando herramientas de código abierto. Para este propósito se empleará **Online Boutique**, una aplicación open source desarrollada por Google, la cual está compuesta por 11 microservicios y permite a los usuarios visualizar productos, agregarlos a un carrito de compras y completar el proceso de compra.

Este proyecto busca aplicar las mejores prácticas aprendidas durante el curso, integrando herramientas DevOps que permitan una correcta gestión del ciclo de vida del software, desde la planeación hasta el despliegue continuo.

---

## 2. Objetivo del proyecto

### Objetivo general

Planificar y comprender de manera estructurada el flujo de trabajo necesario para implementar la metodología DevOps en una aplicación basada en microservicios, garantizando calidad, escalabilidad, seguridad y entrega continua de valor.

### Objetivos específicos

* Justificar la adopción de DevOps en una aplicación de comercio electrónico.
* Organizar las tareas del proyecto mediante un tablero Kanban en Jira.
* Definir una estrategia de control de versiones utilizando Git.
* Establecer las bases para la integración y despliegue continuo (CI/CD).
* Preparar el proyecto para las fases de construcción, configuración y resultados.

---

## . Descripción de la aplicación Online Boutique

**Online Boutique** es una aplicación web de e-commerce de código abierto desarrollada por Google con fines demostrativos. Está diseñada bajo una arquitectura de microservicios y representa un escenario realista de una tienda en línea moderna.

### Características principales:

* Arquitectura basada en **11 microservicios independientes**.
* Comunicación entre servicios mediante APIs.
* Funcionalidades clave de un e-commerce:

  * Catálogo de productos
  * Carrito de compras
  * Proceso de checkout
  * Gestión de pagos simulados
* Ideal para demostrar prácticas de **DevOps, CI/CD y microservicios**.

Repositorio oficial del proyecto:
[https://github.com/GoogleCloudPlatform/microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)

---

## 4. Justificación de la metodología DevOps

La implementación de la metodología **DevOps** es fundamental para maximizar el potencial de una aplicación basada en microservicios como Online Boutique. A continuación, se describen las principales razones:

### 4.1 Mejora en la entrega continua

DevOps permite automatizar los procesos de integración y despliegue, reduciendo el tiempo entre cambios de código y su disponibilidad en producción. En un entorno de e-commerce, esto se traduce en mejoras rápidas, corrección de errores o incorporación de nuevas funcionalidades sin afectar la experiencia del usuario.

### 4.2 Escalabilidad y mantenimiento

Al tratarse de una arquitectura de microservicios, DevOps facilita el despliegue independiente de cada servicio, permitiendo escalar únicamente los componentes necesarios y simplificando el mantenimiento del sistema.

### 4. Calidad y confiabilidad del software

Mediante la integración continua (CI), se pueden ejecutar pruebas automáticas, validaciones de código y análisis de seguridad, garantizando una mayor calidad del software y reduciendo fallos en producción.

### 4.4 Colaboración y visibilidad

DevOps promueve la colaboración entre los equipos de desarrollo y operaciones, mejorando la comunicación, la trazabilidad de cambios y la visibilidad del estado del proyecto.

### 4.5 Seguridad integrada

La seguridad se incorpora desde las primeras etapas del desarrollo (DevSecOps), aplicando políticas, configuraciones seguras y controles automatizados que protegen la aplicación y sus datos.

---

## 5. Metodología de trabajo – Fase I: Planeación

Durante la Fase I se establecen las bases organizativas y técnicas del proyecto.

### 5.1 Gestión de tareas con Jira (Kanban)

Se utilizará un tablero **Kanban en Jira** para organizar y dar seguimiento a todas las actividades del proyecto.

Estados sugeridos del tablero:

* Backlog
* Por hacer
* En progreso
* En revisión
* Completado

Ejemplos de tareas:

* Análisis de la arquitectura de Online Boutique
* Configuración inicial del repositorio Git
* Definición de estrategia de ramificación
* Documentación de la propuesta DevOps
* Planeación de pipelines CI/CD

*(Actualmente el tablero ya se encuentra creado y será poblado en las siguientes fases.)*

---

## 6. Control de versiones con Git

Se trabajará con un repositorio Git ya creado, el cual centralizará el código fuente, documentación y configuraciones del proyecto.

### 6.1 Estrategia de ramificación

Se propone una estrategia basada en **Git Flow simplificado**:

* **main**: rama principal, contiene versiones estables del proyecto.
* **develop**: rama de desarrollo donde se integran las nuevas funcionalidades.
* **feature/***: ramas para el desarrollo de nuevas características o mejoras específicas.
* **hotfix/***: ramas para corrección rápida de errores críticos.

Esta estrategia permite un control ordenado de cambios, facilita la colaboración y se integra de forma natural con pipelines de CI/CD.

---

## 7. Herramientas utilizadas en la Fase I

* **Git**: control de versiones del código fuente.
* **GitHub**: alojamiento del repositorio y colaboración.
* **Jira**: gestión de tareas y seguimiento del proyecto mediante Kanban.
* **Online Boutique (Google)**: aplicación base open source.

---

## 8. Alcance de la propuesta

Esta propuesta comercial cubre la **Fase I: Planeación**, sentando las bases para:

* La construcción de pipelines de integración y despliegue continuo.
* La configuración de políticas de seguridad y gestión de configuraciones.
* La ejecución del proyecto y presentación de resultados finales.

---

## 9. Conclusión

La adopción de la metodología DevOps en la aplicación Online Boutique permite demostrar, de manera práctica, cómo las mejores prácticas de desarrollo moderno mejoran la eficiencia, calidad y seguridad de una aplicación de comercio electrónico basada en microservicios. Esta fase de planeación garantiza un entendimiento claro del flujo de trabajo y prepara el proyecto para una implementación exitosa en las siguientes etapas.

---

**Fase actual:** Planeación (Fase I)
