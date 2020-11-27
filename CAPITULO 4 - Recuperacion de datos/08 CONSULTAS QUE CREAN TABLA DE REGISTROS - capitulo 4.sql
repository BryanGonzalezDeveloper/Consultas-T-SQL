use 
VentasDB
go
--ES POSIBLE REALIZAR CONSULTA QUE GENERE UNA NUEVA TABLA A PARTIR DE UNA CONSULTA REALIZADA, ES DECIR QUE LOS RESULTADOS
--DE UNA CONSULTA SON ALMACENADOS EN UNA NUEVA TABLA.
--ESTE TIPO DE CONSULTAS POSEE EL SIGUIENTE FORMATO:

--SELECT < * |ALIAS.NOMBRE_CAMPO > INTO <NOMBRE_TABLA_DESTINO> FROM <NOMBRE_TABLA_ORIGEN> AS <ALIAS>
--GO

--EJEMPLOS:
--1. Realizar una copia completa de la tabla :tblProducto. En una nueva tabla llamada: tblProducto_Bak.
select * into tblProducto_Bak from tblProducto
go
select * from tblProducto_Bak
go

--2.Crear una tabla llamada: tblReporte_Producto a partir del codigo, descripcion, precio, tipo de unidad de los productos.
select p.Cod_Pro as CODIGO, p.Des_Pro as DESCRIPCION, p.Pre_Pro as PRECIO, p.Unidades_Pro as [TIPO DE UNIDAD]
into tblReporte_Producto from tblProducto as p
go
--Se listan los registros de la nueva tabla:
select * from tblReporte_Producto
go