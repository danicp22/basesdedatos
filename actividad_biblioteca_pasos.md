
- El diseño de bases de datos relacionales es fundamental para representar sistemas reales de forma estructurada y eficiente. En contextos como el de una biblioteca, es habitual trabajar con entidades que se relacionan entre sí: autores que escriben libros, socios que realizan préstamos, y registros que deben mantenerse íntegros y actualizados.
Para lograr una base de datos funcional y coherente, se aplican conceptos como claves primarias y foráneas, restricciones de integridad (CHECK, UNIQUE), índices para mejorar el rendimiento de las consultas, y vistas que permiten simplificar el acceso a información relevante. Además, la gestión de usuarios con permisos específicos refuerza la seguridad y el control del sistema.
- Este tipo de estructura no solo permite almacenar datos de forma ordenada, sino también garantizar su validez, facilitar su consulta y preparar el sistema para futuras ampliaciones o integraciones.


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--Antes de empezar a crear nada, tenemos que entrar dentro de mysql, con este comando: `sudo mysql -u root -p`

CREATE DATABASE biblioteca25; --Con esto se crea la base de datos
USE biblioteca25; --Con esto usamos la base de datos que acabamos de crear


CREATE TABLE autores (   --Creamos la tabla y le asignamos la informacion
  id INT AUTO_INCREMENT PRIMARY KEY, --Le asignamos la clave primaria
  nombre VARCHAR(100) NOT NULL, --Asignamos que este campo no puede estar vacio
  pais VARCHAR(80));

--He usado `DESCRIBE autores;` para que confimar que se ha creado la tabla autores:
```
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | NO   |     | NULL    |                |
| pais   | varchar(80)  | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
3 rows in set (0,02 sec)
```

CREATE TABLE libros (  --Creamos la tabla libros
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  isbn VARCHAR(20) NOT NULL UNIQUE, --No puede estar vacio y tiene que ser unico
  precio DECIMAL(8,2) NOT NULL CHECK (precio >= 0), --Obliga a comprobar que la respuesta es correcta
  autor_id INT NOT NULL,
  CONSTRAINT fk_libros_autor FOREIGN KEY (autor_id)
      REFERENCES autores(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT);

CREATE INDEX idx_libros_titulo ON libros (titulo); --Creamos un indice sobre titulo


DESCRIBE libros; --Verificamos si se ha creado la tabla, deberia de salir esto:
```
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int          | NO   | PRI | NULL    | auto_increment |
| titulo   | varchar(200) | NO   | MUL | NULL    |                |
| isbn     | varchar(20)  | NO   | UNI | NULL    |                |
| precio   | decimal(8,2) | NO   |     | NULL    |                |
| autor_id | int          | NO   | MUL | NULL    |                |
+----------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)
```


SHOW INDEX FROM libros; --Verificamos si el indice se ha creado, deberia de salir esto:
```
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name          | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| libros |          0 | PRIMARY           |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          0 | isbn              |            1 | isbn        | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          1 | fk_libros_autor   |            1 | autor_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          1 | idx_libros_titulo |            1 | titulo      | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0,01 sec)
```

CREATE TABLE socios (    --Creamos la tabla socios
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE), --Si no hay un valor sale por defecto, se pone automaticamente la fecha del dia actual del sistema
  CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'));


DESCRIBE socios; --Verificamos si la tabla se ha creado correctamente, deberia de salir esto:
```
+------------+--------------+------+-----+-----------+-------------------+
| Field      | Type         | Null | Key | Default   | Extra             |
+------------+--------------+------+-----+-----------+-------------------+
| id         | int          | NO   | PRI | NULL      | auto_increment    |
| nombre     | varchar(100) | NO   |     | NULL      |                   |
| email      | varchar(120) | NO   | UNI | NULL      |                   |
| fecha_alta | date         | NO   |     | curdate() | DEFAULT_GENERATED |
+------------+--------------+------+-----+-----------+-------------------+
4 rows in set (0,00 sec)
```
CREATE TABLE prestamos (  --Creamos la tabla prestamos
  id INT AUTO_INCREMENT PRIMARY KEY,
  socio_id INT NOT NULL,
  libro_id INT NOT NULL,
  fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
  fecha_devolucion DATE NULL, --Este campo puede estar vacio, ya que esta la posibilidad de que aun no haya sido devuelto
  CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo), --Si sí hay fecha de devolución, debe ser igual o posterior a la del préstamo.
  CONSTRAINT fk_prestamo_socio FOREIGN KEY (socio_id)
      REFERENCES socios(id)
      ON UPDATE CASCADE --si el id de un socio cambia (raro, pero posible), el cambio se propaga automáticamente a prestamos.
      ON DELETE CASCADE, --si se borra un socio, también se borran todos sus préstamos asociados.
  CONSTRAINT fk_prestamo_libro FOREIGN KEY (libro_id)
      REFERENCES libros(id)
      ON UPDATE CASCADE --si cambia el id del libro, se actualiza automáticamente aquí.
      ON DELETE RESTRICT); --no permite borrar un libro que aún tenga préstamos registrados (protege la integridad).


