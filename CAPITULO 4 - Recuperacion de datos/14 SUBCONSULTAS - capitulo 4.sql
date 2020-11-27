use
VentasDB
go
--Las subconsultas son consultas SELECT anidadas dentro de otras como pueden ser: SELECT, SELECT INTO, INSERT, UPDATE,DELETE o dentro
--de otra subconsulta.
--FORMATO:
--SELECT <ALL> <*> <SUBCONSULTA> FROM Nombre_Tabla
--WHERE < CONDICION - SUBCONSULTA>
--GO

--Ejemplos:
--1.Implementar una consulta que permita mostrar los datos del proveedor, adicionando el nombre del distrito.
select
P.Cod_Prv as CODIGO, P.Rso_Prv as [PROVEEDOR], P.Dir_Prv as DIRECCION, P.Tel_Prv as TELEFONO, P.Rep_Prv as REPRESENTANTE,
(
select D.Nom_Dis  from tblDistrito as D
where D.Cod_Dis=P.Cod_Dis
) as DISTRITO, P.Cod_Dis as [CODIGO DE DISTRITO]
from
tblProveedor as P
go
--2.Implementar una consulta que permita mostrar los provvedores de un determinado distrito.
select P.* from tblProveedor as P
where P.Cod_Dis=
(
select D.Cod_Dis from tblDistrito as D
where D.Nom_Dis='RIMAC'
)
go