#!/bin/bash

# Cambiar a root para tener permisos
if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

# Esperar a que SQL Server esté listo
sleep 30

# Instalar herramientas cliente de SQL Server
apt-get update
apt-get install -y curl gnupg2 software-properties-common apt-transport-https lsb-release

# Agregar repositorio de Microsoft
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

apt-get update
apt-get install -y mssql-tools unixodbc-dev

# Agregar sqlcmd al PATH
export PATH="$PATH:/opt/mssql-tools/bin"

# Ejecutar el script de esquema
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i /tmp/message.sql

# Ejecutar el script de inserción de datos
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i /tmp/insert.sql

echo "SQL Server initialization completed successfully!"

# Mantener el contenedor corriendo
tail -f /dev/null