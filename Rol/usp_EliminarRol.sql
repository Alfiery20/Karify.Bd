USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EliminarRol') 
	BEGIN
		DROP PROCEDURE usp_EliminarRol;
	END
GO

CREATE PROCEDURE usp_EliminarRol
(
	@pId INT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE ROL 
				SET Estado =
					(CASE 
						WHEN Estado = 0 THEN 1 
						ELSE 0 
					 END)
			WHERE Id = @pId

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