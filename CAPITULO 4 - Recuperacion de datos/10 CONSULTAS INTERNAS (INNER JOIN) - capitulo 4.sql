use 
VentasDB
go
--Las consultas internas, funcionan para comparar 2 valores en 2 tablas diferentes y en caso de encontrar registros que
--coincidan en ambas , entonces se mostraran los resultados. Es de gran importancia en este tipo de consulta saber 
--la relacion entre las tablas porque una sera una llave primaria, mientras la otra tendra una llave foranea.

--FORMATO:

--SELECT <NOMBRE_CAMPO> AS <NOMBRE_CABECERA> FROM <NOMBRE_TABLA_A> AS <ALIAS>
--INNER JOIN <NOMBRE_TABLA_B> ON <CAMPO_A> = <CAMPO_B>
--ORDER BY <NOMBRE_CAMPO> <ASC | DESC>
--GO


--EJEMPLOS :

--1.UTILIZANDO LA TABLA: tblDistrito y tblVendedor REALIZAR UN LISTADO QUE MUESTRE LOS SIGUIENTES CAMPOS:

--CODIGO (VENDEDOR)		VENDEDOR (NOMBRE COMPLETO)	SUELDO	FECHA DE INICIO		DISTRITO(NOMBRE)

select V.Cod_ven as CODIGO, (V.Nom_ven +SPACE(1)+V.Ape_ven) as VENDEDOR, V.Sue_ven as SUELDO,
V.FecInicio_Ven as [FECHA DE INICIO], D.Nom_Dis as DISTRITO from tblVendedor as V
inner join tblDistrito as D on V.Cod_Dis=D.Cod_Dis
go

--2.UTILIZANDO LAS TABLAS: tblFactura, tblVendedor y tblCliente.REALIZAR UN LISTADO QUE MUESTRE LOS SIGUIENTES CAMPOS:
--	FACTURA		FECHA FACTURADA		VENDEDOR	CLIENTE

select F.Num_Fac as FACTURA, F.Fec_Fac as [FECHA FACTURADA],
(V.Nom_ven +SPACE(1)+V.Ape_ven) as VENDEDOR, C.Rso_Cli as CLIENTE
from tblFactura as F
inner join tblCliente as C on C.Cod_Cli=F.Cod_Cli
inner join tblVendedor as V on V.Cod_Ven=F.Cod_Ven
go