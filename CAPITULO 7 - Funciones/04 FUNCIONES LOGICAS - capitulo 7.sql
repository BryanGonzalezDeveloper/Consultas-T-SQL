--Funciones logicas son aquellas que como su nombre lo indica realizan operaciones logicas.
--La funcion CHOOSE(), devuelve un valor de un conjunto de valores especificados por un indice.

--1.Realizar un script que permita mostrar los datos de las facturas, adicionando el dia, mes con letras y el año desde la facturacion.
use VentasDB
go

select f.Num_Fac as FACTURA, F.Fec_Fac AS FECHA ,day(Fec_Fac) as DIA, DATENAME(MM,F.Fec_Fac) AS MES, YEAR(F.Fec_Fac) as AÑO 
from tblFactura F
go
--Utilizando CHOOSE()
select 
f.Num_Fac as FACTURA,
F.Fec_Fac AS FECHA ,
day(Fec_Fac) as DIA,
CHOOSE(MONTH(f.Fec_Fac),'ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE',
'OCTUBRE','NOVIEMBRE','DICIEMBRE') as MES,
YEAR(F.Fec_Fac) as AÑO 
from tblFactura F
go

--La funcion IIF(), permite devolver uno de dos valores dependiendo de la evaluacion de una condicion.
--Realizar un script que permita mostrar la descripcion del tipo de vendedor: 1 (corporativo), 2(por venta)
select
V.Cod_Ven as CODIGO, V.Nom_Ven +SPACE(1)+V.Ape_Ven AS VENDEDOR, V.Tipo_Ven AS [TIPO DE VENDEDOR],
IIF(V.Tipo_Ven=1,'CORPORATIVO','POR VENTA') as [DESCRIPCION TIPO DE VENDEDOR]
from tblVendedor V
go

--La funcion ASCII(), devuelve el codigo ascii que represente al caracter.
--Realizar un script que muestre el codigo ascii de un caracter determinado.
declare @caracter char(1) 
set @caracter ='ñ'
select @caracter as CARACTER, ASCII(@caracter) as [ASCII]
go
--La funcion LTRIM(), quita los espacios en blanco del lado izquierdo de una cadena de texto.
--Ejemplo:
declare @nombre varchar(15), @apellido varchar(20)
set @nombre='BRYAN'
set @apellido='          GONZALEZ'
select @apellido +' '+ @nombre as [NOMBRE NORMAL], LTRIM( @apellido +' '+ @nombre) AS [FUNCION LTRIM]
GO
--La funcion RTRIM(), quita los espacios en blanco del lado derecho de una cadena de texto.
--Ejemplo:
declare @nombre varchar(15), @apellido varchar(50)
set @apellido='GONZALEZ          '
select @apellido [NOMBRE NORMAL], RTRIM(@apellido) AS [FUNCION RTRIM]
GO
--la funcion char(), permite convertir un codigo ascii en un caracter.
select 241 as [ASCII], CHAR(241) AS CARACTER
GO
--la funcion concat(), permite unir dos o mas cadenas.
--ejemplo:
select CONCAT(Nom_Ven,SPACE(1),Ape_ven) as VENDEDOR from  tblVendedor
go

--la funcion replace() permite cambiar un caracter dentro de una cadena de texto por otro, ejemplo:
select c.Cod_Cli as CODIGO, REPLACE(c.Cod_Cli,'0','X') as [CODIGO REEMPLAZADO] from tblCliente C
go
--la funcion substring(), permite devolver una cadena de caracteres desde una posicion inicial hasta una posicion final.
--Ejemplo: separar del codigo de cliente el caracter y la parte numerica.
select c.Cod_Cli as 'CODIGO ORIGINAL',SUBSTRING(c.Cod_Cli,1,1) as 'CARACTER', SUBSTRING(C.Cod_Cli,2,3) AS 'PARTE NUMERICA'
from tblCliente as C
go
--la funcion replicate(), permite asignar uno o mas caracteres en una cadena de texto.
--Ejemplo: Realizar un script que permita asignar numeros al lado izquierdo de un numero entero, a partir del estado de factura.
select F.Est_Fac AS [ESTADO FACTURA] , REPLICATE('0',3) + f.Est_Fac as [ESTADO FACTURA CON FORMATO]  from tblFactura F
go
declare @i int
select @i=4-LEN(Est_Fac) from tblFactura
print cast(@i as varchar(10))
--la funcion left() devuelve una cadena de caracteres desde el lado izquierdo de una cadena de texto.
--ejemplo: Realizar un script que muestre el primer caracter del codigo de los clientes
select c.Cod_Cli as CODIGO, LEFT(c.Cod_Cli,1) as [LETRA INICIAL] from tblCliente C
go
--la funcion right() devuelve una cadena de caracteres desde el lado izquierdo de una cadena de texto.
--Ejemplo: Realizar un script que permita asignar numeros al lado izquierdo del estado de factura.
select Num_Fac as [NUMERO FAC.],Est_Fac as [ESTADO FAC.], RIGHT('0000'+LTRIM(RTRIM(Est_Fac)),4) as [ESTADO FAC. CON FORMTATO] from tblFactura
go

--la funcion reverse(), devuelve una cadena de caracteres en orden inverso.
--Realizar un script que muestre el codigo de los clientes de manera inversa:
select C.Rso_Cli as CLIENTE, C.Cod_Cli as CODIGO, REVERSE(C.Cod_Cli) as [CODIGO INVERSO] from tblCliente C
go
--la funcion UPPER(), convierte una cadena de caracteres a mayusculas.
--Ejemplo:
DECLARE @CORREO varchar(50);
SET @CORREO='gonzalezzbryan220@gmail.com';
PRINT  'EL CORREO ES: '+ UPPER(@CORREO);
GO
--la funcion LOWER(), convierte una cadena de caracteres a minusculas.
--Ejemplo:
DECLARE @CORREO varchar(50);
SET @CORREO='GONZALEZZBRYAN220@GMAIL.COM';
PRINT 'EL CORREO ES: '+ LOWER(@CORREO);
GO
--la funcion LEN() regresa el numero total de caracteres en una cadena de texto.
--Mostrar el nombre completo de cada vendedor y una columna que muestre el total de caracteres en cada nombre:
select CONCAT(V.Nom_Ven,SPACE(1),V.Ape_Ven) as VENDEDOR, LEN(V.Nom_Ven + SPACE(1)+v.Ape_Ven) as [TOTAL DE CARACTERES] from tblVendedor V
go