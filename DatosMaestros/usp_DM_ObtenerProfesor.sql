USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_DM_ObtenerProfesor') 
	BEGIN
		DROP PROCEDURE usp_DM_ObtenerProfesor;
	END
GO

CREATE PROCEDURE usp_DM_ObtenerProfesor
(
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
	WHERE (@pNombre IS NULL) OR
			(CONCAT(PRO.Nombre, ' ' , PRO.ApellidoPaterno, ' ', 
				PRO.ApellidoMaterno) LIKE CONCAT('%', @pNombre, '%'))

END