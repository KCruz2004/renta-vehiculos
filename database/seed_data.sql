INSERT OR IGNORE INTO categorias (id_categoria, nombre, descripcion) VALUES
(1, 'Sedán',  'Vehículos compactos y económicos'),
(2, 'SUV',    'Vehículos familiares de mayor capacidad'),
(3, 'Pickup', 'Vehículos de carga y terreno difícil');

INSERT OR IGNORE INTO vehiculos
(id_vehiculo, id_categoria, placa, marca, modelo, anio, color, transmision, capacidad_pasajeros, precio_dia, estado) VALUES
(1, 1, 'P123-456', 'Toyota', 'Yaris',   2023, 'Blanco', 'automatica', 5, 35.00, 'activo'),
(2, 1, 'P234-567', 'Nissan', 'Versa',   2022, 'Gris',   'manual',     5, 32.00, 'activo'),
(3, 2, 'P345-678', 'Kia',    'Sportage',2024, 'Negro',  'automatica', 5, 55.00, 'activo'),
(4, 3, 'P456-789', 'Toyota', 'Hilux',   2023, 'Rojo',   'manual',     5, 60.00, 'mantenimiento');

INSERT OR IGNORE INTO reservas
(id_reserva, id_vehiculo, cliente_nombre, cliente_documento, fecha_inicio, fecha_fin, estado, deposito_garantia, total) VALUES
(1, 1, 'María López',   '01234567-8', '2026-12-10', '2026-12-13', 'confirmada',     100.00, 105.00),
(2, 3, 'Carlos Pérez',  '02345678-9', '2026-12-20', '2026-12-22', 'pendiente_pago', 150.00, 110.00),
(3, 2, 'Ana Martínez',  '03456789-0', '2026-12-15', '2026-12-17', 'cancelada',      100.00,  64.00);

INSERT OR IGNORE INTO detalle_pagos
(id_pago, id_reserva, metodo_pago, monto, estado_pago, id_transaccion) VALUES
(1, 1, 'tarjeta_credito', 105.00, 'aprobado',  'TXN-0001-APR'),
(2, 3, 'tarjeta_debito',   64.00, 'rechazado', 'TXN-0003-REJ');