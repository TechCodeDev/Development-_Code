--------------------------------------------------------------------------------------------------------
--1.	List the Employee details whose salary is greater than the lowest salary of an Employee  
--      belonging to Department=1 


	--SELECT * FROM HumanResources.Employee
	--SELECT * FROM HumanResources.EmployeeDepartmentHistory
	--WHERE DepartmentID=1
	--SELECT * FROM HumanResources.EmployeePayHistory
	--SELECT * FROM HumanResources.Department
------------------------------------------------------------------------------------------------------------------------------------------------
	SELECT HRE.BusinessEntityID,
		   HRE.NationalIDNumber,
		   HRE.LoginID, 
		   HRE.OrganizationNode,
		   HREP.RateChangeDate,
		   HRE.JobTitle,
		   HRE.BirthDate,
		   HREP.Rate*9*20
	FROM HumanResources.EmployeePayHistory HREP
	INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID=HREP.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	WHERE HREDH.DepartmentID=1 
	AND RATE*9*20>(SELECT MIN(Rate*9*20) 
					FROM HumanResources.EmployeePayHistory HREP )AND HREP.RATE=(
																					SELECT TOP(1) EPH1.Rate
																					FROM HumanResources.EmployeePayHistory EPH1 
																					WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID 
																					ORDER BY EPH1.RateChangeDate DESC
																				)

	
-------------------------------------------------------------------------------------------------------------------------------------------------

--2. list the employee details if and only if more than 10 employees are there in that department
	

	SELECT HRE.BusinessEntityID ,
		   HRE.NationalIDNumber ,
		   HRE.LoginID,
		   HRE.OrganizationLevel,
		   HRE.JobTitle,
		   HRE.BirthDate,
		   HRE.MaritalStatus,
		   HRE.Gender
		   FROM HumanResources.Employee HRE
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
	ON HRE.BusinessEntityID=HREDH1.BusinessEntityID
	WHERE HREDH1.DepartmentID IN (
									SELECT HREDH.DepartmentID 
									FROM HumanResources.EmployeeDepartmentHistory HREDH
									GROUP BY HREDH.DepartmentID
									HAVING COUNT(HREDH.DepartmentID)>10
								 )
								 ORDER BY HRE.BusinessEntityID
								
								--CROSS CHECK QUERY
								--SELECT HREDH.[DepartmentID],COUNT(HREDH.DepartmentID)
								--FROM HumanResources.EmployeeDepartmentHistory HREDH
								--GROUP BY HREDH.DepartmentID
								--HAVING COUNT(HREDH.DepartmentID)>10

-------------------------------------------------------------------------------------------------------------------------------
--3.	list out all the jobs/designation unique to departments
	
--CROSS CHECK QUERYS
--SELECT * FROM HumanResources.EmployeeDepartmentHistory
--SELECT * FROM HumanResources.Employee
--SELECT * FROM HumanResources.Department

	SELECT DISTINCT HRD.DepartmentID,
					HRD.Name, 
					HRE.JobTitle 
					FROM HumanResources.Employee HRE
					INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
					ON HREDH.BusinessEntityID=HRE.BusinessEntityID
					INNER JOIN HumanResources.Department HRD
					ON HRD.DepartmentID=HREDH.DepartmentID

------------------------------------------------------------------------------------------------------------------------------
-- 4.	list the jobs common to Department 10 and 15

	SELECT DISTINCT HRD.DepartmentID,
					HRD.Name, 
		            HRE.JobTitle 
					FROM HumanResources.Employee HRE
					INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
					ON HREDH.BusinessEntityID=HRE.BusinessEntityID
					INNER JOIN HumanResources.Department HRD
					ON HRD.DepartmentID=HREDH.DepartmentID 
					WHERE  HRD.DepartmentID=10
	INTERSECT 
	SELECT DISTINCT HRD.DepartmentID,
					HRD.Name, 
		            HRE.JobTitle 
					FROM HumanResources.Employee HRE
					INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
					ON HREDH.BusinessEntityID=HRE.BusinessEntityID
					INNER JOIN HumanResources.Department HRD
					ON HRD.DepartmentID=HREDH.DepartmentID 
					WHERE  HRD.DepartmentID=15



