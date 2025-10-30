# Documentación: Instalación de Motores de Base de Datos en Linux Puro (Alpine)

## Paso 1: Crear e Iniciar Contenedor Linux Puro

### Comando: `docker run -it --name linux-db alpine:latest`

![Creación del contenedor Linux puro](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_01_creacion_contenedor.png)

Este comando crea e inicia un contenedor Linux puro (Alpine) básico con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`-it`**: Habilita el modo interactivo con terminal asignada.
- **`--name linux-db`**: Asigna el identificador "linux-db" al contenedor.
- **`alpine:latest`**: Utiliza la imagen Alpine Linux más reciente (distribución Linux minimalista).

**Resultado**: Inicia una sesión interactiva de terminal dentro del contenedor Linux puro Alpine.

## Paso 2: Configuración Inicial del Contenedor

### Comandos de actualización e instalación de herramientas:

```bash
apk update && apk upgrade
apk add bash wget curl gnupg lsb-release ca-certificates
```

![Actualización del sistema](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_02_apk_update.png)
![Instalación de herramientas](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_03_instalacion_herramientas.png)

### Descripción:

- **`apk update`**: Actualiza la lista de paquetes disponibles desde los repositorios de Alpine.
- **`apk upgrade`**: Actualiza todos los paquetes instalados a sus versiones más recientes.
- **`apk add`**: Instala herramientas necesarias para instalaciones posteriores.

Esta configuración inicial prepara el contenedor con las herramientas y dependencias necesarias para instalar múltiples motores de base de datos.

## Paso 3: Instalación de MySQL

### Comando: `apk add mysql mysql-client`

![Instalación de MySQL](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_04_instalacion_mysql.png)

Este comando instala MySQL en el contenedor Alpine:

- **`apk add mysql mysql-client`**: Instala el servidor MySQL y las herramientas cliente.

### Gestión del Servicio MySQL

Después de la instalación, inicializa e inicia el servicio:

```bash
mysql_install_db --user=mysql --datadir=/var/lib/mysql
rc-service mariadb start
rc-update add mariadb
```

![Inicio del servicio MySQL](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_05_inicio_mysql.png)

### Descripción:

- **`mysql_install_db`**: Inicializa la base de datos MySQL.
- **`rc-service mariadb start`**: Inicia el servicio MariaDB (MySQL en Alpine).
- **`rc-update add mariadb`**: Agrega MariaDB al inicio automático.

## Paso 4: Instalación de PostgreSQL

### Comando: `apk add postgresql postgresql-contrib`

![Instalación de PostgreSQL](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_06_instalacion_postgresql.png)

Este comando instala PostgreSQL en el contenedor Alpine:

- **`apk add postgresql postgresql-contrib`**: Instala PostgreSQL y herramientas complementarias.

### Gestión del Servicio PostgreSQL

Inicializa e inicia el servicio PostgreSQL:

```bash
mkdir -p /run/postgresql
chown postgres:postgres /run/postgresql
su-exec postgres initdb -D /var/lib/postgresql/data
rc-service postgresql start
rc-update add postgresql
```

![Inicio del servicio PostgreSQL](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_07_inicio_postgresql.png)

### Descripción:

- **`mkdir -p /run/postgresql`**: Crea el directorio para el socket de PostgreSQL.
- **`chown postgres:postgres`**: Cambia el propietario del directorio.
- **`su-exec postgres initdb`**: Inicializa la base de datos PostgreSQL.
- **`rc-service postgresql start`**: Inicia el servicio PostgreSQL.

## Paso 5: Instalación de MongoDB

### Comandos de instalación:

```bash
apk add mongodb mongodb-tools
mkdir -p /data/db
chown mongodb:mongodb /data/db
rc-service mongodb start
rc-update add mongodb
```

![Instalación de MongoDB](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_08_instalacion_mongodb.png)
![Inicio del servicio MongoDB](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_09_inicio_mongodb.png)

Este comando instala MongoDB en el contenedor Alpine:

- **`apk add mongodb mongodb-tools`**: Instala MongoDB y sus herramientas.
- **`mkdir -p /data/db`**: Crea el directorio de datos.
- **`chown mongodb:mongodb`**: Cambia el propietario del directorio.
- **`rc-service mongodb start`**: Inicia el servicio MongoDB.

### Verificación de MongoDB

```bash
mongosh --eval "db.runCommand('ping')"
```

![Verificación de MongoDB](capturas/third%20exercise%20bds%20in%20linux/alpine/alpine_10_verificacion_mongodb.png)

### Descripción:

- **`mongosh --eval "db.runCommand('ping')"`**: Verifica que MongoDB esté funcionando correctamente.

## Paso 6: Instalación de SQL Server (Contenedor Separado)

**Nota:** SQL Server no es compatible con Alpine Linux debido a dependencias de glibc. Microsoft SQL Server requiere un sistema basado en Debian/Ubuntu o Red Hat. La solución es usar un contenedor separado que se conecte al mismo network.

### Comando para SQL Server:

```bash
# SQL Server requiere contenedor separado en Alpine Linux
docker run -d --name sqlserver-alpine --network container:linux-db -e ACCEPT_EULA=Y -e SA_PASSWORD=MiPassw0rd! mcr.microsoft.com/mssql/server:2019-latest
```

![SQL Server en contenedor separado](capturas/third%20exercise%20bds%20in%20linux/sqlserver/sqlserver_01_contenedor_separado.png)

### Creación de Base de Datos y Datos:

