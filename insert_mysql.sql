USE GestionProyectos;

-- Insertar 1000 registros en Empresa
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarEmpresas $$
CREATE PROCEDURE InsertarEmpresas()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Empresa (nombre, correo, telefono, NIT)
        VALUES (CONCAT('Empresa ', i), CONCAT('empresa', i, '@example.com'), CONCAT('300', LPAD(i, 6, '0')), CONCAT('NIT', i));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarEmpresas();

-- Insertar 1000 registros en Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarClientes $$
CREATE PROCEDURE InsertarClientes()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Cliente (nombre, telefono, documentoIdentidad)
        VALUES (CONCAT('Cliente ', i), CONCAT('301', LPAD(i, 6, '0')), CONCAT('DOC', i));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarClientes();

-- Insertar 1000 registros en Fase
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarFases $$
CREATE PROCEDURE InsertarFases()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Fase (nombre, descripcion)
        VALUES (CONCAT('Fase ', i), CONCAT('Descripción de la fase ', i));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarFases();

-- Insertar 1000 registros en Empleado
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarEmpleados $$
CREATE PROCEDURE InsertarEmpleados()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Empleado (nombre, cargo)
        VALUES (CONCAT('Empleado ', i), CONCAT('Cargo ', i));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarEmpleados();

-- Insertar 1000 registros en Rol
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarRoles $$
CREATE PROCEDURE InsertarRoles()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Rol (nombre)
        VALUES (CONCAT('Rol ', i));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarRoles();

-- Insertar 1000 registros en Recurso
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarRecursos $$
CREATE PROCEDURE InsertarRecursos()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Recurso (nombre, tipo, costo)
        VALUES (CONCAT('Recurso ', i), CONCAT('Tipo ', i), i * 10.0);
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarRecursos();

-- Insertar 1000 registros en Proyecto
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarProyectos $$
CREATE PROCEDURE InsertarProyectos()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Proyecto (nombre, descripcion, fechaInicio, fechaFin, id_empresa, id_cliente)
        VALUES (CONCAT('Proyecto ', i), CONCAT('Descripción del proyecto ', i), DATE_ADD('2023-01-01', INTERVAL i DAY), DATE_ADD('2023-01-01', INTERVAL (i + 30) DAY), i, i);
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarProyectos();

-- Insertar 1000 registros en ProyectoRecurso
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarProyectoRecursos $$
CREATE PROCEDURE InsertarProyectoRecursos()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO ProyectoRecurso (id_proyecto, id_recurso, cantidad)
        VALUES (i, i, i);
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarProyectoRecursos();

-- Insertar 1000 registros en ProyectoFase
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarProyectoFases $$
CREATE PROCEDURE InsertarProyectoFases()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO ProyectoFase (id_proyecto, id_fase, fecha_inicio, fecha_fin)
        VALUES (i, i, DATE_ADD('2023-01-01', INTERVAL i DAY), DATE_ADD('2023-01-01', INTERVAL (i + 10) DAY));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarProyectoFases();

-- Insertar 1000 registros en EmpleadoProyecto
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarEmpleadoProyectos $$
CREATE PROCEDURE InsertarEmpleadoProyectos()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO EmpleadoProyecto (id_empleado, id_proyecto, id_rol, fecha_asignacion)
        VALUES (i, i, i, DATE_ADD('2023-01-01', INTERVAL i DAY));
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL InsertarEmpleadoProyectos();