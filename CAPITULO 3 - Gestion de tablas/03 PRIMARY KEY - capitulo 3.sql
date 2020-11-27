--SE CREA UNA TABLA PARA AÑADIR LA LLAVE PRIMARIA (PRIMARY KEY) DE 3 FORMAS DIFERENTES, PARA ELLO SE CREA LA BASE DE DATOS
--DB_PRUEBA 

if DB_ID('DB_PRUEBA') is not null
begin
drop database DB_PRUEBA
end

create database DB_PRUEBA
on primary
(
name='DB_PRUEBA',
filename='D:\SQL\Libro\DB_PRUEBA.mdf',
size=10mb, maxsize=50mb, filegrowth=10%
)
go

use
DB_PRUEBA
go

--AGREGAR PRIMARY KEY FORMA #1

if OBJECT_ID('tblPrueba') is not null
begin
drop table tblPrueba
end
create table tblPrueba
(
 ID_ESTUDIANTE int not null primary key,
 nombre varchar(100) not null,
 apellido varchar(100) not null
 )
 go

-- visualizar detalles de los campos en nuestra tabla:
exec sp_columns 'tblPrueba';

--AGREGAR PRIMARY KEY FORMA #2
if OBJECT_ID('tblPrueba') is not null
	begin
	drop table tblPrueba
end

create table tblPrueba
(
ID_ESTUDIANTE int not null,
Nombre varchar(100) not null,
Apellido varchar(100) not null

PRIMARY KEY (ID_ESTUDIANTE)
)
go
-- visualizar detalles de los campos en nuestra tabla:
exec sp_columns 'tblPrueba';

--AGREGAR PRIMARY KEY FORMA #3

if OBJECT_ID('tblPrueba') is not null
	begin
	drop table tblPrueba
end
create table tblPrueba
(
ID_ESTUDIANTE int not null,
Nombre varchar(100) not null,
Apellido varchar(100) not null
)
go

alter table tblPrueba
add primary key (ID_ESTUDIANTE)
go

--VISUALIZAR DETALLES DE LOS CAMPOS EN LA TABLA:
exec sp_columns 'tblPrueba';