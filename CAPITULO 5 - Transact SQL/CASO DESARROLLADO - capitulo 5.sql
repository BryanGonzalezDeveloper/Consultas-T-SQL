/*
En el caso desarrollado de este capitulo se debera utilizar la base de datos creada en el caso desarrollado 2, del capitulo 3.
La base de datos se llama: "RENT_CAR"
*/

use RENT_CAR
go
---1.Mostrar informacion de un determinado cliente a traves de variables locales y el uso de print.
declare @ide char(5)='CL003', @nombreCliente varchar(50), @distrito varchar(50)
select @nombreCliente=  (NOM_CLI + SPACE(1) + APE_CLI) from tblCliente where IDE_CLI = @ide
select @distrito = D.DES_DIS from tblCliente C
inner join tblDistrito D on D.IDE_DIS=c.IDE_DIS
where C.IDE_CLI=@ide
print 'EL CLIENTE: ' + @nombreCliente + ' PERTENECE AL DISTRITO: '+ @distrito
go
--2.Mostrar la informacion del detalle de alquiler, utilizando variables y print.
declare @numero int =1, @ideCliente char(5)='CL002', @matricula char(10), @nombreCliente varchar(50);

select @matricula= MAT_AUT from tblDetalleAlquiler;
select @nombreCliente= C.NOM_CLI + SPACE(1) + C.APE_CLI from tblDetalleAlquiler DA
inner join tblCliente C on C.IDE_CLI = DA.IDE_CLI
where DA.IDE_CLI=@ideCliente;
print 'EL CLIENTE: ' +@nombreCliente + ' ALQUILO EL AUTOMOVIL CON LA MATRICULA: ' + @matricula;
print 'EL NUMERO DE ALQUILER CORRESPONDE A: ' + convert(char(2), @numero);
go
--3.Mostrar una lista de automoviles de un color especificado por medio de una variable.
declare @color varchar(30)= 'PLATA';
select * from tblAutomovil
where COL_AUT=@color;
go
--4.Realizar un script que permita registrar un automovil nuevo, en dado caso de existir solo actualizarlo.
begin try

declare @matricula char(10)='JK-489',@color varchar(30)='NEGRO', @modelo varchar(30)='TOYOTA'
merge tblAutomovil as target
using (
select @matricula, @color, @modelo
)
as source
(
MAT_AUT, COL_AUT, MOD_AUT
) 
on (target.MAT_AUT = source.MAT_AUT)
when matched then
update set COL_AUT= SOURCE.COL_AUT, MOD_AUT= SOURCE.MOD_AUT
when not matched then
insert values (SOURCE.MAT_AUT, SOURCE.COL_AUT, SOURCE.MOD_AUT);
PRINT 'OPERACION REALIZADA SATISFACTORIAMENTE.'
end try

begin catch
PRINT 'ERROR INESPERADO.'
PRINT '____________________________'
PRINT 'DETALLES DEL ERROR:'
PRINT 'LINEA DEL ERROR: ' + CONVERT(CHAR(5), ERROR_LINE())
PRINT 'MENSAJE DEL ERROR: ' + ERROR_MESSAGE()
PRINT 'GRAVEDAD DEL ERROR: ' + ERROR_SEVERITY()
PRINT 'PONGASE EN CONTANTO CON SU ADMINISTRADOR DE BASE DE DATOS.'
end catch
go
select * from tblAutomovil
go
--5.Realizar un script que permita registrar a un nuevo cliente, validando la existencia del nombre del distrito.
begin try
declare
@distrito varchar(40)='SURCO',@ide char(5) = 'CL008',@apellido varchar(30)='GONZALEZ'
,@nombre varchar(30)='BRYAN',@dni varchar(8)='13468794',@telefono varchar(25)='669000000',
@correo varchar(50)='gonzalezzbryan220@gmail.com'

declare @codigoDistrito char(3)

if exists(select DES_DIS from tblDistrito where DES_DIS=@distrito)
begin
select @codigoDistrito= IDE_DIS from tblDistrito where DES_DIS=@distrito
insert into tblCliente values
(@ide,@apellido,@nombre,@dni,@telefono,@codigoDistrito,@correo)
PRINT 'REGISTRO REALIZADO CON EXITO.'	
end
else
begin
print 'EL DISTRITO NO EXISTE O AUN NO SE ENCUENTRA REGISTRADO DENTRO DE NUESTRA BASE DE DATOS.'
end
end try
begin catch
PRINT 'ERROR INESPERADO.'
PRINT '____________________________'
PRINT 'DETALLES DEL ERROR:'
PRINT 'LINEA DEL ERROR: ' + CONVERT(CHAR(5), ERROR_LINE())
PRINT 'MENSAJE DEL ERROR: ' + ERROR_MESSAGE()
PRINT 'GRAVEDAD DEL ERROR: ' + ERROR_SEVERITY()
PRINT 'PONGASE EN CONTANTO CON SU ADMINISTRADOR DE BASE DE DATOS.'
end catch
go
select C.* from tblCliente C
go
/*6.Mostrar los registro de alquiler agragando la columna: "CRITERIO", tomando en cuenta lo siguiente
		MONTO ALQUILER					CRITERIO
		Menor a 50						Bajo
		Entre 50 y 100					Medio
		Mayor a 100						Alto
*/
select 
a.NUM_ALQ as NUMERO, A.FEC_ALQ as FECHA,A.MON_ALQ as [MONTO DE ALQUILER], 
case
WHEN(A.MON_ALQ<50) THEN 'BAJO'
WHEN(A.MON_ALQ BETWEEN 50 AND 100) THEN 'MEDIO'
WHEN(A.MON_ALQ>100) THEN 'ALTO'
end as [CRITERIO]
from tblAlquiler as A
go