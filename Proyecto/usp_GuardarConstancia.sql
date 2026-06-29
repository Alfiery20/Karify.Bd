USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_GuardarConstancia') 
	BEGIN
		DROP PROCEDURE usp_GuardarConstancia;
	END
GO

CREATE PROCEDURE usp_GuardarConstancia
(
	@pIdProyecto INT,
	@pNombreConstancia VARCHAR(MAX),
	@pBase64 VARCHAR(MAX),
	@pGuid VARCHAR(15),
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE REVISION SET
				NombreConstancia = @pNombreConstancia, 
				ConstanciaBase64 = @pBase64,
				GuidConstancia = @pGuid
			WHERE IdProyecto = @pIdProyecto

			SET @msj = 'OK';

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END