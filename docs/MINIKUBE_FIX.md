# 🚨 Solución Rápida - Error de Minikube

## Error Encontrado

```
Error: Provider configuration: cannot load Kubernetes client config
context "minikube" does not exist
```

## Causa

**Minikube no está iniciado**. Terraform necesita que Minikube esté corriendo para poder crear recursos en Kubernetes.

## Solución

### 1. Inicia Minikube

```bash
minikube start --cpus=4 --memory=8192 --driver=docker
```

**Nota**: Si el driver `docker` no funciona (porque Docker Desktop no está instalado), usa:

```bash
minikube start --cpus=4 --memory=8192
```

Minikube automáticamente elegirá el mejor driver disponible (puede ser `qemu`, `hyperkit`, o `virtualbox`).

### 2. Verifica que Minikube esté corriendo

```bash
minikube status
```

Deberías ver:
```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

### 3. Verifica la conexión a Kubernetes

```bash
kubectl cluster-info
kubectl get nodes
```

### 4. Continúa con el script

Una vez que Minikube esté corriendo, puedes:

**Opción A: Continuar con el script**
```bash
./validate-and-capture.sh
```

**Opción B: Ejecutar Terraform manualmente**
```bash
cd terraform
terraform plan -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/dev/terraform.tfvars"
```

## Alternativa: Sin Docker

Si no tienes Docker instalado y Minikube no puede iniciar, puedes:

1. **Usar otro driver**:
   ```bash
   # Ver drivers disponibles
   minikube start --help | grep driver
   
   # Intentar con qemu (recomendado para Mac sin Docker)
   minikube start --cpus=4 --memory=8192 --driver=qemu
   ```

2. **Instalar Docker Desktop** (recomendado):
   ```bash
   brew install --cask docker
   open -a Docker
   # Espera a que Docker Desktop inicie
   minikube start --cpus=4 --memory=8192 --driver=docker
   ```

## Próximos Pasos

1. ✅ Inicia Minikube
2. ✅ Verifica que esté corriendo
3. ✅ Vuelve a ejecutar el script o continúa manualmente
4. ✅ Captura las evidencias restantes

## Comandos Rápidos

```bash
# Iniciar Minikube
minikube start --cpus=4 --memory=8192

# Verificar estado
minikube status

# Ver logs si hay problemas
minikube logs

# Reiniciar si es necesario
minikube delete
minikube start --cpus=4 --memory=8192
```
