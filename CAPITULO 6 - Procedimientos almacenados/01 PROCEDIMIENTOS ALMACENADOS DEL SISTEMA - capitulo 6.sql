/*
Los procedimientos almacenados son un conjunto de instrucciones SQL que se ejecutan al ser llamdas por el nombre del procedimiento
los procedimientos se pueden crear para un uso temporal en una sesion o para uso global en todas las sesiones.
Existen 2 tipos de procedimiento alamcenado:
-Procedimientos almacenados del sistema.
-Procedimientos definidos por el programador.
Generalmente los procedimientos almacenados del sisteman tienen la nomenclatura: "SP_NombreProcedimiento" y son guardados en la base
datos "master".

*/
use VentasDB
go
--EJEMPLOS:
--1.Procedimiento almacenado del sistema que muestra los privilegios de las columnas existentes en la tabla: "tblProducto"
SP_COLUMN_PRIVILEGES 'tblProducto'
go
--2.Procedimiento almacenado del sistema que muestra las columnas existentes en la tabla: "tblProducto"
SP_COLUMNS 'tblProducto'
go
--3.Procedimiento almacenado que muestra la informacion del producto con codigo 'P001'
exec SP_EXECUTESQL N'SELECT * FROM tblProducto WHERE Cod_Pro=@codigo',
N'@codigo char(5)',
@codigo='P001'
go

--4.Procedimiento almacenado del sistema que devuelva una lista de nombres de atributos y sus valores correspondientes en SQL Server,
--la puerta de enlace de la base de datos o el origen de datos subyacente del servidor activo.
exec sp_server_info 
go
--5.Procedimiento almacenado que muestre las tablas creadas dentro de la base de datos.
EXEC sp_tables 
go
--6.Implementar un procedimiento almacenado que permita listar los registros de la tabla: tblProducto
--USANDO EXECUTE:
declare @X varchar(max)
set @X='select * from tblProducto'
execute (@X)
go
--Utilizando 'SP_EXECUTESQL'
declare @X nvarchar(max)
set @X='select * from tblProducto'
EXEC SP_EXECUTESQL @X
GO