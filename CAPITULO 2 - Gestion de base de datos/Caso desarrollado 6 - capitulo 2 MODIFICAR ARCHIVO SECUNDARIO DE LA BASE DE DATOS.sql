--CASO DESARROLLADO 6 : MODIFICACION DE LAS PROPIEDADES DE LA BASE DE DATOS CREADA EN EL CASO DESARROLLADO 5
--Modificacion de tamaño al archivo: DB_Ventas_sec1.ndf 

use Ventas 
go

alter database Ventas
modify file
(
name=DB_Ventas_sec1,
size= 20mb, filegrowth=15%
)
go

--Visualizar los detalles del archivo: DB_Ventas_sec1.ndf
exec sp_helpfile 'DB_Ventas_sec1';