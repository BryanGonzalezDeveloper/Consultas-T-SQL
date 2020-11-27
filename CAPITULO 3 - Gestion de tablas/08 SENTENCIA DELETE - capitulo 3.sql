use DB_VENTAS
go
--Implementar la sentencia delete para la manipulacion de datos en tablas.
--En este ejemplo es de nivel basico, se seguiran realizando las sentencias en la tabla "Producto".

--La sentencia delete permite eliminar registros especificados de una tabla. Los unicos registros que no es posible eliminar
--de manera directa son aquellos asociados a otras tablas, debido a que se rompe la integridad.
--La estructura de la sentencia DELETE es la siguiente:

--DELETE <FROM> <Tabla>
--WHERE <Condicion>
--GO

--Ejemplos:

--ELIMINAR TODOS LOS REGISTROS DE LA TABLA PRODUCTO DONDE EL STOCK ACTUAL SEA INFERIOR A 50.
delete from Producto
where Sac_Pro<50
go

--ELIMINAR TODOS LOS REGISTROS DE LA TABLA PRODUCTO.
delete from Producto
go

--ELIMINAR TODOS LOS REGISTROS DE LA TABLA PRODUCTO. USANDO LA SENTENCIA TRUNCATE
truncate table producto
go