CREATE INDEX idx_prestamos_socio_libro ON prestamos (socio_id, libro_id); --Creamos el indice compuesto

DESCRIBE prestamos; --Verificamos si se ha creado:
```
+------------------+------+------+-----+-----------+-------------------+
| Field            | Type | Null | Key | Default   | Extra             |
+------------------+------+------+-----+-----------+-------------------+
| id               | int  | NO   | PRI | NULL      | auto_increment    |
| socio_id         | int  | NO   | MUL | NULL      |                   |
| libro_id         | int  | NO   | MUL | NULL      |                   |
| fecha_prestamo   | date | NO   |     | curdate() | DEFAULT_GENERATED |
| fecha_devolucion | date | YES  |     | NULL      |                   |
+------------------+------+------+-----+-----------+-------------------+
5 rows in set (0,01 sec)
```


SHOW INDEX FROM prestamos; --Verificamos si se ha creado el indice:
```
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table     | Non_unique | Key_name                  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| prestamos |          0 | PRIMARY                   |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | fk_prestamo_libro         |            1 | libro_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | idx_prestamos_socio_libro |            1 | socio_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | idx_prestamos_socio_libro |            2 | libro_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0,02 sec)
```

INSERT INTO autores (nombre, pais) VALUES --Añadimos datos a la tabla autores
('Isabel Allende', 'Chile'),
('Gabriel García Márquez', 'Colombia'),
('Haruki Murakami', 'Japón');

INSERT INTO libros (titulo, isbn, precio, autor_id) VALUES --Añadimos datos a la tabla libros
('La casa de los espíritus', '9788401352836', 19.90, 1),
('Cien años de soledad', '9780307474728', 22.50, 2),
('Kafka en la orilla', '9788499082478', 18.75, 3);


INSERT INTO socios (nombre, email) VALUES --Añadimos datos a la tabla socios
('Ana Ruiz', 'ana.ruiz@example.com'),
('Luis Pérez', 'luis.perez@example.com');


INSERT INTO prestamos (socio_id, libro_id) VALUES (1, 1); --Añadimos un prestamo activo a la tabla prestamos
INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES (2, 2, '2025-10-01', '2025-10-15'); --Añadimos un prestamo devuelto a la tabla prestamos



--Verificacion

SELECT * FROM autores;
```
+----+--------------------------+----------+
| id | nombre                   | pais     |
+----+--------------------------+----------+
|  1 | Isabel Allende           | Chile    |
|  2 | Gabriel García Márquez   | Colombia |
|  3 | Haruki Murakami          | Japón    |
+----+--------------------------+----------+
3 rows in set (0,00 sec)
```

SELECT * FROM libros;
```
+----+---------------------------+---------------+--------+----------+
| id | titulo                    | isbn          | precio | autor_id |
+----+---------------------------+---------------+--------+----------+
|  1 | La casa de los espíritus  | 9788401352836 |  19.90 |        1 |
|  2 | Cien años de soledad      | 9780307474728 |  22.50 |        2 |
|  3 | Kafka en la orilla        | 9788499082478 |  18.75 |        3 |
+----+---------------------------+---------------+--------+----------+
3 rows in set (0,00 sec)
```

SELECT * FROM socios;
```
+----+-------------+------------------------+------------+
| id | nombre      | email                  | fecha_alta |
+----+-------------+------------------------+------------+
|  1 | Ana Ruiz    | ana.ruiz@example.com   | 2025-10-31 |
|  2 | Luis Pérez  | luis.perez@example.com | 2025-10-31 |
+----+-------------+------------------------+------------+
2 rows in set (0,00 sec)
```

SELECT * FROM prestamos;
```
+----+----------+----------+----------------+------------------+
| id | socio_id | libro_id | fecha_prestamo | fecha_devolucion |
+----+----------+----------+----------------+------------------+
|  1 |        1 |        1 | 2025-10-31     | NULL             |
|  2 |        2 |        2 | 2025-10-01     | 2025-10-15       |
+----+----------+----------+----------------+------------------+
2 rows in set (0,00 sec)
```







--COMPROBACIONES FINALES

SHOW TABLES;

