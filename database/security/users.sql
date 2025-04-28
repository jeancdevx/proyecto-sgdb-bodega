CREATE ROLE 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin';

CREATE ROLE 'vendedor';
GRANT SELECT ON db_ventas.PRODUCTO TO 'vendedor';
GRANT INSERT ON db_ventas.VENTA TO 'vendedor';
GRANT INSERT ON db_ventas.DETALLE_VENTA TO 'vendedor';
GRANT SELECT ON db_ventas.CLIENTE TO 'vendedor';
GRANT INSERT ON db_ventas.BOLETA TO 'vendedor';
GRANT INSERT ON db_ventas.FACTURA TO 'vendedor';

CREATE USER 'admin'@'192.168.0.7' IDENTIFIED BY 'sPoqIwa0ru';
GRANT 'admin' TO 'admin'@'192.168.0.7';
SET DEFAULT ROLE 'admin' TO 'admin'@'192.168.0.7';

CREATE USER 'vendedor'@'192.168.0.7' IDENTIFIED BY '4pabuthuPH';
GRANT 'vendedor' TO 'vendedor'@'192.168.0.7';
SET DEFAULT ROLE 'vendedor' TO 'vendedor'@'192.168.0.7';

DROP USER 'admin'@'192.168.0.7';
DROP USER 'vendedor'@'192.168.0.7';

SELECT USER, HOST FROM mysql.user;