-------------------------------------------------------------------------------------------------------------------------------
-- 5.	list the employees whose salary is greater than or equal to average salary of Department=10
	
	--
	--SELECT RATE*9*22 FROM HumanResources.EmployeePayHistory
	--WHERE Rate*9*22>5895.2946
	--SELECT * FROM HumanResources.Department
	--SELECT * FROM HumanResources.EmployeeDepartmentHistory
	--SELECT * FROM HumanResources.Employee

	SELECT * FROM HumanResources.EmployeePayHistory HREPH
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	WHERE  HREPH.Rate*9*22>(
								SELECT AVG(HREPH1.Rate*9*22) FROM HumanResources.EmployeePayHistory HREPH1 
								INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
								ON HREPH1.BusinessEntityID=HREDH1.BusinessEntityID
								INNER JOIN HumanResources.Department HRD1
								ON HRD1.DepartmentID=HREDH1.DepartmentID
								WHERE HRD1.DepartmentID=10
							) 
-------------------------------------------------------------------------------------------------------------
--6 . list 5 employees in lowest order of salary

	SELECT TOP(5)  HRE.* , 
		   Rate*22*9 
		   FROM HumanResources.EmployeePayHistory HREPH
		   INNER JOIN HumanResources.Employee HRE
	       ON HRE.BusinessEntityID=HREPH.BusinessEntityID
	       ORDER BY Rate*22*9 ASC

--------------------------------------------------------------------------------------------------------------
-- 7 .	list last five records from Employee table
	
	SELECT TOP(5) HRE.* 
		   FROM HumanResources.Employee HRE
		   ORDER BY HRE.BusinessEntityID DESC

--------------------------------------------------------------------------------------------------------------
-- 8.	Display the year and no of employees for the year in which more than one employee was hired
		
		SELECT COUNT(YEAR(HireDate)) AS 'NUMBER OF EMPLOYEE', 
			   YEAR(HIREDATE) AS 'YEAR' 
			   FROM HumanResources.Employee
			   GROUP BY YEAR(HireDate)
		
--------------------------------------------------------------------------------------------------------------
--   9.	Write query department wise maximum , minimum, average salary 
	
		SELECT HRD.DepartmentID,
			   HRD.Name,
			   MAX(HREPH.Rate*9*22) AS 'MaximumSalary',
			   MIN(HREPH.Rate*9*22) AS 'MinimumSalary ',
			   AVG(HREPH.Rate*9*22) AS 'AverageSalary ' 
			   FROM HumanResources.EmployeePayHistory HREPH
			   INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			   ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
			   INNER JOIN HumanResources.Department HRD
			   ON HRD.DepartmentID=HREDH.DepartmentID
			   GROUP BY HRD.DepartmentID,HRD.Name
			   ORDER BY HRD.DepartmentID

----------------------------------------------------------------------------------------------------------------
-- 10.	list the department that has no employees
		
		SELECT HRD.DepartmentID,
			   COUNT(HREDH.DepartmentID) AS 'NUMBER OF EMPLOYEE' 
			   FROM HumanResources.Employee HRE
			   RIGHT OUTER JOIN HumanResources.EmployeeDepartmentHistory HREDH
		       ON HRE.BusinessEntityID=HREDH.BusinessEntityID
		       RIGHT JOIN HumanResources.Department HRD
		       ON HRD.DepartmentID=HREDH.DepartmentID
			   GROUP BY HRD.DepartmentID
		       HAVING COUNT(HREDH.DepartmentID)=0

