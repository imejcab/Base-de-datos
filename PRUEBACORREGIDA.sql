--Crea un paquete con la siguiente nomenclatura TUNOMBREgestioncarreras que contendrá la
--función y el procedimiento solicitados en el ejercicio 2 y ejercicio3. Es decir tendrá:
--Función listadocaballos que no recibirá ningún parámetro y devolverá un número.
--Procedimiento agregarcaballos que recibirá como argumento el nombre, peso, fecha
--de nacimiento, nacionalidad y el dni y el nombre del dueño
CREATE OR REPLACE
PACKAGE IVANGESTIONCARRERAS IS 
VERSION NUMBER:=1.0;
FUNCTION LISTADOCABALLOS() 
RETURN NUMBER;
PROCEDURE AGREGARCABALLOS(NOMBRE VARCHAR2, PESO NUMBER, FECHANAC DATE, NACIONALIDAD VARCHAR2, DNI VARCHAR2, NOMBREDUEÑO VARCHAR2);
END IVANGESTIONCARRERAS;
--Implementa la FUNCIÓN listadocaballos que muestre en consola el siguiente listado y que
--devuelva el número de caballos mostrados en el listado. Deberás utilizar cursores e indicar en
--un comentario en el código el tipo de cursor que estás utilizando.
CREATE OR REPLACE FUNCTION CABALLOS.LISTADOCABALLO
RETURN NUMBER
IS
    --ES UN CURSOR EXPLICITO
    CURSOR C_CABALLOS IS
    SELECT C.NOMBRE AS NOMBRECABALLO, C.PESO, P.NOMBRE AS NOMBREPERSONA
    FROM CABALLOS C, PERSONAS P
    WHERE C.PROPIETARIO=P.CODIGO
    ORDER BY C.NACIONALIDAD, C.PROPIETARIO DESC;
    --ES UN CURSOR EXPLICITO
    CURSOR C_CARRERA IS
    SELECT C.NOMBRECARRERA, PE.NOMBRE AS NOMBREPROPIETARIO, C.FECHAHORA, P.POSICIONFINAL, C.IMPORTEPREMIO
    FROM PARTICIPACIONES P, CARRERAS C, PERSONAS PE
    WHERE P.CODCARRERA=C.CODCARRERA AND PE.CODIGO=P.JOCKEY
    ORDER BY C.NOMBRECARRERA, C.FECHAHORA DESC;
    CARRERASGANADAS NUMBER;
    PREMIOTOTAL NUMBER;
BEGIN
    --CURSORES ANIDADOS CON BUCLE FOR
    FOR REGISTRO IN C_CABALLOS LOOP
    	CARRERASGANADAS :=0;
    	PREMIOTOTAL :=0;
	    DBMS_OUTPUT.PUT_LINE(' CABALLO ' || REGISTRO.NOMBRECABALLO ||
	                            ' PESO ' || REGISTRO.PESO ||
	                            ' DUEÑO ' || REGISTRO.NOMBREPERSONA);
        FOR REGISTRO2 IN C_CARRERA LOOP
        PREMIOTOTAL:=PREMIOTOTAL+REGISTRO2.IMPORTEPREMIO;
        	DBMS_OUTPUT.PUT_LINE('NOMBRE DE CARRERA ' || REGISTRO2.NOMBRECARRERA || ' NOMBRE DE JOCKEY ' || REGISTRO2.NOMBREPROPIETARIO || ' FECHA ' || REGISTRO2.FECHAHORA || ' POSICIONFINAL ' || REGISTRO2.POSICIONFINAL || ' IMPORTEPREMIO ' || REGISTRO2.IMPORTEPREMIO);
        IF REGISTRO.POSICIONFINAL=1 THEN
        	CARRERASGANADAS:=CARRERASGANADAS+1;
        END IF;
        DBMS_OUTPUT.PUT_LINE('NUMERO DE CARRERAS GANADAS ' || CARRERASGANADAS);
        DBMS_OUTPUT.PUT_LINE('TOTAL DEL IMPORTE DE TODOS SUS PREMIOS ' || PREMIOTOTAL);
    	END LOOP;
    END LOOP;
    --IMPRIMIMOS EL MENSAJE CORRESPONDIENTE Y CONTABILIZAMOS LAS CARRERAS GANADAS Y EL PREMIO TOTAL.
END;
SELECT LISTADOCABALLO FROM DUAL;
--CORREGIDO
CREATE OR REPLACE FUNCTION CABALLOS.LISTADOCABALLO
RETURN NUMBER
IS
    --ES UN CURSOR EXPLICITO
    CURSOR C_CABALLOS IS
    SELECT C.NOMBRE, C.PESO, P.NOMBRE
    FROM CABALLOS C, PERSONAS P
    WHERE C.PROPIETARIO=P.CODIGO
    ORDER BY C.NACIONALIDAD, C.PROPIETARIO DESC;
    --ES UN CURSOR EXPLICITO
    CURSOR C_CARRERA IS
    SELECT C.NOMBRECARRERA, PE.NOMBRE, C.FECHAHORA, P.POSICIONFINAL, C.IMPORTEPREMIO
    FROM PARTICIPACIONES P, CARRERAS C, PERSONAS PE
    WHERE P.CODCARRERA=C.CODCARRERA
