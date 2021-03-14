SELECT COUNT(*) FROM HumanResources.Department

DECLARE @C INT=(SELECT COUNT(*) FROM HumanResources.Department);
SELECT @C

SELECT COUNT(D.DepartmentID) FROM HumanResources.Department D

SELECT COUNT(SalesOrderDetailID) 
	   FROM Sales.SalesOrderDetail 
	   WHERE SalesOrderID = 43659

SELECT * FROM HumanResources.EmployeePayHistory

SELECT AVG(Rate * 9 * 22) 
	   FROM HumanResources.EmployeePayHistory

SELECT AVG(Rate) 
	   FROM HumanResources.EmployeePayHistory

SELECT MIN(Rate) 
	   FROM HumanResources.EmployeePayHistory

SELECT MIN(Rate * 9 * 22) 
	   FROM HumanResources.EmployeePayHistory

SELECT MAX(Rate) 
	   FROM HumanResources.EmployeePayHistory

SELECT MAX(Rate * 9 *22) 
	   FROM HumanResources.EmployeePayHistory

select rate from HumanResources.EmployeePayHistory

SELECT COUNT(*) 
	   FROM HumanResources.EmployeePayHistory
             WHERE (Rate * 9 * 22) < (
					  SELECT  AVG(Rate * 9 * 22) 
					  FROM HumanResources.EmployeePayHistory 
				     )


SELECT  AVG(Rate * 9 * 22),
	count(HREPH.BusinessEntityID) 
	FROM HumanResources.EmployeePayHistory HREPH
	GROUP BY  HREPH.BusinessEntityID


SELECT * FROM HumanResources.EmployeePayHistory
		 WHERE (Rate * 9 * 22) <(
						SELECT  AVG(Rate * 9 * 22) 
		    			        FROM HumanResources.EmployeePayHistory
					)

SELECT SUM(Rate) FROM HumanResources.EmployeePayHistory

SELECT SUM(LineTotal) AS 'Totla Due' 
	   FROM Sales.SalesOrderDetail
	   WHERE SalesOrderID=43659

SELECT ProductID , 
	   OrderQty , 
	   UnitPrice , 
	   LineTotal  
	   FROM Sales.SalesOrderDetail S
	   WHERE SalesOrderID=43659

SELECT * FROM Sales.SalesOrderHeader 
WHERE SalesOrderID = 43659

-- GROUP BY , HAVING 

SELECT Gender, 
	   MaritalStatus , 
	   COUNT(*) 
	   FROM HumanResources.Employee
	   GROUP BY Gender , MaritalStatus


SELECT BusinessEntityID,
	   COUNT(*) 
	   FROM HumanResources.Employee
	   GROUP BY BusinessEntityID

SELECT * FROM HumanResources.EmployeeDepartmentHistory

SELECT EDH.DepartmentID , 
	   COUNT(EDH.BusinessEntityID) AS 'Count OF EMP' 
	   FROM HumanResources.EmployeeDepartmentHistory EDH
	   GROUP BY EDH.DepartmentID
	   HAVING COUNT(EDH.BusinessEntityID) < 10

SELECT TOP(1) EPH.BusinessEntityID , 
	   EPH.Rate  * 9 * 22 
	   FROM HumanResources.EmployeePayHistory EPH
	   ORDER BY EPH.Rate  * 9 * 22 DESC

SELECT  EPH.BusinessEntityID , 
		EPH.Rate  * 9 * 22 
		FROM HumanResources.EmployeePayHistory EPH
		WHERE (EPH.Rate  * 9 * 22) >=( 
						SELECT MAX(Rate  * 9 * 22) FROM HumanResources.EmployeePayHistory
					     )

SELECT TOP(1)  EPH.BusinessEntityID , 
			   EPH.Rate  * 9 * 22 
			   FROM HumanResources.EmployeePayHistory EPH
			   WHERE (EPH.Rate  * 9 * 22) NOT IN ( 
								SELECT MAX(Rate  * 9 * 22) 
								FROM HumanResources.EmployeePayHistory
							     )
			  ORDER BY EPH.Rate  * 9 * 22 DESC
