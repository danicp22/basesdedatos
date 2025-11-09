-- Creamos la base de datos
CREATE DATABASE boxeo;


-- Entramos en la base de datos
USE boxeo;


-- Creamos  la tabla
CREATE TABLE boxeadores (
    id_boxeador INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    fecha_nacimiento DATE
);

-- Comprobamos la tabla
DESCRIBE boxeadores;
```
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| id_boxeador      | int         | NO   | PRI | NULL    |       |
| nombre           | varchar(50) | YES  |     | NULL    |       |
| apellidos        | varchar(50) | YES  |     | NULL    |       |
| fecha_nacimiento | date        | YES  |     | NULL    |       |
+------------------+-------------+------+-----+---------+-------+
```


--  Insertamos un boxeador
INSERT INTO boxeadores (id_boxeador, nombre, apellidos, fecha_nacimiento) VALUES 
(1, 'Juan', 'Perez', '1985-03-24');

-- Consultamos todos los boxeadores
SELECT * FROM boxeadores;
```
+-------------+--------+-----------+------------------+
| id_boxeador | nombre | apellidos | fecha_nacimiento |
+-------------+--------+-----------+------------------+
|           1 | Juan   | Perez     | 1985-03-24       |
+-------------+--------+-----------+------------------+
```
