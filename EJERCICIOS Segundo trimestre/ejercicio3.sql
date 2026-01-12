-- Seleccionamos la base de datos de el primer ejercicio

USE clientes1;

-- Realizamos consultas para calcular el promedio de edad redondeado

SELECT ROUND(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado al número entero más cercano

SELECT FLOOR(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado hacia abajo al número entero más cercano

SELECT CEIL(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado hacia arriba al número entero más cercano

