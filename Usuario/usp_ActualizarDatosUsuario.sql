USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_ActualizarDatosUsuario') 
	BEGIN
		DROP PROCEDURE usp_ActualizarDatosUsuario;
	END
GO

CREATE PROCEDURE usp_ActualizarDatosUsuario
(
	@pIdUsuario INT,
	@pCodigoUniversitario VARCHAR(10),
	@pTipoDocumento CHAR(1),
	@pNumeroDocumento VARCHAR(20),
	@pNombre VARCHAR(250),
	@pApellidoPaterno VARCHAR(250),
	@pApellidoMaterno VARCHAR(250),
	@pTelefono VARCHAR(20),
	@pEscuela INT,
	@msj CHAR(2) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE ALUMNO SET 
				TipoDocumento = @pTipoDocumento,
				NumeroDocumento = @pNumeroDocumento,
				Nombre = @pNombre,
				ApellidoPaterno = @pApellidoPaterno,
				ApellidoMaterno = @pApellidoMaterno,
				Telefono = @pTelefono
			WHERE IdUsuario = @pIdUsuario

			UPDATE PROFESOR SET 
				TipoDocumento = @pTipoDocumento,
				NumeroDocumento = @pNumeroDocumento,
				Nombre = @pNombre,
				ApellidoPaterno = @pApellidoPaterno,
				ApellidoMaterno = @pApellidoMaterno,
				Telefono = @pTelefono
			WHERE IdUsuario = @pIdUsuario

			UPDATE USUARIO SET
				CodigoUniversitario = @pCodigoUniversitario,
				IdEscuela = @pEscuela

			SET @msj = 'OK';
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		SET @msj = 'EX';
		ROLLBACK TRANSACTION;
	END CATCH
END