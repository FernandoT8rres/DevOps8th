# Fase III: Implementación de Vault con Ansible para CI/CD

El presente documento técnico describe la arquitectura y los procedimientos aplicados para la administración y configuración segura de secretos mediante **HashiCorp Vault**, provisionándolo con **Ansible** para su integración en el ciclo CI/CD (GitHub Actions).

## 1. Arquitectura de Aprovisionamiento (Ansible)

La infraestructura de seguridad reside externamente al clúster de Kubernetes, como lo establece la Fase III del proyecto (por ejemplo, en un servidor AWS EC2 independiente), garantizando así que una brecha en la aplicación no exponga el gestor de secretos.

Para esto, se estructuró un playbook y un rol de Ansible (`ansible/roles/vault`):
*   **Instalación Automatizada:** El rol descarga el binario oficial de Vault y crea los usuarios, grupos y directorios pertinentes.
*   **Configuración UI:** Se habilita específicamente la interfaz de usuario web (`ui = true`). 
*   **Archivos de Servicio:** El script configura el archivo de inicio `vault.service` para `systemd` para que Vault se ejecute en segundo plano, habilitando la alta disponibilidad del servicio.
*   **Listener TCP:** Vault atiende las peticiones por defecto en el puerto `8200` y está configurado en `0.0.0.0:8200` para poder acceder al UI y API.

*Ejecución:*
```bash
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

## 2. Inicialización y Configuración de Vault

Para configurar o inicializar Vault (desellado, motores de búsqueda, etc.), se elaboró el script `ansible/vault-init.sh` que realiza los siguientes pasos interactuando vía API/CLI:

1.  **Inicialización (`operator init`):** Inicia Vault generando la llave para desellar unseal (`unseal key`) y el Token Raíz (`root token`), que son devueltos y almacenados temporalmente en `vault_credentials.json`.
2.  **Desellado (`operator unseal`):** Desbloquea Vault para hacerlo operativo usando el Unseal Key. Se considera que para entornos productivos estos pasos necesitan inyectarse externamente.
3.  **Habilitación del Motor KV V2 (`secrets enable`):** Provisión de un motor de secretos del tipo Clave/Valor (Key-Value map) en la ruta `secret/`.
4.  **Generación de Políticas (ACLs):** Se estableció la política `cicd-policy` para otorgar únicamente los permisos de "Lectura" (`read`) y "Enlistado" (`list`) en las rutas `secret/data/cicd/*`.
5.  **Token Único para Pipeline:** Finalmente, se genera usando la política previamente declarada un token de Vault con los permisos asignados mínimos necesarios.

### Evidencia Visual (UI de Vault)
A continuación, se anexa la evidencia de nuestro **Servidor Vault operativo, desellado y funcionando 100% sobre la instancia externa a Kubernetes**. Incluye prueba del Dashboard habilitado, uso de la API interactiva y el motor de secretos `secret/` listo:

![Evidencia Vault UI](./vault_ui_evidence.webp)

## 3. Integración con Pipeline de GitHub Actions

Con Vault aprovisionado y configurado mediante el output del script anterior:

1.  **Guardar Tokens:** Almacenar el token generado por el script en un **GitHub Secret** llamado `VAULT_TOKEN`, y almacenar la IP/URL de la instancia EC2 en `VAULT_ADDR` (ej. `http://IP-EC2:8200`).
2.  **Ingresar Datos a Vault:** A través del **UI Web de Vault**, el administrador debe loguearse (con el Token Raíz), dirigirse a `secret/cicd/dockerhub` y registrar sus accesos.
3.  **Llamada en GitHub Actions:** En el `.yaml` del flujo CI/CD, usar la Action oficial de HashiCorp para descargar los datos directamente, por ejemplo:

```yaml
steps:
  - name: Load Secrets from Vault
    uses: hashicorp/vault-action@v2
    with:
      url: \${{ secrets.VAULT_ADDR }}
      token: \${{ secrets.VAULT_TOKEN }}
      secrets: |
        secret/data/cicd/dockerhub username | DOCKER_USERNAME ;
        secret/data/cicd/dockerhub password | DOCKER_PASSWORD
```

Esta configuración permite mantener todos los credenciales desvinculados del código, centralizados en Vault e inyectados dinámicamente durante el pipeline.
