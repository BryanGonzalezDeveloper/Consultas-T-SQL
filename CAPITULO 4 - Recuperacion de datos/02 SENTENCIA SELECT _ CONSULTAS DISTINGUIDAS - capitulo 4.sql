use
VentasDB
go

--EN ESTOS BREVES EJEMPLOS SERAN REALIZADAS ALGUNA CONSULTAS DISTINGUIDAS.

--UNA CONSULTA DISTINGUIDA SIRVE PARA EVITAR MOSTRAR CAMPOS CON VALORES REPETIDOS. EN SU FORMA MAS BASICA
--POSEE EL SIGUIENTE FORMATO:

--SELECT <DISTINCT> <CAMPO> FROM <NOMBRE_TABLA>
--GO

--DONDE "DISTINCT" ES UNNA PALABRA RESERVA DE SQL SERVER, DESPUES DE ELLA SE INDICA "CAMPO", QUE ES EL NOMBRE DEL CAMPO
--DEL CUAL SE QUIERE HACER LA DISTINCION. POR EJEMPLO:

--Listar todos los tipos de unidades que poseen los productod (Unidades_Pro)....una forma sencilla de hacerlo 
--seria la siguiente:

select tblProducto.Unidades_Pro from tblProducto
go
--El inconveniente se presenta cuando al existir en diferentes productos el mismo tipo de unidad, al realizar la consulta
--de esta forma, algunos datos se repiten. La solucion seria realizar una consulta distinguida de la siguiente manera:

select distinct p.Unidades_Pro from tblProducto as p
go
--El resultado de la consulta anterior seria mostrar solo una vez cada tipo de unidad existente en los productos.
-- por ejemplo: (PAQUETE, BOLSA,DOCENA,MLL,ETC.) segun el tipo de unidad que especifiquemos al momento de crear la tabla.

