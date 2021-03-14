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
