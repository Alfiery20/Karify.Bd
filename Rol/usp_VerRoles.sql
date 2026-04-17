USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_VerRoles') 
	BEGIN
		DROP PROCEDURE usp_VerRoles;
	END
GO

CREATE PROCEDURE usp_VerRoles
(
	@pid INT
)
AS
BEGIN
	
	SELECT 
		ROL.Id AS [ID],
		ROL.Nombre AS [NOMBRE],
		ROL.Estado AS [ESTADO]
	FROM ROL ROL
	WHERE ROL.Id = @pid

END