```bash
# Crear base de datos
docker run --rm -i --network container:linux-db mcr.microsoft.com/mssql-tools:latest /opt/mssql-tools/bin/sqlcmd -S sqlserver-alpine -U SA -P "MiPassw0rd!" -Q "CREATE DATABASE GestionProyectos;"

# Copiar y ejecutar scripts
docker cp message_sqlserver.sql linux-db:/tmp/
docker cp insert_sqlserver.sql linux-db:/tmp/
docker run --rm -i --network container:linux-db -v "C:\Users\Hermes\Desktop\Docker-exercise:/host" mcr.microsoft.com/mssql-tools:latest /opt/mssql-tools/bin/sqlcmd -S sqlserver-alpine -U SA -P "MiPassw0rd!" -i /host/message_sqlserver.sql
docker run --rm -i --network container:linux-db -v "C:\Users\Hermes\Desktop\Docker-exercise:/host" mcr.microsoft.com/mssql-tools:latest /opt/mssql-tools/bin/sqlcmd -S sqlserver-alpine -U SA -P "MiPassw0rd!" -i /host/insert_sqlserver.sql
```

![Verificación de datos SQL Server](capturas/third%20exercise%20bds%20in%20linux/sqlserver/sqlserver_02_verificacion_datos.png)

## Paso 7: Creación de Base de Datos y Datos de Prueba

### MySQL

```bash
# Crear base de datos
docker exec -i linux-db mysql -u root -e "CREATE DATABASE GestionProyectos;"

# Copiar y ejecutar scripts
docker cp message_mysql.sql linux-db:/tmp/
docker cp insert_mysql.sql linux-db:/tmp/
docker exec -i linux-db mysql -u root GestionProyectos < /tmp/message_mysql.sql
docker exec -i linux-db mysql -u root GestionProyectos < /tmp/insert_mysql.sql
```

![MySQL - Creación de BD y datos](capturas/third%20exercise%20bds%20in%20linux/mysql/mysql_01_bd_datos.png)

### PostgreSQL

```bash
# Crear base de datos
docker exec -i linux-db bash -c "su-exec postgres createdb gestionproyectos"

# Copiar y ejecutar scripts
docker cp setup_postgres.sql linux-db:/tmp/
docker cp insert_postgresql.sql linux-db:/tmp/
docker exec -i linux-db bash -c "su-exec postgres psql -d gestionproyectos" < /tmp/setup_postgres.sql
docker exec -i linux-db bash -c "su-exec postgres psql -d gestionproyectos" < /tmp/insert_postgresql.sql
```

![PostgreSQL - Creación de BD y datos](capturas/third%20exercise%20bds%20in%20linux/postgresql/postgresql_01_bd_datos.png)

### MongoDB

**Nota:** MongoDB se instala en un contenedor separado debido a incompatibilidades con Alpine Linux.

```bash
# Copiar scripts al host
docker cp message_mongodb.js linux-db:/tmp/
docker cp insert_mongodb.js linux-db:/tmp/

# Ejecutar scripts usando el contenedor MongoDB
type message_mongodb.js | docker run --rm -i --network container:linux-db mongo:6.0 mongosh
type insert_mongodb.js | docker run --rm -i --network container:linux-db mongo:6.0 mongosh
```

![MongoDB - Copiar scripts](capturas/third%20exercise%20bds%20in%20linux/mongodb/mongodb_03_copiar_scripts.png)
![MongoDB - Ejecutar message.js](capturas/third%20exercise%20bds%20in%20linux/mongodb/mongodb_04_ejecutar_message.png)
![MongoDB - Ejecutar insert.js](capturas/third%20exercise%20bds%20in%20linux/mongodb/mongodb_05_ejecutar_insert.png)

## Paso 8: Verificación Final

### Conteo de Registros en Todas las Bases de Datos

```bash
# MySQL
docker exec -i linux-db mysql -u root GestionProyectos -e "SELECT 'MySQL' as Motor, COUNT(*) as Empresa FROM Empresa;"

# PostgreSQL
docker exec -i linux-db su-exec postgres psql -d gestionproyectos -c "SELECT 'PostgreSQL' as Motor, COUNT(*) as Empresa FROM Empresa;"

# MongoDB
docker exec -i linux-db mongosh --eval "use GestionProyectos; db.Empresa.countDocuments();"
```

![Verificación final de todos los motores](capturas/third%20exercise%20bds%20in%20linux/verification/verification_01_final_count.png)

## Diferencias Clave: Linux Puro vs Ubuntu

| Aspecto | Linux Puro (Alpine) | Ubuntu |
|---------|-------------------|--------|
| **Distribución Base** | Alpine Linux (musl libc) | Ubuntu (glibc) |
| **Gestor de Paquetes** | apk | apt |
| **Sistema Init** | OpenRC | systemd |
| **Tamaño de Imagen** | ~5MB | ~29MB |
| **MySQL** | MariaDB | MySQL |
| **SQL Server** | No compatible | Compatible |
| **Sintaxis Comandos** | Diferente | Estándar |
| **Compatibilidad** | Limitada con software propietario | Alta compatibilidad |
| **Enfoque** | Seguridad y minimalismo | Facilidad de uso |

## Notas Importantes sobre Linux Puro

- **Alpine Linux** es una distribución Linux minimalista y segura
- Usa **musl libc** en lugar de glibc (como Ubuntu)
- **apk** es el gestor de paquetes (no apt)
- **OpenRC** es el sistema init (no systemd)
- SQL Server no es compatible debido a dependencias de glibc
- Los comandos de servicio usan **rc-service** en lugar de service
- Alpine es mucho más ligero pero tiene menos paquetes disponibles
- Ideal para contenedores y entornos de producción minimalistas