-- Crear base de datos y tablas para SQL Server
CREATE DATABASE GestionProyectos;
GO

USE GestionProyectos;
GO

-- =====================================
-- 1. Tablas
-- =====================================
IF OBJECT_ID('Empresa', 'U') IS NULL
CREATE TABLE Empresa (
    id_empresa INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20),
    NIT VARCHAR(30) UNIQUE
);

IF OBJECT_ID('Cliente', 'U') IS NULL
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    documentoIdentidad VARCHAR(50) UNIQUE
);

IF OBJECT_ID('Proyecto', 'U') IS NULL
CREATE TABLE Proyecto (
    id_proyecto INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(MAX),
    fechaInicio DATE,
    fechaFin DATE,
    id_empresa INT FOREIGN KEY REFERENCES Empresa(id_empresa),
    id_cliente INT FOREIGN KEY REFERENCES Cliente(id_cliente)
);

IF OBJECT_ID('Fase', 'U') IS NULL
CREATE TABLE Fase (
    id_fase INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(MAX)
);

IF OBJECT_ID('Empleado', 'U') IS NULL
CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50)
);

IF OBJECT_ID('Rol', 'U') IS NULL
CREATE TABLE Rol (
    id_rol INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL
);

IF OBJECT_ID('Recurso', 'U') IS NULL
CREATE TABLE Recurso (
    id_recurso INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    costo DECIMAL(10,2)
);

IF OBJECT_ID('ProyectoRecurso', 'U') IS NULL
CREATE TABLE ProyectoRecurso (
    id_proyecto INT,
    id_recurso INT,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_proyecto, id_recurso),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
);

IF OBJECT_ID('ProyectoFase', 'U') IS NULL
CREATE TABLE ProyectoFase (
    id_proyecto INT,
    id_fase INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (id_proyecto, id_fase),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_fase) REFERENCES Fase(id_fase)
);

