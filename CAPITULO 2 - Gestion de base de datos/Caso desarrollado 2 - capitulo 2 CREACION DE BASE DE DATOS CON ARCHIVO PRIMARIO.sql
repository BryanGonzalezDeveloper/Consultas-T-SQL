
--La ruta especificada donde se alojan los archivos la debes reemplazar por la ruta que tu elijas.
--En mi caso los archivos se alojaran en la ruta -->  D:\SQL\Libro\

use master
go

if DB_ID('Ventas') is not null
begin
drop database Ventas
end

create database Ventas 
on primary
(
name='DB_Ventas',
filename= 'D:\SQL\Libro\DB_Ventas.mdf',
size=50MB, maxsize=150MB, filegrowth=20%
)
go

use Ventas
go

--Visualizar la base de datos mediante un listado

select * from sys.sysdatabases My_DB
where My_DB.name= 'Ventas'
go

--visualizar los archivos que componen la base de datos

exec sp_helpdb 'Ventas';