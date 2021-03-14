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
