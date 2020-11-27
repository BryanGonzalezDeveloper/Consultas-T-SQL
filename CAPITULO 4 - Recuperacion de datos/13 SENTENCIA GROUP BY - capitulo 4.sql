use VentasDB
go
--La sentencia GROUP BY. Para recuperar informacion agrupada por algun criterio, dentro de la consulta SELECT se debe utilizar
--GROUP BY. Para mejorar este tipo de consultas se puede hacer uso de las funciones: SUM, MAX, MIN, COUNT, AVG.
--FORMATO:
--SELECT <ALL> <*> FROM Nombre_Tabla
--GROUP BY <Nombre_Campo>
--HAVING <Condicion>
--GO
--Ejemplos:
--1.Mostrar el total de cliente registrados por distritos.
select  D.Nom_Dis as [NOMBRE DISTRITO],COUNT(*) as TOTAL from tblCliente as C
inner join tblDistrito as D on C.Cod_Dis=D.Cod_Dis
group by D.Nom_Dis
go
--2.Mostrar el total de facturas registradas por mes.
select MONTH(Fec_Fac) as MES, COUNT(*) as [TOTAL DE FACTURAS] from tblFactura
group by MONTH(Fec_Fac)
go

--3.Mostrar el monto acumulado (Precio * cantidad) de las facturas. UTILIZAR LA TABLA: "tblDetalle_Factura"
select Num_Fac as [NUMERO DE FACTURA],SUM(Can_Ven*Pre_Ven) as TOTAL from tblDetalle_Factura
group by Num_Fac
go

--4.Mostrar el total de facturas registradas por cada vendedor.
select (V.Nom_Ven + SPACE(1) + V.Ape_Ven) as [NOMBRE DE VENDEDOR],COUNT(F.Num_Fac) as [TOTAL DE FACTURAS] from tblFactura as F
inner join tblVendedor as V on V.Cod_Ven=F.Cod_Ven
group by (V.Nom_Ven+SPACE(1)+ V.Ape_Ven)
go
--5.Utilizando las tablas: "tblProveedor" y "tblDistrito". Se necesita mostrar el total de proveedores por distrito solo en aquellos
--distritos donde el numero de provvedores sea mayor a 1.
select D.Nom_Dis as [NOMBRE DE DISTRITO],COUNT(*) as [TOTAL DE PROVEEDORES] from tblProveedor as P
inner join tblDistrito as D on D.Cod_Dis=P.Cod_Dis
group by D.Nom_Dis
having COUNT(*)>1
go

--6.Haciendo uso de la tabla: "tblFactura" se necesita mostrar informacion agrupada sobre los años y meses del registro de las
--facturas. condicionadas a que solo sean del primer semestre.
select YEAR(Fec_Fac) as AÑO, MONTH(Fec_Fac) as MES, COUNT(*) as TOTAL from tblFactura
group by YEAR(Fec_Fac),MONTH(Fec_Fac)
having MONTH(Fec_Fac) between 1 and 6
go


--SENTENCIA GROUP BY CON RESUMENES.
--Los resumenes se aplian a un grupo de informacion, permitiendo visualizar montos o conteos realizados en un conjunto de informacion.
--FORMATO:
--SELECT <ALL> <*> FROM Nombre_Tabla
--GROUP BY Nombre_Campo WITH
--[ROLLUP] [CUBE] <Campos>
--<HAVING Condicion>
--GO

--Ejemplos:
--1.Utilizando la tabla: "tblProducto" se necesita mostrar el total de productos registrados por tipo de unidad, ademas el total de
--productos registrados.
--Con ROLLUP:
select Unidades_Pro as UNIDADES, COUNT(*) as TOTAL from tblProducto
group by Unidades_Pro  with rollup
go

--Con cube:
select Unidades_Pro as UNIDADES, COUNT(*) as TOTAL from tblProducto
group by cube( Unidades_Pro ) 
go

--Para cambiar el valor de null, cuando se realiza la suma de las unidades:
--CUBE:
select case when Unidades_Pro is null
then 'TOTAL DE PRODUCTOS:' 
else
Unidades_Pro 
end as [UNIDAD DE PRODUCTO],
COUNT(*) as TOTAL
from tblProducto
group by CUBE( Unidades_Pro ) 
go

--ROLLUP
select case when Unidades_Pro is null
then 'TOTAL DE PRODUCTOS:' 
else
Unidades_Pro 
end as [UNIDAD DE PRODUCTO],
COUNT(*) as TOTAL
from tblProducto
group by ROLLUP( Unidades_Pro ) 
go

--2.Utilizando la tabla: "tblFactura". Se necesita mostrar el total de facturas por cada año en un determinado mes, ademas el total de
--facturas registradas.

select 
YEAR(Fec_Fac) as AÑO,
 MONTH(Fec_Fac) as MES,
COUNT(*) as TOTAL
from tblFactura
group by YEAR(Fec_Fac),MONTH(Fec_Fac) with rollup
go