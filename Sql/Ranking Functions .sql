SELECT BusinessEntityID,
	   Rate*9*22 AS 'Salary',
	   ROW_NUMBER() OVER(ORDER BY Rate*9*22 DESC) as 'RowNum'
	   FROM HumanResources.EmployeePayHistory

	    --using temp table 
SELECT BusinessEntityID,
	   Rate*9*22 AS 'Salary',
	   ROW_NUMBER() OVER(ORDER BY Rate*9*22 DESC) as 'RowNum' into #temp
	   FROM HumanResources.EmployeePayHistory 
	   GO


 -- WTIH TVP 
WITH TVP1 AS
(
		SELECT BusinessEntityID,
			   Rate*9*22 AS 'Salary',
			   ROW_NUMBER() OVER(ORDER BY Rate*9*22 DESC) as 'RowNum' 
			   FROM HumanResources.EmployeePayHistory 
 ) 
 SELECT * FROM TVP1 
 WHERE RowNum =3

  -- rank
SELECT BusinessEntityID,
	   Rate*9*22 AS 'Salary',
	   RANK() OVER(ORDER BY Rate*9*22 ASC) as 'RANK' 
	   FROM HumanResources.EmployeePayHistory 

SELECT BusinessEntityID,
	   Rate*9*22 AS 'Salary',
	   DENSE_RANK() OVER(ORDER BY Rate*9*22 ASC) as 'RANK' 
	   FROM HumanResources.EmployeePayHistory 

SELECT BusinessEntityID,
	   Rate*9*22 AS 'Salary',
	   NTILE(3) OVER(ORDER BY Rate*9*22 ASC) as 'Groups' 
	   FROM HumanResources.EmployeePayHistory 
