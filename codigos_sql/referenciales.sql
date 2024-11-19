CREATE TABLE
	ciudades(
		id_ciudad serial PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);
 
CREATE TABLE
	generos(
		id_genero serial PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	estado_civiles(
		id_estado_civil serial PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);
 
CREATE TABLE 
	personas(
   		id_persona serial PRIMARY KEY NOT NULL,
   		nombre VARCHAR(255),
		apellido VARCHAR(255),
    	cedula  TEXT NOT NULL,
    	id_genero INTEGER NOT NULL,
    	id_estado_civil INTEGER NOT NULL,
		telefono_emergencia TEXT NOT NULL,
	    id_ciudad INTEGER NOT NULL,
    	FOREIGN KEY(id_genero) REFERENCES generos(id_genero)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    	FOREIGN KEY(id_estado_civil) REFERENCES estado_civiles(id_estado_civil)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		FOREIGN KEY(id_ciudad) REFERENCES ciudades(id_ciudad)
		ON DELETE RESTRICT ON UPDATE CASCADE
	); 