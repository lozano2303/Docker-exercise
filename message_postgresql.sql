-- Crear base de datos si no existe
CREATE DATABASE GestionProyectos;

CREATE OR REPLACE PROCEDURE CrearBDGestionProyectos()
LANGUAGE plpgsql
AS $$
BEGIN
    -- =====================================
    -- 1. Tablas
    -- =====================================
    CREATE TABLE IF NOT EXISTS Empresa (
        id_empresa SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        correo VARCHAR(100),
        telefono VARCHAR(20),
        NIT VARCHAR(30) UNIQUE
    );

    CREATE TABLE IF NOT EXISTS Cliente (
        id_cliente SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        telefono VARCHAR(20),
        documentoIdentidad VARCHAR(50) UNIQUE
    );

    CREATE TABLE IF NOT EXISTS Proyecto (
        id_proyecto SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        descripcion TEXT,
        fechaInicio DATE,
        fechaFin DATE,
        id_empresa INT REFERENCES Empresa(id_empresa),
        id_cliente INT REFERENCES Cliente(id_cliente)
    );

    CREATE TABLE IF NOT EXISTS Fase (
        id_fase SERIAL PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        descripcion TEXT
    );

    CREATE TABLE IF NOT EXISTS Empleado (
        id_empleado SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        cargo VARCHAR(50)
    );

    CREATE TABLE IF NOT EXISTS Rol (
        id_rol SERIAL PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Recurso (
        id_recurso SERIAL PRIMARY KEY,
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
        id_log SERIAL PRIMARY KEY,
        tabla VARCHAR(50),
        accion VARCHAR(10),
        registro TEXT,
        fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- Funciones para triggers
    CREATE OR REPLACE FUNCTION log_empresa_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empresa', 'INSERT', 'id_empresa=' || NEW.id_empresa || ', nombre=' || NEW.nombre || ', correo=' || COALESCE(NEW.correo, '') || ', telefono=' || COALESCE(NEW.telefono, '') || ', NIT=' || COALESCE(NEW.NIT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_empresa_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empresa', 'UPDATE', 'id_empresa=' || NEW.id_empresa || ', nombre=' || NEW.nombre || ', correo=' || COALESCE(NEW.correo, '') || ', telefono=' || COALESCE(NEW.telefono, '') || ', NIT=' || COALESCE(NEW.NIT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_empresa_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empresa', 'DELETE', 'id_empresa=' || OLD.id_empresa || ', nombre=' || OLD.nombre || ', correo=' || COALESCE(OLD.correo, '') || ', telefono=' || COALESCE(OLD.telefono, '') || ', NIT=' || COALESCE(OLD.NIT, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    -- Triggers para Empresa
    DROP TRIGGER IF EXISTS trg_Empresa_Insert ON Empresa;
    CREATE TRIGGER trg_Empresa_Insert AFTER INSERT ON Empresa
    FOR EACH ROW EXECUTE FUNCTION log_empresa_insert();

    DROP TRIGGER IF EXISTS trg_Empresa_Update ON Empresa;
    CREATE TRIGGER trg_Empresa_Update AFTER UPDATE ON Empresa
    FOR EACH ROW EXECUTE FUNCTION log_empresa_update();

    DROP TRIGGER IF EXISTS trg_Empresa_Delete ON Empresa;
    CREATE TRIGGER trg_Empresa_Delete AFTER DELETE ON Empresa
    FOR EACH ROW EXECUTE FUNCTION log_empresa_delete();

    -- Funciones y triggers para Cliente
    CREATE OR REPLACE FUNCTION log_cliente_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Cliente', 'INSERT', 'id_cliente=' || NEW.id_cliente || ', nombre=' || NEW.nombre || ', telefono=' || COALESCE(NEW.telefono, '') || ', documentoIdentidad=' || COALESCE(NEW.documentoIdentidad, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_cliente_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Cliente', 'UPDATE', 'id_cliente=' || NEW.id_cliente || ', nombre=' || NEW.nombre || ', telefono=' || COALESCE(NEW.telefono, '') || ', documentoIdentidad=' || COALESCE(NEW.documentoIdentidad, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_cliente_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Cliente', 'DELETE', 'id_cliente=' || OLD.id_cliente || ', nombre=' || OLD.nombre || ', telefono=' || COALESCE(OLD.telefono, '') || ', documentoIdentidad=' || COALESCE(OLD.documentoIdentidad, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Cliente_Insert ON Cliente;
    CREATE TRIGGER trg_Cliente_Insert AFTER INSERT ON Cliente
    FOR EACH ROW EXECUTE FUNCTION log_cliente_insert();

    DROP TRIGGER IF EXISTS trg_Cliente_Update ON Cliente;
    CREATE TRIGGER trg_Cliente_Update AFTER UPDATE ON Cliente
    FOR EACH ROW EXECUTE FUNCTION log_cliente_update();

    DROP TRIGGER IF EXISTS trg_Cliente_Delete ON Cliente;
    CREATE TRIGGER trg_Cliente_Delete AFTER DELETE ON Cliente
    FOR EACH ROW EXECUTE FUNCTION log_cliente_delete();

    -- Funciones y triggers para Proyecto
    CREATE OR REPLACE FUNCTION log_proyecto_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Proyecto', 'INSERT', 'id_proyecto=' || NEW.id_proyecto || ', nombre=' || NEW.nombre || ', descripcion=' || COALESCE(NEW.descripcion, '') || ', fechaInicio=' || COALESCE(NEW.fechaInicio::TEXT, '') || ', fechaFin=' || COALESCE(NEW.fechaFin::TEXT, '') || ', id_empresa=' || COALESCE(NEW.id_empresa::TEXT, '') || ', id_cliente=' || COALESCE(NEW.id_cliente::TEXT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_proyecto_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Proyecto', 'UPDATE', 'id_proyecto=' || NEW.id_proyecto || ', nombre=' || NEW.nombre || ', descripcion=' || COALESCE(NEW.descripcion, '') || ', fechaInicio=' || COALESCE(NEW.fechaInicio::TEXT, '') || ', fechaFin=' || COALESCE(NEW.fechaFin::TEXT, '') || ', id_empresa=' || COALESCE(NEW.id_empresa::TEXT, '') || ', id_cliente=' || COALESCE(NEW.id_cliente::TEXT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_proyecto_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Proyecto', 'DELETE', 'id_proyecto=' || OLD.id_proyecto || ', nombre=' || OLD.nombre || ', descripcion=' || COALESCE(OLD.descripcion, '') || ', fechaInicio=' || COALESCE(OLD.fechaInicio::TEXT, '') || ', fechaFin=' || COALESCE(OLD.fechaFin::TEXT, '') || ', id_empresa=' || COALESCE(OLD.id_empresa::TEXT, '') || ', id_cliente=' || COALESCE(OLD.id_cliente::TEXT, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Proyecto_Insert ON Proyecto;
    CREATE TRIGGER trg_Proyecto_Insert AFTER INSERT ON Proyecto
    FOR EACH ROW EXECUTE FUNCTION log_proyecto_insert();

    DROP TRIGGER IF EXISTS trg_Proyecto_Update ON Proyecto;
    CREATE TRIGGER trg_Proyecto_Update AFTER UPDATE ON Proyecto
    FOR EACH ROW EXECUTE FUNCTION log_proyecto_update();

    DROP TRIGGER IF EXISTS trg_Proyecto_Delete ON Proyecto;
    CREATE TRIGGER trg_Proyecto_Delete AFTER DELETE ON Proyecto
    FOR EACH ROW EXECUTE FUNCTION log_proyecto_delete();

    -- Funciones y triggers para Empleado
    CREATE OR REPLACE FUNCTION log_empleado_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empleado', 'INSERT', 'id_empleado=' || NEW.id_empleado || ', nombre=' || NEW.nombre || ', cargo=' || COALESCE(NEW.cargo, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_empleado_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empleado', 'UPDATE', 'id_empleado=' || NEW.id_empleado || ', nombre=' || NEW.nombre || ', cargo=' || COALESCE(NEW.cargo, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_empleado_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Empleado', 'DELETE', 'id_empleado=' || OLD.id_empleado || ', nombre=' || OLD.nombre || ', cargo=' || COALESCE(OLD.cargo, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Empleado_Insert ON Empleado;
    CREATE TRIGGER trg_Empleado_Insert AFTER INSERT ON Empleado
    FOR EACH ROW EXECUTE FUNCTION log_empleado_insert();

    DROP TRIGGER IF EXISTS trg_Empleado_Update ON Empleado;
    CREATE TRIGGER trg_Empleado_Update AFTER UPDATE ON Empleado
    FOR EACH ROW EXECUTE FUNCTION log_empleado_update();

    DROP TRIGGER IF EXISTS trg_Empleado_Delete ON Empleado;
    CREATE TRIGGER trg_Empleado_Delete AFTER DELETE ON Empleado
    FOR EACH ROW EXECUTE FUNCTION log_empleado_delete();

    -- Funciones y triggers para Fase
    CREATE OR REPLACE FUNCTION log_fase_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Fase', 'INSERT', 'id_fase=' || NEW.id_fase || ', nombre=' || NEW.nombre || ', descripcion=' || COALESCE(NEW.descripcion, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_fase_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Fase', 'UPDATE', 'id_fase=' || NEW.id_fase || ', nombre=' || NEW.nombre || ', descripcion=' || COALESCE(NEW.descripcion, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_fase_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Fase', 'DELETE', 'id_fase=' || OLD.id_fase || ', nombre=' || OLD.nombre || ', descripcion=' || COALESCE(OLD.descripcion, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Fase_Insert ON Fase;
    CREATE TRIGGER trg_Fase_Insert AFTER INSERT ON Fase
    FOR EACH ROW EXECUTE FUNCTION log_fase_insert();

    DROP TRIGGER IF EXISTS trg_Fase_Update ON Fase;
    CREATE TRIGGER trg_Fase_Update AFTER UPDATE ON Fase
    FOR EACH ROW EXECUTE FUNCTION log_fase_update();

    DROP TRIGGER IF EXISTS trg_Fase_Delete ON Fase;
    CREATE TRIGGER trg_Fase_Delete AFTER DELETE ON Fase
    FOR EACH ROW EXECUTE FUNCTION log_fase_delete();

    -- Funciones y triggers para Rol
    CREATE OR REPLACE FUNCTION log_rol_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Rol', 'INSERT', 'id_rol=' || NEW.id_rol || ', nombre=' || NEW.nombre);
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_rol_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Rol', 'UPDATE', 'id_rol=' || NEW.id_rol || ', nombre=' || NEW.nombre);
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_rol_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Rol', 'DELETE', 'id_rol=' || OLD.id_rol || ', nombre=' || OLD.nombre);
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Rol_Insert ON Rol;
    CREATE TRIGGER trg_Rol_Insert AFTER INSERT ON Rol
    FOR EACH ROW EXECUTE FUNCTION log_rol_insert();

    DROP TRIGGER IF EXISTS trg_Rol_Update ON Rol;
    CREATE TRIGGER trg_Rol_Update AFTER UPDATE ON Rol
    FOR EACH ROW EXECUTE FUNCTION log_rol_update();

    DROP TRIGGER IF EXISTS trg_Rol_Delete ON Rol;
    CREATE TRIGGER trg_Rol_Delete AFTER DELETE ON Rol
    FOR EACH ROW EXECUTE FUNCTION log_rol_delete();

    -- Funciones y triggers para Recurso
    CREATE OR REPLACE FUNCTION log_recurso_insert() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Recurso', 'INSERT', 'id_recurso=' || NEW.id_recurso || ', nombre=' || NEW.nombre || ', tipo=' || COALESCE(NEW.tipo, '') || ', costo=' || COALESCE(NEW.costo::TEXT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_recurso_update() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Recurso', 'UPDATE', 'id_recurso=' || NEW.id_recurso || ', nombre=' || NEW.nombre || ', tipo=' || COALESCE(NEW.tipo, '') || ', costo=' || COALESCE(NEW.costo::TEXT, ''));
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE OR REPLACE FUNCTION log_recurso_delete() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO LogAcciones (tabla, accion, registro)
        VALUES ('Recurso', 'DELETE', 'id_recurso=' || OLD.id_recurso || ', nombre=' || OLD.nombre || ', tipo=' || COALESCE(OLD.tipo, '') || ', costo=' || COALESCE(OLD.costo::TEXT, ''));
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS trg_Recurso_Insert ON Recurso;
    CREATE TRIGGER trg_Recurso_Insert AFTER INSERT ON Recurso
    FOR EACH ROW EXECUTE FUNCTION log_recurso_insert();

    DROP TRIGGER IF EXISTS trg_Recurso_Update ON Recurso;
    CREATE TRIGGER trg_Recurso_Update AFTER UPDATE ON Recurso
    FOR EACH ROW EXECUTE FUNCTION log_recurso_update();

    DROP TRIGGER IF EXISTS trg_Recurso_Delete ON Recurso;
    CREATE TRIGGER trg_Recurso_Delete AFTER DELETE ON Recurso
    FOR EACH ROW EXECUTE FUNCTION log_recurso_delete();

END;
$$;

CALL CrearBDGestionProyectos();