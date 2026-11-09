-- Habilitar integridad de claves foráneas
PRAGMA foreign_keys = ON;

-- 1. Categorías de vehículos
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE,
    descripcion  TEXT
);

-- 2. Flota de vehículos (equivale a "productos")
CREATE TABLE IF NOT EXISTS vehiculos (
    id_vehiculo         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_categoria        INTEGER NOT NULL,
    placa               TEXT NOT NULL UNIQUE,
    marca               TEXT NOT NULL,
    modelo              TEXT NOT NULL,
    anio                INTEGER NOT NULL CHECK (anio >= 1990),
    color               TEXT,
    transmision         TEXT NOT NULL CHECK (transmision IN ('manual', 'automatica')),
    capacidad_pasajeros INTEGER NOT NULL CHECK (capacidad_pasajeros > 0),
    precio_dia          REAL NOT NULL CHECK (precio_dia >= 0),
    estado              TEXT NOT NULL DEFAULT 'activo'
                        CHECK (estado IN ('activo', 'mantenimiento', 'fuera_servicio')),
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. Cabecera de reservas (equivale a "ventas")
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo        INTEGER NOT NULL,
    cliente_nombre     TEXT NOT NULL,
    cliente_documento  TEXT NOT NULL,
    fecha_creacion     TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
    fecha_inicio       TEXT NOT NULL,   -- YYYY-MM-DD
    fecha_fin          TEXT NOT NULL,   -- YYYY-MM-DD
    estado             TEXT NOT NULL DEFAULT 'pendiente_pago'
                       CHECK (estado IN ('pendiente_pago', 'confirmada', 'cancelada')),
    deposito_garantia  REAL NOT NULL DEFAULT 0 CHECK (deposito_garantia >= 0),
    total              REAL NOT NULL CHECK (total >= 0),
    CHECK (fecha_fin > fecha_inicio),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4. Detalle de pagos de la reserva (equivale a "detalle_ventas")
CREATE TABLE IF NOT EXISTS detalle_pagos (
    id_pago        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva     INTEGER NOT NULL,
    metodo_pago    TEXT NOT NULL CHECK (metodo_pago IN ('tarjeta_credito', 'tarjeta_debito')),
    monto          REAL NOT NULL CHECK (monto > 0),
    estado_pago    TEXT NOT NULL CHECK (estado_pago IN ('aprobado', 'rechazado', 'expirado')),
    id_transaccion TEXT UNIQUE,         -- identificador devuelto por la pasarela
    fecha_pago     TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva) ON DELETE CASCADE
);