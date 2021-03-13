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
