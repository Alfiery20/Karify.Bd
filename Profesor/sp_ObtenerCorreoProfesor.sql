USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerCorreoProfesor') 
	BEGIN
		DROP PROCEDURE sp_ObtenerCorreoProfesor;
	END
GO

CREATE PROCEDURE sp_ObtenerCorreoProfesor
(
	@pidProfesor INT
)
AS
BEGIN
	SELECT
		COALESCE(USU.Correo, '') AS [CORREO]
	FROM PROFESOR PRO
	INNER JOIN USUARIO USU ON USU.Id = PRO.IdUsuario
	WHERE PRO.Id = @pidProfesor

END