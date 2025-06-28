DROP TRIGGER IF EXISTS trg_reducir_stock_producto;
DROP TRIGGER IF EXISTS trg_restaurar_stock_producto;

DELIMITER $$

CREATE TRIGGER trg_reducir_stock_producto
AFTER INSERT ON DETALLE_VENTA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTO
    SET stock = stock - NEW.cantidad,
        updatedAt = CURRENT_TIMESTAMP
    WHERE idProducto = NEW.idProducto;
END$$

CREATE TRIGGER trg_restaurar_stock_producto
AFTER DELETE ON DETALLE_VENTA
FOR EACH ROW
BEGIN
    UPDATE PRODUCTO
    SET stock = stock + OLD.cantidad,
        updatedAt = CURRENT_TIMESTAMP
    WHERE idProducto = OLD.idProducto;
END$$

DELIMITER ;

-- show triggers
SHOW TRIGGERS;