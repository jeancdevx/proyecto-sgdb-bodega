-- ====================================================================
-- 1. CONSULTAS DE VENTAS
-- ====================================================================

-- 1.1 Listar todas las ventas con información completa
SELECT 
    v.idVenta,
    v.createdAt AS fecha_venta,
    c.nombre AS cliente,
    e.nombre AS empleado,
    v.tipoPago,
    v.total,
    CASE 
        WHEN b.idBoleta IS NOT NULL THEN CONCAT('Boleta: ', b.numeroBoleta)
        WHEN f.idFactura IS NOT NULL THEN CONCAT('Factura: ', f.numeroFactura)
        ELSE 'Sin documento'
    END AS documento
FROM venta v
JOIN cliente c ON v.idCliente = c.idCliente
JOIN empleado e ON v.idEmpleado = e.idEmpleado
LEFT JOIN boleta b ON v.idVenta = b.idVenta
LEFT JOIN factura f ON v.idVenta = f.idVenta
ORDER BY v.createdAt DESC;

-- 1.2 Ventas por rango de fechas
SELECT 
    v.idVenta,
    v.createdAt AS fecha,
    c.nombre AS cliente,
    v.total,
    v.tipoPago
FROM venta v
JOIN cliente c ON v.idCliente = c.idCliente
WHERE DATE(v.createdAt) BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY v.createdAt DESC;

-- 1.3 Ventas por cliente específico
SELECT 
    v.idVenta,
    v.createdAt AS fecha,
    v.total,
    v.tipoPago,
    COUNT(dv.idDetalleVenta) AS cantidad_items
FROM venta v
JOIN cliente c ON v.idCliente = c.idCliente
JOIN detalle_venta dv ON v.idVenta = dv.idVenta
WHERE c.nombre LIKE '%María López%'
GROUP BY v.idVenta, v.createdAt, v.total, v.tipoPago
ORDER BY v.createdAt DESC;

-- ====================================================================
-- 2. CONSULTAS DE DETALLE DE VENTAS
-- ====================================================================

-- 2.1 Detalle completo de una venta específica
SELECT 
    v.idVenta,
    v.createdAt AS fecha_venta,
    c.nombre AS cliente,
    c.telefono,
    c.email,
    p.nombre AS producto,
    cat.nombre AS categoria,
    dv.cantidad,
    p.precio AS precio_unitario,
    (dv.cantidad * p.precio) AS subtotal,
    v.total AS total_venta,
    v.tipoPago
FROM venta v
JOIN cliente c ON v.idCliente = c.idCliente
JOIN detalle_venta dv ON v.idVenta = dv.idVenta
JOIN producto p ON dv.idProducto = p.idProducto
JOIN categoria cat ON p.idCategoria = cat.idCategoria
WHERE v.idVenta = 1
ORDER BY p.nombre;

-- 2.2 Productos más vendidos
SELECT 
    p.nombre AS producto,
    cat.nombre AS categoria,
    SUM(dv.cantidad) AS total_vendido,
    COUNT(DISTINCT dv.idVenta) AS numero_ventas,
    SUM(dv.cantidad * p.precio) AS ingresos_generados,
    p.precio AS precio_actual,
    p.stock AS stock_actual
FROM detalle_venta dv
JOIN producto p ON dv.idProducto = p.idProducto
JOIN categoria cat ON p.idCategoria = cat.idCategoria
GROUP BY p.idProducto, p.nombre, cat.nombre, p.precio, p.stock
ORDER BY total_vendido DESC
LIMIT 10;

-- ====================================================================
-- 3. CONSULTAS DE INVENTARIO
-- ====================================================================

-- 3.1 Estado actual del inventario
SELECT 
    p.idProducto,
    p.nombre AS producto,
    cat.nombre AS categoria,
    p.precio,
    p.stock AS stock_actual,
    CASE 
        WHEN p.stock < 10 THEN 'CRÍTICO'
        WHEN p.stock < 30 THEN 'BAJO'
        WHEN p.stock < 50 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS nivel_stock,
    p.updatedAt AS ultima_actualizacion
FROM producto p
JOIN categoria cat ON p.idCategoria = cat.idCategoria
ORDER BY p.stock ASC, cat.nombre, p.nombre;

