USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarProfesor') 
	BEGIN
		DROP PROCEDURE usp_EditarProfesor;
	END
GO

CREATE PROCEDURE usp_EditarProfesor
(
	@pidProfesor INT,
	@pemail VARCHAR(250),
	@pNombre VARCHAR(250),
	@pApellidoPaterno VARCHAR(250),
	@pApellidoMaterno VARCHAR(250),
	@pidRol INT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @usuarioEncontrado INT

		SELECT 
			@usuarioEncontrado = IdUsuario
		FROM PROFESOR 
		WHERE Id = @pidProfesor;

		UPDATE USUARIO SET 
			Correo = @pemail,
			IdRol = @pidRol
		WHERE Id = @usuarioEncontrado

		UPDATE PROFESOR SET
			Nombre = @pNombre,
			ApellidoPaterno = @pApellidoPaterno,
			ApellidoMaterno = @pApellidoMaterno
		WHERE Id = @pidProfesor

		SET @msj = 'OK';

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END