use
VentasDB
go
--LAS CONSULTAS POR ESPECIFICACION DE CAMPOS PERMITEN ESCOGER CUALES COLUMNAS SERAN MOSTRADAS EN EL RESULTADO.
--FORMATO:

--SELECT <CAMPO1>,<CAMPO2>,<CAMPO3>,...,<CAMPO_N> FROM <NOMBRE_TABLA>
--GO

--EJEMPLOS UTILIZANDO LA TABLA: tblProducto

--1. Realizar una consulta que muestre el codigo, descripcion y stock actual de un producto.
select Cod_Pro,Des_Pro,StockActual_Pro from tblProducto
go

--2.Realizar una consulta que muestre la descripcion, precio y stock minimo de los productos registrados en la tabla
--utilize un alias para la tabla.

select p.Des_Pro,p.Pre_Pro,p.StockMinimo_Pro from tblProducto as p
go