/*
Los procedimientos almacenados definidos de forma personalizada segun la necesidad del programador permiten utilizar los tipos de
instrucciones que se han visto en los capitulos anteriores.
FORMATO DE CREACION DE UN PROCEDIMIENTO ALMACENADO:

CREATE PROCEDURE <NOMBRE_PROCEDIMIENTO>		<(@PARAMETROS TIPO_DATOS)>
AS
BEGIN
<INSTRUCCIONES DEL PROCEDIMIENTO>
END
GO

FORMATO PARA MODIFICAR UN PROCEDIMIENTO ALMACENADO:
ALTER PROCEDURE <NOMBRE_PROCEDIMIENTO>
AS
INSTRUCCIONES MODIFICADAS
GO

FORMATO PARA ELIMINAR UN PROCEDIMIENTO ALMACENADO:
DROP PROCEDURE <NOMBRE_PROCEDIMIENTO>
GO
*/
use VentasDB
go
--EJEMPLOS:
--1.Implementar un procedimiento almacenado que permita devolver los 5 productos con mas alto precio registrados en 'tblProducto'.
--Validando la existencia del procedimiento.
if OBJECT_ID('sp_TOP5PRECIOS') is not null
begin
drop procedure sp_TOP5PRECIOS
end
go
create procedure sp_TOP5PRECIOS
as
begin
select top 5 * from tblProducto as P
order by p.Pre_Pro desc 
end
go
exec sp_TOP5PRECIOS;
--2.Implementar un procedimiento almacenado que muestre un listado de la forma:
--CODIGO	VENDEDOR	SUELDO		FECHA DE INICIO		DISTRITO(NOMBRE)
if OBJECT_ID('sp_ReporteVendedor') is not null
begin
drop procedure sp_ReporteVendedor
end
go
create procedure sp_ReporteVendedor
as
begin
select
v.Cod_Ven as CODIGO,
v.Nom_Ven + SPACE(1) + Ape_Ven as VENDEDOR,
v.Sue_Ven as SUELDO ,
v.FecInicio_Ven as [FECHA DE INICO],
D.Nom_Dis as DISTRITO
from tblVendedor V
inner join tblDistrito D on d.Cod_Dis=v.Cod_Dis
end
go
execute sp_ReporteVendedor;
go
--3.Implementar un procedimiento almacenado que permita mostrar el total de clientes por distrito:
if OBJECT_ID('sp_ClienteDistrito') is not null
begin
drop procedure sp_ClienteDistrito
end
go
create procedure sp_ClienteDistrito
as
begin
select d.Nom_Dis as DISTRITO, COUNT(*) as [TOTAL DE CLIENTES] from tblCliente as C
inner join tblDistrito as D on D.Cod_Dis=c.Cod_Dis
group by d.Nom_Dis
order by d.Nom_Dis asc
end
go
execute sp_ClienteDistrito;
go
--4.Implementar un procedimiento almacenado que permita mostrar la informacion de un producto utilizando parametros.
if OBJECT_ID('sp_ListaProductos') is not null
begin
drop procedure sp_ListaProductos
end
go
create procedure sp_ListaProductos
@codigo char(5)
as
begin
begin try
select * from tblProducto
where Cod_Pro=@codigo
end try
begin catch
print 'CONSULTA FALLIDA. ERROR INESPERADO'
end catch
end
go
--Prueba:
execute sp_ListaProductos 'P001' ;
go
--5.Implementar un procedimiento almacenado que permita mostrar una determinada cantidad de facturas en cierto año.
if OBJECT_ID('sp_TotalFacturas') is not null
begin
drop procedure sp_TotalFacturas
end
go
create procedure sp_TotalFacturas (@anio int)
as
begin
begin try
select YEAR(Fec_Fac) as AÑO, COUNT(*) as [TOTAL FACTURAS] from tblFactura
where  YEAR(Fec_Fac)=@anio
group by YEAR(Fec_Fac)
end try
begin catch
print 'CONSULTA FALLIDA. ERROR INESPERADO'
end catch
end
go
--Prueba del procedimiento:
begin try
exec sp_TotalFacturas'2013';
end try
begin catch
print 'CONSULTA FALLIDA. ERROR INESPERADO'
end catch
go
--6.Implementar procedimiento almacenado que permita mostrar la informacion de los clientes de un determinado distrito.
if OBJECT_ID('sp_InformacionCliente') is not null
begin
drop procedure sp_InformacionCliente
end
go
create procedure sp_InformacionCliente (@nombreDistrito varchar(50))
as
begin
select c.* from tblCliente C
inner join tblDistrito as D on d.Cod_Dis=c.Cod_Dis
where d.Nom_Dis =@nombreDistrito
end
go
--Prueba del procedimiento:
execute sp_InformacionCliente 'LA MOLINA';
go
--7.Implementar un procedimiento almacenado que permita mostrar las facturas de un determinado año y un determinado mes.
if OBJECT_ID('sp_FacturaMesAnio') is not null
begin
drop procedure sp_FacturaMesAnio
end
go
create procedure sp_FacturaMesAnio (@anio int, @mes int)
as
begin
select YEAR(Fec_Fac) as AÑO, MONTH(Fec_Fac) as MES, COUNT(*) as TOTAL FROM tblFactura
where YEAR(Fec_Fac)=@anio and MONTH(Fec_Fac)= @mes
group by YEAR(Fec_Fac), MONTH(Fec_Fac)
end
go
execute sp_FacturaMesAnio 2013,10;
go
--8.Implementar un procedimiento almacenado que permita registrar un nuevo cliente, validando el codigo de distrito.

