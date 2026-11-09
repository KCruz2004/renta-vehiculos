import os
from src.database.conexion import ConexionBD


def ejecutar_script(cursor, ruta):
    if not os.path.exists(ruta):
        raise FileNotFoundError(f"No se localizó el archivo: {ruta}")
    with open(ruta, "r", encoding="utf-8") as archivo:
        cursor.executescript(archivo.read())


def inicializar_base_datos():
    ruta_ddl = os.path.join("database", "schema.sql")
    ruta_seed = os.path.join("database", "seed_data.sql")

    conexion = ConexionBD().get_conexion()
    cursor = conexion.cursor()
    try:
        ejecutar_script(cursor, ruta_ddl)
        conexion.commit()
        print("[ÉXITO] Estructura de base de datos creada y verificada.")

        ejecutar_script(cursor, ruta_seed)
        conexion.commit()
        print("[ÉXITO] Datos semilla insertados.")
    except Exception as error:
        conexion.rollback()
        print(f"[FALLO] Ocurrió un error: {error}")


if __name__ == "__main__":
    inicializar_base_datos()