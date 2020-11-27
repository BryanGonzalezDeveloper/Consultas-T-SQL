--CASO DESARROLLADO 8: CREACION DE LA BASE DE DATOS LLAMADA: DB_PROYECTOS.

--LA BASE DE DATOS DEBE INCLUIR:
	--EL ARCHIVO PRINCIPAL -->(.mdf) 
	--EL ARCHIVO SECUNDARIO --> (.mdf) 
	--EL ARCHIVO DE TRANSACCIONES (LOG)--> (.mdf) 

use master
go
if DB_ID('DB_PROYECTOS') is not null
begin 
drop database DB_PROYECTOS
end
create database DB_PROYECTOS
 on primary
(
name='DB_PROYECTOS',
filename='D:\SQL\Libro\DB_PROYECTOS.mdf',
size=100mb , maxsize=250mb , filegrowth=5mb
),
(
name='DB_SEC_PROYECTOS',
filename='D:\SQL\Libro\DB_SEC_PROYECTOS.ndf',
size=20mb , maxsize=70mb, filegrowth=10%
)
log on
(
name='LOG_DB_PROYECTOS',
filename='D:\SQL\Libro\LOG_DB_PROYECTOS.ldf',
size=10mb , maxsize=40mb , filegrowth=2mb
)
go

--visualizar los archivos que componen la base de datos
exec sp_helpdb 'DB_PROYECTOS';