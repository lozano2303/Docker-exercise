# Documentación: Contenedores Básicos Docker para Motores de Base de Datos

## Contenedor MySQL

### Comando Básico: `docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=mi_password -p 3306:3306 -d mysql:8.0`

Este comando crea e inicia un contenedor MySQL básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`--name mysql-db`**: Asigna el identificador "mysql-db" al contenedor.
- **`-e MYSQL_ROOT_PASSWORD=mi_password`**: Establece la contraseña del usuario root de MySQL.
- **`-p 3306:3306`**: Mapea el puerto 3306 del contenedor al puerto 3306 del host.
- **`-d`**: Ejecuta el contenedor en segundo plano (detached).
- **`mysql:8.0`**: Utiliza la imagen oficial de MySQL versión 8.0.

**Resultado**: Inicia un contenedor MySQL básico listo para conexiones.

### Creación de Base de Datos y Tablas

Para crear la base de datos y tablas, ejecutar el procedimiento desde `message.txt` adaptado para MySQL:

```bash
docker exec -i mysql-db mysql -u root -pmi_password < message_mysql.sql
```

### Inserción de 1000 Registros por Tabla

Para insertar los datos de prueba:

```bash
docker exec -i mysql-db mysql -u root -pmi_password < insert_mysql.sql
```

### Acceso al Contenedor

Para acceder al contenedor:

```bash
docker exec -it mysql-db mysql -u root -p
```

### Verificación de Datos

Para verificar que los registros se insertaron correctamente:

```bash
docker exec -it mysql-db mysql -u root -pmi_password -e "USE GestionProyectos; SELECT COUNT(*) FROM Empresa;"
```

### Reinicio del Contenedor

```bash
docker start mysql-db
docker stop mysql-db
```

---

## Contenedor PostgreSQL

### Comando Básico: `docker run --name postgres-db -e POSTGRES_PASSWORD=mi_password -p 5432:5432 -d postgres:13`

Este comando crea e inicia un contenedor PostgreSQL básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`--name postgres-db`**: Asigna el identificador "postgres-db" al contenedor.
- **`-e POSTGRES_PASSWORD=mi_password`**: Establece la contraseña del usuario postgres.
- **`-p 5432:5432`**: Mapea el puerto 5432 del contenedor al puerto 5432 del host.
- **`-d`**: Ejecuta el contenedor en segundo plano (detached).
- **`postgres:13`**: Utiliza la imagen oficial de PostgreSQL versión 13.

**Resultado**: Inicia un contenedor PostgreSQL básico listo para conexiones.

### Creación de Base de Datos y Tablas

Para crear la base de datos y tablas, ejecutar los siguientes comandos en secuencia:

```bash
# 1. Crear la base de datos (interactivo)
docker exec -it postgres-db psql -U postgres
CREATE DATABASE gestionproyectos;
\q

# 2. Crear las tablas y triggers
docker exec -i postgres-db psql -U postgres -d gestionproyectos < setup_postgres.sql
```

### Inserción de 1000 Registros por Tabla

Para insertar los datos de prueba:

```bash
docker exec -i postgres-db psql -U postgres -d gestionproyectos < insert_postgresql.sql
```

### Verificación de Datos

Para verificar que los registros se insertaron correctamente:

```bash
docker exec -it postgres-db psql -U postgres -d gestionproyectos -c "SELECT COUNT(*) FROM Empresa;"
```

### Acceso al Contenedor

Para acceder al contenedor:

```bash
docker exec -it postgres-db psql -U postgres
```

### Reinicio del Contenedor

```bash
docker start postgres-db
docker stop postgres-db
```

---

## Contenedor MongoDB

### Comando Básico: `docker run --name mongo-db -p 27017:27017 -d mongo:6.0`

Este comando crea e inicia un contenedor MongoDB básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`--name mongo-db`**: Asigna el identificador "mongo-db" al contenedor.
- **`-p 27017:27017`**: Mapea el puerto 27017 del contenedor al puerto 27017 del host.
- **`-d`**: Ejecuta el contenedor en segundo plano (detached).
- **`mongo:6.0`**: Utiliza la imagen oficial de MongoDB versión 6.0.

**Resultado**: Inicia un contenedor MongoDB básico listo para conexiones.

### Creación de Base de Datos y Colecciones

Para crear la base de datos y colecciones, ejecutar el script adaptado desde `message.txt` para MongoDB:

```bash
docker exec -i mongo-db mongosh < message_mongodb.js
```

### Inserción de 1000 Documentos por Colección

Para insertar los datos de prueba:

```bash
docker exec -i mongo-db mongosh < insert_mongodb.js
```

### Acceso al Contenedor

Para acceder al contenedor:

```bash
docker exec -it mongo-db mongosh
```

### Verificación de Datos

Para verificar que los documentos se insertaron correctamente:

```bash
docker exec -it mongo-db mongosh --eval "use GestionProyectos; db.Empresa.countDocuments();"
```

### Reinicio del Contenedor

```bash
docker start mongo-db
docker stop mongo-db
```

---

## Contenedor SQL Server