-- 3.2 Productos con stock crítico (menos de 10 unidades)
SELECT 
    p.nombre AS producto,
    cat.nombre AS categoria,
    p.stock,
    p.precio,
    (p.stock * p.precio) AS valor_inventario
FROM producto p
JOIN categoria cat ON p.idCategoria = cat.idCategoria
WHERE p.stock < 10
ORDER BY p.stock ASC;

-- 3.3 Valor total del inventario por categoría
SELECT 
    cat.nombre AS categoria,
    COUNT(p.idProducto) AS total_productos,
    SUM(p.stock) AS total_unidades,
    SUM(p.stock * p.precio) AS valor_total,
    AVG(p.precio) AS precio_promedio
FROM categoria cat
JOIN producto p ON cat.idCategoria = p.idCategoria
GROUP BY cat.idCategoria, cat.nombre
ORDER BY valor_total DESC;

-- ====================================================================
-- 4. CONSULTAS DE CLIENTES
-- ====================================================================

-- 4.1 Clientes más frecuentes
SELECT 
    c.nombre AS cliente,
    c.telefono,
    c.email,
    COUNT(v.idVenta) AS total_compras,
    SUM(v.total) AS total_gastado,
    AVG(v.total) AS promedio_por_compra,
    MAX(v.createdAt) AS ultima_compra
FROM cliente c
JOIN venta v ON c.idCliente = v.idCliente
GROUP BY c.idCliente, c.nombre, c.telefono, c.email
ORDER BY total_compras DESC, total_gastado DESC;

-- 4.2 Clientes por tipo de pago preferido
SELECT 
    c.nombre AS cliente,
    v.tipoPago,
    COUNT(*) AS veces_usado,
    SUM(v.total) AS total_gastado_tipo_pago
FROM cliente c
JOIN venta v ON c.idCliente = v.idCliente
GROUP BY c.idCliente, c.nombre, v.tipoPago
ORDER BY c.nombre, veces_usado DESC;

-- ====================================================================
-- 5. CONSULTAS DE REPORTES FINANCIEROS
-- ====================================================================

-- 5.1 Reporte de ventas diarias
SELECT 
    DATE(v.createdAt) AS fecha,
    COUNT(v.idVenta) AS total_ventas,
    SUM(v.total) AS ingresos_dia,
    AVG(v.total) AS promedio_venta,
    MIN(v.total) AS venta_minima,
    MAX(v.total) AS venta_maxima
FROM venta v
GROUP BY DATE(v.createdAt)
ORDER BY fecha DESC;

-- 5.2 Ventas por método de pago
SELECT 
    v.tipoPago,
    COUNT(v.idVenta) AS numero_transacciones,
    SUM(v.total) AS total_ingresos,
    AVG(v.total) AS promedio_transaccion,
    ROUND((COUNT(v.idVenta) * 100.0 / (SELECT COUNT(*) FROM venta)), 2) AS porcentaje_uso
FROM venta v
GROUP BY v.tipoPago
ORDER BY total_ingresos DESC;

-- 5.3 Ingresos por categoría de productos
SELECT 
    cat.nombre AS categoria,
    COUNT(DISTINCT dv.idVenta) AS ventas_categoria,
    SUM(dv.cantidad) AS unidades_vendidas,
    SUM(dv.cantidad * p.precio) AS ingresos_categoria,
    AVG(p.precio) AS precio_promedio_categoria
FROM categoria cat
JOIN producto p ON cat.idCategoria = p.idCategoria
JOIN detalle_venta dv ON p.idProducto = dv.idProducto
GROUP BY cat.idCategoria, cat.nombre
ORDER BY ingresos_categoria DESC;

-- ====================================================================
-- 6. CONSULTAS DE DOCUMENTOS TRIBUTARIOS
-- ====================================================================

-- 6.1 Registro de boletas emitidas
SELECT 
    b.numeroBoleta,
    b.dni,
    b.createdAt AS fecha_emision,
    c.nombre AS cliente,
    v.total AS monto,
    v.tipoPago
FROM boleta b
JOIN venta v ON b.idVenta = v.idVenta
JOIN cliente c ON v.idCliente = c.idCliente
ORDER BY b.createdAt DESC;

-- 6.2 Registro de facturas emitidas
SELECT 
    f.numeroFactura,
    f.ruc,
    f.createdAt AS fecha_emision,
    c.nombre AS cliente,
    v.total AS monto,
    v.tipoPago
