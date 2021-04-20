

USE AdventureWorks2014
GO

--Batch Processing 
--Variable Declarations

DECLARE @ID INT,@NAME VARCHAR(20);
DECLARE @DATE DATE='2020-02-24';
SET @ID=1;
SET @NAME='%Sa%';
--SELECT * FROM HumanResources.Department
--WHERE DepartmentID = @ID

SELECT * FROM HumanResources.Department
WHERE Name like @NAME
GO



DECLARE @TBL_NAME VARCHAR(50);
DECLARE @SQL_QUERY VARCHAR(MAX);
SET @TBL_NAME='Department'
--SET @SQL_QUERY  ='SELECT * FROM HumanResources.Department'
SET @SQL_QUERY  ='SELECT * FROM HumanResources.Department WHERE DepartmentID=2'
EXEC(@SQL_QUERY)
GO



--PARAMETERIZED QUERY( Table Names can not be used for Parameters)
DECLARE @P1 INT;
DECLARE @SQL_QUERY NVARCHAR(MAX);
DECLARE @PREP_HANDLER INT;
SET @P1 =1;
SET @SQL_QUERY  = N'SELECT * FROM HumanResources.Department WHERE DepartmentID=@P1'
EXEC sp_prepare @PREP_HANDLER OUTPUT , N'@P1 NVARCHAR(2)' , @SQL_QUERY
EXEC sp_execute @PREP_HANDLER ,@P1
EXEC sp_unprepare @PREP_HANDLER 
GO



DECLARE @P1 INT;
DECLARE @SQL_QUERY NVARCHAR(MAX);
DECLARE @PREP_HANDLER INT;
SET @P1 =1;
SET @SQL_QUERY  = N'SELECT * FROM HumanResources.Department WHERE DepartmentID=@P1'
EXEC sp_prepexec @PREP_HANDLER OUTPUT , N'@P1 NVARCHAR(2)' , @SQL_QUERY , @P1
EXEC sp_unprepare @PREP_HANDLER 
GO


DECLARE @P1 NVARCHAR(50);
DECLARE @SQL_QUERY NVARCHAR(MAX);
DECLARE @PREP_HANDLER INT;
SET @P1 = 'Department';
SET @SQL_QUERY  = N'SELECT * FROM HumanResources.@P1'
EXEC sp_prepexec @PREP_HANDLER OUTPUT , N'@P1 NVARCHAR(50)' , @SQL_QUERY , @P1
EXEC sp_unprepare @PREP_HANDLER 
GO



DECLARE @User_Input INT;
DECLARE @Name VARCHAR(50) ,@GroupName VARCHAR(50);
SET @User_Input=1;

--1 SET
SET @Name = (SELECT Name FROM HumanResources.Department WHERE DepartmentID=@User_Input)
SET @GroupName = (SELECT GroupName FROM HumanResources.Department WHERE DepartmentID=@User_Input)

-- OPRER
SELECT @Name AS 'Name', @GroupName AS 'Group Name'

--2. SELECT
SELECT @Name = Name, @GroupName = GroupName FROM HumanResources.Department WHERE DepartmentID=@User_Input
SELECT @Name AS 'Name', @GroupName AS 'Group Name'
GO



--type conversion 
DECLARE @NUMBER INT=12;  
DECLARE @NUMBER1 FLOAT(53)
SET @NUMBER1 = CAST(@NUMBER AS FLOAT(53))
PRINT @NUMBER1
GO



DECLARE @NUMBER INT=12;  
DECLARE @NUMBER1 FLOAT(53)
SET @NUMBER1 = CONVERT(FLOAT(53), @NUMBER)
PRINT @NUMBER1
GO


DECLARE @A CHAR(2)='11'
DECLARE @B INT;
SET @B= PARSE(@A AS INT)
PRINT @B





DECLARE @A CHAR(3)='1A';
DECLARE @B INT;
SET @B= PARSE(@A AS INT)
PRINT @B



DECLARE @A CHAR(1)='1A';
DECLARE @B INT;
SET @B= TRY_PARSE(@A AS INT)
PRINT @B 


-- CONDITIONAL CONSTRUCT
DECLARE @DAY_NUMBER INT=1;
IF(@DAY_NUMBER = 1)
	SELECT 'Sunday'
ELSE
	SELECT 'Some Other Day'
GO


