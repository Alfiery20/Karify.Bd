USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_AgregarProyecto') 
	BEGIN
		DROP PROCEDURE usp_AgregarProyecto;
	END
GO

CREATE PROCEDURE usp_AgregarProyecto
(
	@pNombre VARCHAR(200),
	@pDescripcion VARCHAR(MAX),
	@pFechaRegistro DATETIME,
	@pIdAlumno INT,
	@pIdCotesista INT,
	@pIdProfesor INT,
	@pNombreArchivo VARCHAR(MAX),
	@pArchivoBase64 VARCHAR(MAX),
	@pPeso INT,
	@idNuevoProyecto INT OUTPUT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @idProyecto INT, @nuevoEstado CHAR(1) = 'P'

			IF(@pIdCotesista = @pIdAlumno)
			BEGIN
				SET @msj = 'E1';
				SET @idNuevoProyecto = 0;
			END
			ELSE
			BEGIN
				INSERT INTO PROYECTO(Nombre, Descripcion, FechaRegistro, IdProfesor)
					VALUES(@pNombre, @pDescripcion, @pFechaRegistro, @pIdProfesor)

				SET @idProyecto = SCOPE_IDENTITY();

				INSERT INTO PROYECTOXALUMNO(IdProyecto, IdAlumno, IsPrincipal)
					VALUES(@idProyecto, @pIdAlumno, 1)

				IF(@pIdCotesista IS NOT NULL AND @pIdCotesista > 0)
				BEGIN
					INSERT INTO PROYECTOXALUMNO(IdProyecto, IdAlumno, IsPrincipal)
						VALUES(@idProyecto, @pIdCotesista, 0)
					SET @nuevoEstado = 'T'
				END

				INSERT INTO REVISION(NombreArchivo, ArchivoBase64, 
							Peso, FechaRegistro, Estado, IdProyecto)
					VALUES (@pNombreArchivo, @pArchivoBase64, @pPeso, 
							@pFechaRegistro, @nuevoEstado, @idProyecto)

				SET @idNuevoProyecto = @idProyecto;
				SET @msj = 'OK';
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		SET @idNuevoProyecto = 0;
		ROLLBACK TRANSACTION
	END CATCH

END