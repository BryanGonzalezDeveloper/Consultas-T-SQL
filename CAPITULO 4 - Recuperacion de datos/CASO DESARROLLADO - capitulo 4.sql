--PARA REALIZAR EL CASO DESARROLADO CORRESPONDIENTE AL CAPITULO NUMERO 4, ES NECESARIO HABER DESARROLLADO PREVIAMENTE EL CASO
--DESARROLLADO 2, DEL CAPITULO. DEBIDO A QUE SE UTILIZARA LA BASE DE DATOS CREADA EN ESE CAPITULO
--EN ESTE CASO LA BASE DE DATOS SE LLAMA: "RENT_CAR".
use 
RENT_CAR
go
--Se pide realizar lo siguiente:

--1.Listar los registros de todas las tablas:
select * from tblAlquiler
select * from tblAutomovil
select * from tblCliente
select * from tblDetalleAlquiler
select * from tblDistrito
go
--2.Listar loa colores de auto permitidos en el registro:
select distinct A.COL_AUT from tblAutomovil as A
go
--3.Listar los automoviles ordenados por la fecha de alquiler en forma descendente; y de forma ascendente por el monto de alquiler
--ante la posible coincidencia de la fecha de alquiler:
select * from tblAlquiler
order by YEAR(FEC_ALQ) DESC, MON_ALQ ASC
go
--4.Listar los 2 primeros registros que cuenten con el menor monto de alquiler.
select top 2 * from tblAlquiler
order by MON_ALQ asc
go
--5. Mostrar el listado de alquiler con las cabeceras organizadas de la siguiente manera:
--	NUMERO DE ALQUILER		FECHA DE ALQUILER		MONTO DE ALQUILER
select
NUM_ALQ as [NUMERO DE ALQUILER], FEC_ALQ AS [FECHA DE ALQUILER], MON_ALQ AS [MONTO DE ALQUILER]
from tblAlquiler
go
--6.Mostrar un listado de cliente con las cabeceras organizadas de la siguiente manera:
--CODIGO	CLIENTE		TELEFONO	DNI
select IDE_CLI AS CODIGO, (NOM_CLI + SPACE(1)+ APE_CLI) AS CLIENTE, TEL_CLI AS TELEFONO, DNI_CLI AS DNI
from tblCliente

--7.Crear una tabla llamada: "tblAutosRojos". Que solo contenga informacion de los autos rojos, a partir de la tabla:"tblAutomovil".
if OBJECT_ID('tblAutosRojos') is not null
begin
drop table tblAutosRojos
end
go
select * into tblAutosRojos from tblAutomovil as A
where A.COL_AUT='ROJO'
go
--Se verifica que la consulta anterior se haya realizado correctamente:
select * from tblAutosRojos
go
--8.Listar los automoviles de color negro:
select * from tblAutomovil
where COL_AUT='NEGRO'
go
--9.Listar los cliente cuyo codigo de distrito sea: "D01".
select * from tblCliente C
where C.IDE_DIS='D01'
go
--10.Listar los clientes donde la letra inicial de su nombre sea la letra 'M'
select * from tblCliente C
where C.NOM_CLI like 'M%'
go
--11.Listar los alquileres cuyo monto de alquiler se encuentre en el rango de 100 a 150.
select * from tblAlquiler
where MON_ALQ between 100 and 150
go
--12.Listar todos los automoviles excepto los que sean de color plata.
select * from tblAutomovil
where not COL_AUT='PLATA'
go
--13.Utilizando union interna, se debe realizar un listado que muestre la cabeceras de la siguiente manera:
--CODIGO	CLIENTE		DISTRITO	DNI
select
C.IDE_CLI AS CODIGO, (C.NOM_CLI + SPACE(1) + C.APE_CLI) AS CLIENTE, D.DES_DIS AS DISTRITO, C.DNI_CLI AS DNI
from tblCliente as C
inner join tblDistrito as D on D.IDE_DIS=C.IDE_DIS
go
--14.Utilizando union interna, se debe realizar un listado que muestre la cabeceras de la siguiente manera:
--	ALQUILER(Numero)	FECHA(Alquiler) 	AUTOMOVIL(Matricula)	CLIENTE(Nombre completo)

select

A.NUM_ALQ as [NUMERO DE ALQUILER], A.FEC_ALQ as FECHA, CAR.MAT_AUT as [MATRICULA AUTOMOVIL], 
(C.NOM_CLI + SPACE(1) + C.APE_CLI) AS CLIENTE

from tblDetalleAlquiler as DA

inner join tblAlquiler as A on A.NUM_ALQ=DA.NUM_ALQ
inner join tblAutomovil as CAR on CAR.MAT_AUT=DA.MAT_AUT
inner join tblCliente as C on C.IDE_CLI=DA.IDE_CLI
GO
--15.Listar los registros de alquiler que aun no cuentan con detalle de alquiler.
select 
A.*
from tblAlquiler as A
left join tblDetalleAlquiler as DA on DA.NUM_ALQ=A.NUM_ALQ
where DA.NUM_ALQ is null
go
--16.Listar los clientes que aun no registran alquiler.
select 
C.* from tblCliente as C
left join tblDetalleAlquiler as D on D.IDE_CLI=C.IDE_CLI
where D.NUM_ALQ is null
go
--17.Listar el total del clientes por distrito.
select D.DES_DIS as DISTRITO, COUNT(*) as [TOTAL DE CLIENTES]
from tblCliente as C
inner join tblDistrito as D on D.IDE_DIS=C.IDE_DIS
group by D.DES_DIS
go
--18.Listar los automoviles por tipo de color:
select COL_AUT as COLOR, COUNT(*) as [TOTAL DE AUTOS] from tblAutomovil
group by COL_AUT
go
--19.Listar el monto acumulado por año desde la tabla: "tblAlquiler".
select YEAR(FEC_ALQ) AS AÑO, SUM(MON_ALQ) AS [MONTO ACUMULADO] from tblAlquiler
group by YEAR(FEC_ALQ)
go
--20.Utilizando subconsulta mostrar un listado con las siguientes cabeceras:
--	CODIGO	CLIENTE		DISTRITO	DNI
select
C.IDE_CLI as CODIGO,(C.NOM_CLI+SPACE(1)+C.APE_CLI) as CLIENTE,
(select D.DES_DIS from tblDistrito D where D.IDE_DIS=C.IDE_DIS ) as DISTRITO, C.DNI_CLI as DNI
from tblCliente C
go
--21.Utilizando subconsulta mostrar un listado con las siguientes cabeceras:
--ALQUILER	FECHA	AUTOMOVIL	CLIENTE
select D.NUM_ALQ as ALQUILER, (select A.FEC_ALQ from tblAlquiler as A where A.NUM_ALQ=D.NUM_ALQ)as FECHA,
MAT_AUT as AUTOMOVIL,
(select NOM_CLI+SPACE(1)+APE_CLI from tblCliente as C where C.IDE_CLI=D.IDE_CLI) as CLIENTE
from tblDetalleAlquiler D
go