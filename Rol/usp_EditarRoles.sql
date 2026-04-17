USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarRoles') 
	BEGIN
		DROP PROCEDURE usp_EditarRoles;
	END
GO

CREATE PROCEDURE usp_EditarRoles
(
	@pId INT,
	@pNombre VARCHAR(200),
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE ROL SET Nombre = @pNombre WHERE Id = @pId

			IF(@@ROWCOUNT > 0)
				BEGIN
					SET @msj = 'OK';
				END
			ELSE
				BEGIN
					SET @msj = 'EX'
				END

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END