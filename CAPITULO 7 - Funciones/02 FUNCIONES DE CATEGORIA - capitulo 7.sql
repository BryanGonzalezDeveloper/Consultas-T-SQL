
--Las funciones por categoria devuelven un valor de categoria por cada fila de una particion.
use VentasDB
go
--La funcion RANK, clasifica a los elementos de un conjunto en posiciones tipo ranking: primero, segundo, tercero, etc.
--si hay datos con el mismo valor se colocan dentro de la misma posicion como si se tratase de un empate.

--1.Realizar un script que permita listar los productos mostrando la unidad, descripcion, precio del producto y la escala que ocupa que esta 
--ocupa en base al precio mas alto por producto
SELECT
p.Unidades_Pro AS UNIDAD,
p.Des_Pro AS DESCRIPCION,
p.Pre_Pro AS PRECIO,
RANK() OVER( PARTITION BY p.Unidades_Pro ORDER BY p.Pre_Pro DESC) AS ESCALA
FROM tblProducto P
GO

--La funcion NTILE, distribuye las filas en una particion ordenadas de un numero especificado de grupos. Los grupos se enumeran a partir de uno.
--Para cada fila, NTILE devuelve el numero del grupo al que pertenece la fila.

--2.Realizar un script que permita mostrar el grupo del nivel de la tabla: 'tblProducto' en base al orden descendente de los precios
-- y del tipo de unidad.
SELECT
p.Unidades_Pro AS UNIDAD,
p.Des_Pro AS DESCRIPCION,
p.Pre_Pro AS PRECIO,
NTILE(4) over(order by p.Unidades_Pro desc,p.Pre_Pro desc) as GRUPO
FROM tblProducto P
GO
--La funcion DENSES_RANK, posee la misma funcionalidad que RANK. 
--3.Realizar un script que permita listar los productos mostrando la unidad, descripcion, precio del producto y la escala que ocupa que esta 
--ocupa en base al precio mas alto por producto utilizando dense_rank(devuelve un bigint).
SELECT
p.Unidades_Pro AS UNIDAD,
p.Des_Pro AS DESCRIPCION,
p.Pre_Pro AS PRECIO,
DENSE_RANK() OVER( PARTITION BY p.Unidades_Pro ORDER BY p.Pre_Pro DESC) AS ESCALA
FROM tblProducto P
GO
--4.Realizar un script que permita visualizar el numerocorrelativo correspondiente a los productos.
select ROW_NUMBER()over(order by Cod_Pro asc) as NUMERO,Cod_Pro as CODIGO, Des_Pro as DESCRIPCION, Pre_Pro as PRECIO from tblProducto
go
