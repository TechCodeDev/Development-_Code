-------------------------------------------------------------------------------------------------------------------------------------------

--/ 1)Display the details of all the customer
	 SELECT SC.* FROM Sales.Customer SC

-------------------------------------------------------------------------------------------------------------------------------------------

--/ 2)Display the ID, type, number, and expiry year of all the credit cards in the following format.  
	 SELECT SC.CreditCardID AS 'Credit Card ID',
			SC.CardType AS 'Credit Card Type',
			SC.CardNumber AS'Credit Card Number',
			SC.ExpYear AS 'Expiry Year'
			FROM Sales.CreditCard SC

-------------------------------------------------------------------------------------------------------------------------------------------

 --/3)Display the customer ID and the account number of all the customers who live in the Territory ID 4.
	SELECT SC.CustomerID,
		   SC.AccountNumber 
		   FROM Sales.Customer SC
	       WHERE SC.TerritoryID=4

-------------------------------------------------------------------------------------------------------------------------------------------

 --/4)Display all the details of the sales orders that have a cost exceeding $ 2,000.
    SELECT * FROM Sales.SalesOrderDetail SS
			 WHERE SS.UnitPrice>2000

-------------------------------------------------------------------------------------------------------------------------------------------

	--/5)Display the sales order details of the product named ‘Cable Lock’.
	--Hint : The Product ID for Cable Lock is 843.
		SELECT * FROM Sales.SalesOrderDetail SS
				WHERE SS.ProductID=843
   	--SELECT * FROM Production.Product WHERE Name='Cable Lock'

-------------------------------------------------------------------------------------------------------------------------------------------

	--/6)Display the list of all the orders placed on June 06, 2004
		
		SELECT SS.* FROM Sales.SalesOrderHeader SS
		WHERE YEAR(SS.OrderDate)=2004 AND MONTH(SS.OrderDate)=06 
 
-------------------------------------------------------------------------------------------------------------------------------------------

	--/7)Display a report of all the orders in the following format. 
		
		SELECT SO.SalesOrderID AS 'Order ID' ,
			   SO.OrderQty AS 'Order Quantity',
			   SO.UnitPrice AS 'Unit Price', 
			   SO.LineTotal AS 'Total Cost'
			   FROM Sales.SalesOrderDetail SO

-------------------------------------------------------------------------------------------------------------------------------------------

	--/8)Display a list of all the sales orders in the price range of $ 2,000 to $ 2,100.
	---Note   LineTotal Cast  the subtotal of each product. Computed as 
	-- UnitPrice * (1-UnitPriceDiscount) * OrderQty.
	   
	   SELECT  *, 
			 SO.UnitPrice * (1-SO.UnitPriceDiscount) * SO.OrderQty AS 'LineTotal COst'FROM SALES.SalesOrderDetail SO
			 WHERE SO.UnitPrice BETWEEN 2000 AND 2100

-------------------------------------------------------------------------------------------------------------------------------------------

	--/9)Display the name, country region code, and sales year to date for the territory with Territory ID as 1.
		
		SELECT ST.Name,
			   ST.CountryRegionCode,
			   ST.SalesLastYear 
			   FROM Sales.SalesTerritory ST
			   WHERE TerritoryID=1

-------------------------------------------------------------------------------------------------------------------------------------------

	--/10)Display the details of the orders that have a tax amount of more than $10,000.
		
		SELECT * FROM Sales.SalesOrderHeader SH
		WHERE SH.TaxAmt>10000

-------------------------------------------------------------------------------------------------------------------------------------------

	--/11)Display the sales territory details of Canada, France, and Germany.
		
		SELECT * FROM Sales.SalesTerritory ST
		WHERE ST.Name='Canada'OR ST.Name='Germany' OR ST.Name='FRANCE'

