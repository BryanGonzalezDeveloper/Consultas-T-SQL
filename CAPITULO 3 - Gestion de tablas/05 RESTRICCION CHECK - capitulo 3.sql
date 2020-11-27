use
DB_VENTAS
go

--UTILIZAR CONDICION CHECK.	EL OBJETIVO DE  IMPLEMENTAR LA RESTRICCION CHECK ES QUE EN LA TABLA PRODUCTO:
--*EL PRECIO REGISTRADO DE UN PRODUCTO SEA UNA CANTIDAD ENTRE 1 Y 100.
--*STOCK ACTUAL (Sac) SEA MAYOR A CERO.
--*QUE EN UNIDAD DE PRODUCTO SOLO SE PERMITA REGISTRAR : BOLSA, CAJA O PAQUETE

--RESTRICCION CHECK PRIMERA FORMA:
if OBJECT_ID('Producto') is not null
begin
drop table Producto
end
go
create table Producto
(
Cod_Pro char(5) not null primary key,
Des_Pro varchar(50) not null,
Pre_Pro money not null check(Pre_Pro between 1 and 100),
Sac_pro int not null check(Sac_Pro>0),
Smi_Pro int not null,
Uni_Prod varchar(30) not null check(Uni_Prod in('BOLSA','CAJA','PAQUETE')),
Lin_Pro varchar(30) not null,
Imp_Pro varchar(10) not null
)
go

--SEGUNDA FORMA DE IMPLENTAR LA RESTRICCION CHECK
	if OBJECT_ID('Producto') is not null
	begin
	drop table Producto
	end
	go
	create table Producto
	(
	Cod_Pro char(5) not null primary key,
Des_Pro varchar(50) not null,
Pre_Pro money not null,
Sac_Pro int not null,
Smi_Pro int not null,
Uni_Prod varchar(30) not null,
Lin_Pro varchar(30) not null,
Imp_Pro varchar(10) not null
)
go

alter table Producto
add constraint CHK_Precio
check(Pre_Pro between 1 and 100)
go
alter table Producto
add constraint CHK_StockActual
check (Sac_Pro>0)
go

alter table Producto
add constraint CHK_Unidad
check (Uni_Prod in('BOLSA','CAJA','PAQUETE'))
go
--Visualizar las restricciones en la base de datos
exec sp_helpconstraint 'Producto';