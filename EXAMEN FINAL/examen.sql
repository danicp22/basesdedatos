-- Entramos en mysql
sudo mysql -u root -p

-- Creamos la base de datos
CREATE DATABASE portafolioexamen;

-- Entramos en la base de datos
USE portafolioexamen;

-- Creamos la tabla piezasportafolio
CREATE TABLE piezasportafolio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200),
    descripcion TEXT,
    fecha DATE,
    id_categoria INT
);

-- Comprobamos que se haya creado
DESCRIBE piezasportafolio;

+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int          | NO   | PRI | NULL    | auto_increment |
| titulo       | varchar(200) | YES  |     | NULL    |                |
| descripcion  | text         | YES  |     | NULL    |                |
| fecha        | date         | YES  |     | NULL    |                |
| id_categoria | int          | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+


-- Creamos la tabla categoriasportafolio
CREATE TABLE categoriasportafolio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200)
);

-- Comprobamos que se haya creado 
DESCRIBE categoriasportafolio;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(200) | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+


--Añadimos la Foreign Key
ALTER TABLE piezasportafolio
ADD CONSTRAINT fk_categoria_pieza
FOREIGN KEY (id_categoria)
REFERENCES categoriasportafolio(id)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- Comprobamos que se haya creado
DESCRIBE piezasportafolio;

| id_categoria | int          | YES  | MUL | NULL    |                |



--Añadimos valores a las tablas
INSERT INTO categoriasportafolio (nombre) 
VALUES
  ('Pintura'), ('Fotografía'), ('Escultura'), ('Instalación');

-- Comprobamos
SELECT * FROM categoriasportafolio;

+----+--------------+
| id | nombre       |
+----+--------------+
|  1 | Pintura      |
|  2 | Fotografía   |
|  3 | Escultura    |
|  4 | Instalación  |
+----+--------------+


 
INSERT INTO piezasportafolio (titulo, descripcion, fecha, id_categoria)
VALUES
  ('Amanecer en la bahía', 'Pintura al óleo que representa el amanecer sobre el mar', '2025-03-15', 1),
  ('Ciudad de noche', 'Fotografía urbana tomada con larga exposición', '2024-11-02', 2),
  ('Escultura de viento', 'Escultura metálica que se mueve con las corrientes de aire', '2025-01-20', 3);

-- Comprobamos
SELECT * FROM piezasportafolio;

+----+-----------------------+-------------------------------------------------------------+------------+--------------+
| id | titulo                | descripcion                                                 | fecha      | id_categoria |
+----+-----------------------+-------------------------------------------------------------+------------+--------------+
|  4 | Amanecer en la bahía  | Pintura al óleo que representa el amanecer sobre el mar     | 2025-03-15 |            1 |
|  5 | Ciudad de noche       | Fotografía urbana tomada con larga exposición               | 2024-11-02 |            2 |
|  6 | Escultura de viento   | Escultura metálica que se mueve con las corrientes de aire  | 2025-01-20 |            3 |
+----+-----------------------+-------------------------------------------------------------+------------+--------------+



-- Seleccion cruzada
SELECT
  piezasportafolio.titulo,
  piezasportafolio.descripcion,
  piezasportafolio.fecha,
  categoriasportafolio.nombre
FROM piezasportafolio
LEFT JOIN categoriasportafolio
ON piezasportafolio.id_categoria = categoriasportafolio.id;

+-----------------------+-------------------------------------------------------------+------------+-------------+
| titulo                | descripcion                                                 | fecha      | nombre      |
+-----------------------+-------------------------------------------------------------+------------+-------------+
| Amanecer en la bahía  | Pintura al óleo que representa el amanecer sobre el mar     | 2025-03-15 | Pintura     |
| Ciudad de noche       | Fotografía urbana tomada con larga exposición               | 2024-11-02 | Fotografía  |
| Escultura de viento   | Escultura metálica que se mueve con las corrientes de aire  | 2025-01-20 | Escultura   |
+-----------------------+-------------------------------------------------------------+------------+-------------+


--Creamos una vista
CREATE VIEW vista_piezas AS 
SELECT
  piezasportafolio.titulo,
  piezasportafolio.descripcion,
  piezasportafolio.fecha,
  categoriasportafolio.nombre AS categoria_nombre
FROM piezasportafolio
LEFT JOIN categoriasportafolio
ON piezasportafolio.id_categoria = categoriasportafolio.id;


--Vemos la vista
SELECT * FROM vista_piezas;

+-----------------------+-------------------------------------------------------------+------------+------------------+
| titulo                | descripcion                                                 | fecha      | categoria_nombre |
+-----------------------+-------------------------------------------------------------+------------+------------------+
| Amanecer en la bahía  | Pintura al óleo que representa el amanecer sobre el mar     | 2025-03-15 | Pintura          |
| Ciudad de noche       | Fotografía urbana tomada con larga exposición               | 2024-11-02 | Fotografía       |
| Escultura de viento   | Escultura metálica que se mueve con las corrientes de aire  | 2025-01-20 | Escultura        |
+-----------------------+-------------------------------------------------------------+------------+------------------+



-- crea usuario nuevo con contraseña
-- creamos el nombre de usuario que queramos
CREATE USER 
'dani'@'localhost' 
IDENTIFIED  BY 'Dani12345&';

-- permite acceso a ese usuario
GRANT USAGE ON *.* TO 'dani'@'localhost';
--[tuservidor] == localhost
-- La contraseña puede requerir Mayus, minus, numeros, caracteres, min len

-- quitale todos los limites que tenga
ALTER USER 'dani'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

-- dale acceso a la base de datos empresadam
GRANT ALL PRIVILEGES ON portafolioexamen .* 
TO 'dani'@'localhost';

-- recarga la tabla de privilegios
FLUSH PRIVILEGES;



-- Borrar 
DELETE FROM piezasportafolio WHERE id = 6;

+----+-----------------------+----------------------------------------------------------+------------+--------------+
| id | titulo                | descripcion                                              | fecha      | id_categoria |
+----+-----------------------+----------------------------------------------------------+------------+--------------+
|  4 | Amanecer en la bahía  | Pintura al óleo que representa el amanecer sobre el mar  | 2025-03-15 |            1 |
|  5 | Ciudad de noche       | Fotografía urbana tomada con larga exposición            | 2024-11-02 |            2 |
+----+-----------------------+----------------------------------------------------------+------------+--------------+


-- Actualizar
UPDATE piezasportafolio SET titulo ="Daniel" WHERE id = 4;


+----+-----------------+----------------------------------------------------------+------------+--------------+
| id | titulo          | descripcion                                              | fecha      | id_categoria |
+----+-----------------+----------------------------------------------------------+------------+--------------+
|  4 | Daniel          | Pintura al óleo que representa el amanecer sobre el mar  | 2025-03-15 |            1 |
|  5 | Ciudad de noche | Fotografía urbana tomada con larga exposición            | 2024-11-02 |            2 |
+----+-----------------+----------------------------------------------------------+------------+--------------+
