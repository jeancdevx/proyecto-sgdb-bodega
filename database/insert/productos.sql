INSERT INTO PRODUCTO (nombre, precio, stock, idCategoria, idMarca) VALUES

-- ABARROTES (idCategoria = 1)
('Arroz Superior x 1kg', 4.50, 200, 1, 17), -- Costeño
('Fideos Espagueti x 500g', 2.80, 150, 1, 19), -- Nicolini  
('Aceite Vegetal x 1L', 8.90, 100, 1, 18), -- Primor
('Azúcar Rubia x 1kg', 3.20, 120, 1, 29), -- Genérico
('Sal de Mesa x 1kg', 1.50, 180, 1, 29), -- Genérico
('Lentejas x 500g', 4.80, 80, 1, 29), -- Genérico
('Frijoles Canarios x 500g', 5.20, 70, 1, 29), -- Genérico
('Quinua x 500g', 12.50, 60, 1, 29), -- Genérico
('Avena x 500g', 3.80, 90, 1, 15), -- Gloria

-- BEBIDAS (idCategoria = 2)  
('Coca Cola 500ml', 2.50, 300, 2, 1), -- Coca Cola
('Inca Kola 500ml', 2.50, 250, 2, 2), -- Inca Kola
('Pepsi 500ml', 2.30, 180, 2, 3), -- Pepsi
('Fanta 500ml', 2.40, 200, 2, 4), -- Fanta
('Sprite 500ml', 2.40, 150, 2, 5), -- Sprite
('Coca Cola 1.5L', 5.80, 120, 2, 1), -- Coca Cola
('Inca Kola 1.5L', 5.80, 100, 2, 2), -- Inca Kola
('Agua Cielo 625ml', 1.50, 400, 2, 6), -- Cielo
('Agua San Luis 625ml', 1.40, 350, 2, 7), -- San Luis
('Chicha Gloria 1L', 4.20, 80, 2, 15), -- Gloria

-- SNACKS (idCategoria = 3)
('Papas Lay\'s Clásicas 45g', 3.50, 200, 3, 8), -- Lay's
('Papas Lay\'s Limón 45g', 3.50, 150, 3, 8), -- Lay's
('Pringles Original 124g', 8.90, 100, 3, 9), -- Pringles
('Pringles Cebolla 124g', 8.90, 80, 3, 9), -- Pringles
('Chifles Sayon 45g', 2.80, 120, 3, 13), -- Sayon
('Maní Salado 100g', 4.50, 100, 3, 29), -- Genérico
('Canchita Serrana 100g', 3.20, 110, 3, 29), -- Genérico

-- LÁCTEOS (idCategoria = 4)
('Leche Gloria UHT 1L', 4.80, 150, 4, 15), -- Gloria
('Leche Laive UHT 1L', 4.90, 120, 4, 21), -- Laive
('Yogurt Gloria Fresa 1L', 7.50, 80, 4, 15), -- Gloria
('Yogurt Gloria Vainilla 1L', 7.50, 70, 4, 15), -- Gloria
('Queso Fresco Gloria 500g', 12.80, 60, 4, 15), -- Gloria
('Mantequilla Gloria 200g', 8.50, 70, 4, 15), -- Gloria
('Crema de Leche Gloria 200ml', 5.20, 80, 4, 15), -- Gloria

-- PANADERÍA (idCategoria = 5)
('Pan Francés (unidad)', 0.30, 1000, 5, 31), -- Bimbo
('Pan Integral (unidad)', 0.50, 500, 5, 31), -- Bimbo
('Pan de Molde Bimbo', 4.20, 80, 5, 31), -- Bimbo
('Tostadas Bimbo', 5.80, 60, 5, 31), -- Bimbo
('Queque Donuts x 6', 6.50, 50, 5, 31), -- Bimbo

-- LIMPIEZA (idCategoria = 6)
('Detergente Ariel 800g', 12.50, 100, 6, 22), -- Ariel
('Lejía Patito 1L', 3.80, 120, 6, 24), -- Patito
('Lavavajillas Sapolio 900ml', 4.50, 80, 6, 25), -- Sapolio
('Desinfectante Sapolio 1L', 6.80, 70, 6, 25), -- Sapolio
('Esponja Scotch Brite x 3', 5.20, 90, 6, 29), -- Genérico

