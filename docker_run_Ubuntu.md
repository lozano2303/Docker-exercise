# Documentación: Instalación de Múltiples Motores de Base de Datos en Ubuntu

## Paso 1: Crear e Iniciar Contenedor Ubuntu

### Comando: `docker run -it --name ubuntu-db ubuntu:22.04`

![Creación del contenedor Ubuntu](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/mysql_01_creacion_contenedor.png)

Este comando crea e inicia un contenedor Ubuntu básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`-it`**: Habilita el modo interactivo con terminal asignada.
- **`--name ubuntu-db`**: Asigna el identificador "ubuntu-db" al contenedor.
- **`ubuntu:22.04`**: Utiliza la imagen Ubuntu versión 22.04 LTS.

**Resultado**: Inicia una sesión interactiva de terminal dentro del contenedor Ubuntu 22.04.

## Paso 2: Configuración Inicial del Contenedor

### Comandos de actualización e instalación de herramientas:

```bash
apt update && apt upgrade -y
apt install -y wget curl gnupg lsb-release software-properties-common apt-transport-https
```

![Actualización del sistema](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/mysql_02_apt_update.png)
![Instalación de herramientas](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/mysql_03_instalacion_herramientas.png)
![Instalación completada](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/mysql_04_instalacion_herramientas_finish.png)

### Descripción:

- **`apt update`**: Actualiza la lista de paquetes disponibles desde los repositorios.
- **`apt upgrade -y`**: Actualiza todos los paquetes instalados a sus versiones más recientes.
- **`apt install -y`**: Instala herramientas necesarias para instalaciones posteriores.

Esta configuración inicial prepara el contenedor con las herramientas y dependencias necesarias para instalar múltiples motores de base de datos.

## Paso 3: Instalación de MySQL

### Comando: `apt install -y mysql-server`

![Instalación de MySQL](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/mysql_05_inicio_servicio.png)

Este comando instala MySQL Server en el contenedor Ubuntu:

- **`apt install -y mysql-server`**: Instala el servidor MySQL junto con todas sus dependencias.

### Gestión del Servicio MySQL

Después de la instalación, inicia y verifica el estado del servicio:

```bash
service mysql start
service mysql status
```

### Descripción:

- **`service mysql start`**: Inicia el servicio MySQL en el contenedor.
- **`service mysql status`**: Verifica el estado actual del servicio MySQL.

### Creación de Base de Datos y Tablas

```bash
# Crear base de datos
mysql -u root -p
CREATE DATABASE GestionProyectos;
USE GestionProyectos;
\q

# Copiar y ejecutar script de esquema
docker cp message_mysql.sql ubuntu-db:/tmp/
type message_mysql.sql | docker exec -i ubuntu-db mysql -u root -pmi_password GestionProyectos
```

![Creación de BD MySQL](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/create%20database.png)

### Inserción de 1000 Registros

```bash
# Copiar y ejecutar script de inserción
docker cp insert_mysql.sql ubuntu-db:/tmp/
type insert_mysql.sql | docker exec -i ubuntu-db mysql -u root -pmi_password GestionProyectos
```

![Inserción de datos MySQL](capturas/second%20exercise%20bds%20in%20ubuntu/mysql/create%20tables%20and%20insert%201000%20registers.png)

### Verificación de Registros

```bash
docker exec -it ubuntu-db mysql -u root -pmi_password GestionProyectos -e "SELECT COUNT(*) FROM Empresa;"
```

## Paso 4: Instalación de PostgreSQL

### Comando: `apt install -y postgresql postgresql-contrib`

![Instalación de PostgreSQL](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/postgresql_01_instalacion.png)
![Instalación completada](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/postgresql_02_instalacion_finish.png)

Este comando instala PostgreSQL en el contenedor Ubuntu:

- **`apt install -y postgresql postgresql-contrib`**: Instala PostgreSQL y herramientas complementarias.

### Gestión del Servicio PostgreSQL

Inicia el servicio PostgreSQL:

```bash
service postgresql start
```

![Inicio del servicio PostgreSQL](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/postgresql_03_inicio_servicio.png)

### Creación de Base de Datos

```bash
# Crear base de datos como usuario postgres
docker exec -it ubuntu-db bash -c "su - postgres -c psql"
CREATE DATABASE gestionproyectos;
\q
```

![Creación de BD PostgreSQL](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/create%20database.png)

### Creación de Tablas y Triggers

```bash
# Copiar y ejecutar script de esquema
docker cp setup_postgres.sql ubuntu-db:/tmp/
type setup_postgres.sql | docker exec -i ubuntu-db bash -c "su - postgres -c 'psql -d gestionproyectos'"
```

![Creación de tablas PostgreSQL](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/create%20tables.png)

### Inserción de 1000 Registros

```bash
# Copiar y ejecutar script de inserción
docker cp insert_postgresql.sql ubuntu-db:/tmp/
type insert_postgresql.sql | docker exec -i ubuntu-db bash -c "su - postgres -c 'psql -d gestionproyectos'"
```

![Inserción de datos PostgreSQL](capturas/second%20exercise%20bds%20in%20ubuntu/postgresql/insert%20and%20list.png)

### Descripción:

- **`service postgresql start`**: Inicia el servicio PostgreSQL en el contenedor.
- **`CREATE DATABASE gestionproyectos`**: Crea la base de datos del proyecto.
- **Scripts SQL**: Crean tablas, triggers y datos de prueba.

