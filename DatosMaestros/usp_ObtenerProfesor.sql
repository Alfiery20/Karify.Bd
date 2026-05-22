USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerProfesor') 
	BEGIN
		DROP PROCEDURE usp_ObtenerProfesor;
	END
GO

CREATE PROCEDURE usp_ObtenerProfesor
(
	@pIdEscuela INT,
	@pNombre VARCHAR(20)
)
AS
BEGIN
	
	SELECT
		PRO.Id AS [CODIGO],
		CONCAT(PRO.Nombre, ' ' , 
			PRO.ApellidoPaterno, ' ', 
			PRO.ApellidoMaterno) AS [NOMBRE]
	FROM PROFESOR PRO
	INNER JOIN USUARIO USU ON USU.Id = PRO.IdUsuario
	WHERE (USU.IdEscuela = @pIdEscuela OR USU.IdEscuela = 0)
		AND (@pNombre IS NULL OR
				@pNombre LIKE CONCAT(PRO.Nombre, ' ' , 
				PRO.ApellidoPaterno, ' ', 
				PRO.ApellidoMaterno)
	)

END