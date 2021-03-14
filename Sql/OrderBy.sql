
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
