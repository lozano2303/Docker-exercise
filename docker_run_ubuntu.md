# Documentación: Comandos Docker Run

## Comando 1: `docker run -it --name ubuntu-db ubuntu:22.04`

![Docker run output](https://raw.githubusercontent.com/kensarusi/images/main/docker%201.jpg)

Este comando crea e inicia un nuevo contenedor Docker con la siguiente configuración:

- **`docker run`**: Crea e inicia un contenedor a partir de una imagen.
- **`-it`**: Habilita el modo interactivo con terminal asignada:
  - `-i`: Mantiene STDIN abierto para recibir entrada del usuario.
  - `-t`: Asigna una pseudoterminal para visualizar la salida.
- **`--name ubuntu-db`**: Asigna el identificador "ubuntu-db" al contenedor.
- **`ubuntu:22.04`**: Especifica la imagen Ubuntu versión 22.04 LTS.

**Resultado**: Inicia una sesión interactiva de terminal dentro del contenedor Ubuntu 22.04.

---

## Comando 2: `docker run -it --name ubuntu-db ubuntu`

Este comando es equivalente al anterior con una variación importante:

- **`ubuntu`**: Utiliza la etiqueta `latest` por defecto, correspondiendo a la versión más reciente de Ubuntu disponible en Docker Hub.

**Resultado**: Inicia una sesión interactiva de terminal dentro del contenedor Ubuntu (versión más reciente).

---

## Diferencias Clave

| Aspecto | Comando 1 | Comando 2 |
|---------|-----------|-----------|
| **Versión especificada** | Ubuntu 22.04 LTS | Ubuntu latest |
| **Consistencia de versión** | Fija y predecible | Sujeta a cambios |
| **Caso de uso recomendado** | Producción | Desarrollo/Pruebas |

Para entornos de producción se recomienda especificar versiones explícitas para garantizar reproducibilidad y estabilidad.

---

## Configuración Inicial del Contenedor

Una vez dentro del contenedor, es recomendable actualizar los repositorios e instalar herramientas esenciales:

```bash
apt update && apt upgrade -y
apt install -y wget curl gnupg lsb-release software-properties-common apt-transport-https
```

![Resultado apt update y apt upgrade](https://raw.githubusercontent.com/kensarusi/images/main/docker%202.jpg)

### Descripción de los comandos:

- **`apt update`**: Actualiza la lista de paquetes disponibles desde los repositorios.
- **`apt upgrade -y`**: Actualiza todos los paquetes instalados a sus versiones más recientes (la bandera `-y` confirma automáticamente).
- **`apt install -y`**: Instala los siguientes paquetes:
  - **`wget`**: Utilidad para descargar archivos desde URLs.
  - **`curl`**: Herramienta para transferencia de datos con URLs.
  - **`gnupg`**: Sistema de encriptación y firma digital.
  - **`lsb-release`**: Identifica la versión del sistema.
  - **`software-properties-common`**: Herramienta para gestionar repositorios de software.
  - **`apt-transport-https`**: Permite que APT acceda a repositorios mediante HTTPS.

Esta configuración inicial prepara el contenedor con las herramientas y dependencias necesarias para instalaciones posteriores de software adicional.

---

## Instalación de MySQL 

Una vez completada la actualización de paquetes, se puede proceder a instalar MySQL Server:

```bash
apt install -y mysql-server
```

![Instalación de MySQL Server](https://raw.githubusercontent.com/kensarusi/images/main/docker%203.jpg)

### Descripción:

- **`apt install -y mysql-server`**: Instala el servidor MySQL junto con todas sus dependencias. La bandera `-y` confirma automáticamente la instalación sin solicitar confirmación.

---

## Gestión del Servicio MySQL

Después de la instalación, es necesario iniciar y verificar el estado del servicio MySQL:

```bash
service mysql start
service mysql status
```

![Inicio y estado de MySQL](https://raw.githubusercontent.com/kensarusi/images/main/docker%204.jpg)

### Descripción:

- **`service mysql start`**: Inicia el servicio MySQL en el contenedor.
- **`service mysql status`**: Verifica el estado actual del servicio MySQL, confirmando que está ejecutándose correctamente.

---

## Reinicio del Contenedor y Acceso

Para salir del contenedor y reiniciarlo posteriormente, utiliza los siguientes comandos:

```bash
docker start ubuntu-db
docker exec -it ubuntu-db bash
```

![Acceso al contenedor con docker exec](https://raw.githubusercontent.com/kensarusi/images/main/docker%206.jpg)

### Descripción:

- **`docker start ubuntu-db`**: Inicia el contenedor detenido llamado "ubuntu-db".
- **`docker exec -it ubuntu-db bash`**: Ejecuta una terminal interactiva (bash) dentro del contenedor en ejecución, permitiendo acceder a él nuevamente sin crear un nuevo contenedor.

---

## Instalación de PostgreSQL

Además de MySQL, también se puede instalar PostgreSQL como sistema de gestión de bases de datos alternativo:

```bash
apt install -y postgresql postgresql-contrib
service postgresql start
```

![Instalación de PostgreSQL](https://raw.githubusercontent.com/kensarusi/images/main/docker%207.jpg)

### Descripción:

- **`apt install -y postgresql postgresql-contrib`**: Instala PostgreSQL y las herramientas complementarias (postgresql-contrib) que incluyen extensiones y utilidades adicionales.
- **`service postgresql start`**: Inicia el servicio PostgreSQL en el contenedor.

---

## Instalación de MongoDB

También se puede instalar MongoDB como una opción adicional de base de datos NoSQL:

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb.gpg
echo "deb [ arch=amd64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt update
apt install -y mongodb-org
mkdir -p /data/db
service mongod start
```

![Configuración de claves de MongoDB](https://raw.githubusercontent.com/kensarusi/images/main/docker%209.jpg)

![Adición del repositorio de MongoDB](https://raw.githubusercontent.com/kensarusi/images/main/docker%2010.jpg)

![Instalación de MongoDB](https://raw.githubusercontent.com/kensarusi/images/main/docker%2011.jpg)

![Creación del directorio de datos](https://raw.githubusercontent.com/kensarusi/images/main/docker%2012.jpg)

![Inicio del servicio MongoDB](https://raw.githubusercontent.com/kensarusi/images/main/docker%2013.jpg)

### Descripción:

- **`curl -fsSL`**: Descarga de forma segura el archivo de clave pública de MongoDB desde su repositorio oficial.
- **`gpg --dearmor -o`**: Convierte la clave ASCII a formato binario GPG y la guarda en `/usr/share/keyrings/mongodb.gpg`.
- **`echo "deb [ arch=amd64 signed-by=...]...`**: Agrega el repositorio oficial de MongoDB 6.0 a la lista de fuentes de APT con verificación de firma.
- **`apt update`**: Actualiza la lista de paquetes con el nuevo repositorio.
- **`apt install -y mongodb-org`**: Instala MongoDB y sus herramientas asociadas.
- **`mkdir -p /data/db`**: Crea el directorio donde MongoDB almacenará sus datos.
- **`service mongod start`**: Inicia el servicio MongoDB (mongod es el demonio de MongoDB).

---

## Inicio de MongoDB en Modo Fork

Alternativamente, se puede iniciar MongoDB en modo fork con un archivo de log específico:

```bash
mkdir -p /data/db
mongod --fork --logpath /var/log/mongodb.log
```

### Descripción:

- **`mkdir -p /data/db`**: Crea el directorio donde MongoDB almacenará sus datos.
- **`mongod --fork --logpath /var/log/mongodb.log`**: Inicia el demonio de MongoDB en segundo plano (fork) y redirige los logs a un archivo específico en `/var/log/mongodb.log`.

Con esto, el contenedor ubuntu-db queda configurado con herramientas esenciales, MySQL Server, PostgreSQL y MongoDB, listo para ser utilizado como servidor completo de bases de datos.

---

## Respaldo y Exportación del Contenedor

Una vez configurado el contenedor con todas las bases de datos, es recomendable hacer un respaldo para preservar la configuración:

```bash
docker stop ubuntu-db
docker commit ubuntu-db ubuntu-db-backup
docker save ubuntu-db-backup -o ubuntu-db-backup.tar
```

![Respaldo y exportación del contenedor](https://raw.githubusercontent.com/kensarusi/images/main/docker%2014.jpg)

### Descripción:

- **`docker stop ubuntu-db`**: Detiene la ejecución del contenedor ubuntu-db.
- **`docker commit ubuntu-db ubuntu-db-backup`**: Crea una nueva imagen a partir del contenedor actual, preservando todos los cambios y configuraciones realizadas. Esta imagen se etiqueta como "ubuntu-db-backup".
- **`docker save ubuntu-db-backup -o ubuntu-db-backup.tar`**: Exporta la imagen creada a un archivo TAR comprimido (`ubuntu-db-backup.tar`), que puede ser transferido, almacenado o compartido fácilmente.

Este proceso permite respaldar toda la configuración del contenedor en un archivo, facilitando su reutilización posterior o compartición con otros usuarios.

---

## Restauración del Respaldo en un Nuevo Contenedor

Para restaurar el respaldo en un nuevo contenedor con una versión diferente de Ubuntu:

```bash
docker run -it --name ubuntu20-db ubuntu:20.04 bash
docker cp ubuntu-db-backup.tar ubuntu20-db:/root/
```

![Creación de nuevo contenedor y transferencia del respaldo](https://raw.githubusercontent.com/kensarusi/images/main/docker%2015.jpg)

### Descripción:

- **`docker run -it --name ubuntu20-db ubuntu:20.04 bash`**: Crea e inicia un nuevo contenedor basado en Ubuntu 20.04 con el nombre "ubuntu20-db" y abre una terminal bash interactiva.
- **`docker cp ubuntu-db-backup.tar ubuntu20-db:/root/`**: Copia el archivo de respaldo (ubuntu-db-backup.tar) desde la máquina host al nuevo contenedor en el directorio `/root/`.

Este procedimiento permite transferir la configuración completa a un nuevo contenedor con una versión diferente de Ubuntu o en otra máquina, facilitando la portabilidad y reutilización de ambientes configurados.

---

## Extracción y Verificación del Respaldo

Una vez que el archivo de respaldo se encuentra en el nuevo contenedor, se procede a extraerlo y verificar su contenido:

```bash
docker start ubuntu20-db
docker exec -it ubuntu20-db bash
cd /root
tar -xvf ubuntu-db-backup.tar
ls -l /root
```

![Transferencia del archivo de respaldo](https://raw.githubusercontent.com/kensarusi/images/main/docker%2019.jpg)

![Inicio del contenedor y acceso](https://raw.githubusercontent.com/kensarusi/images/main/docker%2020.jpg)

![Verificación de la extracción del respaldo](https://raw.githubusercontent.com/kensarusi/images/main/docker%2022.jpg)

### Descripción:

- **`docker start ubuntu20-db`**: Inicia el contenedor ubuntu20-db que fue creado anteriormente.
- **`docker exec -it ubuntu20-db bash`**: Ejecuta una terminal interactiva bash dentro del contenedor en ejecución.
- **`cd /root`**: Cambia al directorio raíz del usuario, donde se encuentra el archivo de respaldo.
- **`tar -xvf ubuntu-db-backup.tar`**: Extrae el archivo TAR mostrando verbosamente el contenido extraído (`-v` = verbose, `-x` = extract, `-f` = file).
- **`ls -l /root`**: Lista los archivos en el directorio raíz para verificar que la extracción fue exitosa y confirmar que el archivo ubuntu-db-backup.tar está presente.

Con este proceso, se ha completado la transferencia y restauración del respaldo del contenedor en un nuevo ambiente con Ubuntu 20.04, permitiendo reutilizar toda la configuración previamente establecida en el contenedor ubuntu-db.

---

## Instalación de SQL Server en Ubuntu 20.04

Una vez en el nuevo contenedor, es posible instalar SQL Server de Microsoft como una opción adicional:

```bash
apt-get update
apt-get install -y curl gnupg2 software-properties-common
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"
apt-get update
apt-get install -y mssql-server
/opt/mssql/bin/mssql-conf setup
```

![Actualización de repositorios en Ubuntu 20.04](https://raw.githubusercontent.com/kensarusi/images/main/images/22.jpg)

![Descarga de claves y configuración de repositorio Microsoft](https://raw.githubusercontent.com/kensarusi/images/main/images/23.jpg)

![Instalación de SQL Server](https://raw.githubusercontent.com/kensarusi/images/main/images/24.jpg)

![Configuración inicial de SQL Server](https://raw.githubusercontent.com/kensarusi/images/main/images/25.jpg)

### Descripción:

- **`apt-get update`**: Actualiza la lista de paquetes disponibles.
- **`apt-get install -y curl gnupg2 software-properties-common`**: Instala herramientas necesarias para descargar claves y gestionar repositorios.
- **`curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -`**: Descarga e importa la clave pública de Microsoft para validar paquetes.
- **`add-apt-repository "$(curl ...)`**: Agrega el repositorio oficial de SQL Server 2019 para Ubuntu 20.04.
- **`apt-get install -y mssql-server`**: Instala SQL Server desde el repositorio de Microsoft.
- **`/opt/mssql/bin/mssql-conf setup`**: Ejecuta el asistente de configuración inicial de SQL Server, solicitando la edición de licencia y contraseña de administrador (SA).

Este proceso permite agregar SQL Server como una cuarta opción de base de datos relacional al contenedor, complementando MySQL, PostgreSQL y MongoDB.
## Instalación y Configuración Final de SQL Server

```bash
/opt/mssql/bin/sqlservr
apt-get update
apt-get install -y mssql-tools unixodbc-dev
```

![Configuración de contraseña y licencia SQL Server](https://raw.githubusercontent.com/kensarusi/images/main/26.jpg)

![Inicio del servicio SQL Server](https://raw.githubusercontent.com/kensarusi/images/main/27.jpg)

![Instalación de herramientas cliente de SQL Server](https://raw.githubusercontent.com/kensarusi/images/main/28.jpg)

### Descripción:

1. **`/opt/mssql/bin/sqlservr`**  
   Inicia manualmente el servicio principal de SQL Server dentro del contenedor.  
   - Verifica el arranque del servidor y muestra logs del proceso.  
   - Confirma la inicialización correcta del motor de base de datos (`SQL Server is now ready for client connections`).

2. **`apt-get update`**  
   Actualiza los índices de los repositorios antes de instalar las herramientas cliente.

3. **`apt-get install -y mssql-tools unixodbc-dev`**  
   Instala las utilidades de línea de comandos para SQL Server (`sqlcmd`, `bcp`) y las dependencias necesarias para conectividad ODBC.

   > **Nota:** Si aparece el error  
   > `E: Unable to locate package mssql-tools`,  
   > asegúrate de haber agregado el repositorio oficial de Microsoft con:
   >
   > ```bash
   > curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
   > add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
   > apt-get update
   > ```

### Resultado esperado

Tras estos pasos, el contenedor tendrá SQL Server completamente operativo junto con las herramientas cliente.  
Podrás conectarte usando:

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'TuContraseñaSegura123'
```

Esto te permitirá ejecutar comandos SQL directamente desde el terminal del contenedor.