### Comando Básico: `docker run --name sqlserver-db -e ACCEPT_EULA=Y -e SA_PASSWORD=MiPassw0rd! -p 1433:1433 -v %cd%:/tmp -d mcr.microsoft.com/mssql/server:2019-latest`

Este comando crea e inicia un contenedor SQL Server básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`--name sqlserver-db`**: Asigna el identificador "sqlserver-db" al contenedor.
- **`-e ACCEPT_EULA=Y`**: Acepta los términos de la licencia de SQL Server.
- **`-e SA_PASSWORD=MiPassw0rd!`**: Establece la contraseña del usuario SA (debe cumplir con los requisitos de complejidad).
- **`-p 1433:1433`**: Mapea el puerto 1433 del contenedor al puerto 1433 del host.
- **`-d`**: Ejecuta el contenedor en segundo plano (detached).
- **`mcr.microsoft.com/mssql/server:2019-latest`**: Utiliza la imagen oficial de SQL Server 2019.

**Resultado**: Inicia un contenedor SQL Server básico listo para conexiones.

### Comando Recomendado (Usando Docker Compose)

Para una configuración más robusta y automatizada, se recomienda usar Docker Compose que maneja la inicialización automáticamente:

```bash
# Iniciar el contenedor SQL Server con inicialización automática
docker-compose -f docker-compose.sqlserver.yml up --abort-on-container-exit

# Para mantener el contenedor corriendo después de la inicialización
docker-compose -f docker-compose.sqlserver.yml up -d sqlserver
```

Este enfoque usa un contenedor de inicialización que ejecuta los scripts SQL automáticamente, evitando problemas de sincronización.

### Instalación de Herramientas Cliente

La imagen básica de SQL Server no incluye las herramientas cliente (`sqlcmd`). Para instalarlas:

```bash
# Acceder al contenedor como root
docker exec -it -u 0 sqlserver-db bash

# Dentro del contenedor, ejecutar:
apt-get update
apt-get install -y curl apt-transport-https gnupg
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
exit
```

### Creación de Base de Datos y Tablas

Para crear la base de datos y tablas usando el script adaptado para SQL Server:

```bash
docker exec -i sqlserver-db /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -C -i /tmp/message_sqlserver.sql
```

### Comando Manual (Paso a Paso)

Si prefieres hacerlo paso a paso después de instalar las herramientas:

```bash
# Crear BD y tablas
docker exec -i sqlserver-db /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -C -i /tmp/message_sqlserver.sql

# Insertar datos
docker exec -i sqlserver-db /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -C -i /tmp/insert_sqlserver.sql
```

### Verificación de Datos

Para verificar que los registros se insertaron correctamente:

```bash
# Usando un contenedor temporal de herramientas
docker run --rm -it --network docker-exercise_sqlserver-network mcr.microsoft.com/mssql-tools:latest /opt/mssql-tools/bin/sqlcmd -S sqlserver-db -U SA -P "MiPassw0rd!" -Q "USE GestionProyectos; SELECT COUNT(*) AS Total_Empresa FROM Empresa;"

# Para otras tablas
docker run --rm -it --network docker-exercise_sqlserver-network mcr.microsoft.com/mssql-tools:latest /opt/mssql-tools/bin/sqlcmd -S sqlserver-db -U SA -P "MiPassw0rd!" -Q "USE GestionProyectos; SELECT COUNT(*) AS Total_Cliente FROM Cliente;"
```

### Acceso al Contenedor

Para acceder al contenedor:

```bash
docker exec -it sqlserver-db /opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -C
```

### Reinicio del Contenedor

```bash
docker start sqlserver-db
docker stop sqlserver-db
```

### Errores Comunes con el Usuario SA

A veces puede aparecer un error como "Login failed for user 'SA'". Esto sucede porque:

- La contraseña no cumple con los requisitos de complejidad (debe tener al menos 8 caracteres, mayúsculas, minúsculas, números y símbolos).
- El contenedor no terminó de inicializarse completamente.
- Hay problemas de conexión o configuración.
- **Problema común**: Scripts con caracteres de retorno de carro (`\r`) al final de líneas, causando errores en Linux.

Para solucionarlo:
- Verifica que la contraseña sea fuerte y espera a que el contenedor esté listo antes de intentar conectarte.
- Si usas scripts creados en Windows, elimina los caracteres `\r` con: `docker run --rm -v %cd%:/work alpine sh -c "sed -i 's/\r$//' /work/init_sqlserver.sh"`
- Usa Docker Compose para una inicialización más confiable.

---

## Diferencias Clave entre Contenedores

| Aspecto | MySQL | PostgreSQL | MongoDB | SQL Server |
|---------|-------|------------|---------|------------|
| **Imagen** | mysql:8.0 | postgres:13 | mongo:6.0 | mcr.microsoft.com/mssql/server:2019-latest |
| **Tipo de DB** | Relacional SQL | Relacional SQL | NoSQL | Relacional SQL |
| **Puerto** | 3306 | 5432 | 27017 | 1433 |
| **Caso de Uso** | General | Avanzado | Documentos | Empresarial |

Para entornos de producción se recomienda especificar versiones explícitas y configurar volúmenes para persistencia de datos.