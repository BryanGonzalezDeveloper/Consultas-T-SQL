use
VentasDB
go

--Las consultas externas son aquellas donde la equivalencia entre campos adquiere importancia, son declaras utilizando
--algunas de las siguientes palabras reservadas de sql server.
--LEFT JOIN , LEFT OUTER JOIN, RIGHT JOIN, RIGHT OUTER JOIN.

--Poseen el siguiente formato:

--SELECT <ALIAS.NOMBRE_CAMPO> AS <NOMBRE_CABECERA> FROM <NOMBRE_TABLA> AS <ALIAS>
--<LEFT | RIGHT > JOIN
--ORDER BY <NOMBRE_CAMPO> <ASC | DESC>
--GO

--Utilizando la sentencia left join. Crear un listado que combinando las tablas "tblVendedor" y "tblDistrito" muestre un listado
--de la forma:	
-- [Cod_Dis]	[Nom_Dis]	[Cod_Ven]	[Nom_Ven]	[Ape_Ven]	[Sue_Ven]  [FecInicio_Ven]  [Tipo_Ven]	[Cod_Dis]
select * from tblDistrito as D 
left join tblVendedor as V on D.Cod_Dis=V.Cod_Dis
go
--Las 2 primeras columnas corresponden a la tabla "tblDistrito" por lo tanto muestran toda su informacion a pesar de no contar 
--con vendedores registrados. En cambio en la tabla "tblVendedor" comienza a partir de la columna 3 y muestra valores nulos en
-- los distritos donde no existen registros asociados a un vendedor.

--EJERCICIO 2: Utilizando las tablas: "tblVendedor" y "tblDistrito". y la sentencia right join muestra un listado de la siguiente manera:
--[Cod_Ven]	[Nom_Ven]	[Ape_Ven]	[Sue_Ven]	 [FecInicio_Ven]  [Tipo_Ven]	[Cod_Dis]	[Cod_Dis]	[Nom_Dis]

select * from tblVendedor as V
right join tblDistrito as D on V.Cod_Dis=D.Cod_Dis
go

--Una consulta de tipo "Full join" regresara filas de 2 tablas, asi no tengan asociacion.
--Ejercicio 3: Utilizan la sentencia "Full join" en las tablas: "tblVendedor" y "tblDistrito".

select * from tblDistrito as D
full join tblVendedor as V
on V.Cod_Dis=D.Cod_Dis
go
