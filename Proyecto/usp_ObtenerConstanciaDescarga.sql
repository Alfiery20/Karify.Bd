USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerConstanciaDescarga') 
	BEGIN
		DROP PROCEDURE usp_ObtenerConstanciaDescarga;
	END
GO

CREATE PROCEDURE usp_ObtenerConstanciaDescarga
(
	@pIdProyecto INT,
	@pIdUsuario INT
)
AS
BEGIN
	
	SELECT
		REV.ConstanciaBase64 AS [CONSTANCIA_BASE64],
		REV.NombreConstancia AS [NOMBRE_CONSTANCIA]
	FROM REVISION REV 
	INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = REV.IdProyecto
	INNER JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
	WHERE REV.IdProyecto = @pIdProyecto 
			AND ALU.IdUsuario = @pIdUsuario AND REV.Estado = 'F'

END