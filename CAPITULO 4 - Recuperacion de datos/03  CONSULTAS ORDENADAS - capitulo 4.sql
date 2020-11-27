use
VentasDB
go

--CONSULTAS ORDENADAS.
--Este tipo de consultas permite mostrar informacion ordenada a partir de un campo especificado.

--FORMATO:
--SELECT <ALL> <*> 
--<DISTINCT>
--FROM <NOMBRE_TABLA> AS <ALIAS>
--ORDER BY <NOMBRE_CAMPO> <ASC | DESC>
--GO

--Donde a una consulta basica o distinguida se agrega la sentencia "ORDER BY" que ordenara los datos de acuerdo al
--campo especificado (NOMBRE_CAMPO). Los datos se pueden ordernar de manera ascendente (ASC) o de manera
--descendente (DESC) pero no ambas.



--EJEMPLO 1 : Se tiene como referencia a la tabla : tblCliente
---Se pide realizar una consulta para mostrar todos los campos y columnas de los clientes
--ordenados a partir de su razon social de manera ascendente.

--PRIMERA FORMA:
select *  from tblCliente
order by Rso_Cli asc
go

--SEGUNDA FORMA:
--Cuando no se especifique si el orden se realizara de manera ascendente (asc) o descendente (desc).
--Se asume por defecto que los datos deber ser ordenados de manera ascendente (asc)

select * from tblCliente
order by Rso_Cli 
go


--EJEMPLO 2:
--Ordenar la informacion de los clientes en base al año de la fecha de registro (Fec_Reg) de forma descendente, debido
--a la posible repeticion de datos, ordenar por meses de forma ascendente.

--Cuando existen 2 criterios de ordenacion el segundo se realiza en base al primero de la siguiente manera:
select * from tblCliente
order by YEAR(Fec_Reg) desc, MONTH(Fec_Reg)asc
go