----------------------------------------------------------------------------------------------------------------
-- 11.   list Employee details whose salary is same as that of  Amy or Ashvini

		SELECT * FROM HumanResources.EmployeePayHistory HREPH
		INNER JOIN  Person.Person PP
		ON PP.[BusinessEntityID]=HREPH.BusinessEntityID
		WHERE (HREPH.Rate*9*22)=(
									SELECT HREPH1.Rate*9*22 FROM Person.Person PP1
									INNER JOIN HumanResources.EmployeePayHistory HREPH1
									ON PP1.BusinessEntityID=HREPH1.BusinessEntityID
									WHERE PP1.FirstName='Amy' 
								)
		OR
		(HREPH.Rate*9*22)=(
									SELECT HREPH2.Rate*9*22 FROM Person.Person PP2
									INNER JOIN HumanResources.EmployeePayHistory HREPH2
									ON PP2.BusinessEntityID=HREPH2.BusinessEntityID
									WHERE PP2.FirstName='Ashvini' 
								)



							--	OR


		SELECT * FROM HumanResources.EmployeePayHistory HREPH
		INNER JOIN  Person.Person PP
		ON PP.[BusinessEntityID]=HREPH.BusinessEntityID
		WHERE (HREPH.Rate*9*22) IN (
									SELECT HREPH1.Rate*9*22 FROM Person.Person PP1
									INNER JOIN HumanResources.EmployeePayHistory HREPH1
									ON PP1.BusinessEntityID=HREPH1.BusinessEntityID
									WHERE PP1.FirstName='Amy' OR  PP1.FirstName='Ashvini'
								)
		
----------------------------------------------------------------------------------------------------------------
-- 12.	list the employees in Department=10 with the same job as anyone in Sales, 
-- Finance Department
-- SELECT * FROM HumanResources.Employee

	SELECT * FROM HumanResources.EmployeeDepartmentHistory HREDH
	WHERE HREDH.DepartmentID=10

	--OR

		SELECT HRE.*
				FROM Person.BusinessEntity PBE
				INNER JOIN HumanResources.Employee HRE
				ON HRE.BusinessEntityID=PBE.BusinessEntityID
				INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
				ON HREDH.BusinessEntityID=HRE.BusinessEntityID
				INNER JOIN HumanResources.Department HRD
				ON HRD.DepartmentID=HREDH.DepartmentID
				WHERE HRD.DepartmentID=10 AND
						HRE.JobTitle = ANY (
									SELECT HRE1.JobTitle 
									FROM HumanResources.Employee HRE1
									INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
									ON HRE1.BusinessEntityID=HREDH1.BusinessEntityID
									INNER JOIN HumanResources.Department HRD1
									ON HRD1.DepartmentID=HREDH1.DepartmentID
									WHERE HRD1.Name ='Sales' OR
										HRD1.Name='Finance'
								)

-----------------------------------------------------------------------------------------------------------------
-- 13.display the information of employees who are also managers

		SELECT DISTINCT E.BusinessEntityID ,
						E.OrganizationLevel,
						P.FirstName AS 'MGR_NAME' ,
						E.* 
						FROM HumanResources.Employee E 
						INNER JOIN HumanResources.Employee M
						ON E.BusinessEntityID = M.OrganizationLevel
						JOIN Person.Person P 
						ON P.BusinessEntityID = E.BusinessEntityID
						ORDER BY E.BusinessEntityID ASC

------------------------------------------------------------------------------------------------------------------------------------
	--14.display  the information of employees who earn more than any employee in Department=10
			
			SELECT * FROM HumanResources.EmployeePayHistory HREPH
			INNER JOIN HumanResources.Employee HRE
			ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.Department HRD
			ON HRD.DepartmentID=HREDH.DepartmentID
			WHERE HREPH.Rate*9*22>ANY(
											SELECT HREPH.Rate*9*22 FROM HumanResources.EmployeePayHistory HREPH
											INNER JOIN HumanResources.Employee HRE
											ON HRE.BusinessEntityID=HREPH.BusinessEntityID
											INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
											ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
											INNER JOIN HumanResources.Department HRD
											ON HRD.DepartmentID=HREDH.DepartmentID
											WHERE HREDH.DepartmentID=10
	
								     )
-------------------------------------------------------------------------------------------------------------------------------------
	--15.list manager's names and employees names that belongs to their managers

			SELECT DISTINCT E.BusinessEntityID ,
						E.OrganizationLevel,
						P.FirstName AS 'MGR_NAME' ,
						E.* 
						FROM HumanResources.Employee E 
						INNER JOIN HumanResources.Employee M
						ON E.BusinessEntityID = M.OrganizationLevel
						JOIN Person.Person P 
						ON P.BusinessEntityID = E.BusinessEntityID
						ORDER BY E.BusinessEntityID ASC
			
			--SELECT * FROM HumanResources.Employee

