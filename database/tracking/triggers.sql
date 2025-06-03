-- actualizar stock de producto al insertar en detalle_venta
CREATE TRIGGER trg_update_stock_producto
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
  UPDATE producto
  SET stock = stock - NEW.cantidad
  WHERE idProducto = NEW.idProducto;
END;

-- calcular total de venta
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
END;

-- Trigger for DELETE
CREATE TRIGGER trg_calcular_total_venta_delete
AFTER DELETE ON detalle_venta
FOR EACH ROW
BEGIN
  DECLARE total_calculado DECIMAL(10,2);
  SELECT COALESCE(SUM(dv.cantidad * p.precio), 0) INTO total_calculado
  FROM detalle_venta dv
  JOIN producto p ON dv.idProducto = p.idProducto
  WHERE dv.idVenta = OLD.idVenta;
  UPDATE venta
  SET total = total_calculado
  WHERE idVenta = OLD.idVenta;
END;