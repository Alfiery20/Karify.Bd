USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarProyecto') 
	BEGIN
		DROP PROCEDURE usp_EditarProyecto;
	END
GO

CREATE PROCEDURE usp_EditarProyecto
(
	@pIdProyecto INT,
	@pNombre VARCHAR(200),
	@pDescripcion VARCHAR(MAX),
	@pIdProfesor INT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
			
			UPDATE PROYECTO SET 
				Nombre = @pNombre,
				Descripcion = @pDescripcion,
				IdProfesor = @pIdProfesor
			WHERE Id = @pIdProyecto

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