-------------------------------------------------------------------------------------------------------------------
	
	--16. list the total salary of each department
		
		SELECT HRD.DepartmentID, 
			   SUM(HREPH.Rate*9*22) AS 'Total Salary' 
			   FROM HumanResources.EmployeePayHistory HREPH
			   INNER JOIN HumanResources.Employee HRE
			   ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			   INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			   ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
			   INNER JOIN HumanResources.Department HRD
			   ON HRD.DepartmentID=HREDH.DepartmentID
		       GROUP BY HRD.DepartmentID

--------------------------------------------------------------------------------------------------------------------
	
	--17.display entire employee details where salary > lowest salary of employees in Department=10

		
			SELECT * FROM HumanResources.EmployeePayHistory HREPH
			INNER JOIN HumanResources.Employee HRE
			ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.Department HRD
			ON HRD.DepartmentID=HREDH.DepartmentID
			WHERE HREPH.Rate*9*22>(
											SELECT MIN(HREPH1.Rate*9*22) FROM HumanResources.EmployeePayHistory HREPH1
											INNER JOIN HumanResources.Employee HRE1
											ON HRE1.BusinessEntityID=HREPH1.BusinessEntityID
											INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
											ON HREDH1.BusinessEntityID=HREPH1.BusinessEntityID
											INNER JOIN HumanResources.Department HRD1
											ON HRD1.DepartmentID=HREDH1.DepartmentID
											WHERE HREDH1.DepartmentID=10
	
								     )
									 AND 
									 HREPH.RATE*9*22=(SELECT TOP(1) EPH1.Rate*9*22 
														FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
														WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID ORDER BY EPH1.RateChangeDate DESC)

