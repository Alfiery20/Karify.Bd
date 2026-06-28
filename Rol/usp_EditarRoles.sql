USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_EditarRoles') 
	BEGIN
		DROP PROCEDURE usp_EditarRoles;
	END
GO

CREATE PROCEDURE usp_EditarRoles
(
	@pId INT,
	@pNombre VARCHAR(200),
	@pPermiso XML,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			UPDATE ROL SET Nombre = @pNombre WHERE Id = @pId

			DELETE FROM ROLXRUTA WHERE IdRol = @pId

			INSERT INTO ROLXRUTA(IdRol, IdRuta)
			SELECT 
				@pId,
				T.N.value('(IdRuta)[1]', 'INT') AS IdRuta
			FROM @pPermiso.nodes('/Permisos/Permiso') AS T(N);

			SET @msj = 'OK';

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END