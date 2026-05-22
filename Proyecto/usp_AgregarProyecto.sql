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