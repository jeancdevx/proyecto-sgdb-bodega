-- Índices para tabla VENTA
CREATE INDEX idx_venta_fecha ON venta(createdAt);
CREATE INDEX idx_venta_cliente ON venta(idCliente);
CREATE INDEX idx_venta_empleado ON venta(idEmpleado);
CREATE INDEX idx_venta_tipo_pago ON venta(tipoPago);
CREATE INDEX idx_venta_total ON venta(total);

-- Índices para tabla DETALLE_VENTA
CREATE INDEX idx_detalle_venta_producto ON detalle_venta(idProducto);
CREATE INDEX idx_detalle_cantidad ON detalle_venta(cantidad);

-- Índices para tabla PRODUCTO
CREATE INDEX idx_producto_categoria ON producto(idCategoria);
CREATE INDEX idx_producto_precio ON producto(precio);
CREATE INDEX idx_producto_stock ON producto(stock);
CREATE INDEX idx_producto_nombre ON producto(nombre);

-- Índices para tabla CLIENTE
CREATE INDEX idx_cliente_nombre ON cliente(nombre);
CREATE INDEX idx_cliente_telefono ON cliente(telefono);

-- Índices para tabla BOLETA y FACTURA
CREATE INDEX idx_boleta_fecha ON boleta(createdAt);
CREATE INDEX idx_factura_fecha ON factura(createdAt);
CREATE INDEX idx_boleta_numero ON boleta(numeroBoleta);
CREATE INDEX idx_factura_numero ON factura(numeroFactura);

-- Índices compuestos para consultas frecuentes
CREATE INDEX idx_venta_fecha_cliente ON venta(createdAt, idCliente);
CREATE INDEX idx_detalle_venta_producto_cantidad ON detalle_venta(idVenta, idProducto, cantidad);
CREATE INDEX idx_producto_categoria_stock ON producto(idCategoria, stock);