-------------------------------------------------------------------------------------------------------------------------------------------

	--/12)Generate a report that contains the IDs of sales persons liv in the
	-- territory with Territory ID as 2 or 4. The report is required in the following format.
		
		SELECT SO.SalesPersonID,SO.TerritoryID FROM Sales.SalesOrderHeader SO
		WHERE TerritoryID=2 OR TerritoryID=4

-------------------------------------------------------------------------------------------------------------------------------------------
	--/13) Display the details of the Vista credit cards that are expiring in the year 2006.
	   SELECT * FROM Sales.CreditCard SC
	   where SC.CardType='VISTA' AND SC.ExpYear=2006

-------------------------------------------------------------------------------------------------------------------------------------------

	--/14)Display the details of all the orders that were shipped after July 12, 2004.
	   SELECT * FROM Sales.SalesOrderHeader SO
	   WHERE  SO.ShipDate>YEAR(2004)-MONTH(07)-DAY(12)

-------------------------------------------------------------------------------------------------------------------------------------------

	--/15) Display the orders placed on July 01, 2001
	--/ that have a total cost of more than $10,000 in the following format.
	  SELECT SO.SalesOrderNumber AS 'Order Number' ,
				SO.OrderDate AS 'Order Date',
				SO.Status AS 'Status',
				SO.SubTotal AS 'Total Cost' FROM  SALES.SalesOrderHeader SO
	  WHERE SO.ShipDate=YEAR(2001)-MONTH(07)-DAY(01) AND SubTotal>10000

-------------------------------------------------------------------------------------------------------------------------------------------

	--/16)Display the details of the orders that have been placed by customers online.
	 SELECT * FROM Sales.SalesOrderHeader SH
	 WHERE SH.OnlineOrderFlag=1

-------------------------------------------------------------------------------------------------------------------------------------------

	--/17)Display the order ID and the total amount due of all the sales orders in 
	--the following format. Ensure that the order with the highest price is at the top of the list.
	 SELECT SH.SalesOrderID AS 'Order ID',SH.TotalDue  FROM Sales.SalesOrderHeader SH
	 ORDER BY SH.TotalDue DESC

-------------------------------------------------------------------------------------------------------------------------------------------

	--/18)Display the order ID and the tax amount for the sales orders that are less than $ 2,000. 
	--The data should be displayed in ascending order.
	SELECT SH.SalesOrderID AS 'ORDER ID', SH.TaxAmt AS 'TAX AMOUNT' FROM Sales.SalesOrderHeader SH
	WHERE SH.TaxAmt<2000
	ORDER BY SH.TaxAmt ASC

-------------------------------------------------------------------------------------------------------------------------------------------

	--/19)Display the order number and the total value of the order in ascending order of the 
	--total value
	SELECT SO.SalesOrderNumber AS 'ORDER NUMBER',SO.SubTotal AS 'TOTAL VALUE' FROM Sales.SalesOrderHeader SO
	ORDER BY SubTotal ASC

-------------------------------------------------------------------------------------------------------------------------------------------

	--/20)Display the maximum, minimum, and the average rate of sales orders.
		SELECT MAX(SS.SubTotal) AS Maximum,MIN(SS.SubTotal) AS Minimum ,AVG(SS.SubTotal) AS 'Average rate' 
	FROM Sales.SalesOrderHeader SS

	SELECT * FROM SALES.SalesOrderHeader
--	SELECT MAX(TotalDue),MIN(TotalDue), AVG(TotalDue)
--FROM Sales.SalesOrderHeader

-------------------------------------------------------------------------------------------------------------------------------------------

	--/21)Display the total value of all the orders put together.
	 SELECT SUM(SH.SubTotal) AS 'SUBTOTAL' FROM Sales.SalesOrderHeader SH

-------------------------------------------------------------------------------------------------------------------------------------------

	--22)Display the Order ID of the top five orders based on the total amount due in the year 2001.
	--Hint : You can extract the year part form a date using the Datepart function.
	 SELECT TOP(5) SH.SalesOrderID FROM Sales.SalesOrderHeader SH
	 WHERE DATEPART(YEAR,SH.DueDate)=2001

