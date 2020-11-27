--CASO DESARROLLADO 7: REMOVER ARCHIVO SECUNDARIO (.ndf) DE LA BASE DE DATOS
--EL ARCHIVO QUE SE DESEA REMOVER ES : DB_Ventas_sec2.ndf

use Ventas
go

--Visualizar los componentes de la base de datos Ventas, notese que el archivo secundario DB_Ventas_sec2.ndf aparece en nuestra base de datos.
exec sp_helpdb 'Ventas';

--Eliminar el archivo DB_Ventas_sec2.ndf
alter database Ventas
remove file DB_Ventas_sec2
go

--Visualizar los componentes que se encuentran en la base de datos Ventas, 
--el archivo secundario DB_Ventas_sec2.ndf, ya no aparece porque fue eliminado.

exec sp_helpdb 'Ventas';
