USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerProyecto') 
	BEGIN
		DROP PROCEDURE usp_VerProyecto;
	END
GO

CREATE PROCEDURE usp_VerProyecto
(
	@pIdProyecto INT
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		PRO.IdProfesor AS [PROFESOR],
		CONCAT(PROF.Nombre, ' ', 
			PROF.ApellidoPaterno, ' ', 
			PROF.ApellidoMaterno) AS [NOMBRE_PROFESOR],
		PRO.FechaRegistro AS [FECHA_REGISTRO],
		REV.ArchivoBase64 AS [ARCHIVO],
		REV.NombreArchivo AS [NOMBRE_ARCHIVO]
	FROM PROYECTO PRO
	LEFT JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
	LEFT JOIN REVISION REV ON REV.IdProyecto = PRO.Id
	WHERE PRO.Id = @pIdProyecto

END