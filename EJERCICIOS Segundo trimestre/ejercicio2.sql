-- Usamos la base de datos creada en el ejercicio anterior 
USE clientes1;

-- Usamos operadores aritmeticos 

SELECT nombre, apellidos, edad + 500 FROM clientes1;  -- Suma

SELECT nombre, apellidos, edad - 500 FROM clientes1;  -- Resta

SELECT nombre, apellidos, edad * 500 FROM clientes1;  -- Multiplicacion

SELECT nombre, apellidos, edad / 500 FROM clientes1;  -- Division


-- Usamos operadores logicos 

SELECT nombre, apellidos, edad < 30 AS 'Menor de 30 años' FROM clientes1; -- Determina si la edad es menor a 30

SELECT nombre, apellidos, edad >= 30 AND edad < 40 AS 'Entre 30 y 40 años' FROM clientes1; -- Determina si estan entre 30 y 40 años

SELECT nombre, apellidos, edad > 40 AS 'Mayor de 40 años' FROM clientes1; -- Determina si son mayores de 40 años