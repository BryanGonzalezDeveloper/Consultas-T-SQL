--EN ESTE EJEMPLO SE MUESTRA EL USO DE UPTDATE PARA ACTUALIZAR VALORES EN CAMPOS DEE ALGUNAS TABLAS
--LA SENTENCIA UPDATE, SE IMPLEMENTA DE LA SIGUIENTE FORMA:

--UPDATE <Tabla>
--SET <Campo=Valor>,<Campo=Valor>
--WHERE <Condicion>
--go

use DB_VENTAS
go
--Las actualizaciones se haran en la tabla:"Producto", que fue realizada en el ejemplo anterior, donde se implementaron restricciones
--Se realiza un select para ver cual producto se encuentra registrado y comparar los cambios.
select * from Producto
go

--Actualizar la columna precio, sumando a la cantidad actual $2.	En este caso la actualizacion se realizara a todos los registros
--de la tabla debido a que no se especifica ninguna conexion.
update Producto
set Pre_Pro +=2
go
select * from Producto
go

--Actualizar el stock actual de los productos al doble, solamente si el stock es menor o igual a 50.
update Producto
set Sac_Pro*=2
where Sac_Pro<=50
go

--Reducir el precio al 50% en productos, donde el codigo de producto sea igual a uno de los siguientes valores 
--P0001, P0010,P0022
update Producto
set Pre_Pro*=0.5
where Cod_Pro in('P0001','P0010','P0022')
go
select * from Producto
go
--Actualizar el stock actual a 50. Establecer el precio en $100.
--Aplicar estos cambios solamente en los productos con un stock actual mayor a 100
update Producto
set Sac_Pro=50, Pre_Pro=100
where Sac_Pro>100
go