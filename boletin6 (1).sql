/*1. Realizar un procedure que se llame insertar_alumno, 
 * que recibirá como parámetro el nombre y apellido de una persona, 
 * e inserte de forma automática esa persona como alumno.*/

CREATE OR REPLACE PROCEDURE insertar_alumno(
  nombre_introducido IN VARCHAR2,
  apellido_introducido IN VARCHAR2
) AS
  dni VARCHAR2(11);
BEGIN
  -- Generar un DNI aleatorio para el alumno
  SELECT LPAD(TRUNC(DBMS_RANDOM.VALUE(10000000, 99999999)), 11, '0') INTO dni FROM DUAL;

  -- Insertar la persona como alumno
  INSERT INTO persona (dni, nombre, apellido)
  VALUES (dni, nombre_introducido, apellido_introducido);

  -- Insertar el alumno
  INSERT INTO alumno (idalumno, dni)
  VALUES (LPAD(TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)), 7, '0'), dni);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Alumno insertado correctamente.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error al insertar el alumno: ' || SQLERRM);
END;

--Llamada
BEGIN
  insertar_alumno('Curro', 'Pérez');
END;

SELECT * FROM ALUMNO a;

SELECT * FROM PERSONA p 


/*2. Realizar una función que reciba como parámetro el nombre y 
 * el apellido de una persona, también debe recibir un parámetro que 
 * podrá ser un 1 (en ese caso debe insertarlo como un alumno) o un 2 
 * (debe insertarlo como profesor), y un parámetro de entrada salida en el 
 * que deberá devolver el código del profesor o alumno insertado. La función 
 * deberá devolver un 1 si se ha podido realizar la inserción, y un cero si 
 * ha ocurrido algún error.*/


CREATE OR REPLACE FUNCTION insertar_persona(
  nombre_introducido IN VARCHAR2,
  apellido_introducido IN VARCHAR2,
  tipo IN NUMBER,
  codigo IN OUT VARCHAR2
) RETURN NUMBER AS
  dni VARCHAR2(11);
BEGIN
  -- Generar un DNI aleatorio para la persona
  dni := LPAD(TRUNC(DBMS_RANDOM.VALUE(10000000, 99999999)), 11, '0');

  -- Insertar la persona en la tabla
  INSERT INTO persona (dni, nombre, apellido)
  VALUES (dni, nombre_introducido, apellido_introducido);

  IF tipo = 1 THEN
    -- Insertar como alumno
    INSERT INTO alumno (idalumno, dni)
    VALUES (LPAD(TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)), 7, '0'), dni);
    codigo := 'ALUMNO_' || dni;  -- Asignar el código del alumno
  ELSIF tipo = 2 THEN
    -- Insertar como profesor
    INSERT INTO profesor (idprofesor, dni)
    VALUES (LPAD(TRUNC(DBMS_RANDOM.VALUE(1000, 9999)), 4, '0'), dni);
    codigo := 'PROFESOR_' || dni;  -- Asignar el código del profesor
  ELSE
    -- Tipo no válido
    codigo := '';
    RETURN 0;
  END IF;

  COMMIT;
  RETURN 1;  -- Inserción exitosa
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    codigo := '';
    RETURN 0;  -- Error al insertar
END;



--LLamada

DECLARE
  codigo VARCHAR2(20);
  resultado NUMBER;
BEGIN
  resultado := insertar_persona('Currito', 'Pérez', 1, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Inserción exitosa. Código: ' || codigo);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error al insertar la persona.');
  END IF;
END;


SELECT * FROM ALUMNO a;
SELECT * FROM PERSONA p 

/*3. Crear un procedure para que se llame tres o más veces a la 
 * función anterior, mostrando el mensaje “El alumno XXXX ha sido 
 * insertado”, o “El alumno XXXX no ha sido insertado, y lo mismo con 
 * profesores donde XXXX será el dato concreto.*/

CREATE OR REPLACE PROCEDURE insertar_varias_personas AS
  codigo VARCHAR2(20);
  resultado NUMBER;
