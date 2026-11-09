from src.database.conexion import ConexionBD

a = ConexionBD()
b = ConexionBD()
print(a is b)  # True