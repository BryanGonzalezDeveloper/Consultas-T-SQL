use VentasDB
go
--se utilizara la base de datos creada en el capitulo 1 llamada: VentasDB para seguir trabando en los ejemplos
--de este capitulo.

--LISTAR TODOS LOS REGISTROS DE LA TABLA: tblProducto.

--PRIMERA FORMA: Es la mas sencilla de todas. Posee el formato:

--SELECT * FROM <NOMBRE_TABLA>
--GO

--Donde el asterisco (*) indica que se quieren consultar todas las filas y 
--columnas existentes en la tabla especificada.

select * from tblProducto
go

--SEGUNDA FORMA.


--POSEE EL SIGUIENTE FORMATO:

--SELECT ALL * FROM <NOMBRE_TABLA>
--GO

--Donde "ALL" hace referencia a que se quieren consultar todas las filas en la tabla y el asterisco (*) hace
--referencia a todas las columnas.
select all * from tblProducto
go


--TERCERA FORMA.
--Posee el formato:

--SELECT <ALIAS>.* FROM <NOMBRE_TABLA> AS <ALIAS>
--GO

--AL NOMBRE DE LA TABLA SE LE ASIGNA UN ALIAS LLAMADO "P".  PARA HACER MAS RAPIDA LA IDENTIFICACION DE LOS CAMPOS
select p.* from tblProducto as p
go



--CUARTA FORMA.

--FORMATO:

--SELECT <NOMBRE_TABLA>.* FROM <NOMBRE_TABLA>
--La forma de hacer una consulta cuando no se asigna un alias, se puede realizar indicando el nombre de la tabla. 
--para de igual forma consultar todas las filas y columnas.

select tblProducto.* from tblProducto
go