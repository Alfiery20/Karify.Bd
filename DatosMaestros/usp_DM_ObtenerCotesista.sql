USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_DM_ObtenerCotesista') 
	BEGIN
		DROP PROCEDURE usp_DM_ObtenerCotesista;
	END
GO

CREATE PROCEDURE usp_DM_ObtenerCotesista
(
	@pNombre VARCHAR(20)
)
AS
BEGIN
	
	SELECT
		ALU.Id AS [CODIGO],
		CONCAT(ALU.Nombre, ' ' , 
			ALU.ApellidoPaterno, ' ', 
			ALU.ApellidoMaterno) AS [NOMBRE]
	FROM ALUMNO ALU
	INNER JOIN USUARIO USU ON USU.Id = ALU.IdUsuario
	WHERE (@pNombre IS NULL) OR
			(CONCAT(ALU.Nombre, ' ' , ALU.ApellidoPaterno, ' ', 
				ALU.ApellidoMaterno) LIKE CONCAT('%', @pNombre, '%'))
END