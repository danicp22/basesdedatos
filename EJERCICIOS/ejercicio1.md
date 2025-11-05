- En el contexto de la gestión empresarial, disponer de una base de datos organizada y funcional es esencial para almacenar información relevante sobre los clientes. Este ejercicio se centra en la creación de una base de datos llamada EmpresaClientes, que incluye una tabla denominada Cliente. Dicha tabla permite registrar datos clave como el DNI, nombre, apellidos y correo electrónico de cada cliente. Además, se insertan registros de ejemplo y se realiza una consulta para visualizar todos los clientes registrados. El objetivo es entender cómo se estructura una base de datos básica en SQL y cómo se pueden realizar operaciones fundamentales como la inserción y la consulta de datos.




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



- A continuacion se muestra un ejercicio en el que se crea una base de datos, se crea una tabla y se le irsentan datos a la tabla:
```

CREATE DATABASE EmpresaClientes;



USE EmpresaClientes;



CREATE TABLE Cliente (
    dni VARCHAR(9) PRIMARY KEY,       
    nombre VARCHAR(50) NOT NULL,      
    apellidos VARCHAR(100) NOT NULL,  
    email VARCHAR(100)                
);



INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('12345678A', 'Juan', 'Pérez Martínez', 'juan.perez@gmail.com');

INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('87654321B', 'Ana', 'López García', 'ana.lopez@gmail.com');


INSERT INTO Cliente (dni, nombre, apellidos, email)
VALUES ('11223344C', 'Carlos', 'Ramírez Díaz', 'carlos.ramirez@hotmail.com');


SELECT * FROM Cliente;


```




- Este ejercicio ha permitido construir una base de datos sencilla pero funcional para la gestión de clientes. Se ha creado la base de datos EmpresaClientes, se ha definido la tabla Cliente con sus respectivos campos y restricciones, y se han insertado registros representativos. Finalmente, se ha ejecutado una consulta para visualizar el contenido de la tabla. Este tipo de estructura es la base para sistemas más complejos de gestión empresarial, y dominar estos conceptos es fundamental para trabajar con bases de datos relacionales en entornos reales.