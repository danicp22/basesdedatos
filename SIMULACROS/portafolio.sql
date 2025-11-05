CREATE DATABASE portafolio;  --Creamos la base de datos

USE portafolio; --Nos metemos en la base de datos

CREATE TABLE pieza(  --Creamos la tabla pieza
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(1000),
    url VARCHAR(1000),
    id_categoria INT
);

CREATE TABLE categoria(  -- Creamos la tabla categoria
    identificador INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT
);


--Añadimos la Foreign Key
ALTER TABLE pieza
ADD CONSTRAINT fk_categoria_pieza
FOREIGN KEY (id_categoria)
REFERENCES categoria(identificador)
ON DELETE CASCADE
ON UPDATE CASCADE;



--Añadimos valores a las tablas
INSERT INTO categoria (titulo, descripcion) 
VALUES
  ('Fotografía', 'Proyectos y series fotográficas'),
  ('Diseño UI', 'Interfaces y prototipos'),
  ('Ilustración', 'Trabajos de ilustración digital');

INSERT INTO pieza (titulo, descripcion, imagen, url, id_categoria)
VALUES
  ('Serie Amanecer', 'Fotos del amanecer en la costa', '/media/amanecer.jpg', 'https://miportfolio.com/amanecer', 1),
  ('Dashboard App', 'Interfaz de panel de control', '/media/dashboard.png', 'https://miportfolio.com/dashboard', 2),
  ('Retrato Digital', 'Retrato hecho en Procreate', '/media/retrato.png', NULL, 3);


--Peticion Cruzada
SELECT
  pieza.titulo,
  pieza.descripcion,
  pieza.imagen,
  pieza.url,
  categoria.titulo,
  categoria.descripcion
FROM pieza
LEFT JOIN categoria
ON pieza.id_categoria = categoria.identificador;

+-----------------+--------------------------------+----------------------+-----------------------------------+--------------+----------------------------------+
| titulo          | descripcion                    | imagen               | url                               | titulo       | descripcion                      |
+-----------------+--------------------------------+----------------------+-----------------------------------+--------------+----------------------------------+
| Serie Amanecer  | Fotos del amanecer en la costa | /media/amanecer.jpg  | https://miportfolio.com/amanecer  | Fotografía   | Proyectos y series fotográficas  |
| Dashboard App   | Interfaz de panel de control   | /media/dashboard.png | https://miportfolio.com/dashboard | Diseño UI    | Interfaces y prototipos          |
| Retrato Digital | Retrato hecho en Procreate     | /media/retrato.png   | NULL                              | Ilustración  | Trabajos de ilustración digital  |
+-----------------+--------------------------------+----------------------+-----------------------------------+--------------+----------------------------------


--Creamos una vista
CREATE VIEW vista_piezas AS
SELECT
  pieza.titulo,
  pieza.descripcion,
  pieza.imagen,
  pieza.url,
  categoria.titulo AS categoria_titulo,
  categoria.descripcion AS categoria_descripcion
FROM pieza
LEFT JOIN categoria
ON pieza.id_categoria = categoria.identificador;


--Vemos la vista
SELECT * FROM vista_piezas;


+-----------------+--------------------------------+----------------------+-----------------------------------+------------------+----------------------------------+
| titulo          | descripcion                    | imagen               | url                               | categoria_titulo | categoria_descripcion            |
+-----------------+--------------------------------+----------------------+-----------------------------------+------------------+----------------------------------+
| Serie Amanecer  | Fotos del amanecer en la costa | /media/amanecer.jpg  | https://miportfolio.com/amanecer  | Fotografía       | Proyectos y series fotográficas  |
| Dashboard App   | Interfaz de panel de control   | /media/dashboard.png | https://miportfolio.com/dashboard | Diseño UI        | Interfaces y prototipos          |
| Retrato Digital | Retrato hecho en Procreate     | /media/retrato.png   | NULL                              | Ilustración      | Trabajos de ilustración digital  |
+-----------------+--------------------------------+----------------------+-----------------------------------+------------------+----------------------------------+


-- crea usuario nuevo con contraseña
-- creamos el nombre de usuario que queramos
CREATE USER 
'portafolioceac'@'localhost' 
IDENTIFIED  BY 'Dani12345&';

-- permite acceso a ese usuario
GRANT USAGE ON *.* TO 'portafolioceac'@'localhost';
--[tuservidor] == localhost
-- La contraseña puede requerir Mayus, minus, numeros, caracteres, min len

-- quitale todos los limites que tenga
ALTER USER 'portafolioceac'@'localhost' 
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 0 
MAX_CONNECTIONS_PER_HOUR 0 
MAX_UPDATES_PER_HOUR 0 
MAX_USER_CONNECTIONS 0;

-- dale acceso a la base de datos empresadam
GRANT ALL PRIVILEGES ON portafolio .* 
TO 'portafolioceac'@'localhost';

-- recarga la tabla de privilegios
FLUSH PRIVILEGES;