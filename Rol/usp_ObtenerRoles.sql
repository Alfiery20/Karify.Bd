USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerRoles') 
	BEGIN
		DROP PROCEDURE usp_ObtenerRoles;
	END
GO

CREATE PROCEDURE usp_ObtenerRoles
(
	@pNombre VARCHAR(100)
)
AS
BEGIN
	
	SELECT 
		ROL.Id AS [ID],
		ROL.Nombre AS [NOMBRE],
		ROL.Estado AS [ESTADO]
	FROM ROL ROL
	WHERE ROL.Nombre LIKE CONCAT(@pNombre, '%') OR @pNombre IS NULL OR @pNombre = ''

END