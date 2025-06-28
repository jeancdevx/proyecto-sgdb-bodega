# 🏪 Sistema de Gestión de Base de Datos - Tiendita Trujillo

## 📋 Descripción del Proyecto

Este proyecto implementa un sistema completo de gestión de base de datos para una pequeña tienda ("tiendita") ubicada en Trujillo, La Libertad, Perú. El sistema incluye gestión de productos, ventas, clientes, empleados, con automatización completa mediante triggers y optimización de consultas.

## 🗂️ Estructura del Proyecto

```
database/
├── create/                    # Scripts de creación
│   └── schema.sql            # Esquema completo de la base de datos
├── insert/                   # Scripts de inserción de datos
│   ├── tipo_cliente.sql     # Tipos de cliente (Natural/Jurídico)
│   ├── tipo_pago.sql        # Tipos de pago (Efectivo/Yape/Plin)
│   ├── cargos.sql           # Cargos (Administrador/Vendedor)
│   ├── empleados.sql        # 3 empleados (1 admin, 2 vendedores)
│   ├── categorias.sql       # 15 categorías de productos
│   ├── marcas.sql           # 35+ marcas peruanas populares
│   ├── productos_new.sql    # 80+ productos realistas
│   ├── clientes.sql         # 55 clientes (40 naturales, 15 jurídicos)
│   ├── ventas.sql           # 200 ventas distribuidas en 2024
│   ├── detalle_venta.sql    # 800+ líneas de detalle de venta
│   ├── boletas.sql          # Boletas para personas naturales
│   └── facturas.sql         # Facturas para personas jurídicas
├── tracking/                 # Scripts de automatización
│   └── triggers.sql         # Triggers para stock, totales y auditoría
├── security/                 # Scripts de seguridad
│   ├── users.sql            # Usuarios y roles de seguridad
│   └── roles.sql            # Definición de roles y permisos
├── read/                     # Scripts de consultas y optimización
│   └── indices_optimizacion.sql  # Índices para mejorar rendimiento
├── backup/                   # Scripts de respaldo
├── delete/                   # Scripts de eliminación
│   └── tablas.sql
├── setup_complete_database.sql   # Script maestro de configuración
├── ejecutar_configuracion.bat    # Script de ejecución Windows (batch)
└── ejecutar_configuracion.ps1    # Script de ejecución Windows (PowerShell)
```

## 📊 Datos Incluidos

### 👥 Empleados (3 personas)
- **Carlos Mendoza** - Administrador
- **María García** - Vendedora
- **Juan Rodríguez** - Vendedor

### 🏢 Clientes (55 total)
- **40 Personas Naturales** - Con DNI y direcciones de Trujillo
- **15 Personas Jurídicas** - Con RUC y razones sociales

### 📦 Productos (80+ items)
- **15 Categorías** - Bebidas, snacks, abarrotes, limpieza, etc.
- **35+ Marcas** - Marcas populares en Perú (Gloria, Inca Kola, etc.)
- **Productos realistas** - Con precios y stock apropiados

### 💰 Ventas (200 transacciones)
- **Distribuidas en 2024** - De enero a agosto
- **3 Métodos de pago** - Efectivo, Yape, Plin
- **800+ Detalles** - Cada venta tiene 2-4 productos

## 🚀 Instalación y Configuración

### Método 1: Ejecución Automática (Recomendado)

1. **Windows Batch** (Más simple):
   ```cmd
   cd database
   ejecutar_configuracion.bat
   ```

2. **Windows PowerShell** (Más robusto):
   ```powershell
   cd database
   .\ejecutar_configuracion.ps1
   ```

### Método 2: Ejecución Manual

1. **Abrir MySQL Command Line**:
   ```sql
   mysql -u root -p
   ```

2. **Ejecutar script principal**:
   ```sql
   source setup_complete_database.sql;
   ```

### Requisitos Previos

- ✅ MySQL Server 8.0+ instalado y ejecutándose
- ✅ Usuario root con permisos completos
- ✅ Puerto 3306 disponible

