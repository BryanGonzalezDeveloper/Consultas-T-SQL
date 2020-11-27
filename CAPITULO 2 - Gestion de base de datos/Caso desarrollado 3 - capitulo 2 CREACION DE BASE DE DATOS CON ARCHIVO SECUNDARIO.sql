
--CASO DESARROLLADO 3 --> Creacion de base de datos con archivo secundario.

--Los archivos de bases de datos sql poseen las siguientes extensiones:
	--Archivo primario = 'NOMBRE_ARCHIVO.mdf'
	--Archivo secundario = 'NOMBRE_ARCHIVO.ndf'
	--Archivo de transacciones (LOG) = 'NOMBRE_ARCHIVO.ldf'

	use master
	go

	if DB_ID('Ventas') is not null
	begin
	drop database Ventas
	end
Create database Ventas
on primary
(
name='DB_Ventas',
filename='D:\SQL\Libro\DB_Ventas.mdf',
size=50MB, maxsize=150MB, filegrowth=20%
)
,
(
name='DB_sec_Ventas',
filename='D:\SQL\Libro\DB_sec_Ventas.ndf',
size=10MB, maxsize=50MB, filegrowth=2MB
)
go

--visualizar la base de datos mediante un listado
select * from sys.sysdatabases My_DB
where My_DB.name='Ventas'
go

--visualizar archivos que componen la base de datos

exec sp_helpdb 'Ventas';