## Paso 5: Instalación de MongoDB

### Comandos de instalación:

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb.gpg
echo "deb [ arch=amd64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt update
apt install -y mongodb-org
mkdir -p /data/db
mongod --fork --logpath /var/log/mongodb.log
```

![Instalación de MongoDB](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/mongodb_01_instalacion.png)
![Instalación completada](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/mongodb_02_instalacion_finish.png)
![Inicio en modo fork](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/mongodb_03_inicio_fork.png)

Este comando instala MongoDB en el contenedor Ubuntu:

- **`curl -fsSL`**: Descarga la clave pública de MongoDB.
- **`gpg --dearmor -o`**: Convierte la clave a formato binario.
- **`echo "deb [...]`**: Agrega el repositorio oficial de MongoDB.
- **`apt update`**: Actualiza la lista de paquetes.
- **`apt install -y mongodb-org`**: Instala MongoDB.
- **`mkdir -p /data/db`**: Crea el directorio de datos.
- **`mongod --fork --logpath /var/log/mongodb.log`**: Inicia MongoDB en modo fork.

### Creación de Base de Datos y Colecciones

```bash
# Copiar y ejecutar script de esquema
docker cp message_mongodb.js ubuntu-db:/tmp/
type message_mongodb.js | docker exec -i ubuntu-db mongosh
```

![Creación de BD MongoDB](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/create%20database.png)

### Inserción de 1000 Documentos

```bash
# Copiar y ejecutar script de inserción
docker cp insert_mongodb.js ubuntu-db:/tmp/
type insert_mongodb.js | docker exec -i ubuntu-db mongosh --quiet
```

![Inserción de datos MongoDB](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/1000%20insertions.png)

### Verificación de MongoDB

```bash
mongosh --eval "db.runCommand('ping')"
docker exec -i ubuntu-db mongosh --eval "use GestionProyectos; db.Empresa.countDocuments()"
```

![Verificación de MongoDB](capturas/second%20exercise%20bds%20in%20ubuntu/mongodb/mongodb_04_verificacion.png)

### Descripción:

- **`mongosh --eval "db.runCommand('ping')"`**: Verifica que MongoDB esté funcionando correctamente.
- **Scripts JS**: Crean la base de datos, colecciones, índices y datos de prueba.

## Paso 6: Instalación de SQL Server 2022

### Comandos de configuración del repositorio:

```bash
apt-get update
apt-get install -y curl gnupg2 software-properties-common
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list)"
apt-get update
```

![Configuración de clave GPG](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_01_clave_gpg.png)
![Configuración del repositorio](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_02_config_repositorio.png)
![Actualización de paquetes](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_03_apt_update.png)

### Instalación de SQL Server:

```bash
apt-get install -y mssql-server
```

![Instalación de SQL Server](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_04_instalacion.png)
![Instalación completada](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_05_instalacion_finish.png)

### Configuración inicial:

```bash
/opt/mssql/bin/mssql-conf setup
```

![Configuración del setup](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_06_setup.png)

### Inicio manual del servicio:

```bash
/opt/mssql/bin/sqlservr
```

![Inicio del servicio](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_07_inicio_manual.png)
![Servicio iniciado](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_08_inicio_finish.png)

### Instalación de herramientas cliente (falló):

```bash
apt-get install -y mssql-tools unixodbc-dev
```

![Error en instalación de herramientas](capturas/second%20exercise%20bds%20in%20ubuntu/sqlserver/sqlserver_09_herramientas_error.png)

### Descripción:

- **`apt-get install -y mssql-server`**: Instala SQL Server 2022.
- **`/opt/mssql/bin/mssql-conf setup`**: Configura la licencia y contraseña SA.
- **`/opt/mssql/bin/sqlservr`**: Inicia manualmente el servicio SQL Server.
- **`apt-get install -y mssql-tools unixodbc-dev`**: Intento fallido de instalar herramientas cliente.

## Respaldo y Restauración del Contenedor

### Crear Respaldo

Para respaldar el contenedor configurado:

```bash
docker stop ubuntu-db
docker commit ubuntu-db ubuntu-db-backup
docker save ubuntu-db-backup -o ubuntu-db-backup.tar
```

### Descripción:

- **`docker stop ubuntu-db`**: Detiene el contenedor.
- **`docker commit ubuntu-db ubuntu-db-backup`**: Crea una imagen de respaldo.
- **`docker save ubuntu-db-backup -o ubuntu-db-backup.tar`**: Exporta la imagen a un archivo TAR.

### Restaurar Respaldo

Para restaurar en un nuevo contenedor:

```bash
docker run -it --name ubuntu20-db ubuntu:20.04 bash
docker cp ubuntu-db-backup.tar ubuntu20-db:/root/
docker start ubuntu20-db
docker exec -it ubuntu20-db bash
cd /root
tar -xvf ubuntu-db-backup.tar
ls -l /root
```

### Descripción:

- **`docker run -it --name ubuntu20-db ubuntu:20.04 bash`**: Crea nuevo contenedor.
- **`docker cp ubuntu-db-backup.tar ubuntu20-db:/root/`**: Copia el respaldo.
- **`docker start ubuntu20-db`**: Inicia el contenedor.
- **`docker exec -it ubuntu20-db bash`**: Accede al contenedor.
- **`tar -xvf ubuntu-db-backup.tar`**: Extrae el respaldo.


