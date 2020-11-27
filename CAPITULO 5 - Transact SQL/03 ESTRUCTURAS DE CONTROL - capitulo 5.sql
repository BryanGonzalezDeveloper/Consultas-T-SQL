/*
En T-SQL existen 3 estructuras de control, que son:
Estructuras secuenciales: Ejecutan las instrucciones una a continuacion de la otra.
Estructuras selectivas: Se ejecutan dependiendo del resultado de una evaluacion logica.

Estructuras repetitivas: Se ejecutan las instrucciones de manera repetida, segun una condicion logica llamada ciclo o bucle.
Las estructuras de control permiten modificar el flujo de ejecucion de las instrucciones en T-SQL. Las estructuras de control pueden:

*De acuerdo a una condicion logica, ejecutar un grupo de sentencias u otro (IF...ELSE);
*De acuerdo al valor de una variable, determinar un valor dentro de las columnas en una tabla(CASE);
*Ejecutar un grupo de sentencias de manera mientras una condicion sea verdadera o falsa(WHILE);
*/


/*
IF, es una estructura selectiva que evalua una condicion logica; Dependiendo del resultado de dicha evaluacion ejecuta un grupo de 
instrucciones u otro. El resultado de evaluar la condicion logica es de tipo booleano (True | False).
FORMATOS:
IF <CONDICION_LOGICA> <INSTRUCCIONES>

IF <CONDICION_LOGICA>
<BEGIN>
<INSTRUCCIONES>
<END>

FORMATO DOBLE:
estructura IF, permite definir un conjunto de instrucciones para cuando el resultado logico de evaluar la condicion sea TRUE.
De igual manera se pueden definir instrucciones para cuando el resultado de evaluar la condicion sea FALSE.
IF <CONDICION_LOGICA>
<BEGIN>
<INSTRUCCIONES>
<END>
ELSE
<BEGIN>
<INSTRUCCIONES>
<END>

FOMATO DOBLEMENTE ENLAZADO:
Se utiliza cuando el resultado de evaluar la condicion devuelve multiples alternativas dentro de la estructura similar al caso CASE.
IF <CONDICION_LOGICA>
<BEGIN>
<INSTRUCCIONES>
<END>
ELSE IF <CONDICION_LOGICA>
<BEGIN>
<INSTRUCCIONES>
<END>
ELSE
<BEGIN>
<INSTRUCCIONES>
<END>
*/
use VentasDB
go
--EJEMPLOS:
--1.Se necesita registrar un nuevo distrito haciendo uso de variables locales. Se debe evaluar que el nombre de distrito no exista en
--la tabla; en caso de no existir mostrar: "Distrito registrado correctamente" 
--en caso contrario mostrar: "El distrito ya se encuentra registrado".

declare @codigo char(5)='D37',
		@distrito varchar(50)='NUEVO SAN JUAN'
--Se busca la existencia del distrito
if exists(select * from tblDistrito where Nom_Dis=@distrito)
begin
print '"EL DISTRITO: '+@distrito + ' YA SE ENCUENTRA REGISTRADO'
end
else
begin
insert into tblDistrito values
(@codigo,@distrito)
print 'EL DISTRITO: '+ @distrito + ' SE REGISTRO CORRECTAMENTE'
end
go

--2. Haciendo uso de variables locales se necesita mostrar el total de facturas realizadas en un año especifico. Donde se debera 
--imprimir un msj diciendo el total de facturas realizadas en dicho año, en dado caso de no existir ninguna factura realizada, mostrar
--el msj: NO SE REGISTRO NINGUNA FACTURA EN EL AÑO.
declare @año int= 2013,@total int
if( select COUNT(*) from tblFactura where year(Fec_Fac)=@año )<1
begin
print 'NO SE REGISTRO NINGUNA FACTURA EN EL AÑO: '+ CAST(@año as char(4))+'.'
end
else
begin
set @total=(select COUNT(*) from tblFactura where year(Fec_Fac)=@año)
print 'EN EL AÑO: '+ CONVERT(char(4), @año)+' SE REGISTRARON: '+  CONVERT(char(2), @total)+' FACTURAS'
end
go
--3. Se necesita implementar una condicion para las cantidades por cada tipo de unidad en los productos; Es decir si un producto
--con el tipo de unidad 'MLL' tiene una cantidad menor o igual a 10 se debe mostrar el msj: "CONDICION: INICIAR REPORTE", en caso 
--contrario mostrar el msj: "CONDICION: CONFORME"
declare @unidades varchar(30)='DOC',@total int
set @total=(select COUNT(*) from tblProducto P where P.Unidades_Pro = @unidades)
if (@total)<=10
begin
print 'CONDICION: INICIAR REPORTE'
end
else 
begin
print 'CONDICION: CONFORME.'
end
go

