CREATE TABLE
	generos(
		id_genero INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	estado_civiles(
		id_estado_civil INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	ocupaciones(
		id_ocupacion INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE 
	personas (
   		id_persona INTEGER PRIMARY KEY,
   		nombre VARCHAR(255),
		apellido VARCHAR(255),
    	cedula VARCHAR(50),
    	id_genero INTEGER NOT NULL,
    	id_estado_civil INTEGER NOT NULL,
    	id_ocupacion INTEGER NOT NULL,
    	FOREIGN KEY(id_genero) REFERENCES generos(id_genero)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    	FOREIGN KEY(id_estado_civil) REFERENCES estado_civiles(id_estado_civil)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    	FOREIGN KEY(id_ocupacion) REFERENCES ocupaciones(id_ocupacion)
		ON DELETE RESTRICT ON UPDATE CASCADE
	); 

CREATE TABLE 
	pacientes (
    	id_paciente INTEGER PRIMARY KEY,
		id_persona INTEGER NOT NULL,
    	edad INT NOT NULL CHECK (edad >= 0),  -- Asegura que la edad no sea negativa
   		peso DECIMAL(5, 2) NOT NULL CHECK (peso >= 0),  -- Asegura que el peso no sea negativo
    	altura DECIMAL(5, 2) NOT NULL CHECK (altura >= 0),  -- Asegura que la altura no sea negativa
		PRIMARY KEY(id_persona),
		FOREIGN KEY(id_persona) REFERENCES personas(id_persona)
    	ON DELETE RESTRICT ON UPDATE CASCADE
	);

CREATE TABLE
	paciente_asignacion(
		id_paciente_asignacion INTEGER PRIMARY KEY,
		id_paciente INTEGER NOT NULL,
		fecha
		hora
		edad
		FOREIGN KEY(id_paciente) REFERENCES pacientes(id_paciente)
    	ON DELETE RESTRICT ON UPDATE CASCADE
	);

CREATE TABLE
	paciente_diagnosticos(
		id_paciente_diagnostico INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	paciente_medicamentos(
		id_paciente_medicamento INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	paciente_estudios(
		id_paciente_estudio INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	enfermedades(
		id_enfermedad INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);


CREATE TABLE 
	dias(
		id_dia INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);		

CREATE TABLE
	turnos(
		id_turno INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	especialidades(
		id_especialidad INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	medicos(
		id_medico INTEGER PRIMARY KEY
		, descripcion varchar(60) UNIQUE
	);

CREATE TABLE
	agenda_medicas(
		id_medico INTEGER NOT NULL,
		id_especialidad INTEGER NOT NULL,
   		id_dia INTEGER NOT NULL,
    	id_turno INTEGER NOT NULL,
		estado_laboral TEXT NOT NULL,
		PRIMARY KEY(id_medico,id_dia,id_turno),
		FOREIGN KEY(id_medico) REFERENCES medicos(id_medico)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    	FOREIGN KEY(id_dia) REFERENCES dias(id_dia)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    	FOREIGN KEY(id_turno) REFERENCES turnos(id_turno)
		ON DELETE RESTRICT ON UPDATE CASCADE
	);