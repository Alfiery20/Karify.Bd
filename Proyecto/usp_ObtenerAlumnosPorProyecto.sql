USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerAlumnosPorProyecto') 
	BEGIN
		DROP PROCEDURE usp_ObtenerAlumnosPorProyecto;
	END
GO

CREATE PROCEDURE usp_ObtenerAlumnosPorProyecto
(
	@pIdProyecto INT
)
AS
BEGIN
	
	SELECT 
		ALU.NumeroDocumento AS [NUMERO_DOCUMENTO],
		CONCAT(ALU.ApellidoPaterno, ' ', ALU.ApellidoMaterno, ' ', ALU.Nombre) AS [NOMBRE]
	FROM ALUMNO ALU
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdAlumno = ALU.Id
	WHERE PROXALU.IdProyecto = @pIdProyecto

END