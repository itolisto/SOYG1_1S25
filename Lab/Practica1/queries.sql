-- Productos Más Vendidos: los 5 productos que han generado más ventas en términos de cantidad.
-- Nota: Como segundo criterio de organización se escogen los productos que más ingresos han generado para construir el top 5 de más vendidos en términos de cantidad.
SELECT p.id AS id_producto, p.name AS producto, p.model AS modelo, SUM(o.quantity) AS total_vendidos
FROM Orden o
INNER JOIN Producto p ON p.id = o.producto_id
GROUP BY p.id, p.name, p.model
ORDER BY total_vendidos DESC, (ROUND(SUM(p.price * o.quantity), 2)) DESC
LIMIT 5;

-- Productos Menos Vendidos: los 3 productos que han generado menos ventas en términos de cantidad.
-- Nota: Como segundo criterio de organización se escogen los productos que menos ingresos han generado para construir el top 3 de menos vendidos en términos de cantidad.
SELECT p.id AS id_producto, p.name AS producto, p.model AS modelo, SUM(o.quantity) AS total_vendidos
FROM Orden o
INNER JOIN Producto p ON p.id = o.producto_id
GROUP BY p.id, p.name, p.model
ORDER BY total_vendidos ASC, (ROUND(SUM(p.price * o.quantity), 2)) ASC
LIMIT 3;

-- Vendedores con Más Ventas: los 5 vendedores que han generado más ventas en términos de ingresos.
SELECT v.id AS id_vendedor, v.name AS nombre_vendedor, ROUND(SUM(p.price * o.quantity), 2) AS total_vendido_dinero
FROM Orden o
INNER JOIN Producto p ON p.id = o.producto_id
INNER JOIN Vendedor v ON v.id = o.vendedor_id
GROUP BY id_vendedor, nombre_vendedor
ORDER BY total_vendido_dinero DESC
LIMIT 5;

-- Vendedores con Menos Ventas: los 3 vendedores que han generado menos ventas en términos de ingresos.
SELECT v.id AS id_vendedor, v.name AS nombre_vendedor, ROUND(SUM(p.price * o.quantity), 2) AS total_vendido_dinero
FROM Orden o
INNER JOIN Producto p ON p.id = o.producto_id
INNER JOIN Vendedor v ON v.id = o.vendedor_id
GROUP BY id_vendedor, nombre_vendedor
ORDER BY total_vendido_dinero ASC
LIMIT 3;

-- Ventas por Marca: Representar el porcentaje de ventas por marca en términos de cantidad.
SELECT
	m.name AS marca,
    ROUND(
        (SUM(o.quantity)/(SELECT SUM(quantity) FROM Orden)) * 100,
        2
    ) AS porcentaje_ventas,
    ROUND(
      SUM(SUM(o.quantity)/(SELECT SUM(quantity) FROM Orden) * 100) OVER (ORDER BY m.name),
      2
    ) AS porcentaje_ventas_cumulativo
FROM Orden o
INNER JOIN Producto p ON p.id = o.producto_id
INNER JOIN Marca m ON m.id = p.marca_id
GROUP BY m.name
ORDER BY m.name ASC;

-- Evolución de ventas en el tiempo: Mostrar la tendencia de las ventas a lo largo de los meses en términos de ingresos.
SELECT 
    DATE_FORMAT(o.created_at, '%Y-%m') AS fecha,
    ROUND(
      SUM(o.quantity * p.price),
      2
    ) AS total_vendido_dinero,
    ROUND(
      SUM(SUM(o.quantity * p.price)) OVER (ORDER BY DATE_FORMAT(o.created_at, '%Y-%m')),
      2
    ) AS total_vendido_dinero_cumulativo
FROM Orden o
JOIN Producto p ON o.producto_id = p.id
GROUP BY DATE_FORMAT(o.created_at, '%Y-%m')
ORDER BY fecha DESC;
