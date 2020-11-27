--SE CREARA UNA BASE DE DATOS DE PRUEBA LLAMADA : --> DB_VENTAS  EN LA CUAL SE LLEVARA A CABO LA IMPLEMENTACION DE ESQUEMAS 
--PARA TENER UNA MAYOR ORGANIZACION AL MOMENTO DE MANIPULAR LOS DATOS ALMCEANADOS EN LAS TABLAS.
--Este ejemplo fue elaborado en base al libro: PROGRAMACION TRANSACT CON SQL SERVER.

use master
go
set dateformat YMD
go

if db_id('DB_VENTAS') is not null
begin 
drop database DB_VENTAS
end

create database DB_VENTAS
on primary
(
name='DB_VENTAS',
filename='D:\SQL\Libro\DB_VENTAS.mdf',
size= 15mb, maxsize=250mb, filegrowth=15%
)
go
use DB_VENTAS
go
--Incia la creacion de los esquemas:
if SCHEMA_ID('COMPRAS') is not null
begin
drop schema COMPRAS
end
go

create schema COMPRAS authorization DBO
go


if SCHEMA_ID('VENTAS') is not null
begin
drop schema VENTAS
end
go
create schema VENTAS authorization DBO
go

if SCHEMA_ID ('RRHH') is not null
begin
drop schema RRHH
end
go

create schema RRHH authorization DBO
go
if OBJECT_ID('RRHH.Distrito') is not null
begin
drop table RRHH.Distrito
end
create table RRHH.Distrito
(
Cod_Dis char(5) not null primary key,
Nom_dis varchar(30) not null
)
go
if OBJECT_ID('RRHH.Vendedor') is not null
begin
drop table RRHH.Vendedor
end
create table RRHH.Vendedor
(
Cod_Ven char(3) not null primary key,
Nom_Ven varchar(25) not null,
Ape_ven varchar(25) not null,
Sueldo_ven decimal(10,2) not null,
Fin_ven date not null,
tipo_ven varchar(30) not null,
Cod_Dis char(5) not null references RRHH.Distrito
)
go
if OBJECT_ID('VENTAS.Cliente') is not null
begin
drop table VENTAS.Cliente
end
create table VENTAS.Cliente
(
Cod_cli char(5) not null primary key,
RFC_Cli char(13) not null,
Dir_Cli varchar(100) not null,
Tlf_Cli varchar(15) not null,
Cod_Dis char(5) not null references RRHH.Distrito,
Fec_reg date not null,
Tipo_Cli varchar(10) not null,
Con_Cli varchar(30) not null
)
go

if OBJECT_ID('COMPRAS.Proveedor') is not null
begin
drop table COMPRAS.Proveedor
end
create table COMPRAS.Proveedor
(
Cod_Prv char(5) not null primary key,
Rso_Prv varchar(80) not null,
Dir_Prv varchar(100) not null,
Tel_prv varchar(15)  null,
Cod_Dis char(5) not null references RRHH.Distrito,
Rep_Prv varchar(80) not null
)
go

if OBJECT_ID('VENTAS.Factura') is not null
begin
drop table VENTAS.Factura
end
create table VENTAS.Factura
(
Num_Fac varchar(12) not null primary key,
Fec_Fac date not null,
Cod_Cli char(5)not null references VENTAS.Cliente,
Fec_Can date not null,
Est_Fac varchar(10) not null,
Cod_Ven char(3) not null references RRHH.Vendedor,
Por_Igv decimal not null
)
go

if OBJECT_ID('COMPRAS.Orden_Compra') is not null
begin 
drop table COMPRAS.Orden_Compra
end
create table COMPRAS.Orden_Compra
(
Num_Ocom char(5) not null primary key,
Fec_Ocom date not null,
Cod_prv char(5) not null references COMPRAS.Proveedor,
Fat_Ocom date not null,
Est_Ocom char(1) not null
)
go
if OBJECT_ID('COMPRAS.Producto') is not null
begin
drop table COMPRAS.Producto
end
create table COMPRAS.Producto
(
Cod_Pro char(5) not null primary key,
Des_Pro varchar(50) not null,
Pre_Pro money not null,
Sac_Pro int not null,
Smi_Pro int not null,
Uni_Pro varchar(30) not null,
Lin_Pro varchar(30) not null,
Imp_Pro varchar(10) not null
)
go

if OBJECT_ID('VENTAS.Detalle_Factura') is not null 
begin
 drop table VENTAS.Detalle_Factura
 end
 create table VENTAS.Detalle_Factura
 (
 Num_Fac varchar(12) not null references VENTAS.Factura,
 Cod_Pro char(5) not null references COMPRAS.Producto,
 Can_Det int not null,
 Pre_Ven money not null
 Primary key(Num_Fac,Cod_Pro)
 )
 go
 
 if OBJECT_ID('COMPRAS.Detalle_Compra') is not null
 begin
 drop table COMPRAS.Detalle_Compra
 end
 create table COMPRAS.Detalle_Compra
 (
 Num_Ocom char(5) not null references COMPRAS.Orden_Compra,
 Cod_Pro char(5) not null references COMPRAS.Producto,
 Can_Det int not null
 primary key(Num_Ocom,Cod_Pro)
 )
 go

 if OBJECT_ID('COMPRAS.Abastecimiento') is not null
 begin
 drop table COMPRAS.Abastecimiento
 end
 create table COMPRAS.Abastecimiento
 (
 Cod_Prv char(5) not null references COMPRAS.Proveedor,
 Cod_Prod char(5) not null references COMPRAS.Producto,
 Pre_Aba money not null
 primary key(Cod_Prv,Cod_Prod)
 )
 go
