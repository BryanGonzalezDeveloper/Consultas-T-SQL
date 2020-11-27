--CASO DESARROLLADO 1. SE CREA UNA BASE DE DATOS NIVEL BASICO, AQUI SE REALIZARA EL SCRIPT. LAS ESPECIFICACIONES CON LA QUE DEBIA 
--CUMPLIR ESTE EJERCICIO. SE ENCUENTRAN UBICADAS EN EL DIRECTORIO, EN DOCUMENTO LLAMADO:
--			"CASO DESARROLLADO 1 - ESPECIFICACIONES"

use master
go
if DB_ID('PROYECTOS_INDUSTRIALES') is not null
begin
drop database PROYECTOS_INDUSTRIALES
end
go

create database PROYECTOS_INDUSTRIALES
on primary
(
name='PROYECTOS_INDUSTRIALES',
filename='D:\SQL\Libro\PROYECTOS_INDUSTRIALES.mdf',
size=15mb, maxsize=150mb, filegrowth=10%
)
go
use
PROYECTOS_INDUSTRIALES
go
if OBJECT_ID('tblDistrito') is not null
begin
drop table tblDistrito
end
go
create table tblDistrito
(
COD_DIS char(3) not null primary key,
NOM_DIS varchar(40) not null
)
go

if OBJECT_ID('tblProyecto') is not null
begin
drop table tblProyecto
end
go
create table tblProyecto
(
NUM_PRO int not null primary key identity(1,1),
FEC_PRO date not null,
MON_PRO money not null check(MON_PRO>0)
)
go

if OBJECT_ID('tblClientes') is not null
begin
drop table tblClientes
end
go

create table tblClientes
(
IDE_CLI char(5) not null primary key,
NOM_CLI varchar(50) not null,
RUC_CLI varchar(11) not null unique,
COD_DIS char(3) not null references tblDistrito,
EMA_CLI varchar(35) null default 'NO CUENTA'
)
go

if OBJECT_ID('tblEncargado') is not null
begin
drop table tblEncargado
end
go
create table tblEncargado
(
IDE_ENC  char(5) not null primary key,
NOM_ENC varchar(30) not null,
APE_ENC varchar(30) not null,
CAR_ENC varchar(30) not null check (CAR_ENC in('Jefe','Contador','Supervisor','Vendedor')),
COD_DIS char(3) references tblDistrito,
FIN_ENC date not null
)
go

if OBJECT_ID('tblDetalle_Proyecto') is not null
begin
drop table tblDetalle_Proyecto
end
go
create table tblDetalle_proyecto
(
NUM_PRO  int not null references tblProyecto,
IDE_CLI char(5) not null references tblClientes,
IDE_ENC char(5) not null references tblEncargado,
DES_DET varchar(40) not null
primary key (NUM_PRO,IDE_CLI)
)
go

--MODIFICAR A 100 LA CAPACIDAD DE CARACTERES EN EL CAMPO EN LA DESCRIPCION DE LA TABLA: tblDetalle_proyecto
alter table tblDetalle_proyecto
alter column DES_DET varchar(100)
go

--AGREGAR EL CAMPO TELEFONO "TEL_CLI" Y NUMERO DE HIJOS "HIJ_CLI" EN LA TABLA : tblClientes
alter table tblClientes
add TEl_CLI varchar(16) null default 'No proporcionado', HIJ_ClI int 
go

--ELIMINAR LA COLUMNA CLIENTE DE LA TABLA: tblClientes
alter table tblClientes
drop column HIJ_CLI
go
--LISTAR LAS TABLAS IMPLEMENTADAS EN LA BASE DE DATOS:
exec sp_tables;
go
--LISTAR LOS CAMPOS DE CADA TABLA IMPLEMENTADA:
exec sp_columns'tblDistrito';
exec sp_columns'tblProyecto';
exec sp_columns'tblEncargado';
exec sp_columns'tblDetalle_Proyecto';
exec sp_columns'tblClientes';
go

--REALIZAR INSERCION DE REGISTROS (LOS DATOS DE LOS REGISTROS FUERON EXTRAIDOS DEL LIBRO):

insert into tblDistrito values
('D01','SURCO'),
('D02','JESUS MARIA'),
('D03','SAN ISIDRO'),
('D04','LA MOLINA'),
('D05', 'SAN MIGUEL'),
('D06','MIRAFLORES'),
('D07','BARRANCO'),
('D08','CHORRILLOS')

