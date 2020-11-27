use
VentasDB
go
--Las consultas condicionadas permiten consultar una tabla y solo obtener una lista de registros filtrados que cumplan
--con una condicion especificada.

--FORMATO:

--SELECT <ALL> | <*> |<ALIAS.NOMBRE_CAMPO AS NOMBRE_CABECERA>  FROM <NOMBRE_TABLA> AS <ALIAS>
--WHERE <CONDICION>		
--ORDER BY <NOMBRE_CAMPO> <ASC | DESC>
--GO

--EJEMPLOS:
--1.MOSTRAR LOS REGISTROS DE LA TABLA : tblCliente .SOLAMENTE DE LOS CLIENTES CUYO  CODIGO DE DISTRITO (Cod_Dis)SEA
-- IGUAL A 'D05' Y EL CLIENTE SE HAYA REGISTRADO EN EL AÑO 2013
select * from tblCliente
where Cod_Dis = 'D05' and YEAR(Fec_Reg) = 2013
go

--2.MOSTRAR LOS REGISTROS DE LOS CLIENTES QUE RESIDEN EN "SAN MIGUEL".
select * from tblCliente as c
where c.Cod_Dis = 
any (
select D.Cod_Dis from tblDistrito as d
where d.Nom_Dis='SAN MIGUEL'
)
go

--3. MOSTRAR LOS REGISTROS DE LOS CLIENTES QUE SE HAYAN REDGISTRADO ENTRE LOS AÑOS 2008 Y 2011.
select * from tblCliente as c
where YEAR(c.Fec_Reg) between 2008 and 2011
go

--4. MOSTRAR LOS REGISTROS DE LOS CLIENTES DONDE EL CODIGO DE DISTRITO SEA 'D01', 'D07' O 'D11'.
select * from tblCliente as C
where C.Cod_Dis in('D01','D07','D11')
go

--5.MOSTRAR LOS REGISTROS DE LOS CLIENTE DONDE LA RAZON SOCIAL INICIE CON LA LETRA 'M'.
select C.* from tblCliente as C
where C.Rso_Cli like 'M%'
go
--6.MOSTRAR LOS REGISTROS DE LOS VENDEDORES, CUYO NOMBRE TENGA COMO SEGUNDA LETRA EL CARACTER 'A'.
select * from tblVendedor as V
where V.Nom_Ven like '_A%'
go
--7. MOSTRAR LOS REGISTROS DE LOS CLIENTES DONDE LA RAZON SOCIAL INCIE CON : 'M', 'C' O 'D'.
select * from tblCliente
where Rso_Cli like '[MCD]%' order by Rso_Cli asc
go

--8.MOSTRAR LOS REGISTROS DE LOS VENDEDORES DONDE EL SEGUNDO CARACTER DEL NOMBRE SEA : 'A', 'E', 'R'.
select * from tblVendedor as V
where V.Nom_Ven like '_[AER]%'
go

--9.MOSTRAR LOS REGISTROS DE LOS CLIENTES DONDE LA RAZON SOCIAL NO INCIE CON : 'F', 'M' O 'C'.
select * from tblCliente as c
where c.Rso_Cli like '[^FMC]%'
go

--10.MOSTRAR LOS REGISTROS DE LOS CLIENTES DONDE EL RUC NO SEA NULO.
select * from tblCliente as c
where c.Ruc_Cli is not null
go

--11.MOSTRAR LOS REGISTROS DE LOS CLIENTES DONDE EL AÑO DE REGISTRO SEA DIFERENTE DE 2012.
select C.* from tblCliente as C
where not YEAR(C.Fec_Reg ) = 2012
go

--12.MOSTRAR LOS REGISTROS DE LOS CLIENTES CON CODIGO 'C002' Y 'C007'.
select * from tblCliente 
where Cod_Cli = 'C002' OR Cod_Cli = 'C007'
go