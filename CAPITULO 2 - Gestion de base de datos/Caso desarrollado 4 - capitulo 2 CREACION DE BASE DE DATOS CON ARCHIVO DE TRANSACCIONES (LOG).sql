--CASO DESARROLLADO 4 --> CREACION DE BASE DE DATOS CON ARCHIVO DE TRANSACCIONES (LOG)

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
filename='D:\SQL\Libro\DB_VENTAS.mdf',
size=50MB, maxsize=150MB, filegrowth=20%
)
log on
(
name='DB_VentasLOG',
filename='D:\SQL\Libro\DB_VENTAS_LOG.ldf',
size= 5MB , maxsize=50MB , filegrowth=10%
)
go

--visualizar la base de datos mediante un listado

select * from sys.sysdatabases MY_DB
where MY_DB.name='Ventas'
go

--visualizar archivos que componen la base de datos
exec sp_helpdb 'Ventas';