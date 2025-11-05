-- me toco la misma tematica con el taller de erick xd
-- El drop es porque a veces me sale un error pero no se que es talvez sea un error de capa 8
DROP DATABASE IF EXISTS TiendaTech;
CREATE DATABASE TiendaTech;
USE TiendaTech;

-- Tabla de Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    fecha_ingreso DATE
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50),
    correo VARCHAR(100),
    fecha_registro DATE
);

-- Tabla de Ventas
CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    id_cliente INT NOT NULL,
    cantidad INT NOT NULL,
    valor_total DECIMAL(10,2),
    fecha_venta DATE
);
-- Hacer esta cosa si es mamona la verdad
-- Insertar Productos
INSERT INTO Productos (nombre_producto, categoria, precio, stock, fecha_ingreso) VALUES
('Laptop Dell Inspiron', 'Computadores', 2500000.00, 15, '2025-01-15'),
('Mouse Logitech', 'Accesorios', 45000.00, 50, '2025-02-01'),
('Teclado Mecánico', 'Accesorios', 180000.00, 30, '2025-02-10'),
('Monitor Samsung 24"', 'Monitores', 650000.00, 20, '2025-01-20'),
('iPhone 15', 'Celulares', 4500000.00, 10, '2025-03-05'),
('Audífonos Sony', 'Audio', 250000.00, 40, '2025-02-15'),
('Tablet Samsung', 'Tablets', 1200000.00, 25, '2025-03-10'),
('Webcam Logitech', 'Accesorios', 320000.00, 18, '2025-01-25'),
('Disco Duro 1TB', 'Almacenamiento', 180000.00, 35, '2025-02-20'),
('Impresora HP', 'Impresoras', 450000.00, 12, '2025-03-01');

-- Insertar Clientes
INSERT INTO Clientes (nombre_cliente, ciudad, correo, fecha_registro) VALUES
('Carlos Rodríguez', 'Bogotá', 'carlos.r@gmail.com', '2025-01-10'),
('María González', 'Medellín', 'maria.g@hotmail.com', '2025-03-15'),
('Juan Pérez', 'Cali', 'juan.p@outlook.com', '2025-02-20'),
('Ana López', 'Barranquilla', 'ana.l@gmail.com', '2025-03-22'),
('Pedro Martínez', 'Cartagena', 'pedro.m@yahoo.com', '2025-01-05'),
('Laura Sánchez', 'Bogotá', 'laura.s@gmail.com', '2025-03-18'),
('Diego Torres', 'Medellín', 'diego.t@hotmail.com', '2025-02-28'),
('Sofía Ramírez', 'Cali', 'sofia.r@gmail.com', '2025-03-25'),
('Andrés Castro', 'Bucaramanga', 'andres.c@outlook.com', '2025-01-30'),
('Valentina Ruiz', 'Pereira', 'valentina.r@gmail.com', '2025-03-20');

-- Insertar Ventas
INSERT INTO Ventas (id_producto, id_cliente, cantidad, valor_total, fecha_venta) VALUES
(1, 1, 1, 2500000.00, '2025-04-05'),
(2, 2, 3, 135000.00, '2025-04-08'),
(3, 3, 2, 360000.00, '2025-04-10'),
(5, 4, 1, 4500000.00, '2025-04-12'),
(4, 5, 2, 1300000.00, '2025-04-15'),
(6, 1, 2, 500000.00, '2025-04-18'),
(7, 6, 1, 1200000.00, '2025-04-20'),
(8, 7, 1, 320000.00, '2025-04-22'),
(9, 8, 3, 540000.00, '2025-04-25'),
(10, 9, 1, 450000.00, '2025-04-28'),
(2, 10, 5, 225000.00, '2025-04-30'),
(3, 2, 1, 180000.00, '2025-03-15'),
(1, 4, 1, 2500000.00, '2025-03-20');


-- Ejercicio 1: Mostrar todos los productos 
SELECT * FROM Productos;

-- Ejercicio 2: Listar clientes registrados en marzo 2025
SELECT * FROM Clientes
WHERE MONTH(fecha_registro) = 3 AND YEAR(fecha_registro) = 2025;

-- Ejercicio 3: Consultar ventas de abril 2025
SELECT * FROM Ventas
-- Aqui para los mismo que en el ejercicio 2 pero lo unico que cambia es el mes
WHERE MONTH(fecha_venta) = 4 AND YEAR(fecha_venta) = 2025;

