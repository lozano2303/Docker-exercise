# Lista de Comandos para Crear Contenedores de Base de Datos e Insertar Datos

## 1. Creación de Contenedores Básicos

### MySQL
```bash
docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=mi_password -p 3306:3306 -d mysql:8.0
```

### PostgreSQL
```bash
docker run --name postgres-db -e POSTGRES_PASSWORD=mi_password -p 5432:5432 -d postgres:13
```

### MongoDB
```bash
docker run --name mongo-db -p 27017:27017 -d mongo:6.0
```

### SQL Server
```bash
docker run --name sqlserver-db -e ACCEPT_EULA=Y -e SA_PASSWORD=MiPassw0rd! -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
```

## 2. Creación de Bases de Datos y Tablas

### MySQL
```bash
docker exec -i mysql-db mysql -u root -pmi_password < message_mysql.sql
```

### PostgreSQL
```bash
docker exec -i postgres-db psql -U postgres < message_postgresql.sql
```

### MongoDB
```bash
docker exec -i mongo-db mongo < message_mongodb.js
```

### SQL Server
```bash
docker exec -i sqlserver-db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i message.txt
```

## 3. Inserción de 1000 Registros por Tabla

### MySQL
```bash
docker exec -i mysql-db mysql -u root -pmi_password < insert_mysql.sql
```

### PostgreSQL
```bash
docker exec -i postgres-db psql -U postgres -d GestionProyectos < insert_postgresql.sql
```

### MongoDB
```bash
docker exec -i mongo-db mongo < insert_mongodb.js
```

### SQL Server
```bash
docker exec -i sqlserver-db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!' -i insert_sqlserver.sql
```

## 4. Acceso a los Contenedores (Opcional)

### MySQL
```bash
docker exec -it mysql-db mysql -u root -p
```

### PostgreSQL
```bash
docker exec -it postgres-db psql -U postgres
```

### MongoDB
```bash
docker exec -it mongo-db mongosh
```

### SQL Server
```bash
docker exec -it sqlserver-db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MiPassw0rd!'
```

## 5. Gestión de Contenedores

### Reinicio de Contenedores
```bash
docker start mysql-db postgres-db mongo-db sqlserver-db
```

### Detención de Contenedores
```bash
docker stop mysql-db postgres-db mongo-db sqlserver-db
```

### Eliminación de Contenedores
```bash
docker rm mysql-db postgres-db mongo-db sqlserver-db
```

## 6. Verificación de Funcionamiento

### Verificar que los contenedores están corriendo
```bash
docker ps
```

### Verificar logs de un contenedor específico
```bash
docker logs mysql-db
docker logs postgres-db
docker logs mongo-db
docker logs sqlserver-db