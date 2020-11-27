--SENTECIA MERGE.	ESTA SENTENCIA REALIZA ACCIONES DE INSERCION, ACTUALIZACION O ELIMINACION EN UNA MISMA TABLA
--ES MUY UTIL PARA EMPAREJAR DATOS EN TABLAS, POR EJEMPLO ACTUALIZAR LOS REGISTROS DE UNA COPIA DE SEGURIDAD. PARA MANTENER
--LA INFORMACION DE FORMA ACTUALIZADA. 

--EN ESTE EJEMPLO SE UTILIZARA LA TABLA LLAMADA : Producto
--LA TABLA SE REALIZO EN EL EJERCICIO: 
--01 CREACION DE TABLA (Producto). PARA UTILIZARLA EN SIGUIENTES EJEMPLOS - capitulo 3
--EL EJERCICIO LO ENCONTRARAS EN EL MISMO DIRECTORIO QUE EL EJERCICIO ACTUAL.

use 
DB_VENTAS
go

--EJERCICIO:
--Implementar un MERGE que permita registrar un producto nuevo.	Si este producto ya se encuentra registrado entonces debera
--actualizar los campos correspondientes en caso contrario se crea un nuevo registro.

--DECLARACION DE VARIABLES:
declare	@Cod char(5),@des varchar(50), @Precio money, @Sac int, @Smi int ,@Uni varchar(30), @Lin varchar(30), @Imp varchar(10)
set @Cod='P001'
set @des='LAPICES CRAYOLA PACK 12 PZAS.'
set @Precio=12.50
set @Sac=175
set @Smi=250
set @Uni='Paquete'
set @Lin='2'
set @Imp='V'

--Aplicando MERGE
merge Producto as Target
using 
(
select @Cod,@des,@Precio,@Sac,@Smi,@Uni,@Lin,@Imp
)
as
source (
Cod_Pro, Des_Pro,Pre_Pro,Sac_Pro,Smi_Pro,Uni_Pro,Lin_Pro,Imp_Pro
)
on (target.Cod_Pro=Source.Cod_Pro)
when matched then update
set Des_Pro=source.Des_Pro , Pre_Pro=source.Pre_Pro, Sac_Pro=source.Sac_Pro,Smi_Pro=source.Smi_Pro,Uni_Pro=source.Uni_Pro,
Lin_Pro=source.Lin_Pro, Imp_Pro=source.Imp_Pro

when not matched then
insert values
(
source.Cod_Pro,source.Des_Pro,source.Pre_Pro,source.Sac_Pro,source.Smi_Pro,source.Uni_Pro,source.Lin_Pro,source.Imp_Pro
);
go