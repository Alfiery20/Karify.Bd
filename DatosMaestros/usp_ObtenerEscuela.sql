USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerEscuela') 
	BEGIN
		DROP PROCEDURE usp_ObtenerEscuela;
	END
GO

CREATE PROCEDURE usp_ObtenerEscuela
(
	@pIdFacultad INT
)
AS
BEGIN
	
	SELECT 
		ESC.Id AS [ID],
		ESC.Nombre AS [NOMBRE]
	FROM ESCUELA ESC
	WHERE ESC.IdFacultad = @pIdFacultad

END