FROM factura f
JOIN venta v ON f.idVenta = v.idVenta
JOIN cliente c ON v.idCliente = c.idCliente
ORDER BY f.createdAt DESC;

-- 6.3 Resumen tributario mensual
SELECT 
    YEAR(v.createdAt) AS año,
    MONTH(v.createdAt) AS mes,
    COUNT(b.idBoleta) AS total_boletas,
    COUNT(f.idFactura) AS total_facturas,
    SUM(CASE WHEN b.idBoleta IS NOT NULL THEN v.total ELSE 0 END) AS ingresos_boletas,
    SUM(CASE WHEN f.idFactura IS NOT NULL THEN v.total ELSE 0 END) AS ingresos_facturas,
    SUM(v.total) AS total_ingresos
FROM venta v
LEFT JOIN boleta b ON v.idVenta = b.idVenta
LEFT JOIN factura f ON v.idVenta = f.idVenta
GROUP BY YEAR(v.createdAt), MONTH(v.createdAt)
ORDER BY año DESC, mes DESC;

-- ====================================================================
-- 7. CONSULTAS DE ANÁLISIS DE NEGOCIO
-- ====================================================================

-- 7.1 Análisis de productos por categoría
SELECT 
    cat.nombre AS categoria,
    COUNT(p.idProducto) AS productos_categoria,
    AVG(p.precio) AS precio_promedio,
    SUM(p.stock) AS stock_total,
    MAX(p.precio) AS precio_mas_alto,
    MIN(p.precio) AS precio_mas_bajo
FROM categoria cat
LEFT JOIN producto p ON cat.idCategoria = p.idCategoria
GROUP BY cat.idCategoria, cat.nombre
ORDER BY productos_categoria DESC;

-- 7.2 Rendimiento del empleado
SELECT 
    e.nombre AS empleado,
    e.email,
    COUNT(v.idVenta) AS ventas_realizadas,
    SUM(v.total) AS ingresos_generados,
    AVG(v.total) AS promedio_venta,
    MIN(v.createdAt) AS primera_venta,
    MAX(v.createdAt) AS ultima_venta
FROM empleado e
LEFT JOIN venta v ON e.idEmpleado = v.idEmpleado
GROUP BY e.idEmpleado, e.nombre, e.email
ORDER BY ingresos_generados DESC;

-- 7.3 Análisis de temporadas de venta
SELECT 
    HOUR(v.createdAt) AS hora_venta,
    COUNT(v.idVenta) AS numero_ventas,
    SUM(v.total) AS ingresos_hora,
    AVG(v.total) AS promedio_venta_hora
FROM venta v
GROUP BY HOUR(v.createdAt)
ORDER BY hora_venta;

-- ====================================================================
-- 8. CONSULTAS DE BÚSQUEDA Y FILTROS
-- ====================================================================

-- 8.1 Búsqueda de productos por nombre o categoría
SELECT 
    p.idProducto,
    p.nombre AS producto,
    cat.nombre AS categoria,
    p.precio,
    p.stock,
    CASE 
        WHEN p.stock > 0 THEN 'Disponible'
        ELSE 'Agotado'
    END AS disponibilidad
FROM producto p
JOIN categoria cat ON p.idCategoria = cat.idCategoria
WHERE p.nombre LIKE '%coca%' 
   OR cat.nombre LIKE '%bebida%'
ORDER BY p.nombre;

-- 8.2 Historial de cliente específico
SELECT 
    v.idVenta,
    v.createdAt AS fecha,
    p.nombre AS producto,
    dv.cantidad,
    p.precio,
    (dv.cantidad * p.precio) AS subtotal,
    v.total AS total_venta,
    CASE 
        WHEN b.numeroBoleta IS NOT NULL THEN b.numeroBoleta
        WHEN f.numeroFactura IS NOT NULL THEN f.numeroFactura
        ELSE 'Sin documento'
    END AS documento
FROM cliente c
JOIN venta v ON c.idCliente = v.idCliente
JOIN detalle_venta dv ON v.idVenta = dv.idVenta
JOIN producto p ON dv.idProducto = p.idProducto
LEFT JOIN boleta b ON v.idVenta = b.idVenta
LEFT JOIN factura f ON v.idVenta = f.idVenta
WHERE c.email = 'maria.lopez@gmail.com'
ORDER BY v.createdAt DESC, p.nombre;