-----------------------------------------------------------------------------------------------------------------------------------------------------------

	--18.display details of all the employees whose salary is > average salary of employees in respective departments

	SELECT * FROM HumanResources.EmployeePayHistory HREPH
			INNER JOIN HumanResources.Employee HRE
			ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
			ON HREDH.BusinessEntityID=HREPH.BusinessEntityID
			INNER JOIN HumanResources.Department HRD
			ON HRD.DepartmentID=HREDH.DepartmentID
			WHERE HREPH.Rate*9*22>(
											SELECT AVG(HREPH1.Rate*9*22) FROM HumanResources.EmployeePayHistory HREPH1
											INNER JOIN HumanResources.Employee HRE1
											ON HRE1.BusinessEntityID=HREPH1.BusinessEntityID
											INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
											ON HREDH1.BusinessEntityID=HREPH1.BusinessEntityID
											INNER JOIN HumanResources.Department HRD1
											ON HRD1.DepartmentID=HREDH1.DepartmentID
											
								     )
									 AND 
									 HREPH.RATE*9*22=(SELECT TOP(1) EPH1.Rate*9*22 
														FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
														WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID ORDER BY EPH1.RateChangeDate DESC)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--19. list all the details of employees who have joined on the same date as that of Ruth Ann Ellerbrock

	SELECT *,PP.FirstName FROM  HumanResources.Employee HRE
	INNER JOIN Person.Person PP
	ON PP.BusinessEntityID=HRE.BusinessEntityID
	WHERE HRE.HireDate=(
							SELECT HRE1.HireDate FROM  HumanResources.Employee HRE1
							INNER JOIN Person.Person PP1
							ON PP1.BusinessEntityID=HRE1.BusinessEntityID
							WHERE (PP1.FirstName+PP1.MiddleName+PP1.LastName)='RuthAnnEllerbrock'

						)

	

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--20.list details of employees where salary is greater than "Ruth Ann Ellerbrock" and who are in sales department

	SELECT *,PP.FirstName FROM  HumanResources.Employee HRE
	INNER JOIN HumanResources.EmployeePayHistory HREPH
	ON HRE.BusinessEntityID=HREPH.BusinessEntityID
	INNER JOIN Person.Person PP
	ON PP.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	WHERE HREPH.Rate*9*22>(
								SELECT HREPH1.Rate*9*22 FROM  HumanResources.Employee HRE1
								INNER JOIN HumanResources.EmployeePayHistory HREPH1
								ON HRE1.BusinessEntityID=HREPH1.BusinessEntityID
								INNER JOIN Person.Person PP1
								ON PP1.BusinessEntityID=HRE1.BusinessEntityID
								WHERE (PP1.FirstName+''+PP1.MiddleName+''+PP1.LastName)='Ruth Ann Ellerbrock'
	
							)
							AND
							HRD.DepartmentID = (
										SELECT HRD1.DepartmentID FROM HumanResources.Department HRD1
										WHERE HRD1.Name='sales'	
									)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--21.	list out all the employees who are reporting to Manager Jo A Brown							
				
				SELECT HRE.*
				FROM HumanResources.Employee HRE
				INNER JOIN Person.Person PP
				ON PP.BusinessEntityID=HRE.BusinessEntityID
				WHERE HRE.OrganizationLevel =(
											SELECT HRE2.BusinessEntityID
											FROM HumanResources.Employee HRE2
											INNER JOIN Person.Person PP2
											ON PP2.BusinessEntityID=HRE2.BusinessEntityID
											WHERE CONCAT(PP2.FirstName,PP2.MiddleName,PP2.LastName) LIKE 'JoABrown'
											)
														
	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
		

	--22.   list the details of employees who are getting maximum salary 
			
			SELECT * FROM HumanResources.Employee HRE
			INNER JOIN HumanResources.EmployeePayHistory HREPH
			ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			WHERE HREPH.Rate*9*22 = (
											SELECT MAX(HREPH1.Rate*9*22) FROM HumanResources.EmployeePayHistory HREPH1
									  )

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
		
	--23. list out all the employees from Department to which " Michael I Sullivan "  belongs



	SELECT * FROM HumanResources.Department HRD
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HRD.DepartmentID=HREDH.DepartmentID
	INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID=HREDH.BusinessEntityID
	INNER JOIN Person.Person PP
	ON PP.BusinessEntityID=HRE.BusinessEntityID
	WHERE HRD.DepartmentID=(
								SELECT HRD1.DepartmentID FROM HumanResources.Department HRD1
								INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
								ON HRD1.DepartmentID=HREDH1.DepartmentID
								INNER JOIN HumanResources.Employee HRE1
								ON HRE1.BusinessEntityID=HREDH1.BusinessEntityID
								INNER JOIN Person.Person PP1
								ON PP1.BusinessEntityID=HRE1.BusinessEntityID
								WHERE (PP1.FirstName+' '+PP1.MiddleName+' '+PP1.LastName)='Michael I Sullivan'
							)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--24. list out the details of employees who’s designation is same as that of " Gail A  Erickson"
		
	SELECT * FROM HumanResources.Employee HRE
	INNER JOIN Person.Person PP
	ON PP.BusinessEntityID=HRE.BusinessEntityID
	WHERE HRE.JobTitle=(	
								SELECT HRE1.JobTitle FROM HumanResources.Employee HRE1
								INNER JOIN Person.Person PP1
								ON PP1.BusinessEntityID=HRE1.BusinessEntityID	
								WHERE (PP1.FirstName+PP1.MiddleName+PP1.LastName)='GailAErickson'
						)
	
	--CROSS CHECK QUERY
	SELECT COUNT(HREDH.DepartmentID),HREDH.DepartmentID FROM HumanResources.EmployeeDepartmentHistory HREDH
	GROUP BY HREDH.DepartmentID

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--25. find out the name of department which is not allocated to Gail A Erickson

	SELECT DISTINCT HRD.* FROM Person.Person PP
	INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID=PP.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	WHERE HRD.DepartmentID NOT IN(	
								SELECT HRD.DepartmentID FROM Person.Person PP
								INNER JOIN HumanResources.Employee HRE
								ON HRE.BusinessEntityID=PP.BusinessEntityID
								INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
								ON HREDH.BusinessEntityID=HRE.BusinessEntityID
								INNER JOIN HumanResources.Department HRD
								ON HRD.DepartmentID=HREDH.DepartmentID
								WHERE (PP.FirstName+PP.MiddleName+PP.LastName)='GailAErickson'
							) 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--26.find out the second lowest salary of Department=10
	
	SELECT TOP(1) HREPH.Rate*9*22 AS 'Second Lowest Salary', * FROM Person.Person PP
	INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID=PP.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	INNER JOIN HumanResources.EmployeePayHistory HREPH
	ON HREPH.BusinessEntityID=HRE.BusinessEntityID
	WHERE HRD.DepartmentID=10
	AND HREPH.RATE*9*22=(SELECT TOP(1) EPH1.Rate*9*22 FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
											WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID ORDER BY EPH1.RateChangeDate DESC)
	AND HREPH.RATE*9*22 NOT IN (
							SELECT  MIN(HREPH.Rate*9*22) FROM Person.Person PP
							INNER JOIN HumanResources.Employee HRE
							ON HRE.BusinessEntityID=PP.BusinessEntityID
							INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
							ON HREDH.BusinessEntityID=HRE.BusinessEntityID
							INNER JOIN HumanResources.Department HRD
							ON HRD.DepartmentID=HREDH.DepartmentID
							INNER JOIN HumanResources.EmployeePayHistory HREPH
							ON HREPH.BusinessEntityID=HRE.BusinessEntityID
							WHERE HRD.DepartmentID=10
						)				
	ORDER BY HREPH.Rate ASC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--27.	find out the second highest salary of Department=10
	
	
	SELECT TOP(1) HREPH.Rate*9*22 AS 'Second highest salary', * FROM Person.Person PP
	INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID=PP.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID=HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID=HREDH.DepartmentID
	INNER JOIN HumanResources.EmployeePayHistory HREPH
	ON HREPH.BusinessEntityID=HRE.BusinessEntityID
	WHERE HRD.DepartmentID=10
	AND HREPH.RATE*9*22=(SELECT TOP(1) EPH1.Rate*9*22 FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
											WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID ORDER BY EPH1.RateChangeDate DESC)
	AND HREPH.RATE*9*22 NOT IN (
							SELECT  MAX(HREPH.Rate*9*22) FROM Person.Person PP
							INNER JOIN HumanResources.Employee HRE
							ON HRE.BusinessEntityID=PP.BusinessEntityID
							INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
							ON HREDH.BusinessEntityID=HRE.BusinessEntityID
							INNER JOIN HumanResources.Department HRD
							ON HRD.DepartmentID=HREDH.DepartmentID
							INNER JOIN HumanResources.EmployeePayHistory HREPH
							ON HREPH.BusinessEntityID=HRE.BusinessEntityID
							WHERE HRD.DepartmentID=10
						)				
	ORDER BY HREPH.Rate DESC
