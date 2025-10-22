-- Script para insertar datos en PostgreSQL
-- Este script se ejecuta en la base de datos gestionproyectos

-- Insertar 1000 registros en Empresa
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Empresa (nombre, correo, telefono, NIT)
        VALUES ('Empresa ' || i, 'empresa' || i || '@example.com', '300' || LPAD(i::TEXT, 6, '0'), 'NIT' || i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Cliente
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Cliente (nombre, telefono, documentoIdentidad)
        VALUES ('Cliente ' || i, '301' || LPAD(i::TEXT, 6, '0'), 'DOC' || i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Fase
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Fase (nombre, descripcion)
        VALUES ('Fase ' || i, 'Descripción de la fase ' || i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Empleado
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Empleado (nombre, cargo)
        VALUES ('Empleado ' || i, 'Cargo ' || i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Rol
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Rol (nombre)
        VALUES ('Rol ' || i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Recurso
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Recurso (nombre, tipo, costo)
        VALUES ('Recurso ' || i, 'Tipo ' || i, i * 10.0);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en Proyecto
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO Proyecto (nombre, descripcion, fechaInicio, fechaFin, id_empresa, id_cliente)
        VALUES ('Proyecto ' || i, 'Descripción del proyecto ' || i, '2023-01-01'::DATE + i, '2023-01-01'::DATE + i + 30, i, i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en ProyectoRecurso
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO ProyectoRecurso (id_proyecto, id_recurso, cantidad)
        VALUES (i, i, i);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en ProyectoFase
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO ProyectoFase (id_proyecto, id_fase, fecha_inicio, fecha_fin)
        VALUES (i, i, '2023-01-01'::DATE + i, '2023-01-01'::DATE + i + 10);
        i := i + 1;
    END LOOP;
END $$;

-- Insertar 1000 registros en EmpleadoProyecto
DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 1000 LOOP
        INSERT INTO EmpleadoProyecto (id_empleado, id_proyecto, id_rol, fecha_asignacion)
        VALUES (i, i, i, '2023-01-01'::DATE + i);
        i := i + 1;
    END LOOP;
END $$;