BEGIN
  -- Insertar alumnos
  resultado := insertar_persona('Emilio', 'Pérez', 1, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' no ha sido insertado.');
  END IF;

  resultado := insertar_persona('María', 'Gómez', 1, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' no ha sido insertado.');
  END IF;

  resultado := insertar_persona('Carlos', 'López', 1, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El alumno ' || codigo || ' no ha sido insertado.');
  END IF;

  -- Insertar profesores
  resultado := insertar_persona('Kevin', 'López', 2, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' no ha sido insertado.');
  END IF;

  resultado := insertar_persona('Pedro', 'Sánchez', 2, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' no ha sido insertado.');
  END IF;

  resultado := insertar_persona('Laura', 'García', 2, codigo);
  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' ha sido insertado.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' no ha sido insertado.');
  END IF;

  -- Insertar profesores
  FOR i IN 1..3 LOOP
    resultado := insertar_persona('Profesor', 'Profesor' || i, 2, codigo);
    IF resultado = 1 THEN
      DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' ha sido insertado.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('El profesor ' || codigo || ' no ha sido insertado.');
    END IF;
  END LOOP;
END;


BEGIN
	insertar_varias_personas();
END;

/*4. Realizar una función que devuelva un uno o un cero, si el alumno con dni que se le 
 * pasa como argumento está matriculado en la asignatura cuyo nombre se le pasa también como 
 * argumento. La función también deberá tener un parámetro de entrada salida en donde se devuelva 
 * el nombre y apellido del profesor que le da clase en esa asignatura, si el alumno está matriculado. 
 * Procedure o bloque anónimo para comprobar que funciona.*/


CREATE OR REPLACE FUNCTION comprobar_matricula(
  dni_alumno IN VARCHAR2,
  nombre_asignatura IN VARCHAR2,
  nombre_profesor IN OUT VARCHAR2
) RETURN NUMBER AS
  contandor NUMBER;
BEGIN
  -- Comprobar si el alumno está matriculado en la asignatura
  SELECT COUNT(*) INTO contandor
  FROM alumno_asignatura aa, Alumno a, Asignatura a2, Profesor p2, PERSONA p
	  WHERE aa.IDALUMNO = a.IDALUMNO 
	  AND aa.IDASIGNATURA = a2.IDASIGNATURA 
	  AND a2.IDPROFESOR = p2.IDPROFESOR 
	  AND P.DNI = P2.DNI 
	  AND a.dni = dni_alumno AND a2.nombre = nombre_asignatura;

  IF contandor > 0 THEN
    -- Obtener el nombre y apellido del profesor
    SELECT p.nombre || ' ' || p.APELLIDO INTO nombre_profesor
   	FROM alumno_asignatura aa, Alumno a, Asignatura a2, Profesor p2, PERSONA p
	  WHERE aa.IDALUMNO = a.IDALUMNO 
	  AND aa.IDASIGNATURA = a2.IDASIGNATURA 
	  AND a2.IDPROFESOR = p2.IDPROFESOR 
	  AND P.DNI = P2.DNI 
	  AND a.dni = dni_alumno AND a2.nombre = nombre_asignatura;

    RETURN 1; -- El alumno está matriculado en la asignatura
  ELSE
    nombre_profesor := '';
    RETURN 0; -- El alumno no está matriculado en la asignatura
  END IF;
END;


--Llamada

DECLARE
  dni_alumno VARCHAR2(11) := '1234567890';
  nombre_asignatura VARCHAR2(20) := 'Matemáticas';
  nombre_profesor VARCHAR2(50);
  resultado NUMBER;
BEGIN
  resultado := comprobar_matricula(dni_alumno, nombre_asignatura, nombre_profesor);

  IF resultado = 1 THEN
    DBMS_OUTPUT.PUT_LINE('El alumno está matriculado en la asignatura.');
    DBMS_OUTPUT.PUT_LINE('Profesor: ' || nombre_profesor);
  ELSE
    DBMS_OUTPUT.PUT_LINE('El alumno no está matriculado en la asignatura.');
  END IF;
END;



/*5. Realizar una función que devuelva un 1 si el nombre y apellido de la persona que se 
 * le pasa por parámetro es un alumno, un dos si es un profesor y un 0 si no está 
 * en la base de datos.*/

CREATE OR REPLACE FUNCTION determinar_tipo_persona(
  nombre IN VARCHAR2,
  apellido IN VARCHAR2
) RETURN NUMBER AS
  contador_alumno NUMBER;
  contador_profesor NUMBER;
BEGIN
  -- Verificar si la persona es un alumno
  SELECT COUNT(*) INTO contador_alumno
  FROM alumno a, Persona p
  WHERE P.DNI = A.DNI
  AND p.nombre = nombre AND p.apellido = apellido;

  IF contador_alumno > 0 THEN
    RETURN 1; -- La persona es un alumno
  END IF;

  -- Verificar si la persona es un profesor
  SELECT COUNT(*) INTO contador_profesor
  FROM profesor pr, PERSONA p 
  WHERE P.DNI = PR.DNI
  AND p.nombre = nombre AND p.apellido = apellido;

  IF contador_profesor > 0 THEN
    RETURN 2; -- La persona es un profesor
  END IF;

  -- La persona no está en la base de datos
  RETURN 0;
END;

--Llamda

DECLARE
  nombre VARCHAR2(30) := 'Currito';
  apellido VARCHAR2(30) := 'Pérez';
  tipo_persona NUMBER;
BEGIN
  tipo_persona := determinar_tipo_persona(nombre, apellido);

  IF tipo_persona = 1 THEN
    DBMS_OUTPUT.PUT_LINE('La persona es un alumno.');
  ELSIF tipo_persona = 2 THEN
    DBMS_OUTPUT.PUT_LINE('La persona es un profesor.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('La persona no está en la base de datos.');
  END IF;
END;



/*6. Crear un procedure que reciba como parámetro el nombre de una titulación, 
 * el nombre de la asignatura, y el nombre y apellido del profesor (en dos parámetros distintos), y 
 * que inserte esos datos en la tabla de asignatura. Si se produce un error notificarlo. 
 * Los errores que deben notificarse son:
		•	No existe la titulación
		•	No existe la personas
		•	La persona no es un profesor
		•	El nombre de la asignatura ya está en la base de datos.
*/

CREATE OR REPLACE PROCEDURE insertar_asignatura(
    titulacion_introducida IN titulacion.nombre%TYPE,
    asignatura_introducida IN asignatura.nombre%TYPE,
    nombre_profesor_introducido IN persona.nombre%TYPE,
    apellido_profesor_introducido IN persona.apellido%TYPE,
) AS
    v_id_titulacion varchar2(50);
    v_id_profesor profesor.idprofesor%TYPE;
    id_asignatura asignatura.idasignatura%TYPE;
   V_CODIGO NUMBER;
BEGIN
    -- Verificar si existe la titulación
	SELECT count(idtitulacion) INTO v_id_titulacion FROM titulacion WHERE nombre = titulacion_introducida;
        IF  v_id_titulacion =0 THEN
         raise_application_error(-20001,'No existe la titulación');
        END; 
     --verificar persona  
       SELECT count(dni) INTO v_id_profesor FROM persona WHERE nombre = nombre_profesor_introducido AND apellido = apellido_profesor_introducido;

     	IF  v_id_profesor =0 THEN
         raise_applicat
		IF V_PROF =0 THEN
       	 raise_application_error(-20003,'No es profesor');
		END IF;
	
		SELECT count(IDASIGNATURA) INTO v_asignatura FROM ASIGNATURA a
    	WHERE A.NOMBRE LIKE asignatura_introducida;
       IF V_ASIGNATURA = 1 THEN
       	       	 raise_application_error(-20004,'Ya existe la asignatura');
	   END IF;
	  SELECT MAX(IDASIGNATURA)+1 INTO V_CODIGO FROM ASIGNATURA a2 ;
	 
	   INSERT INTO ASIGNATURA a (IDASIGNATURA,NOMBRE,IDPROFESOR,IDTITULACION) VALUES (V_CODIGO,asignatura_intro

    -- Verificar si ya existe la asignatura
    BEGIN
        SELECT idasignatura INTO id_asignatura FROM asignatura WHERE nombre = asignatura_introducida;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
        WHEN OTHERS THEN
            resultado := 0;
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            RETURN;
    END;

    IF id_asignatura IS NOT NULL THEN
        resultado := 0;
        DBMS_OUTPUT.PUT_LINE('ERROR: El nombre de la asignatura ya está en la base de datos.');
        RETURN;
    END IF;

    -- Insertar la asignatura
    INSERT INTO asignatura(idasignatura, nombre, creditos, cuatrimestre, costebasico, idprofesor, idtitulacion, curso)
    VALUES (asignatura_id_seq.NEXTVAL, asignatura_introducida, 0, 0, 0, id_profesor, id_titulacion, 0);

    resultado := 1;
    DBMS_OUTPUT.PUT_LINE('La asignatura ' || asignatura_introducida || ' ha sido insertada.');
EXCEPTION
    WHEN OTHERS THEN
        resultado := 0;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
--Llamda 
DECLARE
    resultado NUMBER;
BEGIN
    insertar_asignatura('Licenciatura en Informática', 'Programación Avanzada', 'Currito', 'Pérez', resultado);
    
    IF resultado = 1 THEN
        DBMS_OUTPUT.PUT_LINE('La asignatura ha sido insertada.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se pudo insertar la asignatura.');
    END IF;
END;


/*7. Realizar una función que reciba un nombre de titulación y un porcentaje, y que realice 
 * la subida del precio en el porcentaje indicado de las asignaturas de esa titulación. 
 * La función también recibirá un parámetro de entrada salida en la que debe devolver la 
 * cantidad total que se ha subido en todas las asignaturas. La función debe devolver el número 
 * de asignatura que hay en esa titulación o un -1 si no hay ninguna.*/

CREATE OR REPLACE FUNCTION PLSQL_TRIGGERS_6.subir_precio_asignaturas(
    titulacion_introducida IN titulacion.nombre%TYPE,
    porcentaje_introducido IN NUMBER,
    total_subido IN OUT NUMBER
) RETURN NUMBER IS
    id_titulacion titulacion.idtitulacion%TYPE;
    valor_total_subido NUMBER := 0;
    valor_asignaturas NUMBER := 0;
    -- Obtener el ID de la titulación
    BEGIN
        SELECT idtitulacion INTO id_titulacion FROM titulacion WHERE nombre = titulacion_introducida;

    -- Actualizar el precio de las asignaturas de la titulación
    UPDATE asignatura
    SET costebasico = costebasico * (1 + porcentaje_introducido / 100)
    WHERE idtitulacion = id_titulacion;

    -- Obtener la cantidad total subida y el número de asignaturas
    SELECT SUM(costebasico), COUNT(*) INTO valor_total_subido, valor_asignaturas
    FROM asignatura
    WHERE idtitulacion = id_titulacion;

    total_subido := valor_total_subido;

    RETURN valor_asignaturas;
   EXCEPTION
        WHEN NO_DATA_FOUND THEN
            total_subido := 0;
            RETURN -1;
	    WHEN OTHERS THEN
	        total_subido := 0;
	        RETURN -1;
	END;
--Llamada
DECLARE
    titulacion_nombre titulacion.nombre%TYPE := 'NombreTitulacion';
    porcentaje NUMBER := 10;
    total_subido NUMBER;
    num_asignaturas NUMBER;
BEGIN
    num_asignaturas := subir_precio_asignaturas(titulacion_nombre, porcentaje, total_subido);

    IF num_asignaturas = -1 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró ninguna asignatura en la titulación.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cantidad total subida: ' || total_subido);
        DBMS_OUTPUT.PUT_LINE('Número de asignaturas en la titulación: ' || num_asignaturas);
    END IF;
END;

/*CREATE OR REPLACE FUNCTION PLSQL_TRIGGERS_6.subir_precio_asignaturas(
    titulacion_introducida IN titulacion.nombre%TYPE,
    porcentaje_introducido IN NUMBER,
    total_subido IN OUT NUMBER
) RETURN NUMBER IS
    id_titulacion titulacion.idtitulacion%TYPE;
    valor_total_subido NUMBER := 0;
    valor_asignaturas NUMBER := 0;
BEGIN
    -- Obtener el ID de la titulación
        SELECT idtitulacion INTO id_titulacion FROM titulacion WHERE nombre = titulacion_introducida;


    -- Actualizar el
UPDATE asignatura
    SET costebasico = costebasico * (1 + porcentaje_introducido / 100)
    WHERE idtitulacion = id_titulacion;

    -- Obtener la cantidad total subida y el número de asignaturas
    SELECT SUM(costebasico)INTO valor_total_subido
    FROM asignatura
    WHERE idtitulacion = id_titulacion;
    --cuantas asignaturas tiene la titulación.
   SELECT  COUNT() INTO  valor_asignaturas
    FROM asignatura
    WHERE idtitulacion = id_titulacion;
    total_subido := valor_total_subido;
RETURN valor_asignaturas;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            total_subido := 0;
            RETURN -1;
   	 WHEN OTHERS THEN
        total_subido := 0;
        RETURN -1;
END;*/


