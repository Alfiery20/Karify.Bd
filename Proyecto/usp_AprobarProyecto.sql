USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_AprobarProyecto') 
	BEGIN
		DROP PROCEDURE usp_AprobarProyecto;
	END
GO

CREATE PROCEDURE usp_AprobarProyecto
(
	@pIdProyecto INT,
	@pIdUsuario INT,
	@pFechaRespuesta DATETIME,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
			
			UPDATE REV SET 
				Estado = 'A',
				FechaResultado = @pFechaRespuesta
			FROM REVISION REV
			INNER JOIN PROYECTO PRO ON PRO.Id = REV.IdProyecto
			INNER JOIN PROFESOR PROF ON PROF.Id = PRO.IdProfesor
			WHERE PRO.Id = @pIdProyecto AND PROF.IdUsuario = @pIdUsuario

			IF(@@ROWCOUNT > 0)
			BEGIN
				SET @msj = 'OK';
			END
			ELSE
			BEGIN
				SET @msj = 'E1'
			END

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END