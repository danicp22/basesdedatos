
CREATE DATABASE clientes1;

USE clientes1;

CREATE TABLE clientes1(
  nombre VARCHAR(255),
  apellidos VARCHAR(255),
  edad INT
);

INSERT INTO clientes1 VALUES('Juan', 'Pérez', 30);
INSERT INTO clientes1 VALUES('María', 'López', 25);
INSERT INTO clientes1 VALUES('Pedro', 'García', 40);


SELECT 
    nombre AS 'Nombre del cliente',
    apellidos AS 'Apellidos del cliente',
    edad AS 'Edad del cliente'
FROM 
    clientes1
ORDER BY
    edad DESC;


SELECT 
    nombre AS 'Nombre del cliente',
    apellidos AS 'Apellidos del cliente',
    edad AS 'Edad del cliente'
FROM 
    clientes1
ORDER BY
    apellidos ASC;


SELECT 
    nombre,
    apellidos
FROM 
    clientes1;