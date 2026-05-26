USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProfesor') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProfesor;
	END
GO

CREATE PROCEDURE usp_ObtenerProfesor
(
	@pNombre VARCHAR(200),
	@pIdFacultad INT,
	@pIdEscuela INT
)
AS
BEGIN
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.ApellidoPaterno AS [APELLIDO_PATERNO],
		PRO.ApellidoMaterno AS [APELLIDO_MATERNO],
		(CASE PRO.TipoDocumento
			WHEN 'D' THEN 'DNI'
			WHEN 'C' THEN 'Carnet de Extranjería'
			WHEN 'P' THEN 'Pasaporte'
			WHEN 'N' THEN 'Partida de Nacimiento'
		END) AS [TIPO_DOCUMENTO],
		PRO.NumeroDocumento AS [NUMERO_DOCUMENTO],
		PRO.Telefono AS [TELEFONO],
		USU.Estado AS [ESTADO],
		USU.CodigoUniversitario AS [CODIGO_UNIVERSITARIO],
		USU.Correo AS [CORREO],
		FAC.Nombre AS [FACULTAD],
		ROL.Nombre AS [ROL],
		ESC.Nombre AS [ESCUELA],
		(CASE USU.CodigoUniversitario 
			WHEN NULL THEN 0
			WHEN '' THEN 0
			ELSE 1 END) AS [COMPLETAR_PERFIL]
	FROM PROFESOR PRO
	INNER JOIN USUARIO USU ON USU.Id = PRO.IdUsuario
	INNER JOIN ROL ROL ON ROL.Id = USU.IdRol
	LEFT JOIN ESCUELA ESC ON ESC.Id = USU.IdEscuela
	LEFT JOIN FACULTAD FAC ON FAC.Id = ESC.IdFacultad
	WHERE (PRO.Nombre LIKE CONCAT('%', @pNombre, '%') OR @pNombre = NULL) AND 
		(FAC.Id = @pIdFacultad OR @pIdFacultad = 0) AND
		(ESC.Id = @pIdEscuela OR @pIdEscuela = 0)

END