--Validando existencia del procedimiento:
if OBJECT_ID('sp_RegistroCliente') is not null
begin
drop procedure sp_RegistroCliente
end
go
--Creando el procedimiento:
create procedure sp_RegistroCliente
(
@codigoCliente char(5),
@razonSocial varchar(30),
@direccion varchar(100),
@telefono varchar(15),
@RUC varchar(11),
@codigoDistrito char(5),
@fechaRegistro date,
@tipoCliente varchar(10),
@condicion varchar(30)
)
as
begin try
if exists(select * from tblDistrito where Cod_Dis=@codigoDistrito)
begin

insert into tblCliente values
(@codigoCliente, @razonSocial, @direccion, @telefono, @RUC, @codigoDistrito, @fechaRegistro, @tipoCliente, @condicion)
end

else
print 'EL CODIGO DE DISTRITO NO SE ENCUENTRA REGISTRADO EN LA BASE DE DATOS.'

end try

begin catch
print 'ERROR INESPERADO, REGISTRO NO REALIZADO. '
end catch
go
--9.Implementar un procedimiento almacenado que permita registrar un nuevo distrito, el codigo de distrito debera generarse automaticamente.
if OBJECT_ID('sp_DistritoNuevo') is not null
begin
drop procedure sp_DistritoNuevo
end
go
create procedure sp_DistritoNuevo(@Distrito varchar(50))
as
begin try
set rowcount 1
declare @codigo char(5)
select @codigo=RIGHT(D.Cod_Dis, 4) from tblDistrito as D order by d.Cod_Dis desc
declare @NuevoCodigo char(5)='D'+ cast(@codigo+1 as char(2))
if not exists(select Nom_Dis from tblDistrito where Nom_Dis=@Distrito)
begin
insert into tblDistrito values
(@NuevoCodigo, @Distrito)
end
else print'EL NOMBRE DEL DISTRITO YA SE ENCUENTRA REGISTRADO.'
end try
begin catch
print 'ERROR INESPERADO.'
end catch
go
execute sp_DistritoNuevo 'SANTA MONICA';
go
--PROCEDIMIENTOS ALMACENADOS CON PARAMETROS DE SALIDA:
--10.Implementar un procedimiento almacenado que permita mostrar una determinada cantidad de facturas en cierto año.
if OBJECT_ID('sp_TotalFacturas') is not null
begin
drop procedure sp_TotalFacturas
end
go
create procedure sp_TotalFacturas (@anio int, @total int output)
as
begin
select @total= COUNT(*) from tblFactura
where YEAR(Fec_Fac)= @anio
end
go
--verificando procedimiento:
declare @TOTAL INT, @anio int=2013
exec sp_TotalFacturas 2013,@TOTAL=@total output
print 'EL TOTAL DE FACTURAS EN EL AÑO: ' + CONVERT(CHAR(4), @anio) + ' ES DE: '+ CONVERT(CHAR(2), @TOTAL)
--Visualizar el contenido de un procedimiento almacenado.
--FORMATO:
--EXECUTE sp_helptect 'NOMBRE_PROCEDIMIENTO'
--GO
exec sp_helptext 'sp_TotalFacturas'
go