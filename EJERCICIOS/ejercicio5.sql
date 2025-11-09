-- 1. Crear la tabla productos con restricciones
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(7, 2) NOT NULL,
    stock INT CHECK (stock >= 0),
    CHECK (precio >= 0 AND precio <= 5000),
    CHECK (LENGTH(nombre) >= 5)
);

-- Ver si la tabla se ha creado
DESCRIBE productos;
```
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| id          | int          | NO   | PRI | NULL    | auto_increment |
| nombre      | varchar(255) | NO   |     | NULL    |                |
| descripcion | text         | YES  |     | NULL    |                |
| precio      | decimal(7,2) | NO   |     | NULL    |                |
| stock       | int          | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
```



-- 2. Insertar productos válidos
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Patito Clásico', 'El patito de goma amarillo tradicional.', 3.50, 120),
('Patito Pirata', 'Patito de goma con parche y sombrero pirata.', 4.25, 80);

-- Ver si se añadieron
SELECT * FROM productos;
```
+----+-----------------+----------------------------------------------+--------+-------+
| id | nombre          | descripcion                                  | precio | stock |
+----+-----------------+----------------------------------------------+--------+-------+
|  1 | Patito Clásico  | El patito de goma amarillo tradicional.      |   3.50 |   120 |
|  2 | Patito Pirata   | Patito de goma con parche y sombrero pirata. |   4.25 |    80 |
+----+-----------------+----------------------------------------------+--------+-------+
```

-- 3. Intentar insertar productos con datos inválidos
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Patito Carísimo', 'Patito de goma de edición limitada, muy exclusivo.', 6000, 10); -- Precio > 5000
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Patito Barato', 'Patito de goma muy económico.', -5.00, 200); -- Precio negativo
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Pat', 'Un patito muy pequeño.', 2.50, 150); -- Nombre < 5 caracteres

-- Sale este fallo

`ERROR 3819 (HY000): Check constraint 'productos_chk_2' is violated.`
