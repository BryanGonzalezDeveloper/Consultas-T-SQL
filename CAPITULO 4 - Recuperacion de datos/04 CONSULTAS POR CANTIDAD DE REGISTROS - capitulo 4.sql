use
VentasDB
go
--Las consultas por cantidad de registros, permiten controlar la cantidad de filas mostradas en una consulta.
--FORMATO:

--SELECT <TOP VALOR [PERCENT]>
--FROM <NOMBRE_TABLA> AS <ALIAS>
--ORDER BY <NOMBRE_CAMPO> <ASC | DESC>
--GO

--EJEMPLOS:

--1. Listar los primeros 5 registros de la tabla : tblProducto

select  top 5 * from tblProducto
go
--2.Listar los 3 productos mas caros en la tabla.
select top 3 * from tblProducto as p
order by p.Pre_Pro desc
go

--3.Listar el 50% de los productos en la tabla.
select top 50 percent * from tblProducto
go

--4.Listar los 10 productos con la menor cantidad en stock actual.
select top 10 * from tblProducto
order by StockActual_Pro asc
go