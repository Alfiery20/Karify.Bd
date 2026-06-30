USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerDatosCorreoCotesistaAprobacion') 
	BEGIN
		DROP PROCEDURE sp_ObtenerDatosCorreoCotesistaAprobacion;
	END
GO

CREATE PROCEDURE sp_ObtenerDatosCorreoCotesistaAprobacion
(
	@pidProyecto INT
)
AS
BEGIN
	SELECT
		PRO.ID AS [ID],
		CONCAT(ALU1.Nombre, ' ', ALU1.ApellidoPaterno, ' ', ALU1.ApellidoMaterno) AS [ALUMNO],
		CONCAT(ALU2.Nombre, ' ', ALU2.ApellidoPaterno, ' ', ALU2.ApellidoMaterno) AS [COTESISTA],
		COALESCE(USU.Correo, '') AS [CORREO],
		PRO.Nombre AS [NOMBRE],
		PRO.Descripcion AS [DESCRIPCION]
	FROM PROYECTO PRO
	INNER JOIN PROYECTOXALUMNO PROXALU1 ON PROXALU1.IdProyecto = PRO.Id
	INNER JOIN ALUMNO ALU1 ON ALU1.Id = PROXALU1.IdAlumno 
	INNER JOIN PROYECTOXALUMNO PROXALU2 ON PROXALU2.IdProyecto = PRO.Id
	INNER JOIN ALUMNO ALU2 ON ALU2.Id = PROXALU2.IdAlumno 
	INNER JOIN USUARIO USU ON USU.Id = ALU1.IdUsuario
	WHERE PRO.Id = @pidProyecto AND PROXALU1.IsPrincipal = 1 AND PROXALU2.IsPrincipal = 0

END