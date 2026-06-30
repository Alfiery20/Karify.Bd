USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProyecto') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProyecto;
	END
GO

CREATE PROCEDURE usp_ObtenerProyecto
(
	@pNombre VARCHAR(200),
	@pIdAlumno INT
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		REV.Estado AS [ESTADO],
		CONCAT(
			PROF.Nombre, ' ', 
			PROF.ApellidoPaterno, ' ',
			PROF.ApellidoMaterno) AS [PROFESOR],
		PRO.FechaRegistro AS [FECHA_REGISTRO],
		(CASE
			WHEN PROXALU.IsPrincipal = 0
			THEN 1 ELSE 0 END) AS [ES_COTESISTA]
	FROM PROYECTO PRO
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	INNER JOIN REVISION REV ON REV.IdProyecto = PRO.Id
	INNER JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
	LEFT JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
	WHERE 
		(PRO.Nombre LIKE CONCAT('%', @pNombre, '%') 
			OR @pNombre IS NULL OR @pNombre = '')
		AND (ALU.IdUsuario = @pIdAlumno OR @pIdAlumno = 0)

END