------------------------------------------------------------------------------------------------------------------------------------------------
	--28. list Employee Name , Department No, Avg Salary of their respective department

		

	SELECT HRD.DepartmentID as 'DEPARTMENT',P.FirstName as 'NAME' INTO #bb11
	FROM Person.Person P
	INNER JOIN HumanResources.Employee HRE
	ON P.BusinessEntityID = HRE.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
	ON HREDH.BusinessEntityID= HRE.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID  = HREDH.DepartmentID
	INNER JOIN HumanResources.EmployeePayHistory ph
	ON HRE.BusinessEntityID = ph.BusinessEntityID
	GROUP BY HRD.DepartmentID, P.FirstName

	SELECT AVG(HREPH1.rate*9*22) as 'RATE',HRD.DepartmentID as 'DEPARTMENT' INTO #bc11
	FROM HumanResources.EmployeePayHistory HREPH1
	INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
	ON HREDH1.BusinessEntityID = HREPH1.BusinessEntityID
	INNER JOIN HumanResources.Department HRD
	ON HRD.DepartmentID = HREDH1.DepartmentID
	GROUP BY HRD.DepartmentID

	SELECT * FROM #bb11 b
	INNER JOIN #bc11 c
	ON c.DEPARTMENT = b.DEPARTMENT




---------------------------------------------------------------------------------------------------------------------------------------------
--29. Find out employees who earn highest salary in each job / designation  type sort by descending salary
	
	SELECT HRE.JobTitle,
		   MAX(HREPH.Rate*9*22) AS 'SALARY' 
		   FROM HumanResources.Employee HRE
		   INNER JOIN HumanResources.EmployeePayHistory HREPH
	       ON HREPH.BusinessEntityID=HRE.BusinessEntityID
		   INNER JOIN Person.Person PP
		   ON PP.BusinessEntityID=HRE.BusinessEntityID 
		   GROUP BY HRE.JobTitle
		   ORDER BY MAX( HREPH.Rate*9*22) DESC

