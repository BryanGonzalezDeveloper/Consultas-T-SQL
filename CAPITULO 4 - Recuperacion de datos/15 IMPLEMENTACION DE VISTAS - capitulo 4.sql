use 
VentasDB
go
--Las vistas en sql server, son una especie de tabla virtual, donde se puede almacenar de manera permanente la informacion
--de una consulta realizada, las filas y columnas que conforman la vista pueden provenir de una o mas tablas dentro de una
--base de datos. El tipo de datos y nombre de columna dentro de una vista seran igual que la tabla original.
--FORMATO:
--CREATE VIEW Nombre_Vista
--as
--sentencias
--GO

--Ejemplos:
--1.Implementar una vista que muestre informacion de las tablas: "tblVendedor" y "tblDistrito".

--Validar existencia de la vista.
if OBJECT_ID('V_ListaVendedor') is not null
begin
drop view V_ListaVendedor
end
go
create view V_ListaVendedor
as
select (V.Nom_Ven + SPACE(1) + V.Ape_Ven) as VENDEDOR,V.Cod_Ven as [CODIGO DE VENDEDOR],
V.Sue_Ven as SUELDO, V.FecInicio_Ven as [FECHA DE INICIO], D.Nom_Dis as DISTRITO
from tblVendedor as V
inner join tblDistrito as D
on D.Cod_Dis=V.Cod_Dis
go
--SE VERIFICA QUE LA VISTA MUESTRE LA INFORMACION CORRECTA:
select * from V_ListaVendedor
go
--Las vistas pueden proporcionar informacion como si fueran tablas. Por ejemplo:
--1.Mostrar los vendedores correspondientes al distrito: "LA MOLINA".
select * from V_ListaVendedor as V
where V.DISTRITO='LA MOLINA'
go
--2.Mostrar los vendedores cuyo inicio fue en los años 90's.
select * from V_ListaVendedor as V
where YEAR( V.[FECHA DE INICIO]) between 1990 and 1999
go

--Haciendo uso de las tablas:
--tblFactura
--tblDetalleFactura
--tblCliente
--tblProducto
--Implementar una vista que permita mostrar el numero de factura, nombre del cliente, descripcion del producto y subtotal facturado.

if OBJECT_ID('V_DetallesFactura') is not null
begin
drop view V_DetallesFactura
end
go
create view V_DetallesFactura
as
select
F.Num_Fac as [NUMERO DE FACTURA], C.Rso_Cli as CLIENTE, P.Des_Pro as [DESCRIPCION PRODUCTO],(DF.Can_Ven*DF.Pre_Ven) AS [SUBTOTAL]
from tblFactura as F
inner join tblCliente as C on C.Cod_Cli=F.Cod_Cli
inner join tblDetalle_Factura as DF on DF.Num_Fac=F.Num_Fac
inner join tblProducto as P on P.Cod_Pro=DF.Cod_Pro
go
--Se verifica que la vista muestre los resultados esperados:
select * from V_DetallesFactura
go
--Listar las facturas cuyo subtotal se encuentre entre 50 y 100.
select * from V_DetallesFactura as DF
where DF.SUBTOTAL between 30 and 100
go
--Listar las facturas del cliente: "FINSETH".
select * from V_DetallesFactura as D
where D.CLIENTE='FINSETH'
go


--Las vistas permiten dar mantenimiento de forma automatica a los registros de una tabla, realizando las operaciones basicas de:
--INSERT, UPDATE y DELETE.

--Implementacion de una vista para dar mantenimiento a la tabla: "tblProducto".
if OBJECT_ID('V_MantenimientoProducto') is not null
begin
drop view V_MantenimientoProducto
end
go
create view V_MantenimientoProducto
as
select * from tblProducto
go
--Se verifica que la vista funcione correctamente:
select * from V_MantenimientoProducto
--Se realiza una insercion de un registro a la tabla: tblProducto a traves de la vista realizada anteriormente.
insert into V_MantenimientoProducto values
('P021','CUADERNO SCRIBE DOBLE RAYA',27.50,75,50,'UNI','3','V')
go
--Se consulta la tabla: "tblProducto" para comprobar que el registro se haya realizado correctamente.
select * from tblProducto
go

--Actualizar el valor de importacion a 'F' al producto con codigo: 'P021'.
update V_MantenimientoProducto set Importacion_Pro='F'
where Cod_Pro='P021'
go
--Eliminacion del registro con codigo de producto igual a: P021.
delete V_MantenimientoProducto
where Cod_Pro='P021'
go
--Se verifica que el registro se haya eliminado correctamente:
select * from tblProducto
go
--Tambien se puede verificar de la forma:
select * from V_MantenimientoProducto
go

--2.Implementar una vista horizontal por cada estado de factura
if OBJECT_ID('V_Facturas1') is not null
begin
drop view V_Facturas1
end
go
create view V_Facturas1 
as
select F.* from tblFactura as F
where F.Est_Fac='1'
go
if OBJECT_ID('V_Facturas2') is not null
begin
drop view V_Facturas2
end
go
create view V_Facturas2
as
select F.* from tblFactura as F
where F.Est_Fac='2'
go
if OBJECT_ID('V_Facturas3') is not null
begin
drop view V_Facturas3
end
go
create view V_Facturas3
as
select F.* from tblFactura as F
where F.Est_Fac='3'
go
--Mostrar la vista horizontal que muestra los estados de factura:
select * from V_Facturas1
select * from V_Facturas2
select * from V_Facturas3
go

--Crear una vista de los clientes que permita mostrar los siguientes datos: Nombre completo, codigo, descripcion del distrito y telefono.
if OBJECT_ID('V_DatosCliente') is not null
begin
drop view V_DatosCliente
end
go
create view V_DatosCliente
as
select 
Rso_Cli as CLIENTE, Cod_Cli as CODIGO, D.Nom_Dis as DISTRITO, Tel_Cli as TELEFONO
from tblCliente as C
inner join tblDistrito as D on D.Cod_Dis=C.Cod_Dis
go
select * from V_DatosCliente
go