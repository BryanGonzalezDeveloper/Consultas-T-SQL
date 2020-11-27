use
VentasDB
go
--LAS CONSULTAS CON CAMPOS CALCULADOS PERMITEN MOSTRAR COLUMNAS CON INFORMACION ADICIONAL, OBTENIDA POR MEDIO DE UNA
--EXPRESION REALIZADA EN UN CAMPO NUMERICO.
--FORMATO:

--SELECT <ALIAS.CAMPO>, <CAMPO CALCULADO> AS <NOMBRE_CABECERA> FROM <NOMBRE_TABLA> <ALIAS>
--GO


--EJEMPLOS:
--1.Realizar un listado que muestre los campos de la siguiente forma:

--		CODIGO		DESCRIPCION		PRECIO		PRECIO DE VENTA
--DONDE LA COLUMNA PRECIO DE VENTA ES IGUAL AL PRECIO ORIGINAL + EL 10%

select Cod_Pro as CODIGO, Des_Pro as DESCRIPCION, Pre_Pro as PRECIO, (Pre_Pro*1.1) as [PRECIO DE VENTA]
from tblProducto
go

--2.Realizar un listado que muestre los campos de la siguiente manera:

--	CODIGO	DESCRIPCION		STOCK ACTUAL	STOCK MINIMO	DIFERENCIA STOCK
--Donde el campo "DIFERENCIA STOCK" se calcula restando es STOCK MINIMO  a el STOCK ACTUAL.

select Cod_Pro as CODIGO, Des_Pro as DESCRIPCION,StockActual_pro as [STOCK ACTUAL],
StockMinimo_Pro as [STOCK MINIMO], (StockActual_Pro-StockMinimo_Pro) as [DIFERENCIA STOCK]
from tblProducto
go


--3.Realizar en la tabla: tblVendedor un listado que muestre los campos de la siguiente manera:

--	CODIGO	VENDEDOR	FECHA DE INCIO
--El campo vendedor, debe mostrar el nombre completo del vendedor. Es importante recordar que el operador + concatena
--cadenas de caracteres.

select Cod_ven as CODIGO, Nom_Ven+SPACE(1)+Ape_Ven as VENDEDOR,FecInicio_Ven as [FECHA DE INICO] from tblVendedor
go
--La funcion SPACE, permita asignar una cantidad especificada de espacios en blanco a traves de un parametro
--numerico.
--Si no se quisiera utilizar la funcion SPACE, el espacio se puede asignar usando comillas simple (' ') de la siguiente
--manera:
select Cod_ven as CODIGO, Nom_Ven+' '+Ape_Ven as VENDEDOR,FecInicio_Ven as [FECHA DE INICO] from tblVendedor
go