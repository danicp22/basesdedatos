--Creamos la base de datos
CREATE DATABASE EmpresaClientes;


--Usamos la base de datos
USE EmpresaClientes;


--Creamos la tabla cliente
CREATE TABLE Cliente (
    dni VARCHAR(9) PRIMARY KEY,       -- Identificador único de cada cliente
    nombre VARCHAR(50) NOT NULL,      -- Nombre del cliente
    apellidos VARCHAR(100) NOT NULL,  -- Apellidos del cliente
    email VARCHAR(100)                -- Correo electrónico del cliente
);


--Insertamos algunos registros de ejemplo
INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('12345678A', 'Juan', 'Pérez Martínez', 'juan.perez@gmail.com');

INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('87654321B', 'Ana', 'López García', 'ana.lopez@gmail.com');


INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('11223344C', 'Carlos', 'Ramírez Díaz', 'carlos.ramirez@hotmail.com');

--Consultar todos los clientes
SELECT * FROM Cliente;

```
+-----------+--------+------------------+----------------------------+
| dni       | nombre | apellidos        | email                      |
+-----------+--------+------------------+----------------------------+
| 11223344C | Carlos | Ramírez Díaz     | carlos.ramirez@hotmail.com |
| 12345678A | Juan   | Pérez Martínez   | juan.perez@gmail.com       |
| 87654321B | Ana    | López García     | ana.lopez@gmail.com        |
+-----------+--------+------------------+----------------------------+
```