-----------------------------------------------------------------------------------------------------------------------------------------------
--30. display the employee names who are the managers     		  
		
		SELECT DISTINCT HRE.BusinessEntityID ,
						HRE.OrganizationLevel,
						PP.FirstName AS 'MGR_NAME' ,
						HRE.* 
						FROM HumanResources.Employee HRE 
						INNER JOIN HumanResources.Employee HRE1
						ON HRE.BusinessEntityID = HRE1.OrganizationLevel
						JOIN Person.Person PP 
						ON PP.BusinessEntityID = HRE.BusinessEntityID
						ORDER BY HRE.BusinessEntityID ASC
-------------------------------------------------------------------------------------------------------------------------------------------------------
--31.	Display Manager and number of employees working under him
		
		SELECT COUNT(HRE.BusinessEntityID ) AS 'NUMBER OF EMPLOYEE ',
					HRE.OrganizationLevel ,
					PP.FirstName AS 'MGR_NAME' 
					FROM HumanResources.Employee HRE 
					INNER JOIN HumanResources.Employee HRE1
					ON HRE.BusinessEntityID = HRE1.OrganizationLevel
					JOIN Person.Person PP 
					ON PP.BusinessEntityID=HRE.BusinessEntityID
					GROUP BY HRE.OrganizationLevel,PP.FirstName


-------------------------------------------------------------------------------------------------------------------------------------------------------
--32.display employees who are not managers 
							
						SELECT * 
						FROM HumanResources.Employee HRE
						WHERE HRE.BusinessEntityID NOT IN(   
						SELECT DISTINCT HRE.BusinessEntityID
										FROM HumanResources.Employee HRE 
										INNER JOIN HumanResources.Employee HRE1
										ON HRE.BusinessEntityID = HRE1.OrganizationLevel
										JOIN Person.Person PP 
										ON PP.BusinessEntityID = HRE.BusinessEntityID)
										ORDER BY HRE.BusinessEntityID ASC


------------------------------------------------------------------------------------------------------------------------------------------------------
--33. display the manager’s name who manages the maximum numbers of employees


	SELECT TOP(1) COUNT(HRE.BusinessEntityID ) AS 'NUMBER OF EMPLOYEE ',
					HRE.OrganizationLevel ,
					PP.FirstName AS 'MGR_NAME' 
					FROM HumanResources.Employee HRE 
					INNER JOIN HumanResources.Employee HRE1
					ON HRE.BusinessEntityID = HRE1.OrganizationLevel
					JOIN Person.Person PP 
					ON PP.BusinessEntityID=HRE.BusinessEntityID
					GROUP BY HRE.OrganizationLevel,PP.FirstName
					ORDER BY COUNT(HRE.OrganizationLevel) DESC

-------------------------------------------------------------------------------------------------------------------------------------------------------
--34.Display the Employee who is working in the same department where his manager is working

		
		SELECT * FROM HumanResources.Employee HRE
		INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
		ON HREDH.BusinessEntityID=HRE.BusinessEntityID
		INNER JOIN HumanResources.Department HRD
		ON HRD.DepartmentID=HREDH.DepartmentID
		WHERE HRD.Name IN(	
							SELECT HRD1.Name 
							FROM HumanResources.Employee HRE1 
							INNER JOIN HumanResources.Employee HRE2
							ON HRE1.BusinessEntityID = HRE2.OrganizationLevel
							JOIN Person.Person PP 
							ON PP.BusinessEntityID = HRE1.BusinessEntityID
							INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH1
							ON HREDH1.BusinessEntityID=HRE1.BusinessEntityID
							INNER JOIN HumanResources.Department HRD1
							ON HRD1.DepartmentID=HREDH1.DepartmentID
							GROUP BY HRD1.Name
						)
					
