USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_DecisionDeRevision') 
	BEGIN
		DROP PROCEDURE usp_DecisionDeRevision;
	END
GO

CREATE PROCEDURE usp_DecisionDeRevision
(
	@pidProyecto INT,
	@pidProfesor INT,
	@pdecision BIT,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @idRevision INT

			SELECT @idRevision = REV.Id FROM REVISION REV 
				INNER JOIN PROYECTO PRO ON PRO.Id = REV.IdProyecto
			WHERE PRO.IdProfesor = @pidProfesor AND PRO.Id = @pidProyecto

			SET @idRevision = COALESCE(@idRevision, 0)

			IF(@idRevision = 0)			
			BEGIN
				UPDATE REVISION 
					SET Estado = 
						(CASE @pdecision 
							WHEN 1 THEN 'A' 
						ELSE 'R' END)
				WHERE Id = @idRevision

				SET @msj = 'OK';
			END
			ELSE 
			BEGIN
				SET @msj = 'EX';
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @msj = ERROR_MESSAGE();
		ROLLBACK TRANSACTION
	END CATCH

END