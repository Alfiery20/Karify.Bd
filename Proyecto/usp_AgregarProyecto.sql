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
	@pIdProfesor INT,
	@pNombreArchivo VARCHAR(MAX),
	@pArchivoBase64 VARBINARY(MAX),
	@pPeso INT,
	@idNuevoProyecto INT OUTPUT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @idProyecto INT
			
			INSERT INTO PROYECTO(Nombre, Descripcion, FechaRegistro, IdProfesor)
				VALUES(@pNombre, @pDescripcion, @pFechaRegistro, @pIdProfesor)

			SET @idProyecto = SCOPE_IDENTITY();

			INSERT INTO PROYECTOXALUMNO(IdProyecto, IdAlumno)
				VALUES(@idProyecto, @pIdAlumno)

			INSERT INTO REVISION(NombreArchivo, ArchivoBase64, 
						Peso, FechaRegistro, Estado, IdProyecto)
				VALUES (@pNombreArchivo, @pArchivoBase64, @pPeso, 
						@pFechaRegistro, 'P', @idProyecto)

			SET @idNuevoProyecto = @idProyecto;
			SET @msj = 'OK';

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		SET @idNuevoProyecto = 0;
		ROLLBACK TRANSACTION
	END CATCH

END