DECLARE @GENDER CHAR(1)='M';
IF(@GENDER ='M')
	BEGIN
		SELECT 'Male'
	END
	ELSE
	BEGIN
		SELECT 'Female'
	END
GO


DECLARE @ID INT = 0;
IF EXISTS(SELECT * FROM HumanResources.Department WHERE DepartmentID=@ID)
	BEGIN
		SELECT * FROM HumanResources.Department WHERE DepartmentID=@ID
	END
ELSE
	BEGIN
		--SELECT CONCAT('Record with ID: ',@ID,' not exist')
		--THROW 50000 ,'Record not exist',0;
		--RAISERROR('Record not exist',0,0)
		RAISERROR('Record not exist',18,0)
	END
GO




DECLARE @USER_INPUT INT =72;
DECLARE @CURRRETN_RATE MONEY , @NEW_RATE MONEY;

IF EXISTS(SELECT * FROM HumanResources.EmployeePayHistory WHERE BusinessEntityID = @USER_INPUT)
	BEGIN
		SELECT @CURRRETN_RATE = Rate FROM HumanResources.EmployeePayHistory WHERE BusinessEntityID = @USER_INPUT
		IF(@CURRRETN_RATE < 10)
		BEGIN
			SET @NEW_RATE = @CURRRETN_RATE + 2;
			UPDATE HumanResources.EmployeePayHistory SET Rate = @NEW_RATE  WHERE BusinessEntityID = @USER_INPUT
		END
	END
	ELSE
		BEGIN
			RAISERROR('Record not exist',18,0)
		END
GO



DECLARE @D INT = 0;
DECLARE @Result CHAR(30);
SELECT @Result=CASE(@D)
	WHEN 1  THEN 'Sunday' 
	WHEN 2  THEN 'Monday' 
	WHEN 3  THEN 'Tuesday' 
	WHEN 4  THEN 'Wednesday' 
	WHEN 5  THEN 'Thursday' 
	WHEN 6  THEN 'Friday'  
	WHEN 7  THEN 'Saturday'  
	ELSE 'Invalid'
END
PRINT @Result
GO




SELECT
E.BusinessEntityID,
E.BirthDate,
E.JobTitle,
E.MaritalStatus,
'Gender'= CASE(E.Gender)
WHEN 'M' THEN  'Male'
WHEN 'F' THEN  'Female'
END
FROM HumanResources.Employee E
GO



DECLARE @A INT=1;
WHILE @A <=10
BEGIN
		SELECT @A;
		SET @A = @A + 1;
END
GO



DECLARE @COUNT  INT , @A INT=1;
SET @COUNT=(SELECT COUNT(*) FROM HumanResources.Department);
WHILE @A < = @COUNT
BEGIN 
    WITH CTE1 AS 
	(
		SELECT ROW_NUMBER() OVER(ORDER BY D.Name ASC) AS  'ID', D.Name , D.GroupName , D.ModifiedDate
		FROM HumanResources.Department D 
	)
	SELECT * FROM CTE1 	WHERE ID = @A
	SET @A = @A + 1;
END
GO






DECLARE @COUNT  INT , @A INT=1;
SET @COUNT=(SELECT COUNT(*) FROM HumanResources.EmployeePayHistory);
WHILE @A < = @COUNT
BEGIN 
    DECLARE @Rate MONEY;
	SELECT @Rate = Rate FROM HumanResources.EmployeePayHistory WHERE BusinessEntityID = @A;
	IF @Rate < 15
	BEGIN 
		UPDATE HumanResources.EmployeePayHistory
		SET Rate = Rate + 2
	END
	SET @A = @A + 1;
END


-- TRY CATCH 
DECLARE @A INT=1 , @B INT=0, @R INT;
BEGIN TRY 
	SET @R = @A / @B
