/*
En el caso desarrollado del presente capitulo se utilizara la base de datos que se desarrollo en el capitulo 3 en el caso desarrollado numero 2.
la base de datos tiene el  nombre de :
RENT_CAR
*/
use RENT_CAR
go
--1.Implementar procedimiento almacenado que permita mostrar informacion de los clientes incluyendo el nombre de distrito,
if OBJECT_ID('sp_InformacionClientes') is not null
begin
drop procedure sp_InformacionClientes
end
go
create procedure sp_InformacionClientes
as
begin
select c.IDE_CLI as CODIGO, C.NOM_CLI+SPACE(1)+C.APE_CLI AS CLIENTE, C.DNI_CLI AS DNI, D.DES_DIS AS DISTRITO from tblCliente C
inner join tblDistrito D on d.IDE_DIS=c.IDE_DIS
end
go
--Verificacion del procedimiento:
exec sp_InformacionClientes;
go
--2.procedimiento almacenado que permita dar mantenimiento(Insercion o actualizacion) a la tabla: "tblCliente".
if OBJECT_ID('sp_MantenimientoCliente') is not null
begin
drop procedure sp_MantenimientoCliente
end
go
create procedure sp_MantenimientoCliente
(
@codigoCliente char(5),
@apellido varchar(30),
@nombre varchar(30),
@dni varchar(8),
@telefono varchar(25),
@codigoDistrito char(3),
@correo varchar(50)
)
as
BEGIN TRANSACTION T_MantenimientoCliente
begin try
if exists(select * from tblDistrito where IDE_DIS=@codigoDistrito)
begin

if exists(select * from tblCliente where IDE_CLI=@codigoCliente)
begin
update tblCliente set APE_CLI=@apellido, NOM_CLI=@nombre, DNI_CLI=@dni, TEL_CLI=@telefono, IDE_DIS=@codigoDistrito, COR_CLI=@correo
where IDE_CLI=@codigoCliente
print 'ACTUALIZACION REALIZADA CORRECTAMENTE.'
end

else 
begin
insert into tblCliente values (@codigoCliente, @apellido, @nombre, @dni, @telefono, @codigoDistrito, @correo)
print 'INSERCION REALIZADA CORRECTAMENTE.'
end