```
+------------------------+
| Tables_in_biblioteca25 |
+------------------------+
| autores                |
| libros                 |
| prestamos              |
| socios                 |
+------------------------+
4 rows in set (0,00 sec)
```

DESCRIBE autores;
```
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | NO   |     | NULL    |                |
| pais   | varchar(80)  | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
3 rows in set (0,00 sec)
```
DESCRIBE libros;
```
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int          | NO   | PRI | NULL    | auto_increment |
| titulo   | varchar(200) | NO   | MUL | NULL    |                |
| isbn     | varchar(20)  | NO   | UNI | NULL    |                |
| precio   | decimal(8,2) | NO   |     | NULL    |                |
| autor_id | int          | NO   | MUL | NULL    |                |
+----------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)
```

DESCRIBE socios;
```
+------------+--------------+------+-----+-----------+-------------------+
| Field      | Type         | Null | Key | Default   | Extra             |
+------------+--------------+------+-----+-----------+-------------------+
| id         | int          | NO   | PRI | NULL      | auto_increment    |
| nombre     | varchar(100) | NO   |     | NULL      |                   |
| email      | varchar(120) | NO   | UNI | NULL      |                   |
| fecha_alta | date         | NO   |     | curdate() | DEFAULT_GENERATED |
+------------+--------------+------+-----+-----------+-------------------+
4 rows in set (0,00 sec)
```
DESCRIBE prestamos;
```
+------------------+------+------+-----+-----------+-------------------+
| Field            | Type | Null | Key | Default   | Extra             |
+------------------+------+------+-----+-----------+-------------------+
| id               | int  | NO   | PRI | NULL      | auto_increment    |
| socio_id         | int  | NO   | MUL | NULL      |                   |
| libro_id         | int  | NO   | MUL | NULL      |                   |
| fecha_prestamo   | date | NO   |     | curdate() | DEFAULT_GENERATED |
| fecha_devolucion | date | YES  |     | NULL      |                   |
+------------------+------+------+-----+-----------+-------------------+
5 rows in set (0,00 sec)
```



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



