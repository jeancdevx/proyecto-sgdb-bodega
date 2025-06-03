
-- Facturas para clientes empresariales (RUC)
-- Los números de factura se generan automáticamente con triggers
-- Formato: F001-000001, F001-000002, etc.

INSERT INTO FACTURA (ruc, idVenta) VALUES
-- Ventas con factura (clientes empresariales)
('20123456789', 2),   -- Carlos Rodriguez (empresa)
('20987654321', 4),   -- Pedro Mendoza (empresa)  
('20555666777', 6),   -- Mario Gutierrez (empresa)
('20888999000', 7),   -- Claudia Ríos (empresa)
('20111222333', 10),  -- Jorge Paredes (empresa)
('20444555666', 12),  -- Claudia Ríos (segunda compra)
('20777888999', 14),  -- Pedro Mendoza (segunda compra)
('20123456789', 16);  -- Carlos Rodriguez (segunda compra)

-- Notas:
-- Ventas 1,3,5,8,9,11,13,15,17 tienen BOLETA
-- Ventas 2,4,6,7,10,12,14,16 tienen FACTURA  
-- Los números se generan automáticamente: F001-000001, F001-000002, etc.