-- Ejercicio 4: Total de productos en inventario
-- Aqui es una suma de todo el inventario
SELECT SUM(stock) AS total_productos_inventario FROM Productos;

-- Consulta: Detalle completo de ventas con información de clientes y productos
-- Esta parte es para en lugar de ver solo números (IDs), esta consulta muestra nombres reales de 
-- clientes y productos, haciendo el reporte legible y útil para humanos. Es como hacer un "JOIN manual" entre las 3 tablas.
SELECT 
    c.nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.valor_total,
    v.fecha_venta
FROM Ventas v, Clientes c, Productos p
WHERE v.id_cliente = c.id_cliente
AND v.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;

-- Consulta: Productos más vendidos
-- Aqui se hace algo parecido con la funcion anterior, aqui se esta mostrando el producto mas vendidio
SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS total_vendido,
    SUM(v.valor_total) AS ingresos_totales
FROM Productos p, Ventas v
WHERE p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre_producto
ORDER BY total_vendido DESC;

-- Consulta: Clientes con más compras
-- Ya explique esto con los 2 anteriores ejemplos no hace falta explicarlo otra vez y para las siguientes tambien
SELECT 
    c.nombre_cliente,
    c.ciudad,
    COUNT(v.id_venta) AS total_compras,
    SUM(v.valor_total) AS total_gastado
FROM Clientes c, Ventas v
WHERE c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente, c.ciudad
ORDER BY total_gastado DESC;

-- Consulta: Productos con stock bajo (menos de 20 unidades)
SELECT 
    nombre_producto,
    categoria,
    stock,
    precio
FROM Productos
WHERE stock < 20
ORDER BY stock ASC;

-- Consulta: Ventas por categoría
SELECT 
    p.categoria,
    COUNT(v.id_venta) AS total_ventas,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.valor_total) AS ingresos
FROM Productos p, Ventas v
WHERE p.id_producto = v.id_producto
GROUP BY p.categoria
ORDER BY ingresos DESC;


-- RETO 1: Vista con resumen de ventas
CREATE VIEW vista_resumen_ventas AS
SELECT 
    v.id_venta,
    c.nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    p.categoria,
    v.cantidad,
    v.valor_total,
    v.fecha_venta
FROM Ventas v, Clientes c, Productos p
WHERE v.id_cliente = c.id_cliente
AND v.id_producto = p.id_producto;

-- Consultar la vista
SELECT * FROM vista_resumen_ventas;

-- RETO 2: Ingreso total diario
SELECT 
    fecha_venta,
    COUNT(id_venta) AS num_ventas,
    SUM(valor_total) AS ingreso_total_dia
FROM Ventas
GROUP BY fecha_venta
ORDER BY fecha_venta DESC;

-- RETO 3: Procedimiento almacenado para consultar ventas por cliente
DELIMITER //

CREATE PROCEDURE consultar_ventas_cliente(IN cliente_id INT)
BEGIN
    SELECT 
        v.id_venta,
        c.nombre_cliente,
        p.nombre_producto,
        v.cantidad,
        v.valor_total,
        v.fecha_venta
    FROM Ventas v, Clientes c, Productos p
    WHERE v.id_cliente = c.id_cliente
    AND v.id_producto = p.id_producto
    AND c.id_cliente = cliente_id
    ORDER BY v.fecha_venta DESC;
END //

DELIMITER ;

-- Ejemplo de uso del procedimiento almacenado
CALL consultar_ventas_cliente(1);

-- CONSULTAS ADICIONALES ÚTILES
-- ========================================

-- Productos nunca vendidos
SELECT p.nombre_producto, p.categoria, p.stock
FROM Productos p
WHERE p.id_producto NOT IN (SELECT DISTINCT id_producto FROM Ventas);

-- Total de ingresos por mes
SELECT 
    YEAR(fecha_venta) AS año,
    MONTH(fecha_venta) AS mes,
    COUNT(id_venta) AS total_ventas,
    SUM(valor_total) AS ingresos_mes
FROM Ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY año DESC, mes DESC;

-- Promedio de valor por venta
SELECT AVG(valor_total) AS promedio_venta FROM Ventas;

-- Ciudad con más clientes
SELECT ciudad, COUNT(*) AS total_clientes
FROM Clientes
GROUP BY ciudad
ORDER BY total_clientes DESC;

-- la trasnochada valio la pena jajajjsjjs 