-------------------------------------------------------------------------------------------------------------------------------------------

	--/23)Display the details of all currencies that have the word ‘Dollar’ in their name.
	SELECT * FROM Sales.Currency SC
	WHERE SC.Name LIKE '%Dollar%'

-------------------------------------------------------------------------------------------------------------------------------------------

	--/24)Display all territories whose names begin with ‘N’.
	SELECT * FROM Sales.SalesTerritory ST
	WHERE ST.Name LIKE 'N%'

-------------------------------------------------------------------------------------------------------------------------------------------

	--/25)Display the SalesPersonID, the TerritoryID, and the sales quota 
	--for those sales persons who have been assigned a sales quota.
--   The data should be displayed in the following format.
	  
	 SELECT  SO.SalesPersonID,SP.SalesQuota,SO.TerritoryID  
	 FROM Sales.SalesPerson SP ,Sales.SalesOrderHeader SO
	 WHERE SP.BusinessEntityID=SO.SalesPersonID and SP.SalesQuota IS NOT NULL 

-------------------------------------------------------------------------------------------------------------------------------------------
	
	--/26)What will be the output of the following code written to display the total order value for each order?
      SELECT  SalesOrderID, ProductID, sum (LineTotal) FROM
      Sales.SalesOrderDetail GROUP BY SalesOrderID
	  --/OUTPUT:Msg 8120, Level 16, State 1, Line 128
	  --/Column 'Sales.SalesOrderDetail.ProductID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

-------------------------------------------------------------------------------------------------------------------------------------------

	--/27)Display a report containing the product ID and the total cost of products 
	--    for the product ID whose total cost is more than $ 10,000.
	  SELECT ProductID AS 'ProductID', LineTotal AS 'TOATL COST' FROM Purchasing.PurchaseOrderDetail
	  WHERE LineTotal>10000

-------------------------------------------------------------------------------------------------------------------------------------------
		
	--/28)The following SQL query containing the COMPUTE BY clause generates errors, 
	--What are possible causes of such errors?
               SELECT ProductID, Linetotal AS ‘Total’ FROM Sales.SalesOrderDetail 
			   COMPUTE sum (LineTotal) BY ProductID

		--SYNATX ERROR

-------------------------------------------------------------------------------------------------------------------------------------------

	--/29)Display the top three sales persons based on the bonus.
		SELECT TOP(3) SP.* FROM Sales.SalesPerson SP
		ORDER BY Bonus DESC

-------------------------------------------------------------------------------------------------------------------------------------------

	--/30)Display the details of those stores that have Bike in their name.
		SELECT * FROM Sales.Store SS
		WHERE SS.Name LIKE '%Bike%' 

-------------------------------------------------------------------------------------------------------------------------------------------

--/31)Display the total amount collected from the orders for each order date.
		SELECT SO.SubTotal+SO.TotalDue AS 'TOTALAMOUNT'  FROM Sales.SalesOrderHeader SO

-------------------------------------------------------------------------------------------------------------------------------------------

	--/32)Display the total unit price and the total amount collected after selling the products. 
	--774 and 777. In addition, calculate the total amount collected from these two products.
		SELECT SUM(SO.UnitPrice) AS 'TOTAL UNIT PRICE', 
			   SUM(SH.SubTotal) AS 'TOTAL AMOUNT'
				FROM Sales.SalesOrderDetail SO,Sales.SalesOrderHeader SH
				WHERE SO.SalesOrderID=SH.SalesOrderID AND 
					 (SO.ProductID=774 OR SO.ProductID=777) AND
					  CarrierTrackingNumber IS NOT NULL

