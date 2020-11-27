--Se creara una base de datos de prueba para utilizar llaves foraneas (FOREIGN KEY) para establecer relacion entre 2 tablas

use master
go

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

use DB_PRUEBA
go
--CREACION DE TABLAS


if OBJECT_ID('tblMateria') is not null
begin
drop table tblMateria
end
create table tblMateria
(
Cod_Materia int not null primary key,
Nombre_Materia varchar(30) not null
)
go


if OBJECT_ID('tblEstudiante') is not null
begin
drop table tblEstudiante
end
create table tblEstudiante
(
ID_ESTUDIANTE int not null primary key,
Nombre varchar(100) not null,
Apellido varchar(100) not null,
Cod_Materia int not null
foreign key (Cod_Materia) references tblMateria
)
go
exec sp_columns 'tblMateria';