- En ocasiones, al trabajar con los datos de una base de clientes, se necesita realizar cálculos y evaluaciones lógicas que me permitan clasificar información rápidamente. Para ello, SQL ofrece operadores aritméticos y lógicos que facilitan transformar valores y crear condiciones que ayudan en el análisis. A continuación aplico estos operadores sobre la base de datos *clientes1*.



- A continuacion se muestra un ejercicio que muestra como aplicar todos los operadores:
```
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
```




- En este ejercicio he podido practicar tanto los operadores aritméticos como los lógicos en SQL, comprobando cómo transformar valores numéricos y cómo generar columnas booleanas que clasifican a los clientes según su edad. Me sirve para seguir entendiendo cómo manipular y analizar datos dentro de una tabla.

