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
