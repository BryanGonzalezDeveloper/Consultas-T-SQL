use
VentasDB
go
--LAS CONSULTAS CON CABECERAS PERMITEN AGREGAR CABECERAS A LAS COLUMNAS DE UN RESULTADO.
--FORMATO:

--SELECT <ALIAS.NOMBRE_CAMPO> AS <NOMBRE_CABECERA> FROM <NOMBRE_TABLA> AS <ALIAS>
--GO

--EJEMPLOS APLICADOS EN LA TABLA: tblProducto

--1.Realizar un listado donde en la cabecera aparezcan los nombres:

--		CODIGO		DESCRIPCION			PRECIO		STOCK ACTUAL

--Primera forma:
select p.Cod_Pro as CODIGO, p.Des_Pro as DESCRIPCION, p.Pre_Pro as PRECIO, p.StockActual_Pro as [STOCK ACTUAL]
from tblProducto as p
go

--Segunda forma:
select CODIGO = Cod_Pro, DESCRIPCION = Des_Pro, [STOCK ACTUAL] = StockActual_Pro
	from tblProducto
go


--Tercera forma:
select Cod_Pro CODIGO, Des_Pro DESCRIPCION, StockActual_Pro [STOCK ACTUAL] from tblProducto
go

--Cuando el nombre que se le quiere asignar a la cabecera tiene 2 palabras o mas , se debe especificar utilizando
--los operadores corchetes ([]) o comillas simples ('')