--CASO DESARROLLADO 5: AÑADIR ARCHIVOS A LA BASE DE DATOS.

--Agregar 3 archivos secundarios a la base de datos que fue creada en el caso desarrollado #4.

use Ventas 
go

alter database Ventas
add file
(
name='DB_Ventas_sec1',
filename='D:\SQL\Libro\DB_Ventas_sec1.ndf',
size=10mb , maxsize=500mb, filegrowth=10%
),
(
name='DB_Ventas_sec2',
filename='D:\SQL\Libro\DB_Ventas_sec2.ndf',
size=10mb , maxsize=500mb, filegrowth=10%
),
(
name='DB_Ventas_sec3',
filename='D:\SQL\Libro\DB_Ventas_sec3.ndf',
size=10mb , maxsize=500mb, filegrowth=10%
)

go

--visualizar base de datos en un listado

select * from sys.sysdatabases DB
where DB.name='Ventas'
go

--visualizar archivos que componen la base de datos

exec sp_helpdb 'Ventas';