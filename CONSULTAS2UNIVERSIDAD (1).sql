--Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste mostrar por orden alfabético de nombre de asignatura.
SELECT A.COSTEBASICO, A.IDTITULACION
FROM ASIGNATURA A
ORDER BY A.COSTEBASICO DESC, A.NOMBRE ASC;
--Mostrar el nombre y los apellidos de los profesores. 
SELECT P.NOMBRE, P.APELLIDO
FROM PROFESOR PR, PERSONA P
WHERE PR.DNI=P.DNI;
--Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 
SELECT A.NOMBRE
FROM ASIGNATURA A, PROFESOR PR, PERSONA P
WHERE PR.DNI=P.DNI AND A.IDPROFESOR=PR.IDPROFESOR AND P.CIUDAD LIKE 'Sevilla';
--Mostrar el nombre y los apellidos de los alumnos.
SELECT P.NOMBRE, P.APELLIDO
FROM ALUMNO A, PERSONA P
WHERE A.DNI=P.DNI;
--Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT A.DNI, P.NOMBRE, P.APELLIDO
FROM ALUMNO A, PERSONA P
WHERE A.DNI=P.DNI AND P.CIUDAD LIKE 'Sevilla';
--Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT P.DNI, P.NOMBRE, P.APELLIDO
FROM PERSONA P, ALUMNO A, ALUMNO_ASIGNATURA AA, ASIGNATURA ASI
WHERE A.DNI=P.DNI AND A.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=ASI.IDASIGNATURA AND ASI.NOMBRE LIKE 'Seguridad Vial';
--  7. Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
SELECT  A.IDTITULACION
FROM ASIGNATURA A, ALUMNO_ASIGNATURA AA, ALUMNO A
WHERE A.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=A.IDASIGNATURA AND A.DNI LIKE '20202020A';
--    8. Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
SELECT ASI.NOMBRE
FROM ASIGNATURA ASI, ALUMNO_ASIGNATURA AA, ALUMNO A, PERSONA P
WHERE A.DNI=P.DNI AND AA.IDASIGNATURA=ASI.IDASIGNATURA AND AA.IDALUMNO=A.IDALUMNO AND P.NOMBRE LIKE 'Rosa' AND P.APELLIDO LIKE 'Garcia';
--Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
SELECT P.DNI
FROM ALUMNO A, PROFESOR PR, ASIGNATURA ASI, ALUMNO_ASIGNATURA AA, PERSONA P
WHERE AA.IDASIGNATURA=ASI.IDASIGNATURA AND AA.IDALUMNO=A.IDALUMNO AND ASI.IDPROFESOR=PR.IDPROFESOR AND P.DNI=PR.DNI AND P.NOMBRE LIKE 'Jorge' AND P.APELLIDO LIKE 'Saenz';
-- 10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 
SELECT P.DNI, P.NOMBRE, P.APELLIDO
FROM ALUMNO A, PROFESOR PR, ASIGNATURA ASI, ALUMNO_ASIGNATURA AA, PERSONA P
WHERE AA.IDASIGNATURA=ASI.IDASIGNATURA AND AA.IDALUMNO=A.IDALUMNO AND ASI.IDPROFESOR=PR.IDPROFESOR AND P.DNI=PR.DNI AND P.NOMBRE LIKE 'Jorge' AND P.APELLIDO LIKE 'Saenz';
--Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 
SELECT T.NOMBRE
FROM TITULACION T, ASIGNATURA A
WHERE A.IDTITULACION=T.IDTITULACION AND A.CREDITOS>=4;
--Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 
SELECT A.NOMBRE, A.CREDITOS, T.NOMBRE
FROM ASIGNATURA A, TITULACION T
WHERE A.IDTITULACION=T.IDTITULACION AND A.CUATRIMESTRE=1;
--Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas
SELECT ASI.NOMBRE, ASI.COSTEBASICO, P.NOMBRE
FROM ASIGNATURA ASI, ALUMNO_ASIGNATURA AA, ALUMNO A, PERSONA P
WHERE A.DNI=P.DNI AND AA.IDASIGNATURA=ASI.IDASIGNATURA AND AA.IDALUMNO=A.IDALUMNO AND ASI.CREDITOS>=4.5;
--Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
SELECT P.NOMBRE
FROM ASIGNATURA ASI, PROFESOR PR, PERSONA P
WHERE ASI.IDPROFESOR=PR.IDPROFESOR AND PR.DNI=P.DNI AND (COSTEBASICO>24 AND COSTEBASICO<36);
--Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.
SELECT DISTINCT  P.NOMBRE
FROM PERSONA P, ALUMNO A, ALUMNO_ASIGNATURA AA, ASIGNATURA ASI
WHERE A.DNI=P.DNI AND A.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=ASI.IDASIGNATURA AND (ASI.IDASIGNATURA LIKE '150212' OR ASI.IDASIGNATURA LIKE '130113');
--Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.
SELECT ASI.NOMBRE, T.NOMBRE
FROM ASIGNATURA ASI, TITULACION T
WHERE ASI.IDTITULACION=T.IDTITULACION AND ASI.CUATRIMESTRE=2 AND ASI.CREDITOS!=6;
--Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.
SELECT ASI.NOMBRE, ASI.CREDITOS*10 AS NUMERO_HORAS, A.DNI
FROM ASIGNATURA ASI, ALUMNO_ASIGNATURA AA, ALUMNO A
WHERE A.IDALUMNO=AA.IDALUMNO AND AA.IDASIGNATURA=ASI.IDASIGNATURA;
--Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura
SELECT P.NOMBRE
FROM ALUMNO A, PERSONA P
WHERE A.DNI=P.DNI AND P.VARON=0 AND P.CIUDAD LIKE 'Sevilla';
--Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT ASI.NOMBRE
FROM ASIGNATURA ASI
WHERE ASI.CURSO=1 AND ASI.IDPROFESOR LIKE 'p101';
--LO MAS LOGICO
SELECT ASI.NOMBRE
FROM ASIGNATURA ASI
WHERE ASI.CURSO=1 AND ASI.IDPROFESOR LIKE 'P101';
--Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
SELECT P.NOMBRE
FROM ALUMNO_ASIGNATURA AA, ALUMNO A, PERSONA P
WHERE AA.IDALUMNO=A.IDALUMNO AND A.DNI=P.DNI AND AA.NUMEROMATRICULA>=3;
