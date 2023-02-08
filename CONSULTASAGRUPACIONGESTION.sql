--Descuento medio aplicado en las facturas.
SELECT AVG(F.DTO)
FROM FACTURAS F;
--Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(F.DTO)
FROM FACTURAS F;
--Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT AVG(NVL(F.DTO,0))
FROM FACTURAS F;
--Número de facturas.
SELECT COUNT(F.CODFAC)
FROM FACTURAS F;
--Número de pueblos de la Comunidad de Valencia.
SELECT COUNT(P.CODPUE)
FROM PUEBLOS P, PROVINCIAS PR
WHERE P.CODPRO=PR.CODPRO AND PR.NOMBRE IN  ('VALENCIA','ALICANTE', 'CASTELLON');
--Importe total de los artículos que tenemos en el almacén. Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(A.STOCK*A.PRECIO) AS VALOR_MERCANCIA
FROM ARTICULOS A;
--Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
SELECT COUNT(P.CODPUE)
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE=P.CODPUE AND C.CODPOSTAL LIKE '12%';
--Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
SELECT MAX(A.STOCK), MIN(A.STOCK_MIN) , MAX(A.STOCK)-MIN(A.STOCK_MIN) AS DIFERENCIA
FROM ARTICULOS A
WHERE A.PRECIO BETWEEN 9 AND 12;
--Precio medio de los artículos cuyo stock supera las 10 unidades.
SELECT AVG(A.PRECIO)
FROM ARTICULOS A
WHERE A.STOCK>10;
--Fecha de la primera y la última factura del cliente con código 210.
SELECT MAX(F.FECHA) AS PRIMERA_FACTURA, MIN(F.FECHA) AS ULTIMA_FACTURA
FROM FACTURAS F
WHERE F.CODCLI=210;
--Número de artículos cuyo stock es nulo.
SELECT COUNT(A.CODART)
FROM ARTICULOS A
WHERE A.STOCK IS NULL;
--Número de líneas cuyo descuento es nulo (con un decimal)
SELECT COUNT(CODFAC)
FROM LINEAS_FAC LF
WHERE LF.DTO IS NULL;
--Obtener cuántas facturas tiene cada cliente.
SELECT F.CODCLI, COUNT(CODFAC)
FROM FACTURAS F
GROUP BY F.CODCLI;
--Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.
SELECT F.CODCLI, COUNT(F.CODFAC)
FROM FACTURAS F
GROUP BY F.CODCLI
HAVING COUNT(F.CODFAC)>=2;
--Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los  artículos
SELECT SUM(LF.PRECIO*LF.CANT) AS FACTURACION
FROM LINEAS_FAC LF;
--16.	Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
SELECT SUM(LF.PRECIO*LF.CANT) AS FACTURACION
FROM LINEAS_FAC LF
WHERE (UPPER(LF.CODART)) LIKE '%A%';
--17.	Número de facturas para cada fecha, junto con la fecha
SELECT COUNT(F.FECHA) AS NUMERO_FACTURAS, F.FECHA
FROM FACTURAS F
GROUP BY F.FECHA;
--18.	Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.
SELECT COUNT(C.CODCLI) AS NUMERO_CLIENTES, P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE=P.CODPUE
GROUP BY P.NOMBRE
ORDER BY NUMERO_CLIENTES DESC;
--19.	Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan, siempre y cuando tengan más de dos clientes.
SELECT COUNT(C.CODCLI) AS NUMERO_CLIENTES, P.NOMBRE
FROM CLIENTES C, PUEBLOS P
WHERE C.CODPUE=P.CODPUE
GROUP BY P.NOMBRE
HAVING COUNT(C.CODCLI)>2
ORDER BY NUMERO_CLIENTES DESC;
--20.	Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de dicho artículo.
SELECT SUM(LF.CANT), A.DESCRIP
FROM LINEAS_FAC LF, ARTICULOS A
WHERE LF.CODART=A.CODART AND A.CODART LIKE 'P%'
GROUP BY A.DESCRIP;
--9.-	Precio máximo y precio mínimo de venta (en líneas de facturas) para cada artículo cuyo código empieza por “c”.
SELECT MAX(LF.PRECIO) AS PRECIO_MAXIMO, MIN(LF.PRECIO) AS PRECIO_MINIMO, LF.CODART
FROM LINEAS_FAC LF
WHERE LF.CODART LIKE 'P%'
GROUP BY LF.CODART;
--21.	Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.
SELECT MAX(LF.PRECIO) AS PRECIO_MAXIMO, MIN(LF.PRECIO) AS PRECIO_MINIMO, LF.CODART, (MAX(LF.PRECIO)-MIN(LF.PRECIO)) AS DIFERENCIA_PRECIO
FROM LINEAS_FAC LF
WHERE LF.CODART LIKE 'P%'
GROUP BY LF.CODART;
--22.	Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.
SELECT A.DESCRIP
FROM ARTICULOS A, LINEAS_FAC LF
WHERE A.CODART=LF.CODART AND (LF.CANT*LF.PRECIO)>10000;
--23.	Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), con cada IVA distinto que se les ha aplicado.
SELECT COUNT(F.CODFAC), F.CODCLI, F.IVA
FROM FACTURAS F
WHERE F.CODCLI BETWEEN 150 AND 300
GROUP BY F.CODCLI, F.IVA;
--24.	Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.
SELECT ROUND(AVG(LF.CANT*LF.PRECIO),2) AS MEDIA_FACTURAS
FROM LINEAS_FAC LF



