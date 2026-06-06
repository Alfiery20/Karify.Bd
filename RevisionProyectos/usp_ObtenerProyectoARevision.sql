USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProyectoARevision') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProyectoARevision;
	END
GO

CREATE PROCEDURE usp_ObtenerProyectoARevision
(
	@pNombre VARCHAR(200),
	@pIdProfesor INT
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [ID],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION],
		CONCAT(
			ALUM.Nombre, ' ', 
			ALUM.ApellidoPaterno, ' ',
			ALUM.ApellidoMaterno) AS [PROFESOR],
		PRO.FechaRegistro AS [FECHA_REGISTRO]
	FROM PROYECTO PRO
	INNER JOIN REVISION REV ON 
		REV.IdProyecto = PRO.Id AND REV.Estado IN ('P', 'A', 'R', 'C')
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
	LEFT JOIN ALUMNO ALUM ON ALUM.Id = PROXALU.IdAlumno
	WHERE 
		(PRO.Nombre LIKE CONCAT('%', @pNombre, '%') 
			OR @pNombre IS NULL OR @pNombre = '')
		AND (PRO.IdProfesor = @pIdProfesor 
			OR @pIdProfesor IS NULL OR @pIdProfesor = 0)

END