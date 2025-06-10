DROP TRIGGER IF EXISTS trg_update_stock_producto;
DROP TRIGGER IF EXISTS trg_calcular_total_venta;
DROP TRIGGER IF EXISTS trg_generar_numero_boleta;
DROP TRIGGER IF EXISTS trg_generar_numero_factura;

DELIMITER $$

CREATE TRIGGER trg_update_stock_producto
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
  UPDATE producto
  SET stock = stock - NEW.cantidad
  WHERE idProducto = NEW.idProducto;
END$$

CREATE TRIGGER trg_calcular_total_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
  DECLARE total_calculado DECIMAL(10,2);
  SELECT SUM(dv.cantidad * p.precio) INTO total_calculado
  FROM detalle_venta dv
  JOIN producto p ON dv.idProducto = p.idProducto
  WHERE dv.idVenta = NEW.idVenta;
  UPDATE venta
  SET total = total_calculado
  WHERE idVenta = NEW.idVenta;
END$$

CREATE TRIGGER trg_generar_numero_boleta
BEFORE INSERT ON boleta
FOR EACH ROW
BEGIN
  DECLARE siguiente_numero INT DEFAULT 1;
  DECLARE numero_formateado VARCHAR(20);
  
  SELECT COALESCE(MAX(CAST(SUBSTRING(numeroBoleta, 10) AS UNSIGNED)), 0) + 1 
  INTO siguiente_numero
  FROM boleta 
  WHERE numeroBoleta LIKE 'B001-%';
  
  SET numero_formateado = CONCAT('B001-', LPAD(siguiente_numero, 6, '0'));
  
  SET NEW.numeroBoleta = numero_formateado;
END$$

CREATE TRIGGER trg_generar_numero_factura
BEFORE INSERT ON factura
FOR EACH ROW
BEGIN
  DECLARE siguiente_numero INT DEFAULT 1;
  DECLARE numero_formateado VARCHAR(20);
  
  SELECT COALESCE(MAX(CAST(SUBSTRING(numeroFactura, 10) AS UNSIGNED)), 0) + 1 
  INTO siguiente_numero
  FROM factura 
  WHERE numeroFactura LIKE 'F001-%';
  
  SET numero_formateado = CONCAT('F001-', LPAD(siguiente_numero, 6, '0'));
  
  SET NEW.numeroFactura = numero_formateado;
END$$

DELIMITER ;