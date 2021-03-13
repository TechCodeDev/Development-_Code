--use AdventureWorks2014 database only

--// DQL 
-- SELECT 

USE AdventureWorks2014
GO

-- SELECT ALL (*)
SELECT P.* FROM Person.Person P

SELECT D.* FROM HumanResources.Department D


-- DISTINCT
SELECT DISTINCT D.GroupName FROM HumanResources.Department D

SELECT DISTINCT D.* FROM HumanResources.Department D

SELECT DISTINCT D.Name, D.GroupName FROM HumanResources.Department D

SELECT DISTINCT  D.GroupName, D.Name FROM HumanResources.Department D


-- COLUMN LIST
SELECT D.DepartmentID,  D.Name FROM HumanResources.Department D

-- COLUMN ALIAS 
SELECT D.DepartmentID AS 'DEPT_ID',  
	   D.Name 
	   FROM HumanResources.Department D


SELECT 'DEPT_ID'=D.DepartmentID,  
	    D.Name 
	    FROM HumanResources.Department D

SELECT 'Quest'  AS 'Result'

SELECT 'Result'= 2+3

SELECT '2+3'

SELECT 'A' , 'A'

SELECT 'A''A'

SELECT 2,3

SELECT '2''3'

SELECT '2' '3'

SELECT 2'3'

SELECT 'Quest'  FROM HumanResources.Department

SELECT 2  FROM HumanResources.Department

SELECT DepartmentID  FROM HumanResources.Department

SELECT 'DepartmentID'  FROM HumanResources.Department

SELECT 'DepartmentID''DepartmentID'  FROM HumanResources.Department

SELECT 'DepartmentID' 'DepartmentID'  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID'  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID', DepartmentID  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID', 'DepartmentID'  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID'  'DepartmentID'  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID' 'DepartmentID''DepartmentID'  FROM HumanResources.Department

SELECT DISTINCT 'DepartmentID',* FROM HumanResources.Department

SELECT DISTINCT 2+3  FROM HumanResources.Department

SELECT 2+3  FROM HumanResources.Department

SELECT 'SELECT' AS 'SELECT' 

--ORDER BY-- 

SELECT EPH.* 
	   FROM HumanResources.EmployeePayHistory EPH
	   ORDER BY EPH.Rate ASC

SELECT EPH.* 
	   FROM HumanResources.EmployeePayHistory EPH
	   ORDER BY EPH.Rate DESC


SELECT EPH.* 
	   FROM HumanResources.EmployeePayHistory EPH		
           ORDER BY 2

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName 
	   FROM Person.Person P
	   ORDER BY 1 DESC 

SELECT P.FirstName,
	   P.MiddleName, 
	   P.LastName 
	   FROM Person.Person P
	   ORDER BY 1 ,2,3

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName 
	   FROM Person.Person P
	   ORDER BY P.FirstName, P.MiddleName

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName FROM Person.Person P
	   ORDER BY P.FirstName, P.MiddleName,P.LastName

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName FROM Person.Person P
	   ORDER BY P.FirstName, P.MiddleName DESC


SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName FROM Person.Person P
	   ORDER BY P.FirstName DESC, P.MiddleName ASC


SELECT P.FirstName,
       P.MiddleName ,
       P.LastName FROM Person.Person P
       ORDER BY 1 DESC, 2 ASC

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName FROM Person.Person P
           ORDER BY 1 DESC, 2 DESC

SELECT P.FirstName,
	   P.MiddleName , 
	   P.LastName FROM Person.Person P
           ORDER BY P.BusinessEntityID DESC

--WHERE-- 
SELECT * FROM HumanResources.Department 
WHERE DepartmentID =1

SELECT * FROM HumanResources.Employee 
WHERE OrganizationLevel IS NULL 

SELECT * FROM Person.Person
WHERE MiddleName IS NULL

SELECT * FROM Person.Person
WHERE MiddleName IS NOT NULL



SELECT EP.BusinessEntityID ,
	   EP.Rate AS 'Rate Per Hr',
	   EP.Rate * 9 AS 'Rate Per Day',
	   EP.Rate * 9 * 21 AS 'Rate Per Month'
           FROM HumanResources.EmployeePayHistory EP


-- Operators 

SELECT E.BusinessEntityID , 
       E.JobTitle
       FROM HumanResources.Employee E

SELECT 'EMPID-'+CAST(E.BusinessEntityID AS VARCHAR(5))+'-'+E.JobTitle AS 'Results'
FROM HumanResources.Employee E 

SELECT P.FirstName,
	   P.MiddleName,
	   P.LastName
           FROM Person.Person  P

SELECT 'Name'= P.FirstName + P.MiddleName 
FROM Person.Person  P

SELECT 'Name'= ISNULL(P.FirstName,SPACE(1)) + ISNULL(P.MiddleName,SPACE(1)) + ISNULL(P.LastName,SPACE(1))
FROM Person.Person  P
WHERE P.FirstName LIKE 'Kim%'

