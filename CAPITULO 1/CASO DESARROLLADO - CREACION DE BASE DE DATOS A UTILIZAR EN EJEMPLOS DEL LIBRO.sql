--DESARROLLO DE BASE DE DATOS EN LA QUE SE REALIZARAN ALGUNOS DE LOS EJEMPLOS Y CASOS DESARROLLADOS, PROPUESTOS EN EL LIBRO.
--LA BASE DE DATOS SERA LLAMADA: VentasDB
use master
go
set dateformat 
YMD
go

if DB_ID('VentasDB') is not null
begin
drop database VentasDB
end
go

create database VentasDB
--SI NO DESEAS CREAR DIRECTAMENTE UN ARCHIVO PRIMARIO DE LA BASE DE DATOS IGNORA LO SIGUIENTE.

--DESDE AQUI --->>>
on primary
(
name='VentasDB',
--EN FILENAME, ESPECIFICARE LA RUTA DE UN DISCO EXTRAIBLE, CADA QUIEN DEBE INGRESAR LA RUTA DONDE DEBAN SER GUARDADOS
--LOS ARCHIVOS DE LA BASE DE DATOS
filename='D:\SQL\Libro\VentasDB.mdf',
size =15 mb,
maxsize= 150 mb,
filegrowth= 10%
)
go
--		<<<---HASTA AQUI.
 use VentasDB
 go
if OBJECT_ID('tblDistrito') is not null
begin
drop table tblDistrito 
end
go
create table tblDistrito
(
Cod_Dis char(5) not null primary key,
Nom_Dis varchar(50) not null
)
go
if OBJECT_ID('tblVendedor') is not null
begin
drop table tblVendedor
end
go
create table tblVendedor
(
Cod_Ven char(3) not null primary key,
Nom_Ven varchar(20) not null,
Ape_Ven varchar(20) not null,
Sue_Ven money not null,
FecInicio_Ven date not null,
Tipo_Ven varchar(10) not null,
Cod_Dis char(5) not null references tblDistrito
)
go

if OBJECT_ID('tblCliente') is not null
begin
drop table tblCliente
end
go
create table tblCliente
(
Cod_Cli char(5) not null primary key,
Rso_Cli varchar(30) not null,
Dir_Cli varchar(100) not null,
Tel_Cli varchar(15) not null,
Ruc_Cli varchar(11) null,
Cod_Dis char(5) not null references tblDistrito,
Fec_Reg date not null,
Tipo_Cli varchar(10) not null,
Condicion_Cli varchar(30) not null
)
go

if OBJECT_ID('tblProveedor') is not null
begin
drop table tblProveedor 
end
go
create table tblProveedor
(
Cod_Prv char(5) not null primary key,
Rso_Prv varchar(80) not null,
Dir_prv varchar(100) not null,
Tel_Prv varchar(15) null,
Cod_Dis char(5) not null references tblDistrito,
Rep_Prv varchar(80) not null
)
go


if OBJECT_ID('tblFactura') is not null
begin
drop table tblFactura
end
go
create table tblFactura
(
Num_Fac varchar(12) not null primary key,
Fec_Fac date not null,
Cod_Cli char(5) not null references tblCliente,
Fec_Can date not null,
Est_Fac varchar(10) not null,
Cod_Ven char(3) not null references tblVendedor,
POR_IGV decimal not null
)
go

if OBJECT_ID('tblOrden_Compra') is not null
begin
drop table tblOrden_Compra
end
go
create table tblOrden_Compra
(
Num_Oco char(5) not null primary key,
Fec_Oco date not null,
Cod_Prv char(5) not null references tblProveedor,
Fec_Atendion date not null,
Est_Oco char(1) not null
)
go

if OBJECT_ID('tblProducto') is not null
begin
drop table tblProducto
end
go
create table tblProducto
(
Cod_Pro char(5) not null primary key,
Des_Pro varchar(50) not null,
Pre_Pro money not null,
StockActual_Pro int not null,
StockMinimo_Pro int not null,
Unidades_Pro varchar(30) not null,
Linea_Pro varchar(30) not null,
Importacion_Pro varchar(10) not null
)
go

if OBJECT_ID('tblDetalle_Factura') is not null
begin
drop table tblDetalleFactura
end
go
create table tblDetalle_Factura
(
Num_Fac varchar(12) not null references tblFactura,
Cod_Pro char(5) not null references tblProducto,
Can_Ven int not null,
Pre_Ven money not null
primary key(Num_Fac,Cod_Pro)
)
go

if OBJECT_ID('tblDetalle_Compra') is not null
begin
drop table tblDetalle_Compra
end
go
create table tblDetalle_Compra
(
Num_Oco char(5) not null references tblOrden_Compra,
Cod_Pro char(5) not null references tblProducto,
Can_Det int not null
primary key(Num_Oco,Cod_Pro)
)
go

if OBJECT_ID('tblAbastecimineto') is not null
begin
drop table tblAbastecimiento
end
go
create table tblAbastecimineto
(
Cod_Prv char(5) not null references tblProveedor,
Cod_Pro char(5) not null references tblProducto,
Pre_Aba money not null
primary key (Cod_Prv, Cod_Pro)
)
go