-------------------------------------------------------------------------------------------------------------------------------------------

	--33)Display the sales order ID and the maximum and minimum values of the order 
	--based on the sales order ID. In addition, ensure that the order amount is greater than $ 5,000.		
		--SELECT MAX(SH.SalesOrderID) AS 'MAXIMUM',MIN(SH.SalesOrderID) AS 'MINIMUM'  FROM Sales.SalesOrderHeader SH
		--WHERE SH.SubTotal>5000
		
		SELECT SalesOrderID ,
				MAX(LineTotal) as 'MAX',
				MIN(LineTotal) as 'MIN' 
				FROM Sales.SalesOrderDetail 
					 WHERE LineTotal > 5000
					 GROUP BY SalesOrderID

		--SELECT * FROM
-------------------------------------------------------------------------------------------------------------------------------------------

	--34)Display a report containing the sales order ID and 
	--the average value of the total amount greater than $ 5,000 in the following format.
		
		SELECT SH.SalesOrderID,
			   SH.SubTotal FROM Sales.SalesOrderHeader SH
			   WHERE SH.SubTotal>5000
-------------------------------------------------------------------------------------------------------------------------------------------


--/35 Display the different types of credit cards used for purchasing products.
		
		SELECT DISTINCT  CardType 
			   FROM Sales.CreditCard SC

-------------------------------------------------------------------------------------------------------------------------------------------
--36)Display the customer ID, name, and sales person ID for all the stores.
-- According to the requirement, only first 15 letters of the customer name should be displayed.

		SELECT SOH.CustomerID,
			   LEFT(SS.Name,15),
			   SS.SalesPersonID
			   FROM Sales.Store SS,Sales.SalesOrderHeader SOH


-------------------------------------------------------------------------------------------------------------------------------------------
--/37)Display the details of all orders in the following format.

----Order Number	Total Due	Day of Order	Week Day
		SELECT SO.SalesOrderNumber AS 'ORDER NUMBER',
		       SO.TotalDue AS 'Total Due',
		       SO.OrderDate AS 'Day of Order',
		       DATEPART(WEEKDAY,OrderDate) AS ' WEEK DAY'
			   FROM Sales.SalesOrderHeader SO
			 

-------------------------------------------------------------------------------------------------------------------------------------------
--/38 Display SalesOrderID, OrderQty, and UnitPrice from the SalesOrderDetail table
--  where a similar unit price needs to be marked with an identical value. 
	
		SELECT SalesOrderID,
			   OrderQty,
			   RANK() OVER(ORDER BY SS.UNITPRICE  DESC) AS 'IDENTICAL VALUE',
			   SS.UnitPrice
			   FROM Sales.SalesOrderDetail SS
	
--------------------------------------------------------------------------------------------------------------------------------------------
--/39)Display the EmployeeID and the HireDate of the employees from the Employee table. 
  ---The month and the year need to be displayed.
  
		SELECT  HE.BusinessEntityID , 
				DATENAME(MONTH,HE.HireDate) AS 'MONTH',
				DATEPART(YEAR,HE.HireDate) AS 'YEAR',
				HE.HireDate 
				FROM HumanResources.Employee HE

		
--------------------------------------------------------------------------------------------------------------------------------------------
--/ 40 Write a query to retrieve the details of the product locations where cost rate 
--  is greater than 12. In addition, the locations need to be grouped into three groups,
--- and then ranked based on the cost rate in descending order.

		SELECT * ,
        	  RANK() OVER(ORDER BY CostRate DESC ) AS 'COST RATE',
			  NTILE(3) OVER( ORDER BY LocationID ) AS 'LOCATION' 
			  FROM Production.Location
			  WHERE CostRate>12

---------------------------------------------------------------------------------------------------------------------------------------------
		
--/41)Write a query to retrieve the list price of the products where the products 
---   where the product price is between $ 360.00 and $ 499.00 and display the 
---   price in the following format.The list price of “Product Name” is “Price”

	SELECT  'the list price of' + SPACE(1) +  Name + SPACE(1) +' is '+ CONVERT(varchar,ListPrice) 
	FROM  Production.Product
	WHERE ListPrice BETWEEN 360.00 AND 499.00

