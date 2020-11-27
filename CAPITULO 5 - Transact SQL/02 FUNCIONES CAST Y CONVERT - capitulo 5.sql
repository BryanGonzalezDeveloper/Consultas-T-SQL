/*
Las funciones CAST() Y CONVERT(), generalmente se realizan cuando se tiene que pasar de un tipo de dato a otro.
Una conversion se realiza normalmente cuando una funcion requiere un tipo especial de dato como parametro.
FORMATO:
CAST( EXPRESION | VARIABLE AS TIPO_DATO)
CONVERT(TIPO_DATO, EXPRESION | VARIABLE)
Ejemplos:
*/
--1.Se tiene un monto registrado en la variable local @monto de 1250.75 y se necesita mostrarlo al usuario por medio de la funcion 
--print. Muestralo de maneras diferentes utilizando las funciones CAST() Y CONVERT().
--Primera version:
declare @monto money=1250.75
select @monto as [VALOR DE MONTO]
go
--Segunda version:
declare @monto money=1250.75
print 'EL MONTO INGRESADO ES: ' + cast(@monto as varchar(7))
go
--Tercera version:
declare @monto money=1250.75
print 'EL MONTO INGRESADO ES: ' + convert(varchar(7), @monto)
go
--Cuarta version:
declare @monto money=1250.75
print 'EL MONTO INGRESADO ES: ' + str(@monto)/*La funcion STR no precisa decimales, ademas adiciona espacios*/
go