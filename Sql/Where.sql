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
