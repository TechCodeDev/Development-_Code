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
