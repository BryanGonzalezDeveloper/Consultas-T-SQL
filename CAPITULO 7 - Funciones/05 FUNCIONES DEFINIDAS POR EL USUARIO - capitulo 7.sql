/*
FUNCIONES DEFINIDAS POR EL USUARIO:
Funciones escalares: Son funciones que devuelven un solo valor al ser invocadas, estas funciones luego se integran a sentencias como 
consultas, actualizaciones o eliminaciones.
FORMATO:

CREATE FUNCTION [PROPIETARIO].[NOMBRE_FUNCION]
(
    @parametro1 TipoDato,
	@parametro2 TipoDato,
	...
	@parametroN TipoDato
)
RETURNS TipoDatoRetornado
AS
BEGIN
<CODIGO_FUNCION>
    RETURN<EXPRESON_SALIDA>
	END
*/
use VentasDB
go
--1.Realizar una funcion que permita calcular el 12% de un monto.
IF OBJECT_ID('FN_CALCULARDESCUENTO') IS NOT NULL
BEGIN
DROP FUNCTION FN_CALCULARDESCUENTO
END
GO
CREATE FUNCTION dbo.FN_CALCULARDESCUENTO
(
    @Subtotal money,
	@Descuento decimal(18,2)
	)
RETURNS MONEY
AS
BEGIN
DECLARE @PORCENTAJE MONEY;
SET @PORCENTAJE=@Subtotal*@Descuento;
    RETURN @PORCENTAJE
END
GO
--Verificando la funcion:
select dbo.FN_CALCULARDESCUENTO(1000,.12) as [DESCUENTO] 
go
--Obtener el subtotal de monto de las facturas y aplicar un 25% de descuento.
use VentasDB
go

select
f.Num_Fac as [FACTURA],
f.Can_Ven as [CANTIDAD VENDIDA],
f.Pre_Ven as [PRECIO POR UNIDAD],
f.Can_Ven*f.Pre_Ven as [SUBTOTAL],
'25%' as [% DESCUENTO],
dbo.FN_CALCULARDESCUENTO(f.Can_Ven*f.Pre_Ven,.25) as [DESCUENTO]
from tblDetalle_Factura f
go

--2.Realizar una funcion que permita mostrar el nombre de un distrito a partir del codigo del mismo.
IF OBJECT_ID('FN_NombreDistrito') IS NOT NULL
BEGIN
DROP FUNCTION FN_NombreDistrito
END
GO
CREATE FUNCTION DBO.FN_NombreDistrito
(
    @codigo char(5)
)
RETURNS varchar(50)
AS
BEGIN
DECLARE @Distrito VARCHAR(50);
SELECT @Distrito= D.Nom_Dis FROM tblDistrito D
WHERE D.Cod_Dis=@codigo;
    RETURN @Distrito
END
GO
--Verificando funcion:
--Prueba 1:
DECLARE @CODIGO CHAR(5);
SET @CODIGO = 'D04';
SELECT DBO.FN_NombreDistrito(@CODIGO) AS 'NOMBRE DISTRITO', @CODIGO AS 'CODIGO DISTRITO'
GO
--Prueba 2:
select c.Cod_Cli CODIGO, C.Rso_Cli CLIENTE, dbo.FN_NombreDistrito(C.Cod_Dis) DISTRITO, C.Ruc_Cli  RUC from tblCliente c
go

--3.Realizar una funcion que permita mostra la fecha de facturacion en letras:
IF OBJECT_ID('FN_FechaFacturacion') IS NOT NULL
BEGIN
DROP FUNCTION FN_FechaFacturacion
END
GO
CREATE FUNCTION DBO.FN_FechaFacturacion
(
    @FECHA DATE
)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @FEC_LETRAS VARCHAR(100),@mes int, @mesLetras varchar(15);
set @mes=MONTH(@FECHA);
set @mesLetras=
case @mes
when 1 then 'ENERO'
when 2 then 'FEBRERO'
when 3 then 'MARZO'
when 4 then 'ABRIL'
when 5 then 'MAYO'
when 6 then 'JUNIO'
when 7 then 'JULIO'
when 8 then 'AGOSTO'
when 9 then 'SEPTIEMBRE'
when 10 then 'OCTUBRE'
when 1 then 'NOVIEMBRE'
when 12 then 'DICIEMBRE'
END

SET @FEC_LETRAS = CAST(DAY(@FECHA) AS char(2)) +' DE '+ @mesLetras+' DEL ' + CAST(YEAR(@FECHA) AS char(4))
    RETURN @FEC_LETRAS;

END
GO
--Verificar funcion:
select F.Num_Fac FACTURA, F.Fec_Fac 'FECHA FACTURA', dbo.FN_FechaFacturacion(F.Fec_Fac) 'FECHA CON LETRAS' from tblFactura F
go

--Comprobar funcion con la fecha actual:
SELECT dbo.FN_FechaFacturacion(GETDATE()) AS 'FECHA ACTUAL' 
GO

