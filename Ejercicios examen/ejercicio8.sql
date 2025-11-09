-- 1. Crear la tabla personas
CREATE TABLE personas (
    identificador INT PRIMARY KEY,       -- Clave primaria
    nombre VARCHAR(100),
    edad INT
);

-- 2. Insertar datos en la tabla personas
INSERT INTO personas (identificador, nombre, edad)
VALUES (1, 'Juan Pérez', 30);          -- Insertamos un usuario
-- Vemos que se hayan añadido
SELECT * FROM personas;
```
+---------------+-------------+------+
| identificador | nombre      | edad |
+---------------+-------------+------+
|             1 | Juan Pérez  |   30 |
+---------------+-------------+------+
```

-- 3. Crear la tabla emails
CREATE TABLE emails (
    emid_ail INT PRIMARY KEY,            -- Clave primaria
    email VARCHAR(100),
    persona INT,                         -- Clave ajena (foreign key)
    FOREIGN KEY (persona) REFERENCES personas(identificador)  -- Referencia a la tabla personas
);

-- 4. Insertar datos en la tabla emails
INSERT INTO emails (emid_ail, email, persona)
VALUES (1, 'juanperez@example.com', 1),  -- Email 1 para Juan Pérez
       (2, 'juanperez123@example.com', 1); -- Email 2 para Juan Pérez
--Vemos que se hayan añadido
SELECT * FROM emails;
```
+----------+--------------------------+---------+
| emid_ail | email                    | persona |
+----------+--------------------------+---------+
|        1 | juanperez@example.com    |       1 |
|        2 | juanperez123@example.com |       1 |
+----------+--------------------------+---------+
```
-- 5. Realizar una consulta JOIN para combinar las tablas personas y emails
SELECT personas.nombre, personas.edad, emails.email
FROM personas
JOIN emails ON personas.identificador = emails.persona;
