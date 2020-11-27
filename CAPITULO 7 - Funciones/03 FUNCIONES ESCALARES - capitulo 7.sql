--Las funciones escalares operan sobre un valor y devuelven otro. Pueden ser utilizadas donde la expresion sea valida.
--Funciones de configuracion: Devuelven informacion acerca de la informacion actual, por ejemplo:
use master 
go
--1.Mostrar el nombre del servidor:
select @@SERVERNAME as [NOMBRE DEL SERVIDOR]
go
--2.Mostrar el idioma configurado en el servidor:
select @@LANGUAGE as [IDIOMA DEL SERVIDOR]
go
--3.Mostrar el nombre de la instancia del servidor sql:
select @@SERVICENAME as [NOMBRE DE INSTANCIA SQL]
go
--4.Mostrar la version de SQL SERVER actual:
select @@VERSION as [VERSION DE SQL SERVER]
go
use VentasDB
go
--FUNCIONES DE CONVERSION: Admiten conversion de tipo de datos.

--PARSE: Se recomienda su uso para pasar de tipo cadena a tipo fecha o numero.
--5.Realizar un script que permita convertir un valor monetario expresado en caracteres a tipo moneda.
declare @monto varchar(10)='250,75'
select PARSE(@monto as money using 'es-ES') as conversion
go

--6.Script que permita convertir un valor de tipo fecha a un valor de fecha y hora corta:
--usando TRY CAST:
declare @fecha date='12/10/2019'
select TRY_CAST(@fecha as smalldatetime) as conversion
go

--USANDO TRY_CONVERT:
declare @fecha date='01/02/2001'
select TRY_CONVERT(smalldatetime, @fecha) as conversion
go
--7.Realizar un script que permita convertir un valor monetario expresado en caracteres a tipo moneda.
--usando PARSE_TRY:
declare @monto varchar(10)='250,75'
select TRY_PARSE(@monto as money using 'es-ES') as conversion
go

--Funciones de fecha y hora: realizan operaciones sobre un valor de entrada de fecha y hora, y devuelven un valor numerico de cadena o de fecha y hora.
--1.mostrar fecha y hora actual del sistema con el formato datetime2.
select SYSDATETIME() as[ FECHA Y HORA ACTUAL]
go
--2.mostrar el valor de la fecha y hora universal en el formato datetime2.
select SYSUTCDATETIME() as [FECHA Y HORA UNIVERSAL]
go
--3.mostrar fecha y hora actual del sistema con el formato datetime.
select CURRENT_TIMESTAMP as [FECHA Y HORA ACTUAL]
go
--4.mostrar fecha y hora actual del sistema con el formato datetime universal.
select GETUTCDATE()
go
/*
La funcion DATENAME, devuelve una cadena de caracteres que representa el parametro especificado. Los parametros se muestran de la siguiente manera:
YEAR = < yy| yyyy>
quarter = <qq, q>
month = <mm, m>
dayofyear = <dy, y>
day = <dd d>
week = <wk, ww>
weekday = <dw, w>
hour = <hh>
minute = <mi, n>
second = <ss, s>
millisecond = <mm>
microsecond = <mcs>
nanosecond = <ns>
*/
select DATENAME(MM,GETDATE())
go
select DATENAME(YY,GETDATE())
go

--Implementar script que muestre el numero de dia de la fecha actual.
select DAY(getdate()) as [DIA ACTUAL]
go

---Implementar script que permita mostrar los años en que se registraron facturas.
select f.Num_Fac AS NUMERO, F.Fec_Fac AS 'FECHA DE FACTURA', YEAR(F.Fec_Fac) AS 'AÑO DE FACTURA'  from tblFactura F
go
--DATEDIFF: Devuelve un valor numerico que representa la diferencia entre 2 fechas.
--Realizar un script que muestre la cantidad de anios que tiene registrada cada factura con respecto a la fecha actual.
select f.Num_Fac as NUMERO, f.Fec_Can as FECHA, DATEDIFF(YYYY,f.Fec_Fac,GETDATE()) as [DIFERENCIA DE AÑOS]  from tblFactura F
go

--SET DATEFORMAT: Define el formato de la fecha que se especifica en consultas o inserciones de registros, se tienen las siguientes opciones:
/*
SET DATEFORMAT DMY
SET DATEFORMAT DYM
SET DATEFORMAT MDY
SET DATEFORMAT MYD
SET DATEFORMAT YMD
SET DATEFORMAT YDM
Donde :
Y = Es el anio
M = Es el mes
D = Es el dia
*/
SET DATEFORMAT DMY
go


--La funcion DATEADD(), permite aumentar o disminuir valores a una fecha determinada.
--Realizar un script donde a partir de la fecha actual, muestre las 10 fechas posteriores, si los pagos se deben realizar mes con mes.
declare @fechaActual date = getDate()
declare @i int =1
begin try
print 'LISTADO DE PAGOS.'
print 'FECHA ACTUAL: '+ cast(@fechaActual as varchar(15))
print '________________________________________________'
while(@i<=10)
begin
print dateadd(month,@i,@fechaActual)
set @i+=1
end
end try
begin catch
print'OCURRIO UN ERROR.'
PRINT'DETALLES:'
PRINT 'LINEA: ' + ERROR_LINE()
PRINT 'MENSAJE: ' +ERROR_MESSAGE()
PRINT 'GRAVEDAD: ' + ERROR_SEVERITY()
end catch
go