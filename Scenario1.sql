/*
	Scenario 1:
	There was an error in the order entry system that caused duplicate order lines to get entered into the database. Remove the duplicate order lines.
	BONUS: Modify the database so that this error cannot happen again.
*/
USE Kata;
GO

/* Author :Imran Badrampalli
   Date   :08/10/2019
   STEP 1 :To Identify the duplicate orders using Row number() and common type expressions and delete it from SalesOrderHeader table
*/
BEGIN TRY
BEGIN TRANSACTION T
WITH CTE AS(
   SELECT SalesOrderID,ROW_NUMBER()OVER(PARTITION BY SalesOrderID ORDER BY SalesOrderID) AS RWN
   FROM [Sales].[SalesOrderHeader] WITH (NOLOCK)
)
DELETE FROM CTE WHERE RWN > 1
COMMIT TRANSACTION T
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION T
END CATCH
GO

/* STEP 2 : To set the primary key on SalesOrderHeader.SalesOrderID */
ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT PK_SalesOrderID PRIMARY KEY (SalesOrderID)
GO
