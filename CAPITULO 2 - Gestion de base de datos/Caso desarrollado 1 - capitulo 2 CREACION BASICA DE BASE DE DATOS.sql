
use master
go
if DB_ID('Ventas') is not null
begin
drop database Ventas
end

create database Ventas
go

use Ventas
go

--Visualizar la base de datos mediante un listado

select * from sys.sysdatabases My_DB
where My_DB.name= 'Ventas'
go

--Mostrar los archivos que componen la base de datos
exec sp_helpdb 'Ventas';