SELECT 'Name'=COALESCE(P.FirstName +SPACE(1) +P.MiddleName +SPACE(1) + p.LastName ,
					   P.FirstName +SPACE(1) + p.LastName, 
					   P.FirstName + SPACE(1) + P.MiddleName,
					   P.MiddleName +SPACE(1) + P. LastName) 
FROM Person.Person  P

-- TOP--

SELECT * FROM HumanResources.Employee

SELECT TOP(10) E.BusinessEntityID , E.BirthDate , E.JobTitle FROM HumanResources.Employee E

SELECT TOP(1) PERCENT E.*  FROM HumanResources.Employee E

-- IN , NOT IN , BETWEEN , NOT BETWEEN ,ANY , SOME , ALL--

SELECT * FROM HumanResources.EmployeeDepartmentHistory 
WHERE DepartmentID IN (1,2,3)


SELECT * FROM Person.CountryRegion

SELECT * FROM Person.StateProvince
WHERE CountryRegionCode IN ('US', 'AF')


SELECT * FROM Person.StateProvince
WHERE CountryRegionCode NOT IN ('US', 'AF')



SELECT * FROM HumanResources.EmployeeDepartmentHistory
WHERE DepartmentID NOT IN (1,5,10)


SELECT * FROM HumanResources.Employee
WHERE  YEAR(BirthDate) IN (1945,1965,1975)

SELECT BirthDate FROM HumanResources.Employee
WHERE  YEAR(BirthDate) NOT IN (1945,1965,1975) 

SELECT BirthDate FROM HumanResources.Employee
WHERE  YEAR(BirthDate) NOT IN (1945,1965,1975) AND MONTH(BirthDate) IN (2,5,12) 

SELECT * FROM HumanResources.Employee
WHERE BirthDate = '1969-01-29'

SELECT * FROM HumanResources.Employee
WHERE YEAR(BirthDate) BETWEEN 1990 AND 2000

SELECT * FROM HumanResources.Employee
WHERE YEAR(BirthDate) NOT BETWEEN 1990 AND 2000


--ANY , SOME , ALL

SELECT BusinessEntityID, 
       Rate 
       FROM HumanResources.EmployeePayHistory
       WHERE Rate > ANY ( 
       				SELECT Rate 
				FROM HumanResources.EmployeePayHistory 
				WHERE Rate BETWEEN 50 AND 100 
			)

SELECT BusinessEntityID, 
       Rate 
       FROM HumanResources.EmployeePayHistory
       WHERE Rate > SOME ( 
       				SELECT Rate 
				FROM HumanResources.EmployeePayHistory 
				WHERE Rate BETWEEN 50 AND 100 
			 )


SELECT Rate 
       FROM HumanResources.EmployeePayHistory
       WHERE Rate < ALL ( 
       				SELECT Rate 
				FROM HumanResources.EmployeePayHistory 
				WHERE Rate BETWEEN 50 AND 100 
			)


-- LIKE-- 

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'kim'              					--NAME LIKE kim

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'kIM'              					--NAME LIKE kim

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '%K'               					--NAME ENDS WITH K

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'K%'				  			--NAME STARTS WITH K


SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '%KK%'             					--GROUPED KK WITH IN STRING

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]%'			  				--STARTS WITH GROUPED A TO D 

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]___'	                  		        --STARTS WITH GROUPED A TO D WITH TWO LETTERS ONLY

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '___[A-D]'         					--ENDS WITH GROUPED A TO D ALONG WITH TWO LETTERS ONLY

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]___[X-Z]'    					--STARTING WITH A TO D ALONG AND END WITH X AND Z WITH TWO LETTERS ONLY

SELECT * FROM Person.PersonPhone
WHERE PhoneNumber LIKE '[987]%'          					--STARTING WITH 987 

SELECT P.FirstName FROM Person.Person P
WHERE SOUNDEX(P.FirstName) = SOUNDEX('Mary') 

SELECT P.FirstName FROM Person.Person P
WHERE SOUNDEX(P.FirstName) = SOUNDEX('Reena') 


--EXISTS--

SELECT * FROM HumanResources.Department 
WHERE EXISTS
(
	SELECT * FROM HumanResources.Department WHERE NAME LIKE '%S%'
)

SELECT * FROM HumanResources.Department 
WHERE NOT EXISTS
(
	SELECT * FROM HumanResources.Department WHERE NAME LIKE '%Z%'
)


-- Functions 

--(1) Date Time Functions
--https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15

SELECT GETDATE() AS 'Resut'
DECLARE @Today DATETIME = GETDATE();								--2021-03-10 00:07:19.273
PRINT @Today

SELECT CURRENT_TIMESTAMP  AS 'Resut'								--2021-03-10 00:07:43.540

SELECT DATEFROMPARTS(2020,01,30) AS 'Resut'							--2020-01-30

SELECT DATETIMEFROMPARTS(2020,01,30,11,10,15,0) AS 'Resut'					--2020-01-30 11:10:15.000

SELECT DATETIME2FROMPARTS(2020,01,30,11,10,15,0,0) AS 'Resut'   				--2020-01-30 11:10:15

SELECT TIMEFROMPARTS(14,15,30,0,0)  AS 'Resut'                 					--14:15:30

