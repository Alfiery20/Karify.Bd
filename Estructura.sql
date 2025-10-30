USE master;

go
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Karify') 
	BEGIN
		DROP DATABASE Karify;
	END
go

CREATE DATABASE Karify;
go

USE Karify;
go

CREATE TABLE FACULTAD
(
	Id INT IDENTITY(1, 1),
	Nombre VARCHAR(250),
	CONSTRAINT pk_facultad
		PRIMARY KEY (Id)
)

CREATE TABLE ESCUELA
(
	Id INT IDENTITY(1, 1),	
	Nombre VARCHAR(250),
	CorreoAtencion VARCHAR(320),
	IdFacultad INT,
	CONSTRAINT pk_escuela
		PRIMARY KEY (Id),
	CONSTRAINT fk_escuela_facultad
		FOREIGN KEY (IdFacultad)
		REFERENCES FACULTAD(Id)
)

CREATE TABLE PROFESOR
(
	Id INT IDENTITY(1, 1),
	CodigoUniversitario VARCHAR(10),
	TipoDocumento CHAR(1),
	NumeroDocumento VARCHAR(20),
	Nombre VARCHAR(250),
	ApellidoPaterno VARCHAR(250),
	ApellidoMaterno VARCHAR(250),
	Emeal VARCHAR(320),
	Telefono VARCHAR(20),
	IdEscuela INT,
	CONSTRAINT pk_profesor
		PRIMARY KEY (Id),
	CONSTRAINT fk_profesor_escuela
		FOREIGN KEY (IdEscuela)
		REFERENCES ESCUELA(Id),
	CONSTRAINT uq_codigoUniversitario_prof
		UNIQUE (CodigoUniversitario)
)

CREATE TABLE PROYECTO
(
	Id INT IDENTITY(1, 1),
	Nombre VARCHAR(MAX),
	Descripcion VARCHAR(MAX),
	FechaRegistro DATETIME,
	IdProfesor INT,
	CONSTRAINT pk_proyecto
		PRIMARY KEY (Id),
	CONSTRAINT fk_proyecto_profesor
		FOREIGN KEY (IdProfesor)
		REFERENCES PROFESOR(Id)
)

CREATE TABLE ALUMNO
(
	Id INT IDENTITY(1, 1),
	CodigoUniversitario VARCHAR(10),
	TipoDocumento CHAR(1),
	NumeroDocumento VARCHAR(20),
	Nombre VARCHAR(250),
	ApellidoPaterno VARCHAR(250),
	ApellidoMaterno VARCHAR(250),
	Emeal VARCHAR(320),
	Telefono VARCHAR(20),
	IdEscuela INT,
	CONSTRAINT pk_alumno
		PRIMARY KEY (Id),
	CONSTRAINT fk_alumno_escuela
		FOREIGN KEY (IdEscuela)
		REFERENCES ESCUELA(Id),
	CONSTRAINT uq_codigoUniversitario_alumn
		UNIQUE (CodigoUniversitario)
)

CREATE TABLE PROYECTOXALUMNO
(
	Id INT IDENTITY(1, 1),
	IdAlumno INT,
	IdProyecto INT,
	CONSTRAINT pk_proyectoxalumno
		PRIMARY KEY (Id),
	CONSTRAINT fk_proyectoxalumno_alumno
		FOREIGN KEY (IdAlumno)
		REFERENCES ALUMNO (Id),
	CONSTRAINT fk_proyectoxalumno_proyecto
		FOREIGN KEY (IdProyecto)
		REFERENCES PROYECTO (Id)
)

CREATE TABLE REVISION
(
	Id INT IDENTITY(1, 1),
	NombreArchivo VARCHAR(MAX),
	ArchivoBase64 VARBINARY,
	Peso DECIMAL(10, 4),
	FechaRegistro DATETIME,
	Estado CHAR(1),
	ConstanciaBase64 VARBINARY,
	FechaResultado DATETIME,
	IdProyecto INT,
	CONSTRAINT pk_revision
		PRIMARY KEY (Id),
	CONSTRAINT fk_revision_proyecto
		FOREIGN KEY (IdProyecto)
		REFERENCES PROYECTO (Id)
)

CREATE TABLE COMENTARIO
(
	Id INT IDENTITY(1, 1),
	Descripcion TEXT,
	Fecha DATETIME,
	IdRevision INT,
	CONSTRAINT pk_comentario
		PRIMARY KEY (Id),
	CONSTRAINT fk_comentario_revision
		FOREIGN KEY (IdRevision)
		REFERENCES REVISION(Id)
)