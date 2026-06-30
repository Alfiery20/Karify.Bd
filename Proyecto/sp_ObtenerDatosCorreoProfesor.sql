USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerDatosCorreoProfesor') 
	BEGIN
		DROP PROCEDURE sp_ObtenerDatosCorreoProfesor;
	END
GO

CREATE PROCEDURE sp_ObtenerDatosCorreoProfesor
(
	@pidProyecto INT
)
AS
BEGIN
	SELECT
		PRO.ID AS [ID],
		COALESCE(USU.Correo, '') AS [CORREO],
		CONCAT(ALU.Nombre, ' ', ALU.ApellidoPaterno, ' ', ALU.ApellidoMaterno) AS [ALUMNO],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION]
	FROM PROYECTO PRO
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	INNER JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
	INNER JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
	INNER JOIN USUARIO USU ON USU.Id = PROF.IdUsuario
	WHERE PRO.Id = @pidProyecto AND PROXALU.IsPrincipal = 1

END