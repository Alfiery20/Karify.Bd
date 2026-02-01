USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerFacultad') 
	BEGIN
		DROP PROCEDURE usp_ObtenerFacultad;
	END
GO

CREATE PROCEDURE usp_ObtenerFacultad
AS
BEGIN
	
	SELECT 
		FAC.Id AS [ID],
		FAC.Nombre AS [NOMBRE]
	FROM FACULTAD FAC

END