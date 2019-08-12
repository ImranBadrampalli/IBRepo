/*
	Scenario 4:
	The team has been sent an extract from the mainframe to perform price updates based on category. Using Update.txt, update the product pricing.

	The file format is:

	ProductCategoryId.ProductSubcategoryId|Margin
	-------------------------------------------------
	000001.000001|1.7950

	The list price should be Standard Cost * Margin
*/

/* Author :Imran Badrampalli
   Date   :08/10/2019
   Business requirement:To read and load the provided Inbound text file and update the new list price for given products
*/
USE Kata;
GO
CREATE TABLE #PriceData           
(            
[ProductCategoryId] [int]  ,          
[ProductSubcategoryId] int ,          
[Margin] decimal            
)            
SET @query = 'BULK INSERT #PriceData FROM ''' + 'C\Users\update.txt' + ''' WITH ( FIELDTERMINATOR = ''|'',ROWTERMINATOR = ''\n'')'                  
EXECUTE(@query)

/*  
Prerequisites :
Can Built SSIS package with flat file connection to import the file,do the mapping and load into stage table to use it.
Or Use Bulk operation to read,load the text file into Temp table/Stage table,perform split operations to seperate ProductCategoryId/ProductSubcategoryId
*/

BEGIN TRY
BEGIN TRANSACTION T

UPDATE P
SET ListPrice= RTRIM(LTRIM(PD.Margin * P.StandardCost))  --The list price should be Standard Cost * Margin
FROM [Production].[Product] P INNER JOIN #PriceData Pd ON Pd.ProductSubcategoryId=p.ProductSubcategoryId

COMMIT TRANSACTION T
END TRY

BEGIN CATCH
ROLLBACK TRANSACTION T
END CATCH

DROP Table #PriceData 
GO