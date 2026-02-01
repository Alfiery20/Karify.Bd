USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_IniciarSesion') 
	BEGIN
		DROP PROCEDURE sp_IniciarSesion;
	END
GO

CREATE PROCEDURE sp_IniciarSesion
(
	@pemail VARCHAR(250),
	@pnombre VARCHAR(250),
	@papellidos VARCHAR(250)
)
AS
BEGIN

	DECLARE @usuarioEncontrado INT, @esNecesarioCompletar BIT = 1, @tipoRegistro CHAR(1);

	SELECT @usuarioEncontrado = Id
	FROM USUARIO USU 
	WHERE Correo = @pemail;

	PRINT(@usuarioEncontrado)

	SET @usuarioEncontrado = COALESCE(@usuarioEncontrado, 0);

	IF(@usuarioEncontrado = 0)
	BEGIN

		INSERT INTO USUARIO(Correo, IdRol) VALUES(@pemail, 3)
		SET @usuarioEncontrado = SCOPE_IDENTITY();

		INSERT INTO ALUMNO(Nombre, ApellidoPaterno, ApellidoMaterno, IdUsuario) 
			VALUES(@pnombre, LEFT(@papellidos, CHARINDEX(' ', @papellidos + ' ') - 1), 
			LTRIM(SUBSTRING(@papellidos, CHARINDEX(' ', @papellidos + ' ') + 1, LEN(@papellidos))), @usuarioEncontrado)
	END

	DECLARE @conteoResultados INT, @codigoUniversitarioUsuarioEncotrado VARCHAR(20)

	SELECT 
		@codigoUniversitarioUsuarioEncotrado = CodigoUniversitario 
	FROM USUARIO WHERE Id = @usuarioEncontrado

	IF(@codigoUniversitarioUsuarioEncotrado IS NOT NULL)
	BEGIN
		SET @esNecesarioCompletar = 0
	END

	IF(EXISTS (SELECT 1 FROM ALUMNO WHERE IdUsuario = @usuarioEncontrado))
	BEGIN
		SELECT
			USU.Id AS [ID_USUARIO],
			USU.CodigoUniversitario AS [CODIGO_UNIVERSITARIO],
			ALUM.TipoDocumento AS [TIPO_DOCUMENTO],
			ALUM.NumeroDocumento AS [NUMERO_DOCUMENTO],
			ALUM.Nombre AS [NOMBRE],
			ALUM.ApellidoPaterno AS [APELLIDO_PATERNO],
			ALUM.ApellidoMaterno AS [APELLIDO_MATERNO],
			USU.Correo AS [CORREO],
			ALUM.Telefono AS [TELEFONO],
			ESCU.Id AS [ID_ESCUELA],
			ESCU.Nombre AS [NOMBRE_ESCUELA],
			FACU.Id AS [ID_FACULTAD],
			FACU.Nombre AS [NOMBRE_FACULTAD],
			@esNecesarioCompletar AS [ES_NECESARIO_LLENAR],
			ROL.Id AS [ID_ROL],
			ROL.Nombre AS [ROL]
		FROM ALUMNO ALUM
		INNER JOIN USUARIO USU ON USU.Id = ALUM.IdUsuario
		INNER JOIN ROL ROL ON ROL.Id = USU.IdRol
		LEFT JOIN ESCUELA ESCU ON ESCU.Id = USU.IdEscuela
		LEFT JOIN FACULTAD FACU ON FACU.Id = ESCU.IdFacultad
		WHERE USU.Correo = @pemail
	END
	ELSE
	BEGIN IF(EXISTS (SELECT 1 FROM PROFESOR WHERE IdUsuario = @usuarioEncontrado))
		SELECT
			USU.Id AS [ID_USUARIO],
			USU.CodigoUniversitario AS [CODIGO_UNIVERSITARIO],
			PRO.TipoDocumento AS [TIPO_DOCUMENTO],
			PRO.NumeroDocumento AS [NUMERO_DOCUMENTO],
			PRO.Nombre AS [NOMBRE],
			PRO.ApellidoPaterno AS [APELLIDO_PATERNO],
			PRO.ApellidoMaterno AS [APELLIDO_MATERNO],
			USU.Correo AS [CORREO],
			PRO.Telefono AS [TELEFONO],
			ESCU.Id AS [ID_ESCUELA],
			ESCU.Nombre AS [NOMBRE_ESCUELA],
			FACU.Id AS [ID_FACULTAD],
			FACU.Nombre AS [NOMBRE_FACULTAD],
			@esNecesarioCompletar AS [ES_NECESARIO_LLENAR],
			ROL.Id AS [ID_ROL],
			ROL.Nombre AS [ROL]
		FROM PROFESOR PRO
		INNER JOIN USUARIO USU ON USU.Id = PRO.IdUsuario
		INNER JOIN ROL ROL ON ROL.Id = USU.IdRol
		LEFT JOIN ESCUELA ESCU ON ESCU.Id = USU.IdEscuela
		LEFT JOIN FACULTAD FACU ON FACU.Id = ESCU.IdFacultad
		WHERE USU.Correo = @pemail
	END
END