--Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT A.NOMBRE, A.CREDITOS
FROM ASIGNATURA A;
--Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.
SELECT DISTINCT A.CREDITOS
FROM ASIGNATURA A;
--Mostrar todos los datos de todas de las personas
SELECT *
FROM PERSONA P;
--Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT A.NOMBRE, A.CREDITOS
FROM ASIGNATURA A
WHERE A.CUATRIMESTRE=1;
--Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT P.NOMBRE, P.APELLIDO,P.FECHA_NACIMIENTO
FROM PERSONA P 
WHERE (EXTRACT(YEAR FROM P.FECHA_NACIMIENTO)<1975);
--Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT A.NOMBRE, A.COSTEBASICO
FROM ASIGNATURA A
WHERE A.CREDITOS>4.5;
--Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT A.NOMBRE, A.COSTEBASICO
FROM ASIGNATURA A
WHERE (A.COSTEBASICO>24 AND A.COSTEBASICO<36);
--Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT AA.IDALUMNO
FROM ASIGNATURA A, ALUMNO_ASIGNATURA AA
WHERE A.IDASIGNATURA=AA.IDASIGNATURA AND A.IDASIGNATURA LIKE '150212' OR A.IDASIGNATURA LIKE '130113';
--Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT A.NOMBRE, A.CREDITOS
FROM ASIGNATURA A
WHERE A.CUATRIMESTRE=2 AND A.CREDITOS!=6;
--Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT P.NOMBRE, P.APELLIDO
FROM PERSONA P
WHERE P.APELLIDO LIKE 'G%';
--Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion. 
SELECT A.NOMBRE
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION=T.IDTITULACION AND A.IDTITULACION IS NULL;
--Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT A.NOMBRE, T.IDTITULACION
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION=T.IDTITULACION AND A.IDTITULACION IS NOT NULL;
--Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros. 
SELECT A.NOMBRE, A.CREDITOS
FROM ASIGNATURA A
WHERE A.CREDITOS>8;
--Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
SELECT A.NOMBRE, A.CREDITOS*10
FROM ASIGNATURA A;
--Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT *
FROM ASIGNATURA A
WHERE A.CUATRIMESTRE=2
ORDER BY A.IDASIGNATURA ASC;
--Mostrar el nombre de todas las mujeres que viven en “Madrid”.
SELECT P.NOMBRE
FROM PERSONA P
WHERE P.VARON=0 AND CIUDAD LIKE '%Madrid%';
--Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT P.NOMBRE, P.TELEFONO
FROM PERSONA P
WHERE P.TELEFONO LIKE '91%';
--Mostrar el nombre de las asignaturas que contengan la sílaba “pro”
SELECT A.NOMBRE
FROM ASIGNATURA A
WHERE A.NOMBRE LIKE '%Pro%';
--Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT A.NOMBRE,P.IDPROFESOR
FROM ASIGNATURA A, PROFESOR P
WHERE A.IDPROFESOR=P.IDPROFESOR AND CURSO=1 AND P.IDPROFESOR LIKE '%P101%';
--Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, mostrando también el código de la asignatura correspondiente.
SELECT AA.IDALUMNO, AA.IDASIGNATURA
FROM ALUMNO_ASIGNATURA AA
WHERE NUMEROMATRICULA>2;
--El coste de cada asignatura va subiendo a medida que se repite la asignatura. Para saber cuál sería el precio de las distintas asignaturas en las repeticiones (y así animar a nuestros alumnos a que estudien) se quiere mostrar un listado en donde esté el nombre de la asignatura, el precio básico, el precio de la primera repetición (un 10 por ciento más que el coste básico),  el precio de la segunda repetición (un 30 por ciento más que el coste básico) y el precio de la tercer repetición (un 60 por ciento más que el coste básico).
SELECT A.NOMBRE, A.COSTEBASICO, A.COSTEBASICO*1.1, A.COSTEBASICO*1.3, A.COSTEBASICO*1.6
FROM ASIGNATURA A;
--Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de los 70.
SELECT *
FROM PERSONA P
WHERE (EXTRACT(YEAR FROM FECHA_NACIMIENTO)<1970);
--Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT P.IDPROFESOR
FROM PROFESOR P;
--Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA AA, ASIGNATURA A
WHERE AA.IDASIGNATURA=A.IDASIGNATURA AND A.IDASIGNATURA LIKE '130122';
--Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan códigos repetidos.
SELECT DISTINCT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA AA
WHERE AA.IDALUMNO IS NOT NULL;
--Mostrar el nombre de las asignaturas que tienen más de 4 créditos, y además, o se imparten en el primer cuatrimestre o son del primer curso.
SELECT A.NOMBRE
FROM ASIGNATURA A
WHERE A.CREDITOS>4 AND (A.CUATRIMESTRE=1 OR A.CURSO=1);
--Mostrar los distintos códigos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT DISTINCT T.IDTITULACION
FROM TITULACION T, ASIGNATURA A
WHERE T.IDTITULACION=A.IDTITULACION;
--Mostrar el dni de las personas cuyo apellido contiene la letra g en mayúsculas o minúsculas.
SELECT P.DNI, P.APELLIDO
FROM PERSONA P
WHERE P.APELLIDO LIKE UPPER('%g%');
--Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970 y que vivan en una ciudad que empieza por M.
SELECT *
FROM PERSONA P
WHERE P.VARON=1 AND (EXTRACT(YEAR FROM FECHA_NACIMIENTO)>1970) AND P.CIUDAD LIKE 'M%';