USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerProfesor') 
	BEGIN
		DROP PROCEDURE usp_VerProfesor;
	END
GO

CREATE PROCEDURE usp_VerProfesor
(
	@pIdProfesor INT
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
		USU.CodigoUniversitario AS [CODIGO_UNIVERSITARIO],
		USU.Correo AS [CORREO],
		ESC.IdFacultad AS [FACULTAD],
		USU.IdEscuela AS [ESCUELA]
	FROM PROFESOR PRO
	INNER JOIN USUARIO USU ON USU.Id = PRO.IdUsuario
	LEFT JOIN ESCUELA ESC ON ESC.Id = USU.IdEscuela
	WHERE PRO.Id = @pIdProfesor

END