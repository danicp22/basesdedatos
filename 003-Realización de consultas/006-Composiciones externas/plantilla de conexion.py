import mysql.connector 

conexion = mysql.connector.connect(
  host="localhost",
  user="composiciones",
  password="Composiciones12345&",
  database="composiciones"
)                                      
  
cursor = conexion.cursor() 
cursor.execute("SELECT * FROM matriculas_join;")  

filas = cursor.fetchall()

print(filas)