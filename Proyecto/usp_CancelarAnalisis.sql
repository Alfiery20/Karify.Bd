USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_CancelarAnalisis') 
	BEGIN
		DROP PROCEDURE usp_CancelarAnalisis;
	END
GO

CREATE PROCEDURE usp_CancelarAnalisis
(
	@pidProyecto INT,
	@pidUsuario INT,
	@pfechaCancelacion DATETIME,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION			

			UPDATE REV SET 
				Estado = 'C',
				FechaResultado = @pfechaCancelacion
			FROM REVISION REV
			INNER JOIN PROYECTO PRO ON PRO.Id = REV.IdProyecto
			INNER JOIN PROYECTOXALUMNO PROXALU ON PROXALU.IdProyecto = PRO.Id
			INNER JOIN ALUMNO ALU ON ALU.Id = PROXALU.IdAlumno
			WHERE PRO.Id = @pIdProyecto AND ALU.IdUsuario = @pIdUsuario

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