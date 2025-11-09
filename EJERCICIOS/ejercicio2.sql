--Creamos la base de datos
CREATE DATABASE empresadam;


--Entramos en la base de datos
USE empresadam;


--Creamos la tabla empleados 
CREATE TABLE empleados (
  id_empleado INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellidos VARCHAR(50),
  edad INT,
  cargo VARCHAR(50)
);

--Vemos si la tabla se ha creado
DESCRIBE empleados;
```
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| id_empleado | int         | NO   | PRI | NULL    | auto_increment |
| nombre      | varchar(50) | YES  |     | NULL    |                |
| apellidos   | varchar(50) | YES  |     | NULL    |                |
| edad        | int         | YES  |     | NULL    |                |
| cargo       | varchar(50) | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
```



--Insertamos datos
INSERT INTO empleados (nombre, apellidos, edad, cargo) VALUES 
('Juan', 'Pérez', 30, 'Gerente'),
('Ana', 'López', 28, 'Analista'),
('Carlos', 'Martínez', 35, 'Desarrollador');


--Consultamos los datos de la tabla
SELECT * FROM empleados;
```
+-------------+--------+-----------+------+---------------+
| id_empleado | nombre | apellidos | edad | cargo         |
+-------------+--------+-----------+------+---------------+
|           1 | Juan   | Pérez     |   30 | Gerente       |
|           2 | Ana    | López     |   28 | Analista      |
|           3 | Carlos | Martínez  |   35 | Desarrollador |
+-------------+--------+-----------+------+---------------+
```