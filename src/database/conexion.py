import os
import sqlite3


class ConexionBD:
    """Singleton: garantiza una única conexión a la base de datos."""
    _instancia = None

    def __new__(cls):
        if cls._instancia is None:
            cls._instancia = super().__new__(cls)
            os.makedirs("database", exist_ok=True)
            ruta_db = os.path.join("database", "pos_sistema.db")
            cls._instancia._conexion = sqlite3.connect(ruta_db)
            cls._instancia._conexion.execute("PRAGMA foreign_keys = ON;")
        return cls._instancia

    def get_conexion(self):
        return self._conexion

    def cerrar(self):
        if self._conexion:
            self._conexion.close()
            ConexionBD._instancia = None