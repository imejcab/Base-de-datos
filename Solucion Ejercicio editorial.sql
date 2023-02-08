CREATE TABLE TEMA 
(
		cod_tema VARCHAR2(10),
		denominacion VARCHAR2(25),
		cod_tema_padre VARCHAR2(10),
		CONSTRAINT PK_TEMA PRIMARY KEY(cod_tema),
		CONSTRAINT FK_TEMA FOREIGN KEY (cod_tema_padre) REFERENCES TEMA(cod_tema)
);
CREATE TABLE LIBRO
(
		cod_libro VARCHAR2(10),
		titulo VARCHAR2(20),
		f_creacion DATE,
		cod_tema VARCHAR2(10),
		autor_principal VARCHAR2(10),
		CONSTRAINT PK_LIBRO PRIMARY KEY (cod_libro),
		CONSTRAINT FK1_LIBRO FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema)
);
CREATE TABLE AUTOR
(
		cod_autor VARCHAR2(10),
		nombre VARCHAR2(10),
		f_nacimiento DATE,
		libro_principal VARCHAR2(20),
		CONSTRAINT PK_AUTOR PRIMARY KEY (cod_autor)
);
CREATE TABLE LIBRO_AUTOR
(
		cod_libro VARCHAR2(10),
		cod_autor VARCHAR2(10),
		orden NUMBER(1-5),
		CONSTRAINT PK_LIBRO_AUTOR PRIMARY KEY (cod_libro,cod_autor),
		CONSTRAINT FK1_LIBRO_AUTOR FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro),
		CONSTRAINT FK2_LIBRO_AUTOR FOREIGN KEY (cod_autor) REFERENCES AUTOR(cod_autor)
);
CREATE TABLE EDITORIAL 
(
		cod_editorial VARCHAR2(10),
		denominacion VARCHAR2(10),
		CONSTRAINT PK_EDITORIAL PRIMARY KEY (cod_editorial)
);
CREATE TABLE PUBLICACIONES
(
		cod_editorial VARCHAR2(10),
		cod_libro VARCHAR2(10),
		precio NUMBER(3),
		f_publicacion DATE,
		CONSTRAINT PK_PUBLICACIONES PRIMARY KEY (cod_editorial,cod_libro),
		CONSTRAINT FK1_PUBLICACIONES FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro),
		CONSTRAINT FK2_PUBLICACIONES FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial)
);		
AFTER TABLE LIBRO ADD CONSTRAINT FK2_LIBRO FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
AFTER TABLE AUTOR ADD CONSTRAINT FK_AUTOR FOREIGN KEY (libro_principal) REFERENCES LIBRO(cod_libro)