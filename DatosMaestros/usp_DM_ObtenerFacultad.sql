USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_DM_ObtenerFacultad') 
	BEGIN
		DROP PROCEDURE usp_DM_ObtenerFacultad;
	END
GO

CREATE PROCEDURE usp_DM_ObtenerFacultad
AS
BEGIN
	
	SELECT 
		FAC.Id AS [ID],
		FAC.Nombre AS [NOMBRE]
	FROM FACULTAD FAC

END