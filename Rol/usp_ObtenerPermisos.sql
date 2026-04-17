USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ObtenerPermisos') 
	BEGIN
		DROP PROCEDURE usp_ObtenerPermisos;
	END
GO

CREATE PROCEDURE usp_ObtenerPermisos
(
	@pId VARCHAR(100)
)
AS
BEGIN
	
	SELECT
        RUT.Id AS [ID_RUTA],
        RUT.Menu AS [RUTA],
        CASE 
            WHEN ROXRU.Id IS NULL THEN 0 
            ELSE 1 
        END AS [IS_PERMISO]
    FROM RUTA RUT
    LEFT JOIN ROLXRUTA ROXRU 
        ON ROXRU.IdRuta = RUT.Id 
       AND ROXRU.IdRol = @pId

END