USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerDatosConstancia') 
	BEGIN
		DROP PROCEDURE usp_ObtenerDatosConstancia;
	END
GO

CREATE PROCEDURE usp_ObtenerDatosConstancia
(
	@pIdProyecto INT
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		CONCAT(PROF.Nombre, ' ', 
			PROF.ApellidoPaterno, ' ', 
			PROF.ApellidoMaterno) AS [NOMBRE_PROFESOR],
		REV.FechaProcesamiento AS [FECHA]
	FROM PROYECTO PRO
	INNER JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
	INNER JOIN REVISION REV ON REV.IdProyecto = PRO.Id
	WHERE PRO.Id = @pIdProyecto AND REV.Estado = 'F'

END