#!/bin/bash
# Este script inicializa, desella y configura el servidor Vault para integrarse con GitHub Actions

export VAULT_ADDR='http://127.0.0.1:8200'

# Esperar a que Vault esté en ejecución
echo "Comprobando si Vault está en ejecución..."
while ! curl -s $VAULT_ADDR/v1/sys/health | jq -e 'has("initialized")' > /dev/null; do
  echo "Esperando por Vault en $VAULT_ADDR..."
  sleep 2
done

# Verificar si ya está inicializado
INITIALIZED=$(curl -s $VAULT_ADDR/v1/sys/health | jq -r '.initialized')

if [ "$INITIALIZED" == "false" ]; then
    echo "Inicializando Vault..."
    INITIALIZATION=$(vault operator init -key-shares=1 -key-threshold=1 -format=json)

    UNSEAL_KEY=$(echo $INITIALIZATION | jq -r '.unseal_keys_b64[0]')
    ROOT_TOKEN=$(echo $INITIALIZATION | jq -r '.root_token')

    echo "Guardando credenciales en vault_credentials.json (¡No compartir y asegurar este archivo!)..."
    echo "$INITIALIZATION" > vault_credentials.json

    echo "Unseal Key: $UNSEAL_KEY"
    echo "Root Token: $ROOT_TOKEN"
else
    echo "Vault ya está inicializado. Se requiere el Unseal Key y Root Token para continuar."
    if [ ! -f "vault_credentials.json" ]; then
        echo "No se encontró vault_credentials.json. Saliendo..."
        exit 1
    fi
    UNSEAL_KEY=$(jq -r '.unseal_keys_b64[0]' vault_credentials.json)
    ROOT_TOKEN=$(jq -r '.root_token' vault_credentials.json)
fi

# Desellar Vault
SEALED=$(curl -s $VAULT_ADDR/v1/sys/health | jq -r '.sealed')
if [ "$SEALED" == "true" ]; then
    echo "Desellando Vault..."
    vault operator unseal $UNSEAL_KEY
else
    echo "Vault ya está desellado."
fi

# Iniciar sesión
echo "Iniciando sesión en Vault..."
vault login $ROOT_TOKEN

# Habilitar el motor de secretos KV v2
if ! vault secrets list | grep -q "secret/"; then
    echo "Habilitando el motor de secretos KV v2 en /secret..."
    vault secrets enable -path=secret kv-v2
else
    echo "Motor de secretos en /secret ya está habilitado."
fi

# Crear política para CI/CD
echo "Creando política cicd-policy..."
cat <<EOF > cicd-policy.hcl
path "secret/data/cicd/*" {
  capabilities = ["read", "list"]
}
EOF
vault policy write cicd-policy cicd-policy.hcl

# Generar un token único para GitHub Actions
echo "Generando token para GitHub Actions..."
TOKEN_RESPONSE=$(vault token create -policy=cicd-policy -format=json)
CICD_TOKEN=$(echo $TOKEN_RESPONSE | jq -r '.auth.client_token')

echo "=========================================================="
echo "¡Configuración de Vault completada exitosamente!"
echo "=========================================================="
echo "GitHub Actions Token: $CICD_TOKEN"
echo ">> Agrega este token como un GitHub Secret llamado 'VAULT_TOKEN' en tu pipeline CI/CD."
echo ">> URL del Servidor Vault: http://<TU_IP_EC2>:8200"
echo "=========================================================="
