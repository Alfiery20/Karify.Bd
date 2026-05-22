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
		PRO.FechaRegistro AS [FECHA_REGISTRO]
	FROM PROYECTO PRO
	WHERE PRO.Id = @pIdProyecto

END