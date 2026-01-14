Explicación del modelo de datos y base de datos del proyecto


- Mi proyecto es una pagina web de alquiler de rings de boxeo, he querido hacer una web seria y sin mucha tonteria, pero funcional. En este caso, voy a enfocarme en la base de datos, algo muy necesario, ya que sin la base de datos, casi nada de la web funcionaria. La web permite al usuario elegir entre dos rings de boxeo (profesional o entrenamiento), cuando el usuario escoja el ring deseado, se le pedira que inicie sesion o que se registre en caso de que no tenga cuenta. Una vez el usuario haya entrado con su cuenta, se le va a facilitar un calendario para que seleccione el dia que quiere hacer la reserva, una vez elegido el dia, apareceran unas casillas con las horas que esten disponibles, cuando el usuario elija la hora que desea y confirme la reserva, esta reserva sera guardada en `mis reservas`, donde el usuario podra entrar siempre que quiera iniciando sesion. A continuacion, muestro la estructura de carpetas de mi proyecto:
```
├── app.py
├── basededatos
│   └── base.sql
├── static
│   ├── estilo.css
│   ├── logo_ig.png
│   ├── logo_maps.png
│   ├── ring1.jpg
│   └── ring2.jpg
└── templates
    ├── index.html
    ├── login.html
    ├── mis_reservas.html
    ├── registro.html
    └── reservar.html
```


- Enfocandonos en la base de datos, para empezar, creamos la base de datos y la usamos:

```
CREATE DATABASE rings_boxeo;
USE rings_boxeo;

```

- Creamos la tabla `usuarios`, esta tabla va a permitir que los usuarios puedan iniciar sesion y registrarse, ya que sus datos van a quedar guardados, en cuanto a temas de privacidad no hay que preocuparse, ya que la contraseña se encripta automaticamente en hash.

```
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  email VARCHAR(100),
  password VARCHAR(255)
);
```

- Despues, tenemos que crear la tabla de los rings, en esta tabla añadiremos proximamente toda la informacion que deseemos, pero de momento solo creamos la tabla:
```
CREATE TABLE rings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  descripcion TEXT,
  precio INT,
  imagen VARCHAR(100)
);
```

- Como sabemos, la web es de alquiler de rings de boxeo, por lo que hace falta tener una tabla para almacenar las reservas, esta tabla es mas compleja, ya que coge el id del usuario y del ring para hacer la reserva. Tambien, hay que tener en cuenta que un mismo ring no puede ser reservado el dia 17 a las 11:00 por dos personas diferentes, por lo que ponemos que el id del ring, la fecha y la hora sean unicos, es decir, que solo pueda ser guardado en una reserva.
```
CREATE TABLE reservas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_ring INT,
  fecha DATE,
  hora INT,
  UNIQUE (id_ring, fecha, hora)
);

```


- A continuacion, tenemos que añadir la informacion que queremos que se muestre en la web sobre los ring, en este caso, es muy comodo, ya que insertamos nombre, descripcion, precio y imagen a la vez, lo cual es mostrado todo en la pagina web. Dependiendo de la cantidad de ring que queramos, podriamos añadir mas informacion, o inlcuso podriamos añadir mas tablas, pero para este proyecto no lo he visto necesario. 

```
INSERT INTO rings (nombre, descripcion, precio, imagen) VALUES
('Ring Profesional', 'Ring oficial para competiciones', 25, 'ring1.jpg'),
('Ring Entrenamiento', 'Ring para entrenamientos', 15, 'ring2.jpg');

```

- Para finalizar, creamos un usuario y le otorgamos permisos, este usuario se crea ya que queremos conectar la web con mysql, por lo tanto necesitamos el usuario para ponerlo en el archivo python y hacer la conexion.
```

CREATE USER "daniel"@"localhost" IDENTIFIED BY "Dani12345&";
GRANT ALL PRIVILEGES ON *.* TO "daniel"@"localhost";
FLUSH PRIVILEGES;

```


- Este proyecto me ha servido para acabar de entender como se puede conectar todo para hacer una web funcional, esta base de datos, es una base de datos sencilla, las cosas como son, pero es perfectamente funcional y sin fallos, algo muy importante cuando haces una pagina web. Aunque en este proyecto no he definido las claves foráneas de forma explícita, los campos id_usuario e id_ring actúan como referencias a las tablas usuarios y rings, manteniendo la coherencia lógica de los datos. Gracias a esta base de datos, es posible guardar los datos de los usuarios para el inicio de sesion, guardar la informacion que se va a mostrar sobre los rings, y guardar la informacion sobre todas las reservas, lo que evita problemas como dos reservas en la misma hora... 