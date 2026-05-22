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
		CONCAT(
			PROF.Nombre, ' ', 
			PROF.ApellidoPaterno, ' ',
			PROF.ApellidoMaterno) AS [PROFESOR],
		PRO.FechaRegistro AS [FECHA_REGISTRO]
	FROM PROYECTO PRO
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	LEFT JOIN PROFESOR PROF ON PRO.Id = PRO.IdProfesor
	WHERE 
		(PRO.Nombre LIKE CONCAT('%', @pNombre, '%') 
			OR @pNombre IS NULL OR @pNombre = '')
		AND (PROXALU.IdAlumno = @pIdAlumno)

END