--------------------------------------------------------------------------------------------------------------------
--35.		display the employee whose salary is greater than  his manager
			
			SELECT DISTINCT HRE.OrganizationLevel ,
						HREPH.Rate
						INTO #MGRSAL1
						FROM HumanResources.Employee HRE 
						INNER JOIN HumanResources.Employee HRE1
						ON HRE.BusinessEntityID = HRE1.OrganizationLevel
						JOIN Person.Person PP 
						ON PP.BusinessEntityID = HRE.BusinessEntityID
						INNER JOIN HumanResources.EmployeePayHistory HREPH
						ON HREPH.BusinessEntityID=HRE.BusinessEntityID
						WHERE HREPH.Rate=(	
											SELECT TOP(1) EPH1.Rate 
											FROM AdventureWorks2014.HumanResources.EmployeePayHistory EPH1 
											WHERE EPH1.BusinessEntityID = HRE.BusinessEntityID 
											ORDER BY EPH1.RateChangeDate DESC
										)
						ORDER BY HRE.BusinessEntityID ASC


			SELECT * FROM HumanResources.Employee HRE
			INNER JOIN HumanResources.EmployeePayHistory HREPH
			ON HREPH.BusinessEntityID=HRE.BusinessEntityID
			INNER JOIN #MGRSAL1 MG
			ON MG.OrganizationLevel=HRE.OrganizationLevel
			WHERE HREPH.Rate>MG.Rate


			--CROSS CHECK QUERY
			--SELECT * FROM #MGRSAL1
			--SELECT * FROM HumanResources.Employee HRE
			--INNER JOIN HumanResources.EmployeePayHistory HREPH
			--ON HRE.BusinessEntityID=HREPH.BusinessEntityID
			--WHERE HRE.OrganizationLevel=3 AND HREPH.Rate>29.8462

			
--------------------------------------------------------------------------------------------------------------------------------
	--36.display the 1st  and 2nd highest salary from each Department
		;WITH Temp
		AS
		(
		SELECT E1.BusinessEntityID AS 'EmployeeID',
				D1.DepartmentID,
			   (EPH1.Rate*9*22) 'Salary' ,
			   DENSE_RANK() OVER(PARTITION BY D1.DepartmentID ORDER BY EPH1.Rate DESC) as 'RANKS' 
		FROM HumanResources.Employee E1
		INNER JOIN HumanResources.EmployeeDepartmentHistory EDH1
		ON EDH1.BusinessEntityID=E1.BusinessEntityID
		INNER JOIN HumanResources.Department D1
		ON D1.DepartmentID=EDH1.DepartmentID
		INNER JOIN HumanResources.EmployeePayHistory EPH1
		ON EPH1.BusinessEntityID=E1.BusinessEntityID
		WHERE 
		EPH1.Rate = (	
					SELECT TOP(1) EPH1.Rate FROM HumanResources.EmployeePayHistory EPH1 
					WHERE EPH1.BusinessEntityID = E1.BusinessEntityID ORDER BY EPH1.RateChangeDate DESC
					)
		)
		SELECT EmployeeID,DepartmentID,Salary
		FROM Temp
		WHERE RANKS IN (1,2)
		ORDER BY DepartmentID
			

--------------------------------------------------------------------------------------------------------------------------------

	--37.	Display the details of all employees whose salary is greater than average salary of employees in respective department
	
	SELECT AVG (RATE) as 'SALERY',
		   HRD.DepartmentID as 'DEPARTMENT'
		   INTO #avgsal1
		   FROM HumanResources.EmployeePayHistory  HREPH
		   INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
		   ON HREDH.BusinessEntityID = HREPH.BusinessEntityID
		   INNER JOIN HumanResources.Department HRD
		   ON HRD.DepartmentID = HREDH.DepartmentID
		   GROUP BY HRD.DepartmentID 

	SELECT HREPH.Rate,
		  HRD.DepartmentID ,
		  HRE.* 
		  FROM HumanResources.Employee HRE
		  INNER JOIN HumanResources.EmployeePayHistory HREPH
		  ON HREPH.BusinessEntityID=HRE.BusinessEntityID
		  INNER JOIN HumanResources.EmployeeDepartmentHistory HREDH
		  ON HREDH.BusinessEntityID=HRE.BusinessEntityID
		  INNER JOIN HumanResources.Department HRD
		  ON HRD.DepartmentID=HREDH.DepartmentID
		  INNER JOIN #avgsal1 AV
		  ON AV.DEPARTMENT=HRD.DepartmentID
		  WHERE HREPH.Rate>AV.SALERY 
		  ORDER BY HRD.DepartmentID ASC
------------------------------------------------------------------------------------------------------------------------------------------------