end
else
begin
print'EL CODIGO DE DISTRITO: '+@codigoDistrito +' NO SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS.'
end
commit tran T_MantenimientoCliente
end try
begin catch
print 'ERROR AL REALIZAR MANTENIMIENTO'
rollback tran T_MantenimientoCliente
end catch
go
--3.Implemente procedimiento almacenado que muestre el ultimo codigo de cliente registrado en la tabla 'tblCliente'
if OBJECT_ID('sp_codigoCliente') is not null
begin
drop procedure sp_codigoCliente
end
go
create procedure sp_codigoCliente
as
begin
select top 1 IDE_CLI as [CODIGO CLIENTE] from tblCliente 
order by IDE_CLI desc
end
--Verificacion del procedimiento:
exec sp_codigoCliente;
go
--4.Procedimiento almacenado que muestre el total de cliente por distrito.
if OBJECT_ID('sp_TotalClientes') is not null
begin
drop procedure sp_TotalClientes
end
go
create procedure sp_TotalClientes
as
begin
select D.DES_DIS AS DISTRITO, COUNT(C.NOM_CLI) as [TOTAL CLIENTES] from tblCliente as C
inner join tblDistrito as D on D.IDE_DIS= C.IDE_DIS
group by D.DES_DIS order by D.DES_DIS asc
end
go
--Verificando procedimiento:
exec sp_TotalClientes;
go
--5.Implementar procedimiento almacenado que permita mostrar informacion del detalle de alquiler a partir del numero de alquiler.
if OBJECT_ID('sp_InfoAlquiler') is not null
begin
drop procedure sp_InfoAlquiler
end
go
create procedure sp_InfoAlquiler(@numeroAlquiler int)
as
begin try
select
DA.NUM_ALQ AS [NUMERO ALQUILER], C.NOM_CLI + SPACE(1) + C.APE_CLI AS CLIENTE, DA.MAT_AUT AS [MATRICULA AUTOMOVIL], A.MOD_AUT AS [MODELO AUTOMOVIL] 
from tblDetalleAlquiler AS DA 
inner join tblCliente as C on C.IDE_CLI= DA.IDE_CLI
inner join tblAutomovil as A on A.MAT_AUT=DA.MAT_AUT
where DA.NUM_ALQ=@numeroAlquiler
end try
begin catch
print 'ERROR INESPERADO: ' +ERROR_MESSAGE()
end catch
go
--Verificacion del procedimiento:
exec sp_InfoAlquiler 1;
go
--6.Implementar procedimiento almacenado que muestre los clientes de un determinado distrito
if OBJECT_ID('sp_CLIENTESxDISTRITO') is not null
begin
drop procedure sp_CLIENTESxDISTRITO
end
go
create procedure sp_CLIENTESxDISTRITO (@nombreDistrito varchar(40))
as
begin try
if not exists(select * from tblDistrito where DES_DIS =@nombreDistrito)
begin
print 'EL DISTRITO: ' + @nombreDistrito+' NO SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS.'
end
else
begin
select D.DES_DIS AS DISTRITO, COUNT(C.IDE_CLI) AS [TOTAL DE CLIENTES] from tblCliente C
inner join tblDistrito D on d.IDE_DIS=c.IDE_DIS
where d.DES_DIS=@nombreDistrito
group by d.DES_DIS order by d.DES_DIS asc
end
end try
begin catch
print 'ERROR INESPERADO: ' + ERROR_MESSAGE()
end catch
go
--verificando procedimiento:
exec sp_CLIENTESxDISTRITO 'SURCO';
go
--7.Implementar un procedimiento almacenado que permita mostrar el registro de los autos de un determinado color:
if OBJECT_ID('sp_AUTOSxCOLOR') is not null
begin
drop procedure sp_AUTOSxCOLOR
end
go
create procedure sp_AUTOSxCOLOR (@color varchar(30))
as
begin try
if( @color='ROJO' OR @color='NEGRO' OR @color='PLATA')/*ROJO, NEGRO Y PLATA. SON LOS UNICOS VALORES QUE SE PERMITEN COMO COLOR DE AUTOMOVIL.*/
begin
select A.* from tblAutomovil as A
where COL_AUT=@color
end
else
begin
print 'EL COLOR NO COINCIDE CON LOS VALORES PERMITIDOS'
end
end try
begin catch
print 'ERROR INESPERADO: '+ ERROR_MESSAGE()
end catch
go
--Verificando el procedimiento:
exec sp_AUTOSxCOLOR 'ROJO';
go
--El 'AZUL' es un color no permitido.
exec sp_AUTOSxCOLOR 'AZUL';
go
--8.Implementar procedimiento almacenado que muestre informacion del detalle de alquiler a partir del nombre de un cliente.
if OBJECT_ID('sp_AlquilerXcliente') is not null
begin
drop procedure sp_AlquilerXcliente
end
go
create procedure sp_AlquilerXcliente(@nombre varchar(30))
as
begin try
if not exists(select * from tblCliente where NOM_CLI=@nombre)
begin
print 'EL CLIENTE: ' +@nombre + ' NO SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS.'
end
else
begin
SELECT A.NUM_ALQ AS [NUMERO ALQUILER], C.NOM_CLI +' '+ C.APE_CLI AS CLIENTE, C.IDE_CLI AS [CODIGO CLIENTE], A.MAT_AUT AS MATRICULA
from tblCliente C
inner join tblDetalleAlquiler A on C.IDE_CLI=A.IDE_CLI
where C.NOM_CLI =@nombre
end
end try
begin catch 
print 'ERROR INESPERADO: '+ ERROR_MESSAGE()
end catch
go
exec sp_AlquilerXcliente 'MARISOL';
go
--9.Implementar un procedimiento almacenado que permita listar los alquileres de un determinado año de registro.
if OBJECT_ID('sp_ALQUILERxAÑO') is not null
begin
drop procedure sp_ALQUILERxAÑO
end
go
create procedure sp_ALQUILERxAÑO (@anio int)
as
begin
if exists(select * from tblAlquiler where YEAR(FEC_ALQ)=@anio)
begin

select A.* from tblAlquiler A
where YEAR(A.FEC_ALQ)=@anio
end
else
begin
print'NO EXISTEN REGISTROS DE ALQUILER EN EL AÑO: ' +convert(char(4),@anio)+' .'
end

end
go
--Verificando procedimiento:
execute sp_ALQUILERxAÑO 2012;
go