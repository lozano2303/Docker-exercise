USE GestionProyectos;
GO

-- Insertar 1000 registros en Empresa
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Empresa (nombre, correo, telefono, NIT)
    VALUES ('Empresa ' + CAST(@i AS VARCHAR), 'empresa' + CAST(@i AS VARCHAR) + '@example.com', '300' + RIGHT('000000' + CAST(@i AS VARCHAR), 6), 'NIT' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Cliente
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Cliente (nombre, telefono, documentoIdentidad)
    VALUES ('Cliente ' + CAST(@i AS VARCHAR), '301' + RIGHT('000000' + CAST(@i AS VARCHAR), 6), 'DOC' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Fase
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Fase (nombre, descripcion)
    VALUES ('Fase ' + CAST(@i AS VARCHAR), 'Descripción de la fase ' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Empleado
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Empleado (nombre, cargo)
    VALUES ('Empleado ' + CAST(@i AS VARCHAR), 'Cargo ' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Rol
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Rol (nombre)
    VALUES ('Rol ' + CAST(@i AS VARCHAR));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Recurso
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Recurso (nombre, tipo, costo)
    VALUES ('Recurso ' + CAST(@i AS VARCHAR), 'Tipo ' + CAST(@i AS VARCHAR), @i * 10.0);
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en Proyecto (referenciando Empresa y Cliente existentes)
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Proyecto (nombre, descripcion, fechaInicio, fechaFin, id_empresa, id_cliente)
    VALUES ('Proyecto ' + CAST(@i AS VARCHAR), 'Descripción del proyecto ' + CAST(@i AS VARCHAR), DATEADD(DAY, @i, '2023-01-01'), DATEADD(DAY, @i + 30, '2023-01-01'), @i, @i);
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en ProyectoRecurso
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO ProyectoRecurso (id_proyecto, id_recurso, cantidad)
    VALUES (@i, @i, @i);
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en ProyectoFase
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO ProyectoFase (id_proyecto, id_fase, fecha_inicio, fecha_fin)
    VALUES (@i, @i, DATEADD(DAY, @i, '2023-01-01'), DATEADD(DAY, @i + 10, '2023-01-01'));
    SET @i = @i + 1;
END;

-- Insertar 1000 registros en EmpleadoProyecto
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO EmpleadoProyecto (id_empleado, id_proyecto, id_rol, fecha_asignacion)
    VALUES (@i, @i, @i, DATEADD(DAY, @i, '2023-01-01'));
    SET @i = @i + 1;
END;

GO