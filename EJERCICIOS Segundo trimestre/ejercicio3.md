- Al analizar la información de una base de datos, a veces necesito obtener promedios de manera más precisa y adaptada a distintos tipos de interpretación. Dependiendo de si quiero aproximar hacia arriba, hacia abajo o al entero más cercano, SQL me ofrece funciones de redondeo muy útiles. En este ejercicio trabajo con la tabla *clientes1* para calcular el promedio de edad aplicando distintos tipos de redondeo.



- A continuacion se muestra un ejercicio en el que se calcula el promedio de edad redondeado:
```
-- Seleccionamos la base de datos de el primer ejercicio

USE clientes1;

-- Realizamos consultas para calcular el promedio de edad redondeado

SELECT ROUND(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado al número entero más cercano

SELECT FLOOR(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado hacia abajo al número entero más cercano

SELECT CEIL(AVG(edad)) FROM clientes1; -- Calcula el promedio de edad redondeado hacia arriba al número entero más cercano


```


- En este ejercicio he podido comparar cómo funcionan ROUND, FLOOR y CEIL al aplicarse sobre el promedio de edad. Me ha permitido ver cómo cada función modifica el resultado según su lógica de redondeo y cuándo puede ser más útil usar una u otra en mis consultas.