/*
Las funciones tabla en linea devuelven registros de una tabla como conjunto.
FOMRATO:

CREATE FUNCTION PROPIETARIO.NOMBRE_FUNCION
(
    @PARAMETRO1 TIPODATO,
	 @PARAMETRO2 TIPODATO,
	 ...,
	  @PARAMETRO_N TIPODATO
)
RETURNS TABLE
AS
RETURN(CONSULTA)
END
*/
use VentasDB
go
--1.Realizar una funcion que permita listar los productos:
IF OBJECT_ID('FN_ListaProductos') IS NOT NULL
BEGIN
DROP FUNCTION FN_ListaProductos
END
GO

CREATE FUNCTION dbo.FN_ListaProductos()
RETURNS TABLE AS 
RETURN
(
    SELECT P.Cod_Pro CODIGO, P.Des_Pro DESCRIPCION, P.Pre_Pro PRECIO, P.StockActual_Pro 'STOCK ACTUAL' FROM tblProducto P
)
GO
--verificando funcion:
select * FROM FN_ListaProductos()

--2.Realizar un listado que permita mostrar informacion de los clientes segun el nombre del distrito.
IF OBJECT_ID('FN_CLIENTESxDISTRITO') IS NOT NULL
BEGIN
DROP FUNCTION FN_CLIENTESxDISTRITO
END
GO
CREATE FUNCTION DBO.FN_CLIENTESxDISTRITO(@DISTRITO VARCHAR(50))
RETURNS  TABLE AS
RETURN
(
SELECT C.Cod_Cli CODIGO, C.Rso_Cli CLIENTE, C.Tel_Cli,D.Nom_Dis DISTRITO FROM tblDistrito D
INNER JOIN tblCliente C ON C.Cod_Dis=D.Cod_Dis
WHERE D.Nom_Dis=@DISTRITO
)
GO
--Verificando la funcion:
select * from FN_CLIENTESxDISTRITO('LA MOLINA')
GO


/*
Las funciones multisentencia devuelven los registros de una tabla como un conjunto.

CREATE FUNCTION PROPIETARIO.NOMBRE_FUNCION
(
    @parametro1 TipoDato,
	@parametro2 TipoDato,
	...
	@parametroN TipoDato
)
RETURNS @variable TABLE (argumento)
AS
BEGIN
    <CODIGO DE LA FUNCION>
    RETURN 
END
GO
*/
use VentasDB
go
--1.Realizar una funcion que permita mostrar los datos de la tabla distrito.
IF OBJECT_ID('FN_LISTADODISTRITO') IS NOT NULL
BEGIN
DROP FUNCTION FN_LISTADODISTRITO
END
GO

CREATE FUNCTION [dbo].FN_LISTADODISTRITO()
RETURNS @tabla TABLE 
(
	Codigo char(5),
	Nombre varchar(50)
)
AS
BEGIN
    INSERT INTO @tabla SELECT D.Cod_Dis CODIGO, D.Nom_Dis 'NOMBRE DISTRITO' FROM tblDistrito D
    RETURN 
END
GO
--Verificando la funcion:
select * from dbo.FN_LISTADODISTRITO()
go

--2.Realizar una funcion que permita consultar 2 columnas de las tablas: 'tblDistrito', 'tblCliente' y 'tblVendedor' desde una sola funcion.
IF OBJECT_ID('FN_ConsultaDCV') IS NOT NULL
BEGIN
DROP FUNCTION FN_ConsultaDCV
END
GO
CREATE FUNCTION dbo.FN_ConsultaDCV (@NombreTabla varchar(20))
RETURNS @matriz TABLE
(
CODIGO char(5),
DESCRIPCION varchar(60)
)
AS
BEGIN

IF(@NombreTabla='tblDistrito')
begin
insert into @matriz select d.Cod_Dis, d.Nom_Dis from tblDistrito d
end

else if(@NombreTabla='tblCliente')
begin
insert into @matriz select c.Cod_Cli, c.Rso_Cli from tblCliente c
end

else if(@NombreTabla='tblVendedor')
begin
insert into @matriz select v.Cod_Ven, v.Nom_Ven + SPACE(1) + v.Ape_Ven from tblVendedor v
end

else
begin 
insert into @matriz select '','EL NOMBRE DE LA TABLA NO ES VALIDO PARA ESTA FUNCION.'
end

RETURN
END
GO
--Verificando funcion para la tabla: 'tblDistrito'
select FN.CODIGO 'ID DISTRITO', FN.DESCRIPCION 'DISTRITO' from dbo.FN_ConsultaDCV('tblDistrito') FN
go
--Verificando funcion para la tabla: 'tblCliente'
select FN.CODIGO 'ID CLIENTE', FN.DESCRIPCION 'CLIENTE' from dbo.FN_ConsultaDCV('tblCliente') FN
GO
--Verificando funcion para la tabla: 'tblVendedor'
select FN.CODIGO 'ID VENDEDOR', FN.DESCRIPCION 'VENDEDOR' from dbo.FN_ConsultaDCV('tblVendedor') FN
GO
--Verificando la funcion para el nombre de una tabla no valida:
select * from dbo.FN_ConsultaDCV('MI_TABLA')
GO