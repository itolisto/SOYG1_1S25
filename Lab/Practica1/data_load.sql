LOAD DATA INFILE '/var/lib/mysql-files/Marcas.csv'
INTO TABLE Marca
CHARACTER SET utf8
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id_marca, @nombre)
SET 
  id     = @id_marca,
  name   = TRIM(@nombre);

LOAD DATA INFILE '/var/lib/mysql-files/Vendedores.csv'
INTO TABLE Vendedor
CHARACTER SET utf8
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id_vendedor, @nombre)
SET 
  id     = @id_vendedor,
  name   = TRIM(@nombre);

LOAD DATA INFILE '/var/lib/mysql-files/Productos.csv'
INTO TABLE Producto
CHARACTER SET utf8
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id_producto, @Nombre, @Precio, @id_marca)
SET 
  id       = @id_producto,
  price    = @Precio,
  marca_id = @id_marca,
  -- Stock es constante para todos
  stock    = 100,
  -- Separar "Nombre" por " Modelo ":
  --   - name = todo antes de " Modelo "
  --   - model = todo después de " Modelo "
  name   = TRIM(SUBSTRING_INDEX(@Nombre, ' Modelo ', 1)),
  model  = TRIM(SUBSTRING_INDEX(@Nombre, ' Modelo ', -1));

LOAD DATA INFILE '/var/lib/mysql-files/Ordenes.csv'
INTO TABLE Orden
CHARACTER SET utf8
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id_orden, @fecha_orden, @id_vendedor, @id_producto, @cantidad)
SET 
  id            = @id_orden,
  quantity      = @cantidad,
  created_at    = STR_TO_DATE(@fecha_orden, '%d/%m/%Y'),
  producto_id   = @id_producto,
  vendedor_id   = @id_vendedor;