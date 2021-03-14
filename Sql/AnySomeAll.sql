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
