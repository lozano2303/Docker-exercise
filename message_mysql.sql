-- Crear base de datos y tablas para MySQL
CREATE DATABASE IF NOT EXISTS GestionProyectos;
USE GestionProyectos;

-- =====================================
-- 1. Tablas
-- =====================================
CREATE TABLE IF NOT EXISTS Empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20),
    NIT VARCHAR(30) UNIQUE
);

CREATE TABLE IF NOT EXISTS Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    documentoIdentidad VARCHAR(50) UNIQUE
);

CREATE TABLE IF NOT EXISTS Proyecto (
    id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fechaInicio DATE,
    fechaFin DATE,
    id_empresa INT,
    id_cliente INT,
    FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS Fase (
    id_fase INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS Empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Rol (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Recurso (
    id_recurso INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    costo DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS ProyectoRecurso (
    id_proyecto INT,
    id_recurso INT,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_proyecto, id_recurso),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
);

CREATE TABLE IF NOT EXISTS ProyectoFase (
    id_proyecto INT,
    id_fase INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (id_proyecto, id_fase),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_fase) REFERENCES Fase(id_fase)
);

CREATE TABLE IF NOT EXISTS EmpleadoProyecto (
    id_empleado INT,
    id_proyecto INT,
    id_rol INT,
    fecha_asignacion DATE,
    PRIMARY KEY (id_empleado, id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE IF NOT EXISTS LogAcciones (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    tabla VARCHAR(50),
    accion VARCHAR(10),
    registro TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP()
);

-- Triggers para MySQL (fuera del procedimiento)
-- Trigger INSERT Empresa
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empresa_Insert $$
CREATE TRIGGER trg_Empresa_Insert AFTER INSERT ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empresa', 'INSERT', CONCAT('id_empresa=', NEW.id_empresa, ', nombre=', NEW.nombre, ', correo=', COALESCE(NEW.correo, ''), ', telefono=', COALESCE(NEW.telefono, ''), ', NIT=', COALESCE(NEW.NIT, '')));
END $$
DELIMITER ;

-- Trigger UPDATE Empresa
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empresa_Update $$
CREATE TRIGGER trg_Empresa_Update AFTER UPDATE ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empresa', 'UPDATE', CONCAT('id_empresa=', NEW.id_empresa, ', nombre=', NEW.nombre, ', correo=', COALESCE(NEW.correo, ''), ', telefono=', COALESCE(NEW.telefono, ''), ', NIT=', COALESCE(NEW.NIT, '')));
END $$
DELIMITER ;

-- Trigger DELETE Empresa
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empresa_Delete $$
CREATE TRIGGER trg_Empresa_Delete AFTER DELETE ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empresa', 'DELETE', CONCAT('id_empresa=', OLD.id_empresa, ', nombre=', OLD.nombre, ', correo=', COALESCE(OLD.correo, ''), ', telefono=', COALESCE(OLD.telefono, ''), ', NIT=', COALESCE(OLD.NIT, '')));
END $$
DELIMITER ;

-- Triggers para Cliente
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Cliente_Insert $$
CREATE TRIGGER trg_Cliente_Insert AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Cliente', 'INSERT', CONCAT('id_cliente=', NEW.id_cliente, ', nombre=', NEW.nombre, ', telefono=', COALESCE(NEW.telefono, ''), ', documentoIdentidad=', COALESCE(NEW.documentoIdentidad, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Cliente_Update $$
CREATE TRIGGER trg_Cliente_Update AFTER UPDATE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Cliente', 'UPDATE', CONCAT('id_cliente=', NEW.id_cliente, ', nombre=', NEW.nombre, ', telefono=', COALESCE(NEW.telefono, ''), ', documentoIdentidad=', COALESCE(NEW.documentoIdentidad, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Cliente_Delete $$
CREATE TRIGGER trg_Cliente_Delete AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Cliente', 'DELETE', CONCAT('id_cliente=', OLD.id_cliente, ', nombre=', OLD.nombre, ', telefono=', COALESCE(OLD.telefono, ''), ', documentoIdentidad=', COALESCE(OLD.documentoIdentidad, '')));
END $$
DELIMITER ;

-- Triggers para Proyecto
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Proyecto_Insert $$
CREATE TRIGGER trg_Proyecto_Insert AFTER INSERT ON Proyecto
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Proyecto', 'INSERT', CONCAT('id_proyecto=', NEW.id_proyecto, ', nombre=', NEW.nombre, ', descripcion=', COALESCE(NEW.descripcion, ''), ', fechaInicio=', COALESCE(NEW.fechaInicio, ''), ', fechaFin=', COALESCE(NEW.fechaFin, ''), ', id_empresa=', COALESCE(NEW.id_empresa, ''), ', id_cliente=', COALESCE(NEW.id_cliente, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Proyecto_Update $$
CREATE TRIGGER trg_Proyecto_Update AFTER UPDATE ON Proyecto
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Proyecto', 'UPDATE', CONCAT('id_proyecto=', NEW.id_proyecto, ', nombre=', NEW.nombre, ', descripcion=', COALESCE(NEW.descripcion, ''), ', fechaInicio=', COALESCE(NEW.fechaInicio, ''), ', fechaFin=', COALESCE(NEW.fechaFin, ''), ', id_empresa=', COALESCE(NEW.id_empresa, ''), ', id_cliente=', COALESCE(NEW.id_cliente, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Proyecto_Delete $$
CREATE TRIGGER trg_Proyecto_Delete AFTER DELETE ON Proyecto
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Proyecto', 'DELETE', CONCAT('id_proyecto=', OLD.id_proyecto, ', nombre=', OLD.nombre, ', descripcion=', COALESCE(OLD.descripcion, ''), ', fechaInicio=', COALESCE(OLD.fechaInicio, ''), ', fechaFin=', COALESCE(OLD.fechaFin, ''), ', id_empresa=', COALESCE(OLD.id_empresa, ''), ', id_cliente=', COALESCE(OLD.id_cliente, '')));
END $$
DELIMITER ;

-- Triggers para Empleado
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empleado_Insert $$
CREATE TRIGGER trg_Empleado_Insert AFTER INSERT ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empleado', 'INSERT', CONCAT('id_empleado=', NEW.id_empleado, ', nombre=', NEW.nombre, ', cargo=', COALESCE(NEW.cargo, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empleado_Update $$
CREATE TRIGGER trg_Empleado_Update AFTER UPDATE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empleado', 'UPDATE', CONCAT('id_empleado=', NEW.id_empleado, ', nombre=', NEW.nombre, ', cargo=', COALESCE(NEW.cargo, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Empleado_Delete $$
CREATE TRIGGER trg_Empleado_Delete AFTER DELETE ON Empleado
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Empleado', 'DELETE', CONCAT('id_empleado=', OLD.id_empleado, ', nombre=', OLD.nombre, ', cargo=', COALESCE(OLD.cargo, '')));
END $$
DELIMITER ;

-- Triggers para Fase
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Fase_Insert $$
CREATE TRIGGER trg_Fase_Insert AFTER INSERT ON Fase
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Fase', 'INSERT', CONCAT('id_fase=', NEW.id_fase, ', nombre=', NEW.nombre, ', descripcion=', COALESCE(NEW.descripcion, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Fase_Update $$
CREATE TRIGGER trg_Fase_Update AFTER UPDATE ON Fase
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Fase', 'UPDATE', CONCAT('id_fase=', NEW.id_fase, ', nombre=', NEW.nombre, ', descripcion=', COALESCE(NEW.descripcion, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Fase_Delete $$
CREATE TRIGGER trg_Fase_Delete AFTER DELETE ON Fase
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Fase', 'DELETE', CONCAT('id_fase=', OLD.id_fase, ', nombre=', OLD.nombre, ', descripcion=', COALESCE(OLD.descripcion, '')));
END $$
DELIMITER ;

-- Triggers para Rol
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Rol_Insert $$
CREATE TRIGGER trg_Rol_Insert AFTER INSERT ON Rol
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Rol', 'INSERT', CONCAT('id_rol=', NEW.id_rol, ', nombre=', NEW.nombre));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Rol_Update $$
CREATE TRIGGER trg_Rol_Update AFTER UPDATE ON Rol
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Rol', 'UPDATE', CONCAT('id_rol=', NEW.id_rol, ', nombre=', NEW.nombre));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Rol_Delete $$
CREATE TRIGGER trg_Rol_Delete AFTER DELETE ON Rol
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Rol', 'DELETE', CONCAT('id_rol=', OLD.id_rol, ', nombre=', OLD.nombre));
END $$
DELIMITER ;

-- Triggers para Recurso
DELIMITER $$
DROP TRIGGER IF EXISTS trg_Recurso_Insert $$
CREATE TRIGGER trg_Recurso_Insert AFTER INSERT ON Recurso
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Recurso', 'INSERT', CONCAT('id_recurso=', NEW.id_recurso, ', nombre=', NEW.nombre, ', tipo=', COALESCE(NEW.tipo, ''), ', costo=', COALESCE(NEW.costo, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Recurso_Update $$
CREATE TRIGGER trg_Recurso_Update AFTER UPDATE ON Recurso
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Recurso', 'UPDATE', CONCAT('id_recurso=', NEW.id_recurso, ', nombre=', NEW.nombre, ', tipo=', COALESCE(NEW.tipo, ''), ', costo=', COALESCE(NEW.costo, '')));
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_Recurso_Delete $$
CREATE TRIGGER trg_Recurso_Delete AFTER DELETE ON Recurso
FOR EACH ROW
BEGIN
    INSERT INTO LogAcciones (tabla, accion, registro)
    VALUES ('Recurso', 'DELETE', CONCAT('id_recurso=', OLD.id_recurso, ', nombre=', OLD.nombre, ', tipo=', COALESCE(OLD.tipo, ''), ', costo=', COALESCE(OLD.costo, '')));
END $$
DELIMITER ;