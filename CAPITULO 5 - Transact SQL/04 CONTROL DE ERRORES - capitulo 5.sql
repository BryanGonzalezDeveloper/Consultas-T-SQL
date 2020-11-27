/*
Los errores en T-SQL se pueden controlar a traves del bloque TRY-CATCH  y algunas funciones que provee SQL SERVER.
FORMATO DE UN BLOQUE DE CODIGO TRY-CATCH:

BEGIN TRY
<EXPRESIONES_SQL>
END TRY
BEGIN CATCH
<EXPRESIONES_SQL>
END CATCH


Donde:
BEGIN TRY: Se coloca el codigo de trascendencia normal.
END TRY: indica la finalizacion del BEGIN TRY.
BEGIN CATCH: Si al ejecutar el bloque BEGIN TRY, se produce un error, el error es tratado en este bloque.
END CATCH: Finalizacion del bloque END CATCH.
FUNCIONES ESPECIALES DE ERROR:
*ERROR_NUMBER():	Devuelve el numero de error detectado.
*ERROR_MESSAGE():	Devuelve el texto completo del mensaje de error.
*ERROR_SEVERITY():	Devuelve la gravedad del error.
*ERROR_STATE():		Devuelve el numero de estado de error.
*ERROR_LINE():		Devuelve el numero de linea dentro de la rutina que origino el error.
*ERROR_PROCEDURE():	Devuelve el nombre del procedimiento almacenado en que se produjo el error.
*/
use master
go
--EJEMPLOS:
--1.Implementar uns script que muestre los valores que emiten las funciones de control de errores al tratar de dividir entre cero.
BEGIN TRY 
SELECT 1/0
END TRY
BEGIN CATCH
SELECT 
ERROR_NUMBER() AS [NUMERO DE ERROR],
ERROR_MESSAGE() AS [MENSAJE DE ERROR],
ERROR_PROCEDURE() AS [GRAVEDAD],
ERROR_STATE() AS [ESTADO DE ERROR],
ERROR_LINE() AS [LINEA DEL ERROR],
ERROR_PROCEDURE() AS [NOMBRE PROCEDIMIENTO]
END CATCH
GO
--Implentar un script que permita registrar un nuevo distrito, en la tabla: "tblDistrito en caso de error mostrar un mensaje.
use VentasDB
go
begin try
declare @codigo char(5)='D37', @nombre varchar(50)= 'PUEBLO NUEVO'
insert into tblDistrito values
(@codigo,@nombre)
end try
begin catch
print 'OCURRIO UN ERROR INESPERADO: ' + ERROR_MESSAGE()
end catch
go
/*
La funcion @@ERROR devuelve 0 si la ultima sentencia de T-SQL se ejecuto con exito; Si la instruccion genera algun error, la funcion
regresa el numero del error. Se debe tener en cuenta que el valor de @@ERROR cambia con cada instruccion T-SQL.
Para mostrar el numero del error sql server presenta una lista de posibles errore, usando la sentencia:
SELECT * FROM SYS.SYSMESSAGES
*/
use master
go
SELECT * FROM SYS.SYSMESSAGES
order by sys.sysmessages.severity desc
GO
--EJEMPLOS:
--1.Implementar un script que actualizar el codigo de distrito de un vendedor.
use VentasDB
go
--Utilizando funciones especiales  para el error.
begin try
declare @distritoNuevo char(5)='D03', @Cod_Ven char(3)='V01'
update tblVendedor set Cod_Dis=@distritoNuevo
where Cod_Ven=@Cod_Ven
PRINT 'EL REGISTRO FUE ACTUALIZADO CORRECTAMENTE.'
end try
begin catch
print 'OCURRIO UN ERROR INESPERADO'
print '____________________________________'
print 'DETALLES DEL ERROR:'
print '____________________________________'
print 'MENSAJE DEL ERROR: ' + ERROR_MESSAGE()
print 'NUMERO DEL ERROR: ' + CONVERT(CHAR(5),ERROR_NUMBER())
print 'CONSULTE EL ERROR CON SU ADMINISTRADOR DE BASE DE DATOS.'
print '____________________________________'
end catch
go
--Utilizando @@ERROR.
begin try
declare @distritoNuevo char(5)='D03', @Cod_Ven char(3)='V01'
update tblVendedor set Cod_Dis=@distritoNuevo
where Cod_Ven=@Cod_Ven
PRINT 'EL REGISTRO FUE ACTUALIZADO CORRECTAMENTE.'
end try
begin catch
if (@@ERROR<>0)
begin
print 'OCURRIO UN ERROR INESPERADO'
end
end catch
go

/*
FUNCION RAISERROR.
Esta funcion es utilizada para devolver mensajes de error definidos por el programador con el mismo formato que el sistema gestor
de base de datos, o que un mensaje de advertencia.
POSEE EL SIGUIENTE FORMATO:

RAISERROR <msg_id | msg_str | @localVariable, severity, state > 
DONDE:
msg_id: Sera el numero del error definido por el programador, almacenado en el catalogo sys.sysmessages a traves del procedimiento
almacenado SP_ADDMESSAGE. Los numeros de los errores definidos por el usuario deben ser mayores a 50 000 debido a que ese es el tope
de los errores definidos de forma nativa por el motor de base de datos de SQL. 

msg_str: Es una cadena de caracteres que incluye especificaciones de conversion opcionales. Cada especificacion de conversion
define como se aplica formato a un valor de la lista de argumentos y como se coloca un campo en la posicion indicada dentro de la
especificacion de conversion. La especificacion de conversion tiene el formato siguiente:
% [[flag] [width] [.precision] [h|l]] type

severity: Es el nivel de gravedad asociado al mensaje de error definido por el usuario. Todos los usuarioa pueden especificar niveles
de gravedad del 0 al 18. Solo los  con permisos "ALTER TRACE" pueden especificar los niveles de gravedad del 19 al 25, para asignar
estos niveles de gravedad se requiere la opcion "WITH LOG"
state: Es un numero entero dentro del rango de [0 , 255] los numeros fuera de este rango generan un error.
*/
use master 
go
--EJEMPLOS:
--Implementar un script que permita controlar el error en una division, no definida.
begin try
print 1/0
end try
begin catch
declare @msjError varchar(4000), @severidad int, @estado int
select @msjError=ERROR_MESSAGE(),
@severidad= ERROR_SEVERITY(),
@estado=ERROR_STATE()
raiserror(@msjError, @severidad,@estado)
end catch
go