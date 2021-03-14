SELECT * FROM HumanResources.Employee

SELECT TOP(10) E.BusinessEntityID , E.BirthDate , E.JobTitle FROM HumanResources.Employee E

SELECT TOP(1) PERCENT E.*  FROM HumanResources.Employee E
