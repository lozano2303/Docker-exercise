// Script para crear la base de datos y colecciones en MongoDB
// Ejecutar con: mongo < message_mongodb.js

db = db.getSiblingDB('GestionProyectos');

// Crear colecciones (en MongoDB se crean automáticamente al insertar, pero podemos definir índices)
db.createCollection("Empresa");
db.createCollection("Cliente");
db.createCollection("Proyecto");
db.createCollection("Fase");
db.createCollection("Empleado");
db.createCollection("Rol");
db.createCollection("Recurso");
db.createCollection("ProyectoRecurso");
db.createCollection("ProyectoFase");
db.createCollection("EmpleadoProyecto");
db.createCollection("LogAcciones");

// Crear índices únicos donde sea necesario
db.Empresa.createIndex({ "NIT": 1 }, { unique: true });
db.Cliente.createIndex({ "documentoIdentidad": 1 }, { unique: true });

// Crear índices para claves foráneas
db.Proyecto.createIndex({ "id_empresa": 1 });
db.Proyecto.createIndex({ "id_cliente": 1 });
db.ProyectoRecurso.createIndex({ "id_proyecto": 1, "id_recurso": 1 }, { unique: true });
db.ProyectoFase.createIndex({ "id_proyecto": 1, "id_fase": 1 }, { unique: true });
db.EmpleadoProyecto.createIndex({ "id_empleado": 1, "id_proyecto": 1 }, { unique: true });

// Índice en LogAcciones para fecha
db.LogAcciones.createIndex({ "fecha": 1 });

// Función para simular triggers (se ejecutaría en la aplicación, no en la BD)
print("Base de datos GestionProyectos creada con colecciones e índices.");