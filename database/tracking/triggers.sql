-- Drop existing triggers first (if they exist)
DROP TRIGGER IF EXISTS trg_update_stock_producto;
DROP TRIGGER IF EXISTS trg_calcular_total_venta;

DELIMITER $$

-- actualizar stock de producto al insertar en detalle_venta
CREATE TRIGGER trg_update_stock_producto
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
  UPDATE producto
  SET stock = stock - NEW.cantidad
  WHERE idProducto = NEW.idProducto;
END$$

-- calcular total de venta al insertar
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

DELIMITER ;