ORDER BY C.NOMBRECARRERA, C.FECHAHORA DESC;
    CARRERASGANADAS NUMBER;
    PREMIOTOTAL NUMBER;
BEGIN
    --CURSORES ANIDADOS CON BUCLE FOR
    FOR REGISTRO IN C_CABALLOS LOOP
    	CARRERASGANADAS :=0;
    	PREMIOTOTAL :=0;
	    DBMS.OUTPUT.PUT_LINE(' CABALLO ' || REGISTRO.NOMBRE 
	                            ' PESO ' || REGISTRO.PESO
	                            ' DUEÑO ' || REGISTRO.PROPIETARIO);
        FOR REGISTRO2 IN C_CARRERA LOOP
        PREMIOTOTAL:=PREMIOTOTAL+REGISTRO2.IMPORTEPREMIO;

   

--Realizar un PROCEDIMIENTO agregarcaballos que reciba como argumento el nombre, peso,
--fecha de nacimiento, nacionalidad y el dni y el nombre del dueño. El procedimiento debe
--insertar el dueño si este no existe, y luego insertar el caballo. Si hay algún fallo debe dejar la
--base de datos como estaba, es decir, no puede insertar el dueño si no puede insertar el
--caballo. Si la nacionalidad no tiene ningún valor se le pondrá “ESPAÑOL”. Debes controlar las
--posibles excepciones, por ejemplo si el caballo ya existe deberás lanzar una excepción
--personalizada indicando el mensaje “El caballo que está intentando insertar ya existe”
CREATE OR REPLACE 
PROCEDURE AGREGARCABALLOS(NOMCABALLO CABALLOS.NOMBRE%TYPE, PESOCABALLO CABALLO.PESO%TYPE, FECHA CABALLO.FECHANACIMIENTO%TYPE, NACIONALIDADCAB CABALLO.NACIONALIDAD%TYPE, DNIPERSONA PERSONAS.DNI%TYPE, NUMPROP CABALLO.PROPIETARIO%TYPE)
IS
    NOMBREPERSONA PERSONA.NOMBRE%TYPE;
    CODIGOCABALLO CABALLOS.CODCABALLO%TYPE;
    PERSONAENCONTRADA EXCEPTION;
    CABALLOENCONTRADO EXCEPTION;
BEGIN
    SELECT P.NOMBRE
    INTO NOMBREPERSONA
    FROM PERSONAS P
    WHERE P.DNI=DNIPERSONA AND P.CODIGO=NUMPROP;
    IF SQL%FOUND THEN
        RAISE PERSONAENCONTRADA;
        NOMBREPERSONA:=NULL;
    END IF;
    SELECT C.CODCABALLO
    INTO CODIGOCABALLO
    FROM CABALLO C
    WHERE C.NOMBRE=NOMCABALLO AND C.PESO=PESOCABALLO AND C.FECHANACIMIENTO=FECHA AND C.NACIONALIDAD=NACIONALIDADCAB;
    IF SQL%FOUND THEN
        RAISE CABALLOENCONTRADO;
        CODIGOCABALLO:=NULL;
    END IF;
    IF NOMBREPERSONA IS NULL AND CODIGOCABALLO IS NULL THEN
        INSERT INTO PERSONA (DNI, CODIGO)
        VALUES (DNIPERSONA, NUMPROP);
        INSERT INTO CABALLO (NOMBRE, PESO, FECHANACIMIENTO, NACIONALIDAD)
        VALUES(NOMCABALLO, PESOCABALLO, FECHA, NACIONALIDADCAB);
    END IF;
   	COMMIT;
    EXCEPTION
        WHEN PERSONAENCONTRADA THEN
            DBMS.OUTPUT.PUT_LINE('NO PODEMOS INSERTAR UNA PERSONA QUE SE ENCUENTRA EN EL SISTEMA');
        WHEN CABALLOENCONTRADO THEN
                DBMS.OUTPUT.PUT_LINE('NO PODEMOS INSERTAR UN CABALLO QUE SE ENCUENTRA EN EL SISTEMA');
        ROLLBACK;
END;
BEGIN
    AGREGARCABALLOS('PEDRO', 120, '24/12/2020', 'ESPANOL', '27648934D', 23);
END;
--PARAMETROS ENTRADA Y SALIDA
CREATE OR REPLACE PROCEDURE CABALLOS.LISTADO (NOMBREEMPLEADO IN OUT VARCHAR2, EDAD IN OUT NUMBER)
IS 
BEGIN
	IF NOMBREEMPLEADO IS NULL THEN 
		NOMBREEMPLEADO:='MARTA';
	END IF;
	IF EDAD<10 THEN 
		EDAD:=18;
	END IF;
END;

DECLARE
EDAD_E NUMBER(10);
NOMBRE VARCHAR2(50);
BEGIN 
	EDAD_E:=4;
	LISTADO(NOMBRE,EDAD_E);
	DBMS_OUTPUT.PUT_LINE(NOMBRE ||' ' || EDAD_E);
END;






