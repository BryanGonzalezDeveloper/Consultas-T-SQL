--Consultas agrupadas. Este tipo de consultas permite mostrar la informacion agrupada para multiples propositos, estas consultas
--son mas eficientes cunado se utilizan con funciones agregadas.

--Formato:
--Select <all> <*> From <NombreTabla>
--inner <cross join | left | right>
--where <Condicion> group by <NombreCampo>
--having <Condicion> 
--order by <NombreCampo> <asc | desc>
--GO

--Las funciones agregadas son aquellas que especifican un determinado valor en las columnas de una tabla. SQL SERVER cuenta con las funciones:
-- SUM, MAX, MIN, AVG, COUNT.

--La funcion COUNT permite devolver la cantidad de registros encontrados en una tabla segun la condicion especificada.
--FORMATO:
--SELECT COUNT(NOMBRE_CAMPO) FROM NOMBRE_TABLA
--WHERE <CONDICION>
--GO
use VentasDB
go

--Ejemplos:
--1.Contar el total de registros en la tabla: "tblProducto".
--Primera forma:
select COUNT(Cod_Pro) as [TOTAL DE PRODUCTOS REGISTRADOS] from tblProducto
go
--Segunda forma:
select COUNT(*) as [TOTAL DE PRODUCTOS REGISTRADOS] from tblProducto
go

--2.Contar la cantidad de registros en la tabla: "tblCliente" que se hayan realizado en 2012.

select count(*) as [CLIENTES REGISTRADO EN EL AÑO 2012] from tblCliente
where YEAR(Fec_Reg)= 2012
go

--La funcion SUM, permite devolver la suma de una columna de tipo numerico segun un criterio especificado.
--Formato:
--SELECT SUM(Nombre_Campo) from Nombre_Tabla
--WHERE <Condicion>
--go
--Ejemplos:

--1.MOSTRAR LA SUMA ACUMULADA DEL PRECIO DE LOS PRODUCTOS REGISTRADOS EN LA TABLA: "tblProducto".
select SUM(Pre_Pro) as [SUMA DEL PRECIO DE LOS PRODUCTOS] from tblProducto
go

--2.Mostrar la suma del stock actual solo en los productos importados:
select SUM(StockActual_Pro) from tblProducto
where Importacion_Pro='V'
go
--Mostrar el monto del producto entre el precio y la cantidad registrada en el detalle de la factura.
select SUM(Can_Ven*Pre_Ven) as [SUBTOTAL ACUMULADO]
from tblDetalle_Factura
go

--La funcion MAX devuvelve el valor mas alto, de una columna numerica. Segun la condicion Especificada.
--Formato:
--SELECT MAX(Nombre_Campo) from <Nombre_Tabla>
--WHERE <Condicion>
--GO

--EJEMPLOS:
--1.MOSTRAR EL PRECIO DEL PRODUCTO MAS CARO REGISTRADO EN LA TABLA: "tblProducto"
select MAX(Pre_Pro) as [PRECIO DEL PRODUCTO MAS CARO] from tblProducto
go
--2.MOSTRAR EL PRECIO DEL PRODUCTO MAS CARO REGISTRADO EN LA TABLA: "tblProducto" CON RESPECTO A LOS PRODUCTOS IMPORTADOS.
select MAX(Pre_Pro) as [PRODUCTO IMPORTADO MAS COSTOSO] from tblProducto
where Importacion_Pro='V'
go

--La funcion MIN, devuelve el valor mas pequeño encontrado en la columna seleccionada dentro de una tabla, segun la condicion
--especificada.
--FORMATO:
--SELECT MIN(Nombre_Campo) from <Nombre_Tabla>
--WHERE <Condicion>
--GO
--Ejemplos:
--1.Mostrar el producto con el precio mas bajo registrado en la tabla: "tblProducto"
select MIN(Pre_Pro) as [PRODUCTO MAS BARATO] from tblProducto
go
--2.Mostrar el producto mas barato, respecto a los productos no importados.
select MIN(Pre_Pro) as [PRODUCTO MAS BARATO] from tblProducto
where Importacion_Pro='F'
go
--La funcion AVG, devuelve el promedio de una columna de tipo numerica, bajo una condicion determinada.
--FORMATO:
--SELECT AVG(Nombre_Campo) from Nombre_Tabla
--WHERE <Condicion>
--GO

--Ejemplos:
--1.Mostrar el promedio del precio de los productos en la tabla: "tblProducto"
select AVG(Pre_Pro) as [PRECIO PROMEDIO] from tblProducto
go
--2.Mostrar el promedio del stock actual, correspondiente a los productos importados.
select AVG(StockActual_Pro) as [STOCK ACTUAL PROMEDIO] from tblProducto
where Importacion_Pro='V'
go