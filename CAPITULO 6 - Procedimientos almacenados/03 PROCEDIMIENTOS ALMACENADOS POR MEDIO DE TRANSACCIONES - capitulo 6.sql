/*
Una transaccion en T-SQL es un conjunto de instrucciones que se forman de manera indivisible Un SGBD es transaccional si es capaz de mantener la 
integridad de los datos. De modo que estas transacciones no pueden finalizar en un estado intermedio. Cuando por alguna causa se cancela una 
transaccion las ordenes realizadas son deshechas, hasta dejar la base de datos en el punto inicial, como si la orden de transaccion nunca se 
hubiera realizado. 
El motor de SQL Server provee los mecanismos para especificar que un conjunto de instrucciones debe constituir una transaccion.

BEGIN TRAN: Especifica el comienzo de una transaccion.
COMMIT TRAN: Le indica al motor de base de datos que puede considerar la transaccion completada con exito.
ROLLBACK TRAN: Indica que ocurrio un error y la base de datos debe volver a su punto de integridad.

FORMATO:
BEGIN <TRAN | TRANSACTION> NOMBRE_TRANSACCION
COMMIT TRAN <NOMBRE_TRANSACCION>
ROLLBACK TRAN <NOMBRE_TRANSACCION>
*/
use VentasDB
go
/*Implementar un procedimiento almacenado que permita registrar un proveedor, controlando dicha insercion por medio de una transaccion.
Emitir un mensaje en cada ocasion; es decir si todo es correcto, emitir "PROVEEDOR REGISTRADO CON EXITO", en caso contrario 
"Ocurrio un error al insertar".
*/
if OBJECT_ID('sp_registroProveedor') is not null
begin
drop procedure sp_registroProveedor
end
go
create procedure sp_registroProveedor
(
@codigo char(5),
@razonSocial varchar(80),
@direccion varchar(100),
@telefono varchar(15),
@distrito char(5),
@representante varchar(80)
)
as
begin

begin transaction Registrar_Proveedor

if not exists(select V.* from tblProveedor V where V.Cod_Prv=@codigo)
begin
insert into tblProveedor values
(@codigo, @razonSocial, @direccion, @telefono, @distrito, @representante)
print 'PROVEEDOR REGISTRADO CON EXITO'
end
else
begin
print 'EL CODIGO DEL PROVEEDOR YA EXISTE EN LA BASE DE DATOS. REEMPLAZA POR UN CODIGO VALIDO.' 
end

if @@ERROR=0
begin
commit tran Registrar_Proveedor
end

else
begin
print 'OCURRIO UN ERROR AL REALIZAR LA INSERCION.'
rollback tran Registrar_Proveedor
end

end
go
--Verificando el procedimiento
exec sp_registroProveedor 'PR050','BEGZ','LA GUASIMA','699000000','D01','BRYAN ENRIQUE';
go
--El mismo procedimiento, pero utilizando el bloque try-catch
if OBJECT_ID('sp_Proveedor') is not null
begin
drop procedure sp_Proveedor
end
go

create procedure sp_Proveedor
(
@codigo char(5),
@razonSocial varchar(80),
@direccion varchar(100),
@telefono varchar(15),
@distrito char(5),
@representante varchar(80)
)
as
begin tran Registrar_Proveedor
begin try
insert into tblProveedor values
(
@codigo,@razonSocial,@direccion,@telefono,@distrito,@representante
)
commit tran Registrar_Proveedor
print 'REGISTRO INSERTADO CORRECTAMENTE,'
end try

begin catch
print 'NO SE REALIZO LA INSERCION. ERROR INESPERADO!'
rollback tran Registrar_Proveedor
end catch
go