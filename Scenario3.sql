/*
	Scenario 3:
	Steve is a warehouse supervisor with a staff of four to pick the orders. Before the beginning of each shift, Steve splits all of the orders for the day into four lists, one for each of his staff. 
	Tonight (2008-05-01), Bob called in sick. Write a query to split the orders into three equal lists.
*/
USE Kata;
GO
/* Author :Imran Badrampalli
   Date   :08/10/2019
   Query Written To :Get the Total received orders for Steve's team on (2008-05-01) and assing them equally to the available staff.
*/
DECLARE @TotalOrders int,
        @AssignedOrders int
        @OrderStartDate DateTime='2008-05-01 00:00:00',
        @OrderEndDate   DateTime='2008-05-01 23:59:59'

SELECT @TotalOrders=COUNT(DISTINCT SalesOrderID) FROM [Sales].[SalesOrderHeader] WITH (NOLOCK)
         WHERE OrderDate BETWEEN @OrderStartDate AND @OrderEndDate
		 AND SalesPersonID=289   --Assume that Steve PersonId is 289

SELECT @AssignedOrders=@TotalOrders/3

SELECT 'TM1' AS Associate,@AssignedOrders  AS AssignedOrders UNION
       'TM2' AS Associate ,@AssignedOrders  AS AssignedOrders UNION
	   'TM3' AS Associate,@AssignedOrders  AS AssignedOrders
	    