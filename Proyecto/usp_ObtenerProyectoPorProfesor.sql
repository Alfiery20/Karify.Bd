USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProyectoPorProfesor') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProyectoPorProfesor;
	END
GO

CREATE PROCEDURE usp_ObtenerProyectoPorProfesor
(
	@pIdUsuario INT
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		REV.Estado AS [ESTADO],
		CONCAT(
			ALU.Nombre, ' ', 
			ALU.ApellidoPaterno, ' ',
			ALU.ApellidoMaterno) AS [ALUMNO],
		PRO.FechaRegistro AS [FECHA_REGISTRO]
	FROM PROYECTO PRO
	INNER JOIN REVISION REV ON REV.IdProyecto = PRO.Id
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	LEFT JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
	INNER JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
	WHERE 
		PROF.IdUsuario = @pIdUsuario AND PROXALU.IsPrincipal = 1

END