- A continuacion, se muestra un ejercicio en el que se crea una base de datos de una biblioteca, en ella se añaden diferentes tablas y a cada una se le añade su informacion, tambien hay tablas que tienen indices:
```
--Antes de empezar a crear nada, tenemos que entrar dentro de mysql, con este comando: `sudo mysql -u root -p`

CREATE DATABASE biblioteca25; --Con esto se crea la base de datos
USE biblioteca25; --Con esto usamos la base de datos que acabamos de crear


CREATE TABLE autores (   --Creamos la tabla y le asignamos la informacion
  id INT AUTO_INCREMENT PRIMARY KEY, --Le asignamos la clave primaria
  nombre VARCHAR(100) NOT NULL, --Asignamos que este campo no puede estar vacio
  pais VARCHAR(80));

--He usado `DESCRIBE autores;` para que confimar que se ha creado la tabla autores:
```
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | NO   |     | NULL    |                |
| pais   | varchar(80)  | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
3 rows in set (0,02 sec)
```

CREATE TABLE libros (  --Creamos la tabla libros
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  isbn VARCHAR(20) NOT NULL UNIQUE, --No puede estar vacio y tiene que ser unico
  precio DECIMAL(8,2) NOT NULL CHECK (precio >= 0), --Obliga a comprobar que la respuesta es correcta
  autor_id INT NOT NULL,
  CONSTRAINT fk_libros_autor FOREIGN KEY (autor_id)
      REFERENCES autores(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT);

CREATE INDEX idx_libros_titulo ON libros (titulo); --Creamos un indice sobre titulo


DESCRIBE libros; --Verificamos si se ha creado la tabla, deberia de salir esto:
```
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int          | NO   | PRI | NULL    | auto_increment |
| titulo   | varchar(200) | NO   | MUL | NULL    |                |
| isbn     | varchar(20)  | NO   | UNI | NULL    |                |
| precio   | decimal(8,2) | NO   |     | NULL    |                |
| autor_id | int          | NO   | MUL | NULL    |                |
+----------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)
```


SHOW INDEX FROM libros; --Verificamos si el indice se ha creado, deberia de salir esto:
```
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name          | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| libros |          0 | PRIMARY           |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          0 | isbn              |            1 | isbn        | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          1 | fk_libros_autor   |            1 | autor_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| libros |          1 | idx_libros_titulo |            1 | titulo      | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+--------+------------+-------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0,01 sec)
```

CREATE TABLE socios (    --Creamos la tabla socios
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  fecha_alta DATE NOT NULL DEFAULT (CURRENT_DATE), --Si no hay un valor sale por defecto, se pone automaticamente la fecha del dia actual del sistema
  CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'));


DESCRIBE socios; --Verificamos si la tabla se ha creado correctamente, deberia de salir esto:
```
+------------+--------------+------+-----+-----------+-------------------+
| Field      | Type         | Null | Key | Default   | Extra             |
+------------+--------------+------+-----+-----------+-------------------+
| id         | int          | NO   | PRI | NULL      | auto_increment    |
| nombre     | varchar(100) | NO   |     | NULL      |                   |
| email      | varchar(120) | NO   | UNI | NULL      |                   |
| fecha_alta | date         | NO   |     | curdate() | DEFAULT_GENERATED |
+------------+--------------+------+-----+-----------+-------------------+
4 rows in set (0,00 sec)
```
CREATE TABLE prestamos (  --Creamos la tabla prestamos
  id INT AUTO_INCREMENT PRIMARY KEY,
  socio_id INT NOT NULL,
  libro_id INT NOT NULL,
  fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
  fecha_devolucion DATE NULL, --Este campo puede estar vacio, ya que esta la posibilidad de que aun no haya sido devuelto
  CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo), --Si sí hay fecha de devolución, debe ser igual o posterior a la del préstamo.
  CONSTRAINT fk_prestamo_socio FOREIGN KEY (socio_id)
      REFERENCES socios(id)
      ON UPDATE CASCADE --si el id de un socio cambia (raro, pero posible), el cambio se propaga automáticamente a prestamos.
      ON DELETE CASCADE, --si se borra un socio, también se borran todos sus préstamos asociados.
  CONSTRAINT fk_prestamo_libro FOREIGN KEY (libro_id)
      REFERENCES libros(id)
      ON UPDATE CASCADE --si cambia el id del libro, se actualiza automáticamente aquí.
      ON DELETE RESTRICT); --no permite borrar un libro que aún tenga préstamos registrados (protege la integridad).


CREATE INDEX idx_prestamos_socio_libro ON prestamos (socio_id, libro_id); --Creamos el indice compuesto

DESCRIBE prestamos; --Verificamos si se ha creado:
```
+------------------+------+------+-----+-----------+-------------------+
| Field            | Type | Null | Key | Default   | Extra             |
+------------------+------+------+-----+-----------+-------------------+
| id               | int  | NO   | PRI | NULL      | auto_increment    |
| socio_id         | int  | NO   | MUL | NULL      |                   |
| libro_id         | int  | NO   | MUL | NULL      |                   |
| fecha_prestamo   | date | NO   |     | curdate() | DEFAULT_GENERATED |
| fecha_devolucion | date | YES  |     | NULL      |                   |
+------------------+------+------+-----+-----------+-------------------+
5 rows in set (0,01 sec)
```


SHOW INDEX FROM prestamos; --Verificamos si se ha creado el indice:
```
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table     | Non_unique | Key_name                  | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| prestamos |          0 | PRIMARY                   |            1 | id          | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | fk_prestamo_libro         |            1 | libro_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | idx_prestamos_socio_libro |            1 | socio_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| prestamos |          1 | idx_prestamos_socio_libro |            2 | libro_id    | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+-----------+------------+---------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0,02 sec)
```

INSERT INTO autores (nombre, pais) VALUES --Añadimos datos a la tabla autores
('Isabel Allende', 'Chile'),
('Gabriel García Márquez', 'Colombia'),
('Haruki Murakami', 'Japón');

INSERT INTO libros (titulo, isbn, precio, autor_id) VALUES --Añadimos datos a la tabla libros
('La casa de los espíritus', '9788401352836', 19.90, 1),
('Cien años de soledad', '9780307474728', 22.50, 2),
('Kafka en la orilla', '9788499082478', 18.75, 3);


INSERT INTO socios (nombre, email) VALUES --Añadimos datos a la tabla socios
('Ana Ruiz', 'ana.ruiz@example.com'),
('Luis Pérez', 'luis.perez@example.com');


INSERT INTO prestamos (socio_id, libro_id) VALUES (1, 1); --Añadimos un prestamo activo a la tabla prestamos
INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion)
VALUES (2, 2, '2025-10-01', '2025-10-15'); --Añadimos un prestamo devuelto a la tabla prestamos



--Verificacion

SELECT * FROM autores;
```
+----+--------------------------+----------+
| id | nombre                   | pais     |
+----+--------------------------+----------+
|  1 | Isabel Allende           | Chile    |
|  2 | Gabriel García Márquez   | Colombia |
|  3 | Haruki Murakami          | Japón    |
+----+--------------------------+----------+
3 rows in set (0,00 sec)
```

SELECT * FROM libros;
```
+----+---------------------------+---------------+--------+----------+
| id | titulo                    | isbn          | precio | autor_id |
+----+---------------------------+---------------+--------+----------+
|  1 | La casa de los espíritus  | 9788401352836 |  19.90 |        1 |
|  2 | Cien años de soledad      | 9780307474728 |  22.50 |        2 |
|  3 | Kafka en la orilla        | 9788499082478 |  18.75 |        3 |
+----+---------------------------+---------------+--------+----------+
3 rows in set (0,00 sec)
```

SELECT * FROM socios;
```
+----+-------------+------------------------+------------+
| id | nombre      | email                  | fecha_alta |
+----+-------------+------------------------+------------+
|  1 | Ana Ruiz    | ana.ruiz@example.com   | 2025-10-31 |
|  2 | Luis Pérez  | luis.perez@example.com | 2025-10-31 |
+----+-------------+------------------------+------------+
2 rows in set (0,00 sec)
```

SELECT * FROM prestamos;
```
+----+----------+----------+----------------+------------------+
| id | socio_id | libro_id | fecha_prestamo | fecha_devolucion |
+----+----------+----------+----------------+------------------+
|  1 |        1 |        1 | 2025-10-31     | NULL             |
|  2 |        2 |        2 | 2025-10-01     | 2025-10-15       |
+----+----------+----------+----------------+------------------+
2 rows in set (0,00 sec)
```







--COMPROBACIONES FINALES

SHOW TABLES;

```
+------------------------+
| Tables_in_biblioteca25 |
+------------------------+
| autores                |
| libros                 |
| prestamos              |
| socios                 |
+------------------------+
4 rows in set (0,00 sec)
```

DESCRIBE autores;
```
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| nombre | varchar(100) | NO   |     | NULL    |                |
| pais   | varchar(80)  | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
3 rows in set (0,00 sec)
```
DESCRIBE libros;
```
+----------+--------------+------+-----+---------+----------------+
| Field    | Type         | Null | Key | Default | Extra          |
+----------+--------------+------+-----+---------+----------------+
| id       | int          | NO   | PRI | NULL    | auto_increment |
| titulo   | varchar(200) | NO   | MUL | NULL    |                |
| isbn     | varchar(20)  | NO   | UNI | NULL    |                |
| precio   | decimal(8,2) | NO   |     | NULL    |                |
| autor_id | int          | NO   | MUL | NULL    |                |
+----------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)
```

DESCRIBE socios;
```
+------------+--------------+------+-----+-----------+-------------------+
| Field      | Type         | Null | Key | Default   | Extra             |
+------------+--------------+------+-----+-----------+-------------------+
| id         | int          | NO   | PRI | NULL      | auto_increment    |
| nombre     | varchar(100) | NO   |     | NULL      |                   |
| email      | varchar(120) | NO   | UNI | NULL      |                   |
| fecha_alta | date         | NO   |     | curdate() | DEFAULT_GENERATED |
+------------+--------------+------+-----+-----------+-------------------+
4 rows in set (0,00 sec)
```
DESCRIBE prestamos;
```
+------------------+------+------+-----+-----------+-------------------+
| Field            | Type | Null | Key | Default   | Extra             |
+------------------+------+------+-----+-----------+-------------------+
| id               | int  | NO   | PRI | NULL      | auto_increment    |
| socio_id         | int  | NO   | MUL | NULL      |                   |
| libro_id         | int  | NO   | MUL | NULL      |                   |
| fecha_prestamo   | date | NO   |     | curdate() | DEFAULT_GENERATED |
| fecha_devolucion | date | YES  |     | NULL      |                   |
+------------------+------+------+-----+-----------+-------------------+
5 rows in set (0,00 sec)
```
```



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


- La construcción de la base de datos biblioteca25 ha permitido aplicar de forma práctica los principios del diseño relacional en MySQL. Se han definido correctamente las tablas autores, libros, socios y prestamos, estableciendo relaciones entre ellas mediante claves foráneas con comportamientos CASCADE y RESTRICT, y validando los datos con restricciones CHECK y expresiones regulares.
Además, se han creado índices para optimizar búsquedas, una vista para consultar préstamos activos, y un usuario de solo lectura para reforzar la seguridad. Los datos insertados han sido coherentes y han permitido verificar el correcto funcionamiento de la estructura.
- Este ejercicio demuestra cómo una base de datos bien diseñada puede representar fielmente un sistema real, y sienta las bases para futuras ampliaciones como reservas, historial de préstamos o gestión de sanciones.