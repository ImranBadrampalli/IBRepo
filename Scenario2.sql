/*
	Scenario 2:
	New orders came into the staging area for (2008-05-01). Merge these orders with the existing orders for the same date.
*/
USE Kata;
GO
/* Author :Imran Badrampalli
   Date   :08/10/2019
   Query Written To :Get the existing orders and add the new orders from  staging area for (2008-05-01).
*/

DECLARE @OrderStartDate DateTime='2008-05-01 00:00:00',
        @OrderEndDate   DateTime='2008-05-01 23:59:59'

SELECT * FROM [Sales].[SalesOrderHeader] WITH (NOLOCK)
         WHERE OrderDate BETWEEN @OrderStartDate AND @OrderEndDate
UNION
SELECT * FROM [Sales].[SalesOrderHeaderStaging] WITH (NOLOCK)
         WHERE OrderDate BETWEEN @OrderStartDate AND @OrderEndDate
 GO