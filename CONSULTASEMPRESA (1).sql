DROP TABLE EMPLEADO;
DROP TABLE DEPARTAMENTO;
CREATE TABLE DEPARTAMENTO
(
	DEPT_NO VARCHAR (10),
	DNOMBRE VARCHAR (20),
	LOC VARCHAR (10),
	CONSTRAINT PRIMARY KEY PK_DEPARTAMENTO (DEPT_NO)
);
CREATE TABLE EMPLEADO 
(
	EMP_NO VARCHAR (5),
	APELLIDO VARCHAR (10),
	OFICIO VARCHAR (10),
	DIR VARCHAR (5),
	FECHA_ALT DATE,
	SALARIO INTEGER (10),
	COMISION INTEGER (10),
	DEPT_NO VARCHAR (5),
	CONSTRAINT PRIMARY KEY PK_EMPLEADO (EMP_NO),
	CONSTRAINT FOREIGN KEY FK_EMPLEADO (DEPT_NO) REFERENCES DEPARTAMENTO (DEPT_NO)
); 
INSERT DEPARTAMENTO
VALUES("10","CONTABILIDAD","SEVILLA");
INSERT DEPARTAMENTO
VALUES("20","INVESTIGACION","MADRID");
INSERT DEPARTAMENTO
VALUES("30","VENTAS","BARCELONA");
INSERT DEPARTAMENTO
VALUES("40","PRODUCCION","BILBAO");
INSERT INTO EMPLEADO
VALUES("7639","SANCHEZ","EMPLEADO","7902",STR_TO_DATE('17-12-1980','%d-%m-%Y'),104000,NULL,"20");
INSERT INTO EMPLEADO
VALUES("7499","ARROYO","VENDEDOR","7698",STR_TO_DATE('20-02-1981','%d-%m-%Y'),208000,39000,"30");
INSERT INTO EMPLEADO
VALUES("7521","SALA","VENDEDOR","7689",STR_TO_DATE('22-02-1981','%d-%m-%Y'),162500,162500,"30");
INSERT INTO EMPLEADO
VALUES("7566","JIMENEZ","DIRECTOR","7839",STR_TO_DATE('02-04-1981','%d-%m-%Y'),386750,NULL,"20");
INSERT INTO EMPLEADO
VALUES("7654","MARTIN","VENDEDOR","7698",STR_TO_DATE('29-09-1981','%d-%m-%Y'),162500,182000,"30");
INSERT INTO EMPLEADO
VALUES("7698","NEGRO","DIRECTOR","7839",STR_TO_DATE('01-05-1981','%d-%m-%Y'),370500,NULL,"30");
INSERT INTO EMPLEADO
VALUES("7788","GIL","ANALISTA","7566",STR_TO_DATE('09-11-1981','%d-%m-%Y'),390000,NULL,"20");
INSERT INTO EMPLEADO
VALUES("7839","REY","PRESIDENTE",NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),650000,NULL,"10");
INSERT INTO EMPLEADO
VALUES("7844","TOVAR","VENDEDOR","7698",STR_TO_DATE('08-09-1981','%d-%m-%Y'),195000,0,"30");
INSERT INTO EMPLEADO
VALUES("7654","ALONSO","EMPLEADO","7788",STR_TO_DATE('23-09-1981','%d-%m-%Y'),143000,NULL,"20");
INSERT INTO EMPLEADO
VALUES("7900","JIMENO","EMPLEADO","7698",STR_TO_DATE('03-12-1981','%d-%m-%Y'),1235000,NULL,"30");
INSERT INTO EMPLEADO
VALUES("7902","FERNANDEZ","ANALISTA","7566",STR_TO_DATE('03-12-1980','%d-%m-%Y'),390000,NULL,"20");
INSERT INTO EMPLEADO
VALUES("7934","MUÑOZ","EMPLEADO","7782",STR_TO_DATE('23-01-1982','%d-%m-%Y'),169000,NULL,"10");
#1 Mostrar el apellido, oficio y número de departamento de cada empleado
SELECT E.APELLIDO, E.OFICIO, E.DEPT_NO
FROM EMPLEADO E;
#2 Mostrar el número, nombre y localización de cada departamento.
SELECT D.DEPT_NO, D.DNOMBRE, D.LOC
FROM DEPARTAMENTO D;
#3 Mostrar todos los datos de todos los empleados.
SELECT *
FROM EMPLEADO E;
#4 Datos de los empleados ordenados por apellidos.
SELECT *
FROM EMPLEADO E
ORDER BY E.APELLIDO ASC;
#5 Datos de los empleados ordenados por número de departamento descendentemente.
SELECT *
FROM EMPLEADO E
ORDER BY E.DEPT_NO DESC;
#6 Datos de los empleados ordenados por número de departamento descendentemente y dentro de cada departamento ordenados por apellido ascendentemente.
SELECT *
FROM EMPLEADO E
ORDER BY E.DEPT_NO DESC, E.APELLIDO ASC;
#8 Mostrar los datos de los empleados cuyo salario sea mayor que 2000000.
SELECT *
FROM EMPLEADO E
WHERE E.SALARIO>2000000;
#9 Mostrar los datos de los empleados cuyo oficio sea ʻANALISTAʼ.
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'ANALISTA';
#10 Seleccionar el apellido y oficio de los empleados del departamento número 20.
SELECT E.APELLIDO, E.OFICIO
FROM EMPLEADO E
WHERE E.DEPT_NO LIKE '20';
#11 Mostrar todos los datos de los empleados ordenados por apellido.
SELECT *
FROM EMPLEADO E
ORDER BY E.APELLIDO DESC;
#12 Seleccionar los empleados cuyo oficio sea ʻVENDEDORʼ. Mostrar los datos ordenados por apellido.
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'VENDEDOR'
ORDER BY E.APELLIDO DESC;
#13 Mostrar los empleados cuyo departamento sea 10 y cuyo oficio sea ʻANALISTAʼ. Ordenar el resultado por apellido
SELECT *
FROM EMPLEADO E
WHERE E.DEPT_NO LIKE '10' AND E.OFICIO LIKE 'ANALISTA'
ORDER BY E.APELLIDO ASC;
#14 Mostrar los empleados que tengan un salario mayor que 200000 o que pertenezcan al departamento número 20.
SELECT *
FROM EMPLEADO E
WHERE E.SALARIO >200000 OR E.DEPT_NO=20;
#15 Ordenar los empleados por oficio, y dentro de oficio por nombre.
SELECT *
FROM EMPLEADO E
ORDER BY E.OFICIO DESC, E.OFICIO ASC;
#16 Seleccionar de la tabla EMPLE los empleados cuyo apellido empiece por ʻAʼ.
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE 'A%';
#17 Seleccionar de la tabla EMPLE los empleados cuyo apellido termine por ʻZʼ.
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE '%Z';
#18 Seleccionar de la tabla EMPLE aquellas filas cuyo APELLIDO empiece por ʻAʼ y el OFICIO tenga una ʻEʼ en cualquier posición.
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE 'A%' AND E.OFICIO LIKE '%E%';
#19 Seleccionar los empleados cuyo salario esté entre 100000 y 200000. Utilizar el operador BETWEEN
SELECT *
FROM EMPLEADO E
WHERE E.SALARIO BETWEEN 100000 AND 200000;
#20 Obtener los empleados cuyo oficio sea ʻVENDEDORʼ y tengan una comisión superior a 100000.
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'VENDEDOR' AND E.COMISION >100000;
#21 Seleccionar los datos de los empleados ordenados por número de departamento, y dentro de cada departamento ordenados por apellido
SELECT *
FROM EMPLEADO E
ORDER BY E.DEPT_NO DESC, E.APELLIDO DESC;
#22 Número y apellidos de los empleados cuyo apellido termine por ʻZʼ y tengan un salario superior a 300000.
SELECT E.APELLIDO, E.EMP_NO
FROM EMPLEADO E
WHERE E.APELLIDO LIKE '%Z' AND SALARIO>300000;
#23. Datos de los departamentos cuya localización empiece por ʻBʼ.
SELECT *
FROM DEPARTAMENTO D
WHERE D.LOC LIKE 'B%';
#24. Datos de los empleados cuyo oficio sea ʻEMPLEADOʼ, tengan un salario superior a 100000 y pertenezcan al departamento número 10.
SELECT *
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'EMPLEADO' AND E.SALARIO>100000 AND DEPT_NO LIKE '10';
#25. Mostrar los apellidos de los empleados que no tengan comisión.
SELECT E.APELLIDO
FROM EMPLEADO E
WHERE E.COMISION IS NULL;
#26. Mostrar los apellidos de los empleados que no tengan comisión y cuyo apellido empiece por ʻJʼ.
SELECT E.APELLIDO
FROM EMPLEADO E
WHERE E.COMISION IS NULL AND E.APELLIDO LIKE 'J%';
#27. Mostrar los apellidos de los empleados cuyo oficio sea ʻVENDEDORʼ, ʻANALISTAʼ o ʻEMPLEADOʼ.
SELECT E.APELLIDO
FROM EMPLEADO E
WHERE E.OFICIO LIKE 'VENDEDOR' OR E.OFICIO LIKE 'ANALISTA' OR E.OFICIO LIKE 'EMPLEADO';
#28. Mostrar los apellidos de los empleados cuyo oficio no sea ni ʻANALISTAʼ ni ʻEMPLEADOʼ, y además tengan un salario mayor de 200000.
SELECT E.APELLIDO
FROM EMPLEADO E
WHERE E.OFICIO NOT LIKE 'ANALISTA' AND E.OFICIO NOT LIKE 'EMPLEADO' AND E.SALARIO>200000;
#29 Seleccionar de la tabla EMPLE los empleados cuyo salario esté entre 2000000 y 3000000 (utilizar BETWEEN).
SELECT *
FROM EMPLEADO E
WHERE E.SALARIO BETWEEN 2000000 AND 3000000;
#30 Seleccionar el apellido, salario y número de departamento de los empleados cuyo salario sea mayor que 200000 en los departamentos 10 ó 30.
SELECT E.APELLIDO, E.SALARIO, D.DEPT_NO
FROM DEPARTAMENTO D, EMPLEADO E
WHERE E.DEPT_NO=D.DEPT_NO AND (E.SALARIO>200000 AND (D.DEPT_NO="10" OR D.DEPT_NO="30"));
#31. Mostrar el apellido y número de los empleados cuyo salario no esté entre 100000 y 200000 (utilizar BETWEEN).
SELECT E.APELLIDO, E.EMP_NO
FROM EMPLEADO E
WHERE E.SALARIO BETWEEN 100000 AND 200000;
#32.Obtener el apellidos de todos los empleados en minúscula
SELECT LOWER(E.APELLIDO)
FROM EMPLEADO E;
#33.En una consulta concatena el apellido de cada empleado con su oficio
SELECT CONCAT(E.APELLIDO,E.OFICIO)
FROM EMPLEADO E;
#34. Mostrar el apellido y la longitud del apellido (función LENGTH) de todos los empleados, ordenados por la longitud de los apellidos de los empleados descendentemente.
SELECT E.APELLIDO, LENGTH(E.APELLIDO) AS LONGITUD_APELLIDO
FROM EMPLEADO E
ORDER BY LONGITUD_APELLIDO DESC;
#35.Obtener el año de contratación de todos los empleados (función YEAR).
SELECT YEAR(E.FECHA_ALT)
FROM EMPLEADO E;
#36. Mostrar los datos de los empleados que hayan sido contratados en el año 1992.
SELECT *
FROM EMPLEADO E
WHERE EXTRACT(YEAR FROM E.FECHA_ALT)=1992;
#37. Mostrar los datos de los empleados que hayan sido contratados en el mes de febrero de cualquier año (función MONTHNAME).
SELECT *
FROM EMPLEADO E
WHERE MONTHNAME(E.FECHA_ALT)='FEBRUARY';
#38. Para cada empleado mostrar el apellido y el mayor valor del salario y la comisión que tienen.
SELECT E.APELLIDO, E.SALARIO, E.COMISION
FROM EMPLEADO E
ORDER BY E.SALARIO DESC;
#39. Mostrar los datos de los empleados cuyo apellido empiece por 'A' y hayan sido contratados en el año 1990.
SELECT *
FROM EMPLEADO E
WHERE E.APELLIDO LIKE 'A%' AND (EXTRACT(YEAR FROM E.FECHA_ALT))=1990;
#40. Mostrar los datos de los empleados del departamento 10 que no tengan comisión.
SELECT *
FROM EMPLEADO E
WHERE E.DEPT_NO="10" AND E.COMISION IS NULL;