IF OBJECT_ID('EmpleadoProyecto', 'U') IS NULL
CREATE TABLE EmpleadoProyecto (
    id_empleado INT,
    id_proyecto INT,
    id_rol INT,
    fecha_asignacion DATE,
    PRIMARY KEY (id_empleado, id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

IF OBJECT_ID('LogAcciones', 'U') IS NULL
CREATE TABLE LogAcciones (
    id_log INT IDENTITY PRIMARY KEY,
    tabla NVARCHAR(50),
    accion NVARCHAR(10),
    registro NVARCHAR(MAX),
    fecha DATETIME DEFAULT GETDATE()
);

-- =====================================
-- 2. Triggers
-- =====================================

-- Trigger INSERT Empresa
IF OBJECT_ID('trg_Empresa_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Empresa_Insert;
GO
CREATE TRIGGER trg_Empresa_Insert
ON Empresa
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empresa','INSERT', CONCAT('id_empresa=',id_empresa, ', nombre=',nombre, ', correo=',ISNULL(correo,''), ', telefono=',ISNULL(telefono,''), ', NIT=',ISNULL(NIT,''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Empresa
IF OBJECT_ID('trg_Empresa_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Empresa_Update;
GO
CREATE TRIGGER trg_Empresa_Update
ON Empresa
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empresa','UPDATE', CONCAT('id_empresa=',id_empresa, ', nombre=',nombre, ', correo=',ISNULL(correo,''), ', telefono=',ISNULL(telefono,''), ', NIT=',ISNULL(NIT,''))
    FROM inserted;
END;
GO

-- Trigger DELETE Empresa
IF OBJECT_ID('trg_Empresa_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Empresa_Delete;
GO
CREATE TRIGGER trg_Empresa_Delete
ON Empresa
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empresa','DELETE', CONCAT('id_empresa=',id_empresa, ', nombre=',nombre, ', correo=',ISNULL(correo,''), ', telefono=',ISNULL(telefono,''), ', NIT=',ISNULL(NIT,''))
    FROM deleted;
END;
GO

-- Trigger INSERT Cliente
IF OBJECT_ID('trg_Cliente_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Cliente_Insert;
GO
CREATE TRIGGER trg_Cliente_Insert
ON Cliente
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Cliente','INSERT', CONCAT('id_cliente=',id_cliente, ', nombre=',nombre, ', telefono=',ISNULL(telefono,''), ', documentoIdentidad=',ISNULL(documentoIdentidad,''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Cliente
IF OBJECT_ID('trg_Cliente_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Cliente_Update;
GO
CREATE TRIGGER trg_Cliente_Update
ON Cliente
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Cliente','UPDATE', CONCAT('id_cliente=',id_cliente, ', nombre=',nombre, ', telefono=',ISNULL(telefono,''), ', documentoIdentidad=',ISNULL(documentoIdentidad,''))
    FROM inserted;
END;
GO

-- Trigger DELETE Cliente
IF OBJECT_ID('trg_Cliente_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Cliente_Delete;
GO
CREATE TRIGGER trg_Cliente_Delete
ON Cliente
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Cliente','DELETE', CONCAT('id_cliente=',id_cliente, ', nombre=',nombre, ', telefono=',ISNULL(telefono,''), ', documentoIdentidad=',ISNULL(documentoIdentidad,''))
    FROM deleted;
END;
GO

-- Trigger INSERT Proyecto
IF OBJECT_ID('trg_Proyecto_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Proyecto_Insert;
GO
CREATE TRIGGER trg_Proyecto_Insert
ON Proyecto
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Proyecto','INSERT', CONCAT('id_proyecto=',id_proyecto, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''), ', fechaInicio=',ISNULL(CONVERT(VARCHAR,fechaInicio,120),''), ', fechaFin=',ISNULL(CONVERT(VARCHAR,fechaFin,120),''), ', id_empresa=',ISNULL(CONVERT(VARCHAR,id_empresa),''), ', id_cliente=',ISNULL(CONVERT(VARCHAR,id_cliente),''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Proyecto
IF OBJECT_ID('trg_Proyecto_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Proyecto_Update;
GO
CREATE TRIGGER trg_Proyecto_Update
ON Proyecto
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Proyecto','UPDATE', CONCAT('id_proyecto=',id_proyecto, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''), ', fechaInicio=',ISNULL(CONVERT(VARCHAR,fechaInicio,120),''), ', fechaFin=',ISNULL(CONVERT(VARCHAR,fechaFin,120),''), ', id_empresa=',ISNULL(CONVERT(VARCHAR,id_empresa),''), ', id_cliente=',ISNULL(CONVERT(VARCHAR,id_cliente),''))
    FROM inserted;
END;
GO

-- Trigger DELETE Proyecto
IF OBJECT_ID('trg_Proyecto_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Proyecto_Delete;
GO
CREATE TRIGGER trg_Proyecto_Delete
ON Proyecto
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Proyecto','DELETE', CONCAT('id_proyecto=',id_proyecto, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''), ', fechaInicio=',ISNULL(CONVERT(VARCHAR,fechaInicio,120),''), ', fechaFin=',ISNULL(CONVERT(VARCHAR,fechaFin,120),''), ', id_empresa=',ISNULL(CONVERT(VARCHAR,id_empresa),''), ', id_cliente=',ISNULL(CONVERT(VARCHAR,id_cliente),''))
    FROM deleted;
END;
GO

-- Trigger INSERT Empleado
IF OBJECT_ID('trg_Empleado_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Empleado_Insert;
GO
CREATE TRIGGER trg_Empleado_Insert
ON Empleado
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empleado','INSERT', CONCAT('id_empleado=',id_empleado, ', nombre=',nombre, ', cargo=',ISNULL(cargo,''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Empleado
IF OBJECT_ID('trg_Empleado_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Empleado_Update;
GO
CREATE TRIGGER trg_Empleado_Update
ON Empleado
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empleado','UPDATE', CONCAT('id_empleado=',id_empleado, ', nombre=',nombre, ', cargo=',ISNULL(cargo,''))
    FROM inserted;
END;
GO

-- Trigger DELETE Empleado
IF OBJECT_ID('trg_Empleado_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Empleado_Delete;
GO
CREATE TRIGGER trg_Empleado_Delete
ON Empleado
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Empleado','DELETE', CONCAT('id_empleado=',id_empleado, ', nombre=',nombre, ', cargo=',ISNULL(cargo,''))
    FROM deleted;
END;
GO

-- Trigger INSERT Fase
IF OBJECT_ID('trg_Fase_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Fase_Insert;
GO
CREATE TRIGGER trg_Fase_Insert
ON Fase
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Fase','INSERT', CONCAT('id_fase=',id_fase, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Fase
IF OBJECT_ID('trg_Fase_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Fase_Update;
GO
CREATE TRIGGER trg_Fase_Update
ON Fase
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Fase','UPDATE', CONCAT('id_fase=',id_fase, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''))
    FROM inserted;
END;
GO

-- Trigger DELETE Fase
IF OBJECT_ID('trg_Fase_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Fase_Delete;
GO
CREATE TRIGGER trg_Fase_Delete
ON Fase
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Fase','DELETE', CONCAT('id_fase=',id_fase, ', nombre=',nombre, ', descripcion=',ISNULL(descripcion,''))
    FROM deleted;
END;
GO

-- Trigger INSERT Rol
IF OBJECT_ID('trg_Rol_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Rol_Insert;
GO
CREATE TRIGGER trg_Rol_Insert
ON Rol
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Rol','INSERT', CONCAT('id_rol=',id_rol, ', nombre=',nombre)
    FROM inserted;
END;
GO

-- Trigger UPDATE Rol
IF OBJECT_ID('trg_Rol_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Rol_Update;
GO
CREATE TRIGGER trg_Rol_Update
ON Rol
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Rol','UPDATE', CONCAT('id_rol=',id_rol, ', nombre=',nombre)
    FROM inserted;
END;
GO

-- Trigger DELETE Rol
IF OBJECT_ID('trg_Rol_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Rol_Delete;
GO
CREATE TRIGGER trg_Rol_Delete
ON Rol
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Rol','DELETE', CONCAT('id_rol=',id_rol, ', nombre=',nombre)
    FROM deleted;
END;
GO

-- Trigger INSERT Recurso
IF OBJECT_ID('trg_Recurso_Insert', 'TR') IS NOT NULL DROP TRIGGER trg_Recurso_Insert;
GO
CREATE TRIGGER trg_Recurso_Insert
ON Recurso
AFTER INSERT
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Recurso','INSERT', CONCAT('id_recurso=',id_recurso, ', nombre=',nombre, ', tipo=',ISNULL(tipo,''), ', costo=',ISNULL(CONVERT(VARCHAR,costo),''))
    FROM inserted;
END;
GO

-- Trigger UPDATE Recurso
IF OBJECT_ID('trg_Recurso_Update', 'TR') IS NOT NULL DROP TRIGGER trg_Recurso_Update;
GO
CREATE TRIGGER trg_Recurso_Update
ON Recurso
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Recurso','UPDATE', CONCAT('id_recurso=',id_recurso, ', nombre=',nombre, ', tipo=',ISNULL(tipo,''), ', costo=',ISNULL(CONVERT(VARCHAR,costo),''))
    FROM inserted;
END;
GO

-- Trigger DELETE Recurso
IF OBJECT_ID('trg_Recurso_Delete', 'TR') IS NOT NULL DROP TRIGGER trg_Recurso_Delete;
GO
CREATE TRIGGER trg_Recurso_Delete
ON Recurso
AFTER DELETE
AS
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    SELECT 'Recurso','DELETE', CONCAT('id_recurso=',id_recurso, ', nombre=',nombre, ', tipo=',ISNULL(tipo,''), ', costo=',ISNULL(CONVERT(VARCHAR,costo),''))
    FROM deleted;
END;
GO

PRINT 'Base de datos GestionProyectos creada exitosamente con todas las tablas y triggers.';
GO