#!/bin/bash

# Esperar a que SQL Server esté listo
sleep 30

# Ejecutar el script de esquema
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i /tmp/message.sql

# Ejecutar el script de inserción de datos
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i /tmp/insert.sql

# Mantener el contenedor corriendo
tail -f /dev/null