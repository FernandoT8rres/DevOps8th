# Guía de Instalación de Docker Desktop

## Para macOS

### Opción 1: Homebrew (Recomendado)

```bash
# Instalar Docker Desktop
brew install --cask docker

# Abrir Docker Desktop
open -a Docker
```

### Opción 2: Descarga Manual

1. Visita: https://www.docker.com/products/docker-desktop/
2. Descarga Docker Desktop para Mac (Apple Silicon o Intel)
3. Abre el archivo `.dmg` descargado
4. Arrastra Docker.app a la carpeta Applications
5. Abre Docker Desktop desde Applications

## Verificación

Después de instalar y abrir Docker Desktop:

```bash
# Espera a que Docker Desktop inicie completamente
# Verás el ícono de Docker en la barra de menú

# Verifica la instalación
docker --version
docker ps

# Deberías ver:
# Docker version 24.0+ 
# CONTAINER ID   IMAGE   ...
```

## Configuración Recomendada

En Docker Desktop → Settings:

- **Resources → Advanced**:
  - CPUs: 4
  - Memory: 8 GB
  - Swap: 2 GB

- **Kubernetes** (opcional):
  - ☑ Enable Kubernetes

## Troubleshooting

### Docker Desktop no inicia

```bash
# Reiniciar Docker
killall Docker && open -a Docker
```

### Error de permisos

```bash
# Agregar usuario al grupo docker (si es necesario)
sudo dscl . append /Groups/_developer GroupMembership $(whoami)
```

## Siguiente Paso

Una vez instalado Docker Desktop, ejecuta:

```bash
./validate-and-capture.sh
```

Este script te guiará por todo el proceso de validación y captura de evidencias.
