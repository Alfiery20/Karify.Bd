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
	@pIdAlumno INT,
	@pIdCotesista INT,
	@pIdProfesor INT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

		IF(@pIdCotesista = @pIdAlumno)
			BEGIN
				SET @msj = 'E1';
			END
		ELSE
			BEGIN
			
				UPDATE PROYECTO SET 
					Nombre = @pNombre,
					Descripcion = @pDescripcion,
					IdProfesor = @pIdProfesor
				WHERE Id = @pIdProyecto

				DELETE FROM PROYECTOXALUMNO 
					WHERE IdProyecto = @pIdProyecto

				INSERT INTO PROYECTOXALUMNO(IdProyecto, IdAlumno, IsPrincipal)
					VALUES(@pIdProyecto, @pIdAlumno, 1)

				IF(@pIdCotesista IS NOT NULL AND @pIdCotesista > 0)
				BEGIN
					INSERT INTO PROYECTOXALUMNO(IdProyecto, IdAlumno, IsPrincipal)
						VALUES(@pIdProyecto, @pIdCotesista, 0)

					UPDATE REVISION SET Estado = 'T' WHERE IdProyecto = @pIdProyecto
				END
				ELSE
				BEGIN
					UPDATE REVISION SET Estado = 'P' WHERE IdProyecto = @pIdProyecto
				END

				IF(@@ROWCOUNT > 0)
					BEGIN
						SET @msj = 'OK';
					END
				ELSE
					BEGIN
						SET @msj = 'EX'
					END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END