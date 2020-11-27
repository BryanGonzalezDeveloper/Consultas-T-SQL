/*
Una funcion en T-SQL nos permitira definir fragmentos de codigo(scripts) que realizaran una determinada tarea (funcion) y podran ser llamados tantas
veces se necesite, de manera similar a como ocurre con los procedimientos almacenados.
Las funciones del sistema se subdividen en 4 grupos:

*Funciones de conjunto de filas:
Se caracterizan por devolver un objeto que se puede utilizar, como las referencias de tabla en una instruccion
sql, como :
-OPENDATASOURCE.
-OPENROWSET.
-OPENQUERY.
-OPENXML.

*Funciones de agregado:
Se caracterizan por operar sobre una cierta cantidad de valores en alguna columna donde el tipo de dato sea numerico y devuelve un solo valor
resumen.
*/
use VentasDB
go
--EJEMPLOS DE FUNCIONES DE AGREGADO:
--1.Obtener el promedio del subtotal en la tabla: 'tblDetalle_Factura'
select AVG(F.Can_Ven*F.Pre_Ven) as [PROMEDIO DEL SUBTOTAL] from tblDetalle_Factura as F
go
--2.Implementar un script que obtenga el minimo valor del stock actual de un producto, luego mostrar que productos tienen el mismo Stock que el
--valor menor.
declare @stockMinimo int
select @stockMinimo=  min(p.StockActual_Pro) from tblProducto as p

select p.Cod_Pro as [CODIGO PRODUCTO], P.Des_Pro AS [DESCRIPCION], P.Pre_Pro AS PRECIO, P.StockActual_Pro AS [STOCK ACTUAL]
from tblProducto as p
where p.StockActual_Pro=@stockMinimo
order by p.Cod_Pro asc
go
--CHECKSUM_AGG: Devuelve la suma de comprobacion de los valores en un grupo, asimismo omite los valores null que se presenten.
--3.Implementar un script que permita mostrar la comprobacion de la suma del subtotal en la tabla: 'tblDetalle_Factura'
select CHECKSUM_AGG(cast(F.Can_Ven*F.Pre_Ven as int)) as [SUMA SUBTOTAL FACTURA] from tblDetalle_Factura F

--La funcion STDEV devuelve la desviacion estandar en un conjunto de valores.
--4.Script que muestre la desviacion estandar del campo: 'Can_Ven' en la tabla: 'tblDetalle_Factura'
select STDEV(F.Can_Ven) as [DESVIACION ESTANDAR] from tblDetalle_Factura F

--La funcion COUNT_BIG, tiene el mismo funcionamiento que COUNT, la diferencia es que COUNT_BIG siempre regresa un valor de tipo BIGINT 
--5.script que muestre el total de los productos registrados.
select COUNT_BIG(*) as [ PRODUCTOS REGISTRADOS] from tblProducto

--La funcion STDEVP, devuelve la desviacion estandar poblacional.
--6.Script que muestre la desviacion estandar poblacional del campo: 'Can_Ven' en la tabla: 'tblDetalle_Factura'
select stdevp(F.Can_Ven) as [DESVIACION ESTANDAR] from tblDetalle_Factura F
go
--La funcion GROUPING devuelve valores de cero y uno. Cero cuando el valor es no agregado y uno cuando si lo es, dentro de una consulta agrupada
--con rollup o cube.
--7.Implementar un script que permita visualizar el total de facturas realizadas agrupadas por anio y mes. Ademas agregar un campo indicando el 
--tipo de fila, la cual mostrara el tipo de fila en cada resultado.
select
YEAR(Fec_Fac) as AÑO, MONTH(Fec_Fac) as MES, COUNT(*) as TOTAL,case
when  GROUPING(year(Fec_Fac))=0 and  GROUPING(MONTH(Fec_Fac))=1 then 'TOTAL AÑO'
when  GROUPING(year(Fec_Fac))=1 and  GROUPING(MONTH(Fec_Fac))=0 then 'TOTAL MES'
when  GROUPING(year(Fec_Fac))=1 and  GROUPING(MONTH(Fec_Fac))=1 then 'TOTAL GENERAL'
else 'FILA NORMAL'
end as [TIPO DE FILA]
from tblFactura
group by rollup (YEAR(Fec_Fac),MONTH(Fec_Fac))
go

--La funcion VAR, devuelve la varianza estadistica.
--8. script que permita mostrar la varianza estadistica del campo: 'Can_Ven' de la tabla: 'tblDetalle_Factura'
select VAR(F.Can_Ven) as [VARIANZA ESTADISTICA] from tblDetalle_Factura F
go

--La funcion VARP, devuelve la varianza estadistica poblacional.
--9. script que permita mostrar la varianza estadistica poblacional del campo: 'Can_Ven' de la tabla: 'tblDetalle_Factura'
select VARP(F.Can_Ven) as [VARIANZA ESTADISTICA POBLACIONAL] from tblDetalle_Factura F
go

--10.Realizar un script que muestre los distritos con el mayor numero de proveedores registrados.
--Obtener el valor maximo:
declare @maximo int
select @maximo=MAX(X.[TOTAL PROVEEDORES])
FROM 
(
SELECT D.Nom_Dis as DISTRITO, COUNT(*) as [TOTAL PROVEEDORES] FROM tblDistrito D
inner join tblProveedor P on p.Cod_Dis=d.Cod_Dis
group by d.Nom_Dis
)as X
--Mostrar los distritos con el numero maximo de proveedores:
SELECT X.DISTRITO ,X.[TOTAL PROVEEDORES] 
FROM 
( 
SELECT D.Nom_Dis as DISTRITO, COUNT(*) as [TOTAL PROVEEDORES]
FROM tblDistrito D
inner join tblProveedor P on p.Cod_Dis=d.Cod_Dis
GROUP BY d.Nom_Dis
)AS X
WHERE X.[TOTAL PROVEEDORES]=@maximo
GO