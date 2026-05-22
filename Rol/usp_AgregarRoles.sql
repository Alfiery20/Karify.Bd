USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_AgregarRoles') 
	BEGIN
		DROP PROCEDURE usp_AgregarRoles;
	END
GO

CREATE PROCEDURE usp_AgregarRoles
(
	@pNombre VARCHAR(200),
	@pPermiso XML,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION

			DECLARE @idNuevo INT;

			INSERT INTO ROL(Nombre, Estado) VALUES (@pNombre, 1);

			SET @idNuevo = SCOPE_IDENTITY();

			INSERT INTO ROLXRUTA(IdRuta, IdRol)
			SELECT 
				T.N.value('(IdRuta)[1]', 'INT') AS IdRuta,
				@idNuevo
			FROM @pPermiso.nodes('/Permisos/Permiso') AS T(N);

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