--SE IMPLEMNTARA INSERCION DE REGISTRO UTILIZANDO UNA BASE DE DATOS LLAMADA ->"DB_VENTAS" Y LAS INSERCIONES SE REALIZARAN UNICAMENTE
--SI LA TABLA "Producto" EXISTE EN LA BASE DE DATOS, EN CASO CONTRARIO EL SCRIPT NO REALIZARA NINGUNA ACCION

use
DB_VENTAS
go
--Implementar insercion de registros en la tabla "Producto"

--INSERCION DE REGISTROS DE FORMA BASICA
if OBJECT_ID('Producto') is not null
begin
--Se eliminan todos los registros existentes de la tabla con el fin de facilitar la visualizacion
--en este ejemplo.
delete from Producto;

--Se realiza la insercion de un registro
insert into Producto values ('P0001','Papel Bond A-4',35,200,1500,'PAQUETE','2','V');
--Se verifica que el registro se registrado corectamente
select * from Producto;
end
go


--INSERCCION DE REGISTROS CON ESPECIFICACION DE CAMPOS
--Ejemplo de prueba, al insertar registros con una especificacion de campos
if OBJECT_ID('Producto') is not null
begin
delete from Producto;

insert into Producto (Cod_Pro,Des_Pro,Pre_Pro,Sac_Pro,Smi_Pro,Uni_Prod,Lin_Pro,Imp_Pro)
values 

('P0001','Papel Periodico',25,350,1000,'PAQUETE','3','F');
select * from Producto;
end
go

--REALIZAR INSERCION MULTIPLE
if OBJECT_ID('Producto') is not null
begin
delete from Producto;
insert into Producto values 
('P0001','Cartucho tinta negra',70,500,3000,'CAJA','2','V'),
('P0002','Cartucho tinta color',100,110,2000,'PAQUETE','2','V')
select * from Producto;
end
go



--INSERCION CON EL USO DE VARIABLES LOCALES
if OBJECT_ID('Producto') is not null
begin
delete from Producto;
--Declaracion de variables
declare @COD char(5),@descripion varchar(50),@Pre money,@Stock int,@Smi int,@Uni varchar(30),@Lin varchar(30), @Imp varchar(10);
--Asignar valores a las variables
set @COD='P0010';
set @descripion='BORRADOR BLANCO';
set @Pre=33;
set @Stock=147;
set @Smi=400;
set @Uni='PAQUETE';
set @Lin='3';
set @Imp='F';

--Se realiza la insercion
insert into Producto
values
(@COD,@descripion,@Pre,@Stock,@Smi,@Uni,@Lin,@Imp);

select * from Producto;
end
go
