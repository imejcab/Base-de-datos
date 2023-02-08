--Código, fecha y doble del descuento de las facturas con iva cero.
SELECT codfac,fecha,dto*2
FROM facturas
WHERE iva=0;
--Código de las facturas con iva nulo.
SELECT codfac
FROM facturas
WHERE iva IS NULL;
--Código y fecha de las facturas sin iva (iva cero o nulo).
SELECT codfac,fecha
FROM facturas
WHERE (iva=0 OR iva IS NULL);
--Código de factura y de artículo de las líneas de factura en las que la cantidad solicitada es menor de 5 unidades y además se ha aplicado un descuento del 25% o mayor.
SELECT codfac, codart
FROM lineas_fac
WHERE (cant<5 AND dto>=25);
--Obtener la descripción de los artículos cuyo stock está por debajo del stock mínimo, dado también la cantidad en unidades necesaria para alcanzar dicho mínimo.
SELECT descrip
FROM articulos
WHERE (stock<stock_min);
--Ivas distintos aplicados a las facturas.
SELECT DISTINCT iva
FROM facturas;
--Código, descripción y stock mínimo de los artículos de los que se desconoce la cantidad de stock. Cuando se desconoce la cantidad de stock de un artículo, el stock es nulo.
SELECT codart,descrip,stock_min
FROM articulos
WHERE stock IS NULL;
--Obtener la descripción de los artículos cuyo stock es más de tres veces su stock mínimo y cuyo precio supera los 6 euros.
SELECT descrip
FROM articulos
WHERE stock=3*stock_min AND precio>6;
--Código de los artículos (sin que salgan repetidos) comprados en aquellas facturas cuyo código está entre 8 y 10.
SELECT DISTINCT codart	
FROM lineas_fac
WHERE (codfac>=8 AND codfac<=10);
--Mostrar el nombre y la dirección de todos los clientes.
SELECT nombre,direccion
FROM clientes;
--Mostrar los distintos códigos de pueblos en donde tenemos clientes
SELECT DISTINCT codpue
FROM clientes;
--Obtener los códigos de los pueblos en donde hay clientes con código de cliente menor que el código 25. No deben salir códigos repetidos.
SELECT DISTINCT codpue
FROM clientes 
WHERE (codcli<25);
--Nombre de las provincias cuya segunda letra es una 'O' (bien mayúscula o minúscula).
SELECT nombre
FROM provincias
WHERE (nombre LIKE '_o%' OR nombre LIKE '_O%');
--Código y fecha de las facturas del año pasado para aquellos clientes cuyo código se encuentra entre 50 y 100.
SELECT codfac, fecha
FROM facturas
WHERE (EXTRACT (YEAR FROM fecha))= (EXTRACT (YEAR FROM sysdate)-1)
AND codcli BETWEEN 50 AND 100;
--Nombre y dirección de aquellos clientes cuyo código postal empieza por “12”. 
SELECT nombre,direccion
FROM clientes
WHERE codpostal LIKE '12%';
--Mostrar las distintas fechas, sin que salgan repetidas, de las factura existentes de clientes cuyos códigos son menores que 50.
SELECT DISTINCT fecha
FROM facturas 
WHERE codcli<50;
--Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004
SELECT codfac,fecha 
FROM facturas
WHERE ((EXTRACT(MONTH FROM fecha)=06) AND (EXTRACT(YEAR FROM fecha)=2004));
--Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004 para aquellos clientes cuyo código se encuentra entre 100 y 250.
SELECT codfac,fecha 
FROM facturas
WHERE (((EXTRACT(MONTH FROM fecha)=06) AND (EXTRACT(YEAR FROM fecha)=2004)) AND (codcli>100 AND codcli<250));
--Código y fecha de las facturas para los clientes cuyos códigos están entre 90 y 100 y no tienen iva. NOTA: una factura no tiene iva cuando éste es cero o nulo.
SELECT codfac, fecha
FROM facturas 
WHERE ((codcli BETWEEN 90 AND 100) AND (iva IS NULL OR iva=0));
--Nombre de las provincias que terminan con la letra 's' (bien mayúscula o minúscula).
SELECT nombre 
FROM provincias
WHERE ((nombre LIKE '%s') OR (nombre LIKE '%S'));
--Nombre de los clientes cuyo código postal empieza por “02”, “11” ó “21”.
SELECT nombre
FROM CLIENTES 
WHERE codpostal LIKE '02%' OR codpostal LIKE '11%' OR codpostal LIKE '21';
--artículos (todas las columnas) cuyo stock sea mayor que el stock mínimo    y no haya en stock más de 5 unidades del stock_min.
SELECT *
FROM articulos
WHERE (stock>stock_min) AND stock-stock_min<6;
--Nombre de las provincias que contienen el texto “MA” (bien mayúsculas o minúsculas).
SELECT nombre
FROM provincias
WHERE (nombre LIKE '%ma%' OR nombre LIKE '%MA%');
--Se desea promocionar los artículos de los que se posee un stock grande. Si el artículo es de más de 6000 € y el stock supera los 60000 €, se hará un descuento del 10%. Mostrar un listado de los artículos que van a entrar en la promoción, con su código de artículo, nombre del articulo, precio actual y su precio en la promoción.
SELECT codart, descrip, precio,precio*0.9
FROM articulos
WHERE (stock*precio>60000 AND precio>6000);