/*
Cuando existen mas de 2 valores para una condicion, se deben utiliza estructuras de control multiple.
La estructura CASE evalua una expresion que podra tomar N valores distintos, segun se eliga uno de esos valores, se tomara 1 de N 
acciones posibles.
FORMATO DE LA ESTRUCTURA CASE PARA MULTIPLES VALORES EN UNA CONDICION:

CASE <CAMPO>
WHEN <VALOR1> THEN expresion_resultado
WHEN <VALOR2> THEN expresion_resultado
WHEN <VALOR...> THEN expresion_resultado
WHEN <VALOR_N> THEN expresion_resultado
ELSE expresion_falsa
END
FORMATO DE LA ESTRUCTURA CASE PARA MULTIPLES CONDICIONES:
CASE
WHEN <CONDICION1> THEN expresion_resultado
WHEN <CONDICION2> THEN expresion_resultado
WHEN <CONDICION...> THEN expresion_resultado
WHEN <CONDICION_N> THEN expresion_resultado
ELSE expresion_falsa
END

Donde 
CAMPO:Es el nombre de la columna que se va a comparar, tambien se pueden utilizar funciones	 SQL.
WHEN: Especifica las expresiones que se van a buscar segun la condicion.
THEN: Especifica las expresiones resultantes de una condicion.
ELSE: Especifica las acciones que realizaran cuando las opciones o las condiciones resulter ser falsas o no se cumplan
END: Especifica la finalizacion de la estructura CASE.
*/
--EJEMPLOS:
--1.Se necesita listar el codigo, descripcion, precio, unidad y una breve descripcion de la unidad. Referente a la tabla: tblProducto
select 
p.Cod_Pro as CODIGO, p.Des_Pro as DESCRIPCION, p.Pre_Pro as PRECIO, p.Unidades_Pro as UNIDAD,
CASE p.Unidades_Pro
WHEN 'MLL' THEN 'MILLARES'
WHEN 'DOC' THEN 'DOCENAS'
WHEN 'UNI' THEN 'UNIDADES'
WHEN 'CIE' THEN 'CIENTOS'
end as [DESCRIPCION DE UNIDAD]
from tblProducto as p
go
--2. Se necesita listar el codigo, nombre, sueldo, fecha de inicio y fecha de inicio en letras. La informacion debe ser obtenida
--de la tabla: tblVendedor.
select
V.Cod_Ven as CODIGO, v.Nom_Ven + SPACE(1)+v.Ape_Ven as VENDEDOR, v.FecInicio_Ven as [FECHA DE INICIO],
CAST(day(v.FecInicio_Ven) as char(2)) +' DE '+
case MONTH(v.FecInicio_Ven)
when 1 then 'ENERO'
when 2 then 'FEBRERO'
when 3 then 'MARZO'
when 4 then 'ABRIL'
when 5 then 'MAYO'
when 6 then 'JUNIO'
when 7 then 'JULIO'
when 8 then 'AGOSTO'
when 9 then 'SEPTIEMBRE'
when 10 then 'OCTUBRE'
when 11 then 'NOVIEMBRE'
when 12 then 'DICIEMBRE'
+ ' DE '+
+ CAST(YEAR(V.FecInicio_Ven) as char(4))
end as [FECHA]
from tblVendedor V
go
--3. Se necesita mostrar el total de proveedores por distrito, adicionando el msj : "NO CUENTA" solo si la cantidad de proveedores
-- en un distrito es 0
select d.Nom_Dis as DISTRITO, COUNT(p.Cod_Dis) as [TOTAL PROVEEDORES],
case 
when COUNT(p.Cod_Dis)=0 then 'NO CUENTA'
else ' '
end as [MENSAJE]
from tblDistrito as d
left join tblProveedor as p on p.Cod_Dis=d.Cod_Dis
group by d.Nom_Dis
go
/*
Estructura repetitiva WHILE 
Formato:
WHILE <CONDICION>
<EXPRESION_REPETIDA>
[BREAK]
<EXPRESION_REPETIDA>
[CONTINUE]
<EXPRESION_REPETIDA>

DONDE:
CONDICION:Se aplica una evaluacion logica, donde a partir de la evaluacion quedara definida la cantidad de repeticiones(iteraciones) que
realizaea el ciclo.
BREAK: Detiene las iteraciones del ciclo permitiendo seguir el flujo de instrucciones despues del ciclo.
CONTINUE: Permite regenerar el ciclo de repeticiones no tomando en cuenta las operaciones asignadas despues de CONTINUE.
Es mejor plantear la estructura while con los operadores de control de inicio y fin (BEGIN - END) para tener un mejor
control en las expresiones internas del ciclo.
*/
--EJEMPLOS:
--1.Mostrar los primeros 10 numeros naturales utilizando WHILE
declare @numero int =1
while @numero<=10
begin
print 'NUMERO: '+ convert(char(2),@numero)
set @numero+=1
end
go
--2.Mostrar los ultimos 3 registros de la tabla: tblFactura
declare @cantidad int=1,@tope int= 3
while @cantidad<=100
begin
if @cantidad=@tope
begin
select top(@cantidad)  * from tblFactura
order by Num_Fac desc
break
end
set @cantidad+=1
end
go
--3.Implementar un script que permita mostrar el registro de los clientes, en forma de paginacion de 5 en 5.
declare @pagina int=1
while @pagina<=5
begin
declare @cantidadFilas int = 5
select * from ( select rowNum=ROW_NUMBER() over(order by Cod_Cli),* from tblCliente) 
X
where 
rowNum>(@cantidadFilas*(@pagina-1)) and
rowNum<=(@cantidadFilas*(@pagina-1))+ @cantidadFilas
set @pagina +=1
end 
go