SELECT DATENAME(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT DATENAME(MONTH,GETDATE()) AS 'Resut'							--March

SELECT DATENAME(DAY,GETDATE()) AS 'Resut'							--10

SELECT DATENAME(QUARTER,GETDATE()) AS 'Resut'							--1

SELECT DATENAME(DAYOFYEAR,GETDATE()) AS 'Resut'							--69

SELECT DATENAME(WEEK,GETDATE()) AS 'Resut'							--11

SELECT DATENAME(WEEKDAY,GETDATE()) AS 'Resut'							--Wednesday

SELECT DATENAME(HOUR,GETDATE()) AS 'Resut'                      				--21

SELECT DATENAME(MINUTE,GETDATE()) AS 'Resut'							--56
												
SELECT DATENAME(SECOND,GETDATE()) AS 'Resut'							--41varies

SELECT DATEPART(SECOND,GETDATE()) AS 'Resut'							--41varies

SELECT DATEPART(MONTH,GETDATE()) AS 'Resut'							--3

SELECT DATEPART(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT DATEPART(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT YEAR(GETDATE()) AS 'Resut'								--2021

SELECT MONTH(GETDATE()) AS 'Resut'								--3

SELECT DAY(GETDATE()) AS 'Resut'								--10

SELECT EOMONTH(GETDATE()) AS 'Resut'								--Every end of Month based upon the month

SELECT ISDATE('2020/01/30') AS 'Resut'								--return 1 because jan 30th day

SELECT ISDATE('2020/02/30') AS 'Resut'								--return 0 because Feb 30th day

SELECT ISDATE(NULL) AS 'Resut'

SELECT DATEADD(YEAR,1,GETDATE()) AS 'Resut'							--2022-03-10 22:27:08.640

SELECT DATEADD(YEAR,10,GETDATE()) AS 'Resut'							--2031-03-10 22:30:00.683

SELECT DATEADD(MONTH,6,GETDATE()) AS 'Resut'							--2021-09-10 22:33:50.450

SELECT DATEADD(DAY,10,GETDATE()) AS 'Resut'							--2021-03-20 22:34:45.660

SELECT DATEADD(DAY,-10,GETDATE()) AS 'Resut'							--2021-02-28 22:34:58.823

SELECT DATEDIFF(YEAR,'2000-01-30',GETDATE()) AS 'Resut'						--21

SELECT DATEDIFF(YEAR,'2019-12-30',GETDATE()) AS 'Resut'						--2

SELECT DATEDIFF(MONTH,'2019-11-30',GETDATE()) AS 'Resut'					--16

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE MONTH(E.BirthDate)=2

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE MONTH(E.BirthDate)=1  AND  DAY(E.BirthDate)=29 

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE DATEDIFF(YEAR,E.BirthDate,GETDATE()) > 60

SELECT E.BusinessEntityID , 
	   E.BirthDate FROM HumanResources.Employee E
	   WHERE DATEDIFF(YEAR,E.BirthDate,GETDATE()) < 30


--(1) String Functions
--https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver15

SELECT ASCII('Q') AS 'Result'										--81

SELECT ASCII('Quest') AS 'Result'									--81

SELECT CHAR(65) AS 'Result'										--A

SELECT CHAR(97) AS 'Result'										--a

SELECT CHAR(123) AS 'Result'										--{

SELECT CHARINDEX('t','Quest') AS 'Result'								--5

SELECT CHARINDEX('Q','Quqest') AS 'Result'								--1

SELECT CHARINDEX('Q','Quqest',4) AS 'Result'								--0

SELECT CHARINDEX('Q','Quqest',2) AS 'Result'								--3

SELECT CONCAT('India','-','Bangalore') AS 'Result'							--India-Bangalore

SELECT CONCAT('India','-','Bangalore') AS 'Result'

SELECT CONCAT(',', 'Bangalore','Chennai') AS 'Result'							--,BangaloreChennai

SELECT DIFFERENCE(SOUNDEX('Ram'),SOUNDEX('Shyam'))							--3

print SOUNDEX('Quest')

SELECT FORMAT(GETDATE(),'yyyy-dd-MM') AS 'Result'							--2021-10-03

SELECT FORMAT(GETDATE(),'yyyy-dd-MMM') AS 'Result'							--2021-10-Mar

SELECT FORMAT(GETDATE(),'yyyy-dd-MMMM') AS 'Result'							--2021-10-March

SELECT FORMAT(500,'C') AS 'Result'									--$500.00

SELECT FORMAT(500,'c') AS 'Result'									--$500.00

SELECT LEFT('Quest',2) AS 'Result'									--Qu

SELECT RIGHT('Quest',2) AS 'Result'									--st

SELECT LEN('Quest') AS 'Result'										--5

SELECT LOWER('Quest') AS 'Result'									--quest

SELECT UPPER('Quest') AS 'Result'									--QUEST

SELECT LTRIM('      Quest') AS 'Result'									--Quest

SELECT RTRIM('Quest     ') AS 'Result'									--Quest

SELECT NCHAR(65) AS 'Result'										--A

SELECT PATINDEX('%st%','Quest') AS 'Result'								--4

SELECT  PATINDEX('%en_ure%', 'Please ensure the door is locked!') AS 'Result'--8

SELECT QUOTENAME('Employee') AS 'Result'								--[Employee]

SELECT REPLACE('Employee','E','X') AS 'Result'								--XmployXX

SELECT REPLACE('968961111','1','X') AS 'Result'								--96896XXXX

SELECT REPLICATE('Q',3) AS 'Result'									--QQQ

SELECT REPLICATE('Quest',3) AS 'Result'									--QuestQuestQuest

SELECT REVERSE('Quest') AS 'Result'									--tseuQ

SELECT STR(12.36) AS 'Result'										--12

SELECT STR(12.31,6,2) AS 'Result'									--12.31

SELECT SUBSTRING('Quest Informatics',6,3) AS 'Result'							--In

SELECT SUBSTRING('Quest Informatics',7,4) AS 'Result'							--Info

SELECT STUFF('ABCDEFGH',0,0,'-XYZ-') AS 'Result'							--NULL

SELECT STUFF('ABCDEFGH',1,0,'-XYZ-') AS 'Result'							---XYZ-ABCDEFGH

SELECT STUFF('ABCDEFGH',1,4,'-XYZ-') AS 'Result'							---XYZ-EFGH

SELECT STUFF('ABCDEFGH',8,0,'-XYZ-') AS 'Result'							--ABCDEFG-XYZ-H

SELECT STUFF('ABCDEFGH',8,1,'-XYZ-') AS 'Result'							--ABCDEFG-XYZ-

SELECT STUFF('ABCDEFGH',9,0,'-XYZ-') AS 'Result'							--NULL

--SELECT STRING_SPLIT('D:\MR_files\Mphasis_MLA .NET', ' ') AS 'Result'

--SELECT STRING_AGG('Quest',',') AS 'Result'

--https://docs.microsoft.com/en-us/sql/t-sql/functions/aggregate-functions-transact-sql?view=sql-server-ver15
--https://docs.microsoft.com/en-us/sql/t-sql/functions/ranking-functions-transact-sql?view=sql-server-ver15


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


USE SampleDB
GO

--INNER JOIN 

SELECT C.* , F.* 
	   FROM dbo.Table_Color C
	   INNER JOIN dbo.Table_Fruits F
	   ON C.Color = F.Fruit


SELECT C.* , F.* 
	   FROM dbo.Table_Color C
	   INNER JOIN dbo.Table_Fruits F
	   ON C.Color = F.Fruit


SELECT E.*, 
	   A.AddresLine , 
	   A.City ,
	   A.State, 
	   A.Country ,
	   A.PinCode   
	   FROM dbo.MA_Employee E
	   INNER JOIN dbo.MA_Address A
	   ON E.EmpID = A.EMPID

SELECT DISTINCT E.BusinessEntityID ,
	   E.Gender,
	   E.MaritalStatus,
	   P.FirstName,
	   D.Name AS 'Department',
	   PH.Rate * 9 * 22 AS 'Salary'
	   FROM AdventureWorks2014.HumanResources.Employee E
	   INNER JOIN AdventureWorks2014.HumanResources.EmployeeDepartmentHistory DH
       ON E.BusinessEntityID = DH.BusinessEntityID
       INNER JOIN AdventureWorks2014.HumanResources.Department D 
       ON D.DepartmentID = DH.DepartmentID
       INNER JOIN AdventureWorks2014.HumanResources.EmployeePayHistory PH 
       ON E.BusinessEntityID = PH.BusinessEntityID
       INNER JOIN AdventureWorks2014.Person.Person P 
       ON P.BusinessEntityID = E.BusinessEntityID
       WHERE DH.EndDate IS NULL		
       AND PH.Rate = (
						SELECT TOP(1) EPH1.Rate 
						FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
						WHERE EPH1.BusinessEntityID = E.BusinessEntityID 
						ORDER BY EPH1.RateChangeDate DESC
					 )
		ORDER BY E.BusinessEntityID ASC



-- LEFT OUTER JOIN 
SELECT C.* FROM dbo.Table_Color C
SELECT F.* FROM dbo.Table_Fruits F

SELECT C.* , F.* FROM dbo.Table_Color C
LEFT OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit


SELECT C.* , F.* FROM dbo.Table_Color C
LEFT OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit
WHERE F.Fruit IS NULL


-- RIGHT OUTER JOIN 

SELECT C.* , F.* FROM dbo.Table_Color C
RIGHT OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit


SELECT C.* , F.* FROM dbo.Table_Color C
RIGHT OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit
WHERE C.Color IS NULL


-- FULL OUTER JOIN 
SELECT C.* , F.* FROM dbo.Table_Color C
FULL OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit




SELECT C.* , F.* FROM dbo.Table_Color C
FULL OUTER JOIN dbo.Table_Fruits F
ON C.Color = F.Fruit
WHERE C.Color IS NULL OR F.Fruit IS NULL



-- CROSS JOIN
SELECT C.*,F.Fruit FROM dbo.Table_Color C
CROSS JOIN dbo.Table_Fruits F


SELECT C1.* , C2.*  FROM dbo.MA_Country C1 
CROSS JOIN dbo.Table_Color C2


-- SELF JOIN
SELECT * FROM AdventureWorks2014.HumanResources.Employee E ,
	      AdventureWorks2014.HumanResources.Employee M
	      WHERE E.BusinessEntityID = M.BusinessEntityID

-- ONLY MANAGERS 
SELECT * FROM AdventureWorks2014.HumanResources.Employee 
WHERE BusinessEntityID IN (
		    		SELECT DISTINCT E.OrganizationLevel 
				FROM AdventureWorks2014.HumanResources.Employee E
			  )

SELECT * FROM AdventureWorks2014.HumanResources.Employee
	      WHERE JobTitle LIKE '%Manager%' 


-- ONLY EMPLOYEES WHO ARE NOT MANAGERS


SELECT * FROM AdventureWorks2014.HumanResources.Employee
WHERE JobTitle NOT LIKE '%Manager%' 

SELECT DISTINCT E.BusinessEntityID ,
	   E.OrganizationLevel,
	   P.FirstName AS 'MGR_NAME'  INTO #Managers
	   FROM HumanResources.Employee E 
	   
	   INNER JOIN HumanResources.Employee M
	   ON E.BusinessEntityID = M.OrganizationLevel
	   
	   JOIN Person.Person P 
	   ON P.BusinessEntityID = E.BusinessEntityID
	   ORDER BY E.BusinessEntityID ASC


select * from #Managers

SELECT DISTINCT E.BusinessEntityID ,
	   E.OrganizationLevel,
	   P.FirstName AS 'EMP_NAME' INTO #Employee
	   
	   FROM HumanResources.Employee E 
	   JOIN Person.Person P 
	   ON P.BusinessEntityID = E.BusinessEntityID
	   WHERE E.BusinessEntityID NOT IN (
						SELECT DISTINCT E.OrganizationLevel FROM HumanResources.Employee 
			                   )
	   ORDER BY E.BusinessEntityID ASC

SELECT * FROM #Employee


SELECT E.BusinessEntityID , 
	   E.EMP_NAME , 
	   M.MGR_NAME 
	   FROM #Employee E
	   JOIN #Managers M
	   ON E.OrganizationLevel = M.BusinessEntityID
       ORDER BY E.BusinessEntityID ASC

-- USING TVP


;WITH MGR AS
(
		SELECT DISTINCT E.BusinessEntityID ,
			        E.OrganizationLevel,
			        P.FirstName AS 'MGR_NAME'  
		                FROM HumanResources.Employee E 
		                INNER JOIN HumanResources.Employee M
				ON E.BusinessEntityID = M.OrganizationLevel
				JOIN Person.Person P 
				ON P.BusinessEntityID = E.BusinessEntityID
),
EMP AS 
(
		SELECT DISTINCT E.BusinessEntityID ,
				E.OrganizationLevel,
				P.FirstName AS 'EMP_NAME' 
				FROM HumanResources.Employee E 
				JOIN Person.Person P 
				ON P.BusinessEntityID = E.BusinessEntityID
				WHERE E.BusinessEntityID NOT IN (
									SELECT DISTINCT E.OrganizationLevel FROM HumanResources.Employee 
					        		 )
)
SELECT EMP.BusinessEntityID , 
	   EMP.EMP_NAME , 
	   MGR.MGR_NAME
	   FROM MGR 
	   JOIN EMP 
	   ON EMP.OrganizationLevel = MGR.BusinessEntityID 
           ORDER BY EMP.BusinessEntityID ASC

SELECT E.BusinessEntityID AS 'EMP_ID',
       PE.FirstName AS 'EMP_NAME',
       PM.FirstName AS 'MGR_NAME'
       FROM HumanResources.Employee E 
       JOIN HumanResources.Employee M 
       ON E.OrganizationLevel = M.BusinessEntityID
       JOIN Person.Person PE
       ON E.BusinessEntityID = PE.BusinessEntityID 
       JOIN Person.Person PM 
       ON M.BusinessEntityID = PM.BusinessEntityID
       ORDER BY E.BusinessEntityID ASC



SELECT E.BusinessEntityID AS 'EMP_ID',
	   PE.FirstName AS 'EMP_NAME',
	   PM.FirstName AS 'MGR_NAME'
	   --D.Name AS 'DEPT'
	   FROM HumanResources.Employee E 
	   JOIN HumanResources.Employee M 
	   ON E.OrganizationLevel = M.BusinessEntityID
	   JOIN Person.Person PE
           ON E.BusinessEntityID = PE.BusinessEntityID 
	   JOIN Person.Person PM 
	   ON M.BusinessEntityID = PM.BusinessEntityID
--JOIN HumanResources.EmployeeDepartmentHistory DH 
--ON DH.BusinessEntityID = M.OrganizationLevel
--JOIN HumanResources.Department D
--ON D.DepartmentID = DH.DepartmentID
ORDER BY E.BusinessEntityID ASC


--Sub Query & Set Operation 
-- ANY , ALL, SOME  


SELECT * FROM HumanResources.Employee E
WHERE E.BirthDate = (
			SELECT BirthDate 
			FROM HumanResources.Employee 
			WHERE BusinessEntityID =1
	           )

SELECT * FROM HumanResources.Employee E
WHERE E.BirthDate = (
		  	    SELECT BirthDate 
			    FROM HumanResources.Employee 
			    WHERE BusinessEntityID =1
		   )

SELECT * FROM HumanResources.Employee E
WHERE EXISTS(
			    SELECT * FROM HumanResources.Employee 
			    WHERE BusinessEntityID =1
	    )


SELECT * FROM HumanResources.Employee E
WHERE NOT EXISTS(
			  SELECT * FROM HumanResources.Employee 
			  WHERE BusinessEntityID =0
		)

SELECT * FROM  SampleDB.dbo.Table_Color
UNION
SELECT * FROM  SampleDB.dbo.Table_Fruits

SELECT * FROM  SampleDB.dbo.Table_Color
INTERSECT
SELECT * FROM  SampleDB.dbo.Table_Fruits


SELECT * FROM  SampleDB.dbo.Table_Color
EXCEPT
SELECT * FROM  SampleDB.dbo.Table_Fruits



-- xml , rowset function 

--:::=============== DCL =================:::--
CREATE DATABASE CRMS_DB_Dev
GO

USE CRMS_DB_Dev
GO

CREATE SCHEMA crms
GO

CREATE TABLE [crms].[Ma_Country]  
(
	CountryID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	IsActive BIT  CONSTRAINT DF_Ma_Country_IsActive DEFAULT 1,
	[RowGUID] VARCHAR(50) CONSTRAINT DF_Ma_Country_RowGUID DEFAULT NEWID(),
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_Country_CountryID PRIMARY KEY(CountryID,Name),
	CONSTRAINT UQ_Ma_Country_Name UNIQUE(Name)
)
GO

EXEC sp_help [crms.Ma_Country]  
INSERT INTO [crms].[Ma_Country](Name) VALUES('India') 
SELECT * FROM [crms].[Ma_Country] 



CREATE TABLE [crms].[Ma_State]  
(
	StateID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CountryID INT NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_State_IsActive DEFAULT 1,
	[RowGUID] VARCHAR(50) CONSTRAINT DF_Ma_State_RowGUID DEFAULT NEWID(),
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_State_StateID PRIMARY KEY(StateID),
	CONSTRAINT FK_Ma_State_CountryID_Ma_Country_CountryID FOREIGN KEY(CountryID) 
														  REFERENCES [crms].[Ma_Country](CountryID),
	CONSTRAINT UQ_Ma_State_Name UNIQUE(Name)
)
GO

EXEC sp_help [crms.Ma_State]  
INSERT INTO [crms].[Ma_State](Name , CountryID) VALUES('Karnataka',1) 
INSERT INTO [crms].[Ma_State](Name , CountryID) VALUES('Test1',0) 
SELECT * FROM [crms].[Ma_State] 

CREATE TABLE [crms].[Ma_City]  
(
	CityID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	StateID INT NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_City_IsActive DEFAULT 1,
	RowGUID UNIQUEIDENTIFIER CONSTRAINT DF_Ma_City_RowGIUD DEFAULT NEWID() ROWGUIDCOL,
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_City_CityID PRIMARY KEY(CityID),
	CONSTRAINT FK_Ma_City_StateID_Ma_State_StateID FOREIGN KEY(StateID) 
														  REFERENCES [crms].[Ma_State](StateID),
	CONSTRAINT UQ_Ma_City_Name UNIQUE(Name)
)
GO


EXEC sp_help [crms.Ma_City]  

SELECT * FROM [crms].[Ma_City] 

CREATE TABLE [crms].[Ma_Vehicles]  
(
	VehiclesID INT,
	VehiclesType VARCHAR(50) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	FuelType VARCHAR(50) NOT NULL,  
	TransmissionType VARCHAR(50) NOT NULL,  
	SeatingCapacity TINYINT NOT NULL,
	PermitType VARCHAR(50) NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_Vehicles_IsActive DEFAULT 1,
	RowGUID UNIQUEIDENTIFIER CONSTRAINT DF_Ma_Vehicles_RowGIUD DEFAULT NEWID() ROWGUIDCOL,
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_Vehicles_VehiclesID PRIMARY KEY(VehiclesID),
	CONSTRAINT CK_Ma_Vehicles_VehiclesType CHECK(VehiclesType IN('Scooter','Car')),
	CONSTRAINT CK_Ma_Vehicles_FuelType CHECK(FuelType IN('Petrol','Diesel','Electric')),
	CONSTRAINT CK_Ma_Vehicles_TransmissionType CHECK(TransmissionType IN('Manuel','Automatics')),
	CONSTRAINT CK_Ma_Vehicles_PermitType CHECK(PermitType IN('State','National')),
	CONSTRAINT CK_Ma_Vehicles_SeatingCapacity CHECK(SeatingCapacity IN(2,5,7)),
	)
GO

insert into crms.Ma_Vehicles(VehiclesID,VehiclesType,Name,FuelType,TransmissionType,SeatingCapacity,PermitType)
values(1,'Car','Datsun','Petrol','Manuel',5,'National')

insert into crms.Ma_Vehicles(VehiclesID,VehiclesType,Name,FuelType,TransmissionType,SeatingCapacity,PermitType)
values(2,'Car','BMW','Diesel','Automatics',7,'National'),
	  (3,'Car','BMW','Diesel','Automatics',7,'National'),
	  (4,'Car','BMW','Diesel','Automatics',7,'National')

select * from crms.Ma_Vehicles

-- 1. DML 

-- Select from T1 insert into T2


USE AdventureWorks2014
GO

SELECT * FROM HumanResources.Department 
SELECT * FROM HumanResources.Department_1

SELECT * FROM HumanResources.Department 
WHERE DepartmentID > 62


SELECT D.*  INTO #TEMP2 FROM HumanResources.Department D
WHERE D.DepartmentID > 62

SELECT * FROM #TEMP2

SELECT D.*  INTO Department_2  FROM HumanResources.Department D
WHERE D.DepartmentID > 62

SELECT * FROM [dbo].[Department_2]

SELECT * FROM [HumanResources].[Department_1]

INSERT INTO dbo.Department_3( Name, GroupName, ModifiedDate)
SELECT S.Name , S.GroupName , S.ModifiedDate
FROM HumanResources.Department S
WHERE S.DepartmentID > 62



SELECT E.BusinessEntityID ,
	   E.Gender ,
	   E.MaritalStatus ,
	   E.BirthDate,
	   D.Name AS 'Dept',
	   E.HireDate,
	   P.Rate * 9 * 21 AS 'Salary',
	   PP.FirstName
--INTO #EMP
--INTO EMP_1
INTO Employee_1
FROM HumanResources.Department D
JOIN HumanResources.EmployeeDepartmentHistory H
ON D.DepartmentID = H.DepartmentID
JOIN HumanResources.Employee E
ON H.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory P
ON E.BusinessEntityID = P.BusinessEntityID
JOIN Person.Person PP
ON E.BusinessEntityID = PP.BusinessEntityID
--WHERE 1=2

SELECT * FROM #EMP

SELECT * FROM EMP_1

SELECT * FROM Employee_1


INSERT INTO Employee_1 (BusinessEntityID ,Gender,MaritalStatus,BirthDate,Dept,HireDate,Salary,FirstName)
SELECT E.BusinessEntityID ,
	   E.Gender ,
	   E.MaritalStatus ,
	   E.BirthDate,
	   D.Name AS 'Dept',
	   E.HireDate,
	   P.Rate * 9 * 21 AS 'Salary',
	   PP.FirstName
FROM HumanResources.Department D
JOIN HumanResources.EmployeeDepartmentHistory H
ON D.DepartmentID = H.DepartmentID
JOIN HumanResources.Employee E
ON H.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory P
ON E.BusinessEntityID = P.BusinessEntityID
JOIN Person.Person PP
ON E.BusinessEntityID = PP.BusinessEntityID

-- Update , Delete , Truncate 

select * from dbo.Department_2
select * from dbo.Department_3

select * into Department_2 from dbo.Department_3

UPDATE dbo.Department_2 
SET Name = 'pqr'
WHERE DepartmentID = 64


UPDATE dbo.Department_2
SET Name = 'Raj', GroupName ='Raj'
WHERE DepartmentID = 66


UPDATE 
    D3
SET 
    D3.Name = D2.Name,
	D3.GroupName = D2.GroupName
FROM  
	dbo.Department_3 D3
	JOIN dbo.Department_2 D2
    ON D2.DepartmentID = D3.DepartmentID

select * from dbo.Department_2
select * from dbo.Department_3

-- TRUCNCATE

DELETE FROM dbo.Department_3
WHERE DepartmentID = 76


-- delete all rec but not droop table
DELETE FROM dbo.Department_3

-- delete all rec and reset identity to default
truncate table dbo.Department_2

select * from dbo.Department_2

select * from dbo.Department_3

-- delete with join 

DELETE D2
       FROM dbo.Department_2 D2
	   JOIN dbo.Department_3  D3
	   ON D2.DepartmentID = D3.DepartmentID


--3. OPENROWSET

INSERT INTO Production.ProductPhoto (ThumbNailPhoto,ThumbnailPhotoFileName,LargePhoto,LargePhotoFileName)
SELECT *  , 'P1.jpg',* , 'P1.jpg' FROM OPENROWSET(BULK 'C:\Users\Qipl143\Pictures\Flowers\P1.jpg', SINGLE_BLOB) AS Document;


SELECT * FROM OPENROWSET(BULK 'C:\Users\Qipl143\Pictures\Flowers\P1.jpg', SINGLE_BLOB) AS Document
 

INSERT INTO Production.ProductPhoto (ThumbNailPhoto,ThumbnailPhotoFileName,LargePhoto,LargePhotoFileName)
SELECT *  , 'test.docx',* , 'test.docx' FROM OPENROWSET(BULK 'C:\Users\Qipl143\Downloads\coding_test.docx', SINGLE_BLOB) AS Document;
 

--4. XML / JSON

SELECT * FROM HumanResources.Department
FOR XML AUTO

SELECT * FROM HumanResources.Department
FOR XML AUTO,ELEMENTS,ROOT

SELECT * FROM HumanResources.Department
FOR XML RAW('row'), ELEMENTS,ROOT 

--OPENXML 
DECLARE @XML_DOC VARCHAR(MAX);
DECLARE @Doc_Pointer INT;
SET @XML_DOC ='<root>
		     <row>
			  <DepartmentID>17</DepartmentID>
			  <Name>FSP</Name>
			  <GroupName>SD</GroupName>
			  <ModifiedDate>2020-02-17</ModifiedDate>
	   	    </row>
		    <row>
			   <DepartmentID>18</DepartmentID>
			   <Name>SD</Name>
			   <GroupName>SD</GroupName>
			   <ModifiedDate>2020-02-17</ModifiedDate>
		    </row>
		    <row>
			  <DepartmentID>19</DepartmentID>
			  <Name>QA</Name>
			  <GroupName>Testing</GroupName>
			  <ModifiedDate>2020-02-17</ModifiedDate>
		   </row>
		   <row>
			 <DepartmentID>20</DepartmentID>
			 <Name>QC</Name>
			 <GroupName>Testing</GroupName>
			 <ModifiedDate>2020-02-17</ModifiedDate>
		  </row>
		  <row>
			<DepartmentID>21</DepartmentID>
			<Name>CS</Name>
			<GroupName>CS</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		 </row>
	</root>' 
EXEC sp_xml_preparedocument  @Doc_Pointer OUTPUT , @XML_DOC
SELECT * FROM OPENXML(@Doc_Pointer,'/root/row',2) 
WITH (DepartmentID INT , Name VARCHAR(50) , GroupName VARCHAR(50), ModifiedDate DATE)
EXEC sp_xml_removedocument  @Doc_Pointer 
GO


-- select and insert
DECLARE @XML_DOC VARCHAR(MAX);
DECLARE @Doc_Pointer INT;
SET @XML_DOC ='<root>
		  <row>
			<DepartmentID>17</DepartmentID>
			<Name>FSP</Name>
			<GroupName>SD</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		  </row>
                  <row>
 			<DepartmentID>18</DepartmentID>
			<Name>SD</Name>
			<GroupName>SD</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>19</DepartmentID>
		   	<Name>QA</Name>
			<GroupName>Testing</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>20</DepartmentID>
			<Name>QC</Name>
			<GroupName>Testing</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>21</DepartmentID>
			<Name>CS</Name>
			<GroupName>CS</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
	     </root>' 
EXEC sp_xml_preparedocument  @Doc_Pointer OUTPUT , @XML_DOC
INSERT INTO HumanResources.Department(Name,GroupName,ModifiedDate)
SELECT Name,GroupName,ModifiedDate FROM OPENXML(@Doc_Pointer,'/root/row',2) 
WITH (Name VARCHAR(50) , GroupName VARCHAR(50), ModifiedDate DATE)
EXEC sp_xml_removedocument  @Doc_Pointer 
GO

select * from HumanResources.Department


-- ALTER
--1. Existing Table without records 

-- ADD A COLUMN

ALTER TABLE MA_Country_bkp 
ADD Remarks VARCHAR(100)


ALTER TABLE MA_Country_bkp 
ADD Remarks1 VARCHAR(100) ,Remarks2 VARCHAR(100)
 
-- DROP A COLUMN

ALTER TABLE MA_Country_bkp 
DROP COLUMN XYZ


ALTER TABLE MA_Country_bkp 
DROP COLUMN Remarks1 ,Remarks2

-- ADD A COLUMN CONSTRIANT
ALTER TABLE MA_Country_bkp 
ADD CONSTRAINT PK_MA_Country_bkp_CountryIC PRIMARY KEY(CountryIC),
GO



ALTER TABLE MA_Country_bkp 
ADD CONSTRAINT PK_MA_Country_bkp_CountryIC PRIMARY KEY(CountryIC),
	CONSTRAINT UQ_MA_Country_bkp_Name UNIQUE(Name)
GO
 
-- drop A COLUMN CONSTRIANT
ALTER TABLE MA_Country_bkp 
DROP CONSTRAINT PK_MA_Country_bkp_CountryIC



ALTER TABLE MA_Country_bkp 
DROP CONSTRAINT PK_MA_Country_bkp_CountryIC, 
				UQ_MA_Country_bkp_Name 


-- ALTER A COLUMN CHNAGE SIZE
ALTER TABLE MA_Country_bkp 
ALTER COLUMN Remarks VARCHAR(50)


-- ALTER A COLUMN CHNAGE DATA TYPE
ALTER TABLE MA_Country_bkp 
ALTER COLUMN ModifiedDate DATE NOT NULL


--2. Existing Table with records
ALTER TABLE MA_Country WITH CHECK
ADD CONSTRAINT UQ_MA_Country_Name UNIQUE(Name)
GO