-- HIGIENE PERSONAL (idCategoria = 7)
('Champú Sedal 340ml', 8.90, 80, 7, 26), -- Sedal
('Champú Pantene 400ml', 12.50, 60, 7, 27), -- Pantene
('Jabón Dove 90g', 3.80, 120, 7, 29), -- Genérico
('Pasta Dental Kolynos 75ml', 4.20, 100, 7, 28), -- Kolynos
('Desodorante Rexona 150ml', 8.50, 70, 7, 29), -- Genérico
('Papel Higiénico Suave x 4', 6.80, 150, 7, 29), -- Genérico

-- MEDICINA BÁSICA (idCategoria = 8)
('Paracetamol 500mg x 10', 3.50, 120, 8, 29), -- Genérico
('Ibuprofeno 400mg x 10', 5.20, 100, 8, 29), -- Genérico
('Alcohol 96° 250ml', 4.80, 80, 8, 29), -- Genérico
('Vendas Elásticas', 3.20, 60, 8, 29), -- Genérico
('Curitas x 10', 2.80, 90, 8, 29), -- Genérico

-- DULCES (idCategoria = 9)
('Chocolate Sublime Clásico', 2.80, 200, 9, 10), -- Sublime
('Chocolate Sublime Maní', 2.80, 150, 9, 10), -- Sublime
('Caramelos Ambrosoli x 10', 1.50, 180, 9, 33), -- Ambrosoli
('Chicles Trident x 10', 3.20, 200, 9, 12), -- Nestle
('Chupetín Lollipop', 0.50, 300, 9, 33), -- Ambrosoli
('Gomitas Haribo 100g', 4.50, 100, 9, 29), -- Genérico

-- ÚTILES ESCOLARES (idCategoria = 10)
('Cuaderno Justus 100 hojas', 8.50, 80, 10, 29), -- Genérico
('Lapiceros Pilot x 3', 4.20, 120, 10, 29), -- Genérico
('Lápices Faber x 5', 3.80, 100, 10, 29), -- Genérico
('Borrador Artesco', 1.20, 150, 10, 29), -- Genérico
('Regla 30cm', 2.50, 60, 10, 29), -- Genérico

-- CIGARRILLOS (idCategoria = 11)
('Cigarrillos Hamilton', 8.00, 120, 11, 29), -- Genérico
('Cigarrillos Marlboro', 10.50, 100, 11, 29), -- Genérico

-- HELADOS (idCategoria = 12)
('Helado Donofrio Princesa', 1.80, 120, 12, 11), -- Donofrio
('Helado Donofrio Sublime', 2.50, 100, 12, 11), -- Donofrio
('Helado D\'Onofrio Frugos', 3.20, 80, 12, 11), -- Donofrio

-- CONDIMENTOS (idCategoria = 13)
('Ají Amarillo Alicorp 85g', 2.80, 100, 13, 20), -- Alicorp
('Comino Molido 15g', 1.50, 120, 13, 29), -- Genérico
('Ajos Molidos 50g', 2.20, 80, 13, 29), -- Genérico
('Sillao Alicorp 200ml', 3.50, 70, 13, 20), -- Alicorp

-- ENLATADOS (idCategoria = 14)
('Atún Gloria 170g', 6.80, 100, 14, 15), -- Gloria
('Sardinas Costeño 425g', 5.20, 80, 14, 17), -- Costeño
('Duraznos Gloria 820g', 8.50, 60, 14, 15), -- Gloria
('Leche Condensada Nestle 393g', 7.20, 70, 14, 12), -- Nestle

-- FRUTAS Y VERDURAS (idCategoria = 15)
('Plátano de Seda (kg)', 2.80, 120, 15, 29), -- Genérico
('Manzana Delicia (kg)', 4.50, 100, 15, 29), -- Genérico
('Papa Blanca (kg)', 2.20, 150, 15, 29), -- Genérico
('Cebolla Roja (kg)', 3.50, 120, 15, 29), -- Genérico
('Tomate (kg)', 4.80, 100, 15, 29), -- Genérico
('Limón (kg)', 6.50, 80, 15, 29); -- Genérico
