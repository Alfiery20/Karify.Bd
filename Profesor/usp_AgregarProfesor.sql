USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_AgregarProfesor') 
	BEGIN
		DROP PROCEDURE usp_AgregarProfesor;
	END
GO

CREATE PROCEDURE usp_AgregarProfesor
(
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

		INSERT INTO USUARIO(Correo, IdRol) VALUES(@pemail, @pidRol)
		SET @usuarioEncontrado = SCOPE_IDENTITY();

		INSERT INTO PROFESOR(Nombre, ApellidoPaterno, ApellidoMaterno, IdUsuario) 
			VALUES(@pnombre, @pApellidoPaterno, @pApellidoMaterno, @usuarioEncontrado)

		SET @msj = 'OK';

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END