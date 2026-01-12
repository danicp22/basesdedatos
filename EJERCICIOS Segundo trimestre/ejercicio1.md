- En muchas aplicaciones empresariales, uno de los primeros pasos para gestionar la información de manera eficiente consiste en estructurar y almacenar los datos en un sistema que permita consultarlos, ordenarlos y manipularlos según las necesidades del usuario. Una base de datos bien definida se convierte así en el núcleo del programa, ya que permite acceder rápidamente a listados organizados, realizar búsquedas concretas y trabajar con la información de forma segura y coherente.


- A continuacion se muestra un ejercicio en el que creamos una base de datos, añadimos clientes y hacemos vistas para ordenarlos segun lo que queramos:
```
-- Crear la base de datos
CREATE DATABASE clientes1;

-- Usar la base de datos
USE clientes1;

-- Crear la tabla de clientes
CREATE TABLE clientes1(
  nombre VARCHAR(255),
  apellidos VARCHAR(255),
  edad INT
);

-- Insertar datos de ejemplo
INSERT INTO clientes1 VALUES('Juan', 'Pérez', 30);
INSERT INTO clientes1 VALUES('María', 'López', 25);
INSERT INTO clientes1 VALUES('Pedro', 'García', 40);

-- Listado ordenado por edad de mayor a menor
SELECT 
    nombre AS 'Nombre del cliente',
    apellidos AS 'Apellidos del cliente',
    edad AS 'Edad del cliente'
FROM 
    clientes1
ORDER BY
    edad DESC;

-- Listado ordenado por apellidos alfabéticamente (A → Z)
SELECT 
    nombre AS 'Nombre del cliente',
    apellidos AS 'Apellidos del cliente',
    edad AS 'Edad del cliente'
FROM 
    clientes1
ORDER BY
    apellidos ASC;

-- Selección simple de nombre y apellidos (vista rápida)
SELECT 
    nombre,
    apellidos
FROM 
    clientes1;

```



- Con esta base de datos y las consultas he podido crear un esquema sencillo para listar clientes según distintas necesidades: por edad de mayor a menor, por apellidos alfabéticamente y una vista rápida sin la edad. Considero que es una base sobre la que puedo seguir construyendo, añadiendo claves primarias y validaciones cuando escale el número de registros. ¿Quieres que lo extienda con filtros por rango de edad o búsqueda por apellidos?
