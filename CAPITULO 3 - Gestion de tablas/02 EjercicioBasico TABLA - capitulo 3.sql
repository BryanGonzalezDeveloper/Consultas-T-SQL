--Se implementara una base de datos llamada : DB_PRUEBA
--donde se creara una tabla para realizar las instrucciones elementales de sql.
use master
go
--Se valida la existencia de la base de datos, si ya existe entonces la eliminamos para crearla de nuevo y usarla en este ejemplo
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



if OBJECT_ID('tblPrueba') is not null
begin
drop table tblPrueba
end


--SE CREA UNA TABLA CON DATOS BASICOS. POSTERIORMENTE SE LE REALIZARAN MODIFICACIONES A LA TABLA PARA QUE HAYA MAYOR COHERENCIA EN LA TABLA 

create table tblPrueba
(
id int,
nombre varchar(10) not null,
apellido varchar(100) not null,
Salario decimal (10,10)
)
go

--MODIFICAMOS LA TABLA PARA QUE EL CAMPO: ID SEA PRIMARY KEY
--primero se realiza modificacion en el campo id, para que no acepte valores nulos
alter table tblPrueba
alter column id int not null
go
--se asigna la llave primaria (primary key)
alter table tblPrueba
add primary key (id)
go

--MODIFICAMOS LA TABLA PARA QUE NOMBRE ALMACENE HASTA 100 CARACTERES Y NO PERMITA VALORES NULOS
alter table tblPrueba
alter column 
nombre varchar(100) not null

--ELIMINAMOS EL CAMPO SALARIO DE LA TABLA.
alter table tblPrueba
drop column Salario
--AL SER ELIMINADO EL CAMPO SALARIO, AHORA SE DEBE AGREGAR EL CAMPO SUELDO DIARIO
alter table tblPrueba
add  SueldoDiario decimal (3,2) not null


--Visualiar los campos y propiedades de la tabla
exec sp_columns 'tblPrueba';