insert into tblClientes values
('CL001','LOPEZ MARIA','10856985252','D01','MLOPEZ@HOTMAIL.COM',DEFAULT),
('CL002','GOMEZ JOSE','1085111252','D03','JGOMEZ@HOTMAIL.COM',DEFAULT),
('CL003','ACOSTA JESUS','10856222252','D02','JACOSTA@HOTMAIL.COM',DEFAULT),
('CL004','ARIAS GUADALUPE','10833385252','D01','GARIAS@HOTMAIL.COM',DEFAULT),
('CL005','CARLOS MANUEL','1085444252','D04','MCARLOS@HOTMAIL.COM',DEFAULT),
('CL006','GERZ BRIGITTE','10855555252','D08','BGERZ@HOTMAIL.COM',DEFAULT),
('CL007','BARBOSA MARISOL','10855598252','D06','MBARBOSA@HOTMAIL.COM',DEFAULT)

insert into tblEncargado values
('E0001','LUIS','GRIMALDO','Jefe','D01','01/02/2010'),
('E0002','FILIMON','ROJAS','Contador','D02','04/05/2010'),
('E0003','RODOLFO','SALAZAR','Supervisor','D01','05/05/2010'),
('E0004','ALEJANDRO','VICHESL','Vendedor','D03','01/03/2011'),
('E0005','MARTIN','JACINTO','Jefe','D04','04/07/2011'),
('E0006','CARLOS','JUAREZ','Contador','D01','01/08/2011'),
('E0007','EDUARDO','LAMAS','Vendedor','D06','03/09/2011'),
('E0008','ELVIS','PALACIOS','Jefe','D04','01/02/2012'),
('E0009','CARLOS','PRIETO','Supervisor','D01','03/04/2012'),
('E0010','MARIA','CONTRERAS','Supervisor','D07','02/06/2012'),
('E0011','JUANA','LAZARO','Vendedor','D08','02/07/2012')
go

insert into tblProyecto values
('01/05/2012',100000),
('11/05/2012',300000),
('23/05/2012',140000),
('21/06/2012',150000),
('21/06/2012',10000),
('16/07/2012',330000),
('15/07/2012',220000),
('10/08/2012',260000),
('08/08/2012',140000),
('06/09/2012',160000),
('02/10/2012',246000)
go

insert into tblDetalle_proyecto values
(8,'CL001','E0001','OBRA LIMA'),
(9,'CL002','E0011','OBRA AREQUIPA'),
(10,'CL001','E0002','OBRA LIMA'),
(11,'CL001','E0002','OBRA LIMA'),
(12,'CL004','E0003','OBRA AREQUIPA'),
(13,'CL007','E0003','OBRA LIMA'),
(14,'CL005','E0004','OBRA LIMA'),
(15,'CL002','E0005','OBRA AREQUIPA'),
(16,'CL001','E0006','OBRA LIMA'),
(17,'CL002','E0007','OBRA LIMA'),
(18,'CL003','E0005','OBRA AREQUIPA')
go
--SE LISTAN LOS REGISTROS EN LAS TABLAS CREADAS
select  * from tblClientes
select  * from tblProyecto
select  * from tblEncargado
select  * from tblDetalle_proyecto
select  * from tblDistrito
go
--MODFICAR EL CORREO ELECTRONIVO DEL CLIENTE: MARIA LOPEZ.	POR: maria_lopez@gmail.com
update tblClientes 
set EMA_CLI='maria_lopez@gmail.com'
where NOM_CLI ='LOPEZ MARIA'
go
--MODIFICAR EL NUMERO DE TELEFONO DE TODOS LOS CLIENTES POR : 0000000
update tblClientes
set TEl_CLI='0000000'
go

--DISMINUIR EN $ 5000.00   LOS PROYECTOS REGISTRADOS EN EL  PRIMER SEMESTRE DE 2012.
update tblProyecto
set MON_PRO-=5000
where YEAR(FEC_PRO)=2012 and MONTH(FEC_PRO) between 1 and 6
go
--IMPLEMENTAR SENTENCIA MERGE PARA QUE EN DADO CASO DE QUE UN DISTRITO EXISTA, ACTUALIZAR
--SU INFORMACION. EN CASO DE NO EXISTIR CREAR UNO.
--Declaracion de variables:
declare @COD_DIS CHAR(3), @NOM_DIS VARCHAR(40)
set @COD_DIS='D09'
set @NOM_DIS='LINCE'
--Sentencia merge
merge tblDistrito as target
using
(select @COD_DIS, @NOM_DIS)
as source
(COD_DIS, NOM_DIS)
on (target.COD_DIS=source.COD_DIS)
when matched then
update 
set NOM_DIS=SOURCE.NOM_DIS
when not matched then insert values
(
SOURCE.COD_DIS, SOURCE.NOM_DIS
);
go