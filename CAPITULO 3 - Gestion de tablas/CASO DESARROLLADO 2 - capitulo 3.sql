use master 
go

if DB_ID('RENT_CAR') is not null
begin
 drop database RENT_CAR
 end
 go
 create database RENT_CAR
 on primary
 (
 name='RENT_CAR',
 filename='D:\SQL\Libro\RENT_CAR.mdf',
 size=20mb , maxsize=100mb, filegrowth=15%
 )
 go

 use RENT_CAR
 go
 set dateformat DMY
 --CREACION DE LAS TABLAS
create table tblDistrito
(
IDE_DIS CHAR(3) NOT NULL PRIMARY KEY,
DES_DIS VARCHAR(40) NOT NULL
)
go
create table tblAlquiler
(
NUM_ALQ INT NOT NULL PRIMARY KEY,
FEC_ALQ DATE NOT NULL,
MON_ALQ MONEY NOT NULL
)
go
 

 create table tblAutomovil
 (
 MAT_AUT CHAR(10) NOT NULL PRIMARY KEY,
 COL_AUT VARCHAR(30) NOT NULL,
 MOD_AUT VARCHAR(30)
 )
 go
 

 create table tblCliente 
 (
 IDE_CLI CHAR(5) NOT NULL PRIMARY KEY,
 APE_CLI VARCHAR(30) NOT NULL,
 NOM_CLI VARCHAR(30) NOT NULL,
 DNI_CLI VARCHAR(8) NOT NULL,
 TEL_CLI VARCHAR(25) NULL DEFAULT '000-0000',
 IDE_DIS CHAR(3) NOT NULL REFERENCES tblDistrito
 )
 go


 create table tblDetalleAlquiler
 (
 NUM_ALQ INT NOT NULL REFERENCES tblAlquiler,
 IDE_CLI CHAR(5) NOT NULL REFERENCES tblCliente,
 MAT_AUT CHAR(10) NOT NULL REFERENCES tblAutomovil
 PRIMARY KEY(NUM_ALQ,IDE_CLI)
 )
 go

 --En el monto de alquiler no permitir valores inferiores a cero.
 alter table tblAlquiler
 add constraint CHK_MONTO_ALQUILER
 check (MON_ALQ>0)
 go
 --permitir como colores de automovil solo los colores: ROJO,PLATA,NEGRO.
 alter table tblAutomovil
add constraint CHK_COLOR_AUTOMOVIL
check (COL_AUT in('ROJO','PLATA','NEGRO'))
go
--agregar el campo correo electronico (COR_CLI) en la tabla : tblCliente
alter table tblCliente
add COR_CLI varchar(50) null default 'NO PROPORCIONADO'
go

--Realiza insercion de registro a las tablas existentes (los datos utilizados fueron tomados del libro).
--INSERCION EN TABLA : tblDistrito
insert into tblDistrito values
('D01','SURCO'),
('D02','JESUS MARIA'),
('D03','SAN ISIDRO'),
('D04','LA MOLINA'),
('D05', 'SAN MIGUEL'),
('D06','MIRAFLORES'),
('D07','BARRANCO'),
('D08','CHORRILLOS')
go
--INSERCION EN TABLA : tblCliente
insert into tblCliente values
('CL001','LOPEZ','MARIA','10856952','526-5254','D01','MLOPEZ@HOTMAIL.COM'),
('CL002','GOMEZ', 'JOSE','10851152','585-8212','D03',DEFAULT),
('CL003','ACOSTA' ,'JESUS','10856222','485-1598','D02','JACOSTA@HOTMAIL.COM'),
('CL004','ARIAS', 'GUADALUPE','10833385','258-8569','D01',DEFAULT),
('CL005','CARLOS', 'MANUEL','10854478','296-9685','D04',DEFAULT),
('CL006','GERZ', 'BRIGITTE','10855252','585-1284','D08','BGERZ@HOTMAIL.COM'),
('CL007','BARBOSA', 'MARISOL','10859852','584-5869','D06','MBARBOSA@HOTMAIL.COM')
go
--INSERCION EN TABLA : tblAlquiler
insert into tblAlquiler values
('1','12/03/10',185),
('2','02/01/11',100),
('3','01/05/11',54),
('4','11/08/12',85),
('5','22/06/12',18),
('6','30/01/12',15),
('7','16/04/12',165),
('8','23/05/12',15),
('9','21/03/12',225)
go

--INSERCION EN TABLA : tblAutomovil
insert into tblAutomovil values
('AF-456','ROJO','SEDAN'),
('D4-243','NEGRO','SEDAN'),
('H5-455','ROJO','STATION WAGON'),
('GG-654','ROJO','CAMIONETA'),
('FD-463','PLATA','STATION WAGON'),
('SF-112','ROJO','LI'),
('FG-654','PLATA','L10'),
('GT-532','ROJO','SEDAN'),
('YT-457','NEGRO','STATION WAGON')
go
--INSERCION EN TABLA : tblDetalleAlquiler
insert into tblDetalleAlquiler values
('1','CL002','GG-654'),
('2','CL002','GT-532'),
('3','CL006','FD-463'),
('3','CL007','GT-532'),
('4','CL005','H5-455'),
('5','CL004','SF-112'),
('6','CL004','YT-457'),
('7','CL003','GT-532')
go
--visualizar registros:
select * from tblDistrito;
select * from tblAutomovil;
select * from tblCliente;
select * from tblAlquiler;
select * from tblDetalleAlquiler;
go

--IMPLEMENTAR UN MERGE QUE ACTUALICE LOS CAMPOS CORRESPONDIENTES EN UN AUTOMOVIL EN CASO DE QUE EL AUTOMOVIL EXISTA
--EN CASO DE NO EXISTIR, CREAR EL REGISTRO. RECORDAR QUE UN AUTOMOVIL SE IDENTIFICA POR SU MATRICULA (MAT_AUT).

--DECLARACION DE VARIABLES 
declare @matricula char(10),@color varchar(30), @modelo varchar(30)
--ASIGNACION DE LAS VARIABLES DECLARADAS ANTERIORMENTE:
set @matricula='MX5-010';
set @color='NEGRO';
set @modelo='CHEVROLET SILVERADO';
merge tblAutomovil as target
using(select @matricula,@color,@modelo)
as source
(MAT_AUT,COL_AUT,MOD_AUT)
on (target.MAT_AUT=source.MAT_AUT)
when matched then update
set COL_AUT=SOURCE.COL_AUT, MOD_AUT=SOURCE.MOD_AUT
when not matched then
insert values
(SOURCE.MAT_AUT,SOURCE.COL_AUT,SOURCE.MOD_AUT);
go