## 🔧 Funcionalidades Implementadas

### 🤖 Automatización con Triggers

1. **Control de Stock**:
   - Reducción automática al vender productos
   - Restauración automática al cancelar ventas
   - Validación de stock antes de venta

2. **Cálculo de Totales**:
   - Actualización automática del total de venta
   - Recálculo al modificar detalles

3. **Auditoría**:
   - Registro de cambios en productos críticos
   - Timestamps automáticos

4. **Protección de Datos**:
   - Previene eliminación de productos con ventas
   - Validaciones de integridad

### 🔐 Seguridad

- **Roles definidos**: Administrador y Vendedor
- **Permisos específicos** por tipo de usuario
- **Usuarios nominales** para cada empleado
- **Acceso desde red local** configurado

### ⚡ Optimización

- **Índices estratégicos** en columnas frecuentemente consultadas
- **Consultas optimizadas** para reportes comunes
- **Estructura normalizada** para eficiencia

## 📈 Consultas de Ejemplo

### Productos más vendidos
```sql
SELECT p.nombre, SUM(dv.cantidad) as total_vendido
FROM PRODUCTO p
JOIN DETALLE_VENTA dv ON p.idProducto = dv.idProducto
GROUP BY p.idProducto
ORDER BY total_vendido DESC
LIMIT 10;
```

### Ventas por empleado
```sql
SELECT e.nombres, COUNT(v.idVenta) as ventas, SUM(v.total) as total
FROM EMPLEADO e
LEFT JOIN VENTA v ON e.idEmpleado = v.idEmpleado
GROUP BY e.idEmpleado;
```

### Productos con stock bajo
```sql
SELECT nombre, stock FROM PRODUCTO 
WHERE stock <= 10 
ORDER BY stock ASC;
```

## 👤 Usuarios Creados

| Usuario | Contraseña | Rol | Descripción |
|---------|------------|-----|-------------|
| `carlos_admin` | `admin_2024_seguro` | Administrador | Acceso completo |
| `maria_vendedor` | `vendedor_2024_maria` | Vendedor | Operaciones de venta |
| `juan_vendedor` | `vendedor_2024_juan` | Vendedor | Operaciones de venta |

## 🔍 Verificación Post-Instalación

Después de la instalación, verificar que todo esté correcto:

```sql
-- Conectar como administrador
mysql -u carlos_admin -p db_ventas

-- Verificar datos
SELECT 'Productos' as Tabla, COUNT(*) as Total FROM PRODUCTO
UNION ALL
SELECT 'Ventas' as Tabla, COUNT(*) as Total FROM VENTA
UNION ALL
SELECT 'Clientes' as Tabla, COUNT(*) as Total FROM CLIENTE;
```

## 📝 Contexto Peruano

Los datos están completamente adaptados al contexto peruano:

- **🏠 Direcciones**: Distritos reales de Trujillo
- **🏪 Productos**: Marcas y productos populares en Perú
- **💳 Pagos**: Métodos de pago comunes (Efectivo, Yape, Plin)
- **📄 Documentos**: DNI y RUC con formato peruano
- **🏢 Empresas**: Razones sociales típicas peruanas

## 🆘 Solución de Problemas

### Error de conexión
- Verificar que MySQL esté ejecutándose
- Comprobar que el puerto 3306 esté disponible
- Verificar credenciales de root

### Error de permisos
- Ejecutar como administrador
- Verificar permisos del usuario root
- Comprobar configuración de firewall

### Error de ruta
- Ajustar ruta de MySQL en scripts de ejecución
- Verificar estructura de carpetas del proyecto

## 📞 Soporte

Para problemas o consultas sobre la implementación:

1. Verificar logs de error de MySQL
2. Revisar la documentación de triggers
3. Comprobar integridad referencial
4. Validar permisos de usuarios

---

**Desarrollado para:** Sistema de Gestión de Base de Datos - Ciclo V  
**Contexto:** Tiendita en Trujillo, La Libertad, Perú  
**Fecha:** 2024
