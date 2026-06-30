USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerCorreoCotesista') 
	BEGIN
		DROP PROCEDURE sp_ObtenerCorreoCotesista;
	END
GO

CREATE PROCEDURE sp_ObtenerCorreoCotesista
(
	@pidProyecto INT
)
AS
BEGIN
	SELECT
		COALESCE(USU.Correo, '') AS [CORREO]
	FROM PROYECTO PRO
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	INNER JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
	INNER JOIN USUARIO USU ON USU.Id = ALU.IdUsuario
	WHERE PRO.Id = @pidProyecto AND PROXALU.IsPrincipal = 0

END