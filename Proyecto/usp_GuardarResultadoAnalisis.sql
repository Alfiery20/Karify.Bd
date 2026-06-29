USE Karify;
GO
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'usp_GuardarResultadoAnalisis') 
	BEGIN
		DROP PROCEDURE usp_GuardarResultadoAnalisis;
	END
GO

CREATE PROCEDURE usp_GuardarResultadoAnalisis
(
	@pidProyecto INT,
	@pDOI VARCHAR(20),
	@pPorcentaje DECIMAL(10,4),
	@pFechaProcesamiento DATETIME,
	@msj VARCHAR(200) OUTPUT
)
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION			
			
			UPDATE REVISION SET 
				ProyectoSimilarDOI = @pDOI, 
				PorcentajeSimilitud = @pPorcentaje,
				FechaProcesamiento = @pFechaProcesamiento,
				Estado = (CASE WHEN @pPorcentaje < 40.00 THEN 'F' ELSE 'R' END)
			WHERE IdProyecto = @pidProyecto

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