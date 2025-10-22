// Script para insertar 1000 registros en MongoDB
// Ejecutar con: mongo < insert_mongodb.js

db = db.getSiblingDB('GestionProyectos');

// Insertar 1000 documentos en Empresa
for (let i = 1; i <= 1000; i++) {
    db.Empresa.insertOne({
        nombre: 'Empresa ' + i,
        correo: 'empresa' + i + '@example.com',
        telefono: '300' + ('000000' + i).slice(-6),
        NIT: 'NIT' + i
    });
}

// Insertar 1000 documentos en Cliente
for (let i = 1; i <= 1000; i++) {
    db.Cliente.insertOne({
        nombre: 'Cliente ' + i,
        telefono: '301' + ('000000' + i).slice(-6),
        documentoIdentidad: 'DOC' + i
    });
}

// Insertar 1000 documentos en Fase
for (let i = 1; i <= 1000; i++) {
    db.Fase.insertOne({
        nombre: 'Fase ' + i,
        descripcion: 'Descripción de la fase ' + i
    });
}

// Insertar 1000 documentos en Empleado
for (let i = 1; i <= 1000; i++) {
    db.Empleado.insertOne({
        nombre: 'Empleado ' + i,
        cargo: 'Cargo ' + i
    });
}

// Insertar 1000 documentos en Rol
for (let i = 1; i <= 1000; i++) {
    db.Rol.insertOne({
        nombre: 'Rol ' + i
    });
}

// Insertar 1000 documentos en Recurso
for (let i = 1; i <= 1000; i++) {
    db.Recurso.insertOne({
        nombre: 'Recurso ' + i,
        tipo: 'Tipo ' + i,
        costo: i * 10.0
    });
}

// Insertar 1000 documentos en Proyecto
for (let i = 1; i <= 1000; i++) {
    db.Proyecto.insertOne({
        nombre: 'Proyecto ' + i,
        descripcion: 'Descripción del proyecto ' + i,
        fechaInicio: new Date(2023, 0, i + 1), // Enero es 0
        fechaFin: new Date(2023, 0, i + 31),
        id_empresa: i,
        id_cliente: i
    });
}

// Insertar 1000 documentos en ProyectoRecurso
for (let i = 1; i <= 1000; i++) {
    db.ProyectoRecurso.insertOne({
        id_proyecto: i,
        id_recurso: i,
        cantidad: i
    });
}

// Insertar 1000 documentos en ProyectoFase
for (let i = 1; i <= 1000; i++) {
    db.ProyectoFase.insertOne({
        id_proyecto: i,
        id_fase: i,
        fecha_inicio: new Date(2023, 0, i + 1),
        fecha_fin: new Date(2023, 0, i + 11)
    });
}

// Insertar 1000 documentos en EmpleadoProyecto
for (let i = 1; i <= 1000; i++) {
    db.EmpleadoProyecto.insertOne({
        id_empleado: i,
        id_proyecto: i,
        id_rol: i,
        fecha_asignacion: new Date(2023, 0, i + 1)
    });
}

// Insertar 1000 documentos en LogAcciones
for (let i = 1; i <= 1000; i++) {
    db.LogAcciones.insertOne({
        tabla: 'Ejemplo',
        accion: 'INSERT',
        registro: 'Registro ' + i,
        fecha: new Date()
    });
}