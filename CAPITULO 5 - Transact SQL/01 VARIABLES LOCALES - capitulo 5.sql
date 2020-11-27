/*
La programacion en Transact-SQL(T-SQL) permite extender el standard SQL, proporcionando la manera de emplear estructuras condicionales
o repetitivas sin la necesidad de un lenguaje de programacion adicional, utilizando T-SQL se pueden programar:
PROCEDIMIENTO ALMACENADOS (STORED PROCEDURE).
TRIGGERS.
FUNCIONES (FUNCTION).
SCRIPTS.
En T-SQL se pueden definir solo variables locales, ya que las variables globales solo se utilizan por SQL Server en procesos
por lotes, procedimientos almacenados, funciones, etc.
para asignarle un valor a una variable local se hace uso del operador 'SET'.
La declaracion de una variable local es de la siguiente manera:

DECLARE @nombreDeLaVariable TipoDato

		MULTIPLES DECLARACIONES:
DECLARE @nombreDeLaVariable1 TipoDato,
		@nombreDeLaVariable2 TipoDato,
		....,
		@nombreDeLaVariableN TipoDato

El formato para asignar un valor a una variable local es el siguiente:
SET @nombreDeLaVariable = Valor

Formato para la declaracion-asignacion de una variable local:

DECLARE @nombreDeLaVariable TipoDatos = Valor

Formato para la declaracion-asignacion de multiples variables:
DECLARE	@nombreDeLaVariable1 TipoDatos = Valor,
		@nombreDeLaVariable2 TipoDatos = Valor,
		...,
		@nombreDeLaVariableN TipoDatos = Valor

		EJEMPLOS:
*/
use VentasDB
go
--1.Desarrollar un Script que permita calcular el promedio de 4 notas de un alumno; Las notas estaran inicalizadas con un valor 
--determinado.
DECLARE @NombreAlumno varchar(50)='Bryan Enrique Gonzalez Zambrano',
		@Nota1 int =85,
		@Nota2 int =100,
		@Nota3 int=95,
		@Nota4 int=90,
		@promedio decimal(5,2)
		
--CALCULANDO EL PROMEDIO:
set @promedio=(@Nota1+@Nota2+@Nota3+@Nota4)/4.00
--Mostrando resultados:
print '***RESUMEN DE NOTAS***'
print '_____________________________'
print 'ESTUDIANTE: ' + @NombreAlumno
print 'NOTA 1: ' + cast(@Nota1 as char(2))
print 'NOTA 2: ' + cast(@Nota2 as char(3))
print 'NOTA 3: ' + cast(@Nota3 as char(2))
print 'NOTA 4: ' + cast(@Nota4 as char(2))
print '_____________________________'
print 'EL PROMEDIO ES : ' + cast(@promedio as char(5))
go
--2.Realizar una consulta que permita mostrar informacion de la tabla: "tblProducto".
--con tipo de unidad 'MLL', haciendo uso de variables locales.
declare @Unidad char(3)='MLL'
select * from tblProducto as P
where P.Unidades_Pro = @Unidad
go
--3.Utilizando la tabla: "tblfactura" realizar una consulta que permita asociar cada numero de factura con la razon social del cliente
--la consulta debera mostrar algo como:
-- El numero de factura : <NumeroFactura> tiene como cliente a <NombreCliente>
declare @factura varchar(5), @cliente varchar(15)
set @factura= 'FA003'
select @cliente= C.Rso_Cli from tblFactura as F
inner join tblCliente as C on C.Cod_Cli=F.Cod_Cli
where F.Num_Fac= @factura
print 'El numero de factura : ' + @factura +' tiene como cliente a: '+ @cliente
go