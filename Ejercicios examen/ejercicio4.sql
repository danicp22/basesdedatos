-- Seleccionamos la base de datos
USE empresadam;

-- Creamos una tabla llamada `inscritos`
CREATE TABLE inscritos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  evento VARCHAR(50)
);

-- Vemos si se ha creado
DESCRIBE inscritos;
```
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | YES  |     | NULL    |                |
| evento | varchar(50)  | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
```