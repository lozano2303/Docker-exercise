#!/bin/bash

# Ejecutar el script de esquema
/opt/mssql-tools/bin/sqlcmd -S sqlserver-db -U SA -P 'MiPassw0rd!' -i /tmp/message.sql

# Ejecutar el script de inserción de datos
/opt/mssql-tools/bin/sqlcmd -S sqlserver-db -U SA -P 'MiPassw0rd!' -i /tmp/insert.sql

echo "SQL Server initialization completed successfully!"