END TRY 
BEGIN CATCH
	--SELECT ERROR_LINE() , ERROR_SEVERITY(), ERROR_STATE(),  ERROR_MESSAGE() , ERROR_NUMBER() , ERROR_PROCEDURE() 
	INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
	VALUES(GETDATE(),'SA',ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
	SELECT ERROR_MESSAGE()
END CATCH 
GO



BEGIN TRY 
	INSERT INTO HumanResources.Department(Name,GroupName,ModifiedDate) 
	VALUES('Engineering','Research and Development',GETDATE())
END TRY 
BEGIN CATCH
	INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
	VALUES(GETDATE(),SUSER_SNAME() ,ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
	SELECT ERROR_MESSAGE()
END CATCH 
GO

-- user defined functions


CREATE FUNCTION ufn_Add
(
 @A INT ,
 @B INT 
) 
RETURNS INT
AS 
BEGIN 
	DECLARE @R INT=0;
	SET @R = @A + @B;
	RETURN @R;		
END 
GO


ALTER FUNCTION ufn_Add
(
 @A INT,
 @B INT 
) 
RETURNS INT  
WITH RETURNS NULL ON NULL INPUT , SCHEMABINDING --ENCRYPTION
AS 
BEGIN 
	DECLARE @R INT=0;
	IF @A IS NOT NULL AND @B IS NOT NULL 
		BEGIN 
			SET @R = @A + @B;
		END 
		-- Error raising cant be done inside function body
	RETURN @R;		
END 
GO


exec sp_helptext 'dbo.ufn_Add' 
GO

--table valued functions
use AdventureWorks2014
go


CREATE FUNCTION ufn_All_Department()
RETURNS TABLE  
WITH SCHEMABINDING 
AS 
	RETURN (SELECT DepartmentID , Name , GroupName , ModifiedDate FROM HumanResources.Department)
GO


SELECT * from dbo.ufn_All_Department()
GO


CREATE FUNCTION ufn_Search_Department(@ID INT)
RETURNS TABLE  
WITH SCHEMABINDING 
AS 
	RETURN (SELECT DepartmentID , Name , GroupName , ModifiedDate FROM HumanResources.Department WHERE DepartmentID=@ID)
GO

SELECT * FROM dbo.ufn_Search_Department(1)
GO

-- Complex / Custom Types 

CREATE TYPE Emp_Type
AS TABLE
(
	ID INT ,
	NAME VARCHAR(20)
)
GO



DECLARE @E Emp_Type 
INSERT INTO @E VALUES(1,'ABC')
SELECT * FROM @E
GO


CREATE FUNCTION ufn_ComplexType1
( 
	@CT1 AS Emp_Type READONLY 
)
RETURNS @Result  TABLE(ID INT,NAME NVARCHAR(10))
AS
BEGIN 
	INSERT INTO @Result (ID,NAME) SELECT * FROM @CT1
RETURN;
END
GO



DECLARE @A AS Emp_Type
INSERT INTO @A(ID,NAME) VALUES(102,'Test1')
INSERT INTO @A(ID,NAME) VALUES(102,'Test2')
SELECT * FROM dbo.ufn_ComplexType1(@A)
GO




CREATE TYPE dbo.Customer_Type
AS TABLE(ID INT , FName  VARCHAR(50) , MName  VARCHAR(50), LName  VARCHAR(50) )
GO



CREATE FUNCTION ufn_GetCustomerName
(
	@NameType VARCHAR(20),
	@Customers AS Customer_Type READONLY
)
RETURNS @Result AS TABLE(ID INT , Name  VARCHAR(150)) 
AS 
BEGIN
	IF(UPPER(@NameType)='LONGNAME')
	BEGIN
		INSERT INTO @Result SELECT ID , CONCAT(FName,MName,LName) FROM @Customers 
	END
	ELSE 
	BEGIN 
		IF(UPPER(@NameType)='SHORTNAME')
		BEGIN 
			INSERT INTO @Result SELECT ID , CONCAT(LName) FROM @Customers 
		END
	END
RETURN; 
GO




CREATE TYPE Products_Type
AS TABLE
(
	ID INT , 
	Name VARCHAR(50)
)
GO



CREATE FUNCTION PrintProductDetails
(
	@Items AS  Products_Type READONLY
)
RETURNS @Result TABLE(ID INT ,Name VARCHAR(50)) 
AS 
BEGIN
	INSERT INTO  @Result SELECT * FROM @Items 
	RETURN;
END
GO



DECLARE @Items AS  Products_Type
INSERT INTO @Items VALUES(1,'Mango')
INSERT INTO @Items VALUES(2,'Watermelon')
SELECT * FROM PrintProductDetails(@Items)
GO


-- STORED PROCEDURE

CREATE PROCEDURE usp_Hello
AS
BEGIN
	PRINT 'Hello'
END
GO 


DECLARE @Name VARCHAR(50)
SET @Name ='Quest'
EXEC  usp_Hello @Name
GO


ALTER PROCEDURE usp_Hello
(-- INPUT PARM
	@Name VARCHAR(50) 
)
AS
BEGIN
	PRINT CONCAT('Hello',SPACE(1),@Name)   
END
GO 


CREATE PROCEDURE usp_Add
(
	@A INT,
	@B INT
)
AS
BEGIN
	DECLARE @R INT=0;
	SET @R = @A + @B;
	SELECT @A AS 'Value1' , @B AS 'Value2', @R AS 'Result' 
END
GO

EXEC usp_Add 1,1


-- Add Recor TO Dept Table
GO;
ALTER PROC usp_AddDepartmentRecords
(
	@Name VARCHAR(50),
	@GroupName VARCHAR(50),
	@GeneratedID INT OUTPUT
)
AS
BEGIN
	IF ( (@Name IS NOT NULL AND @GroupName IS NOT NULL) AND (LEN(@Name)!=0 AND LEN(@GroupName )!=0) )
		BEGIN 
			IF NOT EXISTS(SELECT * FROM HumanResources.Department WHERE Name = @Name  AND GroupName = @GroupName)
				BEGIN TRY 
					INSERT INTO HumanResources.Department(Name , GroupName) VALUES(@Name , @GroupName)
					
					SET @GeneratedID = @@IDENTITY -- IF id IS IDENTITY

					--SET @GeneratedID = (SELECT DepartmentID FROM HumanResources.Department WHERE Name=@Name AND GroupName = @GroupName)
					--SET @GeneratedID = (SELECT COUNT(*) FROM HumanResources.Department) + 1 ; -- IF id IS SERIAL NUMBERS AND NOT IDENTITY

				END TRY
				BEGIN CATCH 
					INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
					VALUES(GETDATE(),SUSER_SNAME() ,ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
				END CATCH
			ELSE 
			RAISERROR('Record Exist...!!' , 18,0)
		END
	ELSE
	RAISERROR('Invalid User Input' , 18,0)
END
GO


EXEC usp_AddDepartmentRecords null , null

EXEC usp_AddDepartmentRecords ' ' , ' '


DECLARE @id INT 
EXEC usp_AddDepartmentRecords 'D2' , 'D2 '  , @id OUTPUT
PRINT @id 

SELECT * FROM HumanResources.Department


-- BULK OPERATIONS USING XML

DECLARE @XML_DOC XML;
SET @XML_DOC='<root>
			  <row>
				<Name>sd</Name>
				<GroupName>Development</GroupName>
			  </row>
			  <row>
				<Name>qa</Name>
				<GroupName>Development</GroupName>
			  </row>
			</root>'
EXEC dbo.usp_InsertDepartment_XML @XML_DOC
GO

CREATE PROC usp_InsertDepartment_XML
(
	@XML_DOC XML
)
AS BEGIN 
	DECLARE @DOC_POINTER INT;
	EXEC sp_xml_preparedocument  @DOC_POINTER output , @XML_DOC;
	INSERT INTO HumanResources.Department(Name,GroupName) 
	SELECT * FROM OPENXML(@DOC_POINTER,'/root/row',2)
	WITH(Name  VARCHAR(50), GroupName VARCHAR(50))
	EXEC sp_xml_removedocument @DOC_POINTER;
END
GO

-- BULK OPERATIONS USING TVP

--37.	Display the details of all employees whose salary is greater than average salary of employees in respective department

-- Dept=1;
-- avgSal=6364.0815
select AVG(Rate * 9 * 21) from HumanResources.EmployeePayHistory p
join HumanResources.EmployeeDepartmentHistory h
on p.BusinessEntityID = h.BusinessEntityID
where h.DepartmentID =1


select * from HumanResources.Employee e
join HumanResources.EmployeePayHistory p
on e.BusinessEntityID = p.BusinessEntityID
join HumanResources.EmployeeDepartmentHistory h
on p.BusinessEntityID = h.BusinessEntityID
where h.DepartmentID =1 and p.Rate * 9 * 21 > 6364.0815



WITH EMP_Salary
AS
(
	SELECT H.DepartmentID, P.Rate * 9 * 21 AS 'Salary',E.BusinessEntityID  FROM HumanResources.Employee E
	JOIN HumanResources.EmployeeDepartmentHistory H
	ON E.BusinessEntityID = H.BusinessEntityID
	JOIN HumanResources.EmployeePayHistory P 
	ON P.BusinessEntityID = H.BusinessEntityID
),
Dept_Savg_Salary 
AS
(
	SELECT H.DepartmentID, AVG(P.Rate * 9 * 21) AS 'Avg_Salary'  FROM HumanResources.Employee E
	JOIN HumanResources.EmployeeDepartmentHistory H
	ON E.BusinessEntityID = H.BusinessEntityID
	JOIN HumanResources.EmployeePayHistory P 
	ON P.BusinessEntityID = H.BusinessEntityID
	GROUP BY H.DepartmentID
)
SELECT D.DepartmentID , E.Salary , E.BusinessEntityID FROM EMP_Salary E
JOIN Dept_Savg_Salary D
ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > D.Avg_Salary
ORDER BY D.DepartmentID ASC 
GO


-- views 
CREATE VIEW uvw_Employee_Details
AS
SELECT * FROM HumanResources.Employee E 
GO

SELECT * FROM dbo.uvw_Employee_Details
ORDER BY BusinessEntityID ASC
GO



ALTER VIEW uvw_Employee_Details
AS
SELECT E.BusinessEntityID ,
	   E.Gender,
	   E.MaritalStatus,
	   E.BirthDate,
	   E.HireDate,
	   E.JobTitle AS 'Designatoin',
	   D.Name AS 'Department',
	   PH.Rate * 9 * 21 AS 'Salary',
	   p.FirstName,
	   p.MiddleName,
	   p.LastName,
	   A.AddressLine1 ,
	   A.City,
	   SP.Name AS 'State',
	   CR.Name AS 'Country',
	   A.PostalCode
FROM HumanResources.Employee E 
JOIN HumanResources.EmployeeDepartmentHistory DH
ON E.BusinessEntityID = DH.BusinessEntityID
JOIN HumanResources.Department D
ON DH.DepartmentID = D.DepartmentID
JOIN HumanResources.EmployeePayHistory PH
ON E.BusinessEntityID = PH.BusinessEntityID
JOIN Person.Person P
ON E.BusinessEntityID = P.BusinessEntityID
JOIN Person.BusinessEntityAddress BA 
ON E.BusinessEntityID = BA.BusinessEntityID
JOIN Person.Address A
ON A.AddressID = BA.AddressID
JOIN Person.StateProvince SP 
ON SP.StateProvinceID = A.StateProvinceID
JOIN Person.CountryRegion CR
ON SP.CountryRegionCode = CR.CountryRegionCode
GO



SELECT * FROM dbo.uvw_Employee_Details
WHERE BusinessEntityID=1



--index

CREATE NONCLUSTERED  INDEX ncix_Department_GroupName
ON HumanResources.Department(GroupName)
GO

SELECT * FROM HumanResources.Department




SELECT * FROM [crms].[Ma_Vehicles]
go

use CRMS_DB_Dev
go



--CREATE UNIQUE INDEX uix_Ma_Vehicles_RowGUID
--ON crms.Ma_Vehicles(RowGUID)
--   INCLUDE
--   (
--		VehiclesType,Name,FuelType ,TransmissionType,SeatingCapacity,PermitType,IsActive 
--   ) 	
--GO


drop index crms.Ma_Vehicles.uix_Ma_Vehicles_RowGUID

CREATE UNIQUE INDEX uix_Ma_Vehicles_RowGUID
ON crms.Ma_Vehicles(RowGUID)
GO


CREATE NONCLUSTERED  INDEX ncix_Ma_Vehicles
ON crms.Ma_Vehicles(VehiclesType,Name,FuelType ,TransmissionType,SeatingCapacity,PermitType,IsActive )
GO


USE AdventureWorks2014
GO


SELECT * FROM HumanResources.Department


-- TRANSACTION 
BEGIN TRY 

	BEGIN TRANSACTION T1
	INSERT INTO HumanResources.Department(Name , GroupName) VALUES('Engineering1','Research and Development1')
	--IF(XACT_STATE()) = 1
	COMMIT TRANSACTION T1	
END TRY 
BEGIN CATCH 
	--IF(XACT_STATE()) = -1
	ROLLBACK TRANSACTION T1	
END CATCH

***************************
