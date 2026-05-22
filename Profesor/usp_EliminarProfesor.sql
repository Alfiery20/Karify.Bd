USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EliminarProfesor') 
	BEGIN
		DROP PROCEDURE usp_EliminarProfesor;
	END
GO

CREATE PROCEDURE usp_EliminarProfesor
(
	@pId INT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			DECLARE @idUsuario INT;

			SELECT 
				@idUsuario = IdUsuario
			FROM PROFESOR WHERE Id = @pId

			UPDATE USUARIO 
				SET Estado =
					(CASE 
						WHEN Estado = 0 THEN 1 
						ELSE 0 
					 END)
			WHERE Id = @idUsuario

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