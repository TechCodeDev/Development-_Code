USE AdventureWorks2014
GO
-------------------------------------------------------------------------------------------------------------------------------------------
--1.	Write Stored Procedure to insert a records for a table

	CREATE PROC usp_Addpartment
	(
		@Name VARCHAR(100),
		@Groupname VARCHAR(100)
	)
	AS
	BEGIN
		IF( (@Name IS NOT NULL AND @GroupName IS NOT NULL) AND (LEN(@Name)!=0 AND LEN(@GroupName )!=0) )
			BEGIN
				IF NOT EXISTS(SELECT * FROM HumanResources.Department WHERE NAME=@NAME AND GroupName=@Groupname)
					BEGIN TRY 
						INSERT INTO HumanResources.Department(Name,GroupName)VALUES(@Name,@Groupname)
					END TRY 
					BEGIN CATCH 
						INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
						VALUES(GETDATE(),SUSER_SNAME() ,ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
					END CATCH
				ELSE
					RAISERROR('RECORD EXISTS',18,0)
			END
		ELSE
			RAISERROR('Invalid User Input',18,0)
	END
	GO

	EXEC usp_Addpartment '' ,''
	GO
--------------------------------------------------------------------------------------------------------------------------------------------------
--2 Write Stored Procedure to delete a particular record from the table



	CREATE PROC usp_Deletedepartment
	(
		@DeleteID INT
	)
	AS
	BEGIN
		IF NOT EXISTS(SELECT * FROM HumanResources.Department WHERE DepartmentID=@DeleteID)
				RAISERROR('RECORD NOT EXISTS',18,0)
		ELSE
			BEGIN TRY 
				DELETE HumanResources.Department
				WHERE DepartmentID=@DeleteID
			END TRY 
			BEGIN CATCH 
				INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
				VALUES(GETDATE(),SUSER_SNAME() ,ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
			END CATCH
	END
	GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Write Stored Procedure which returns count of records for the given condition
	
	CREATE PROC usp_COUNT
	(
		@VAL VARCHAR(100),
		@COUNT VARCHAR(100) OUTPUT
	)
	AS
	BEGIN 
		SET @COUNT=CASE @VAL
		WHEN 1 THEN (SELECT COUNT(*) FROM HumanResources.Employee)
		WHEN 2 THEN (SELECT COUNT(*) FROM HumanResources.Department)
		WHEN 3 THEN (SELECT COUNT(*) FROM HumanResources.EmployeePayHistory)
		ELSE
		'PLEASE ENTER VALID DATA'
		END
	END
	GO

	DECLARE @id VARCHAR(100) 
	EXEC usp_COUNT 1, @id OUTPUT
	PRINT @id +' RECORD FOUND.....!!!' 

----------------------------------------------------------------------------------------------------------------------------------------------------------------
--4.Write Stored Procedure to display the employee details using output keyword
	
	SELECT * FROM HumanResources.Employee

	ALTER PROCEDURE usp_Empdetail
	(
		@ID INT,
		@NATIONALID INT OUTPUT ,
		@JOBTITLE VARCHAR(100) OUTPUT,
		@DOB VARCHAR(100) OUTPUT,
		@LOGINID VARCHAR(100) OUTPUT
	)
	AS
	BEGIN
		IF(@ID IS NOT NULL AND LEN(@ID)!=0)
			BEGIN
				IF EXISTS(SELECT * FROM HumanResources.Employee WHERE BusinessEntityID=@ID)
					BEGIN TRY 
						SELECT @JOBTITLE=JobTitle,@NATIONALID=NationalIDNumber,@DOB=BirthDate,@LOGINID=LoginID FROM HumanResources.Employee WHERE BusinessEntityID=@ID
					END TRY 
					BEGIN CATCH 
						INSERT INTO ErrorLog(ErrorTime,UserName,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
						VALUES(GETDATE(),SUSER_SNAME() ,ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
					END CATCH
				ELSE
					RAISERROR('RECORD NOT EXISTS',18,0)
			END
		ELSE
			RAISERROR('Invalid User Input',18,0)
	END
	GO
	
	DECLARE  @ID INT , @JOBTITLE VARCHAR(100) , @DOB VARCHAR(100) ,@LOGINID VARCHAR(200)
	EXEC usp_Empdetail 1, @ID , @JOBTITLE OUTPUT ,@DOB OUTPUT ,@LOGINID OUTPUT
	PRINT CONCAT(@ID, SPACE(1),@JOBTITLE,SPACE(1),@DOB,SPACE(1),@LOGINID)


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5 . Write Stored Procedure to display the records of a table with specified number of records

	ALTER PROCEDURE usp_DisplayRecord
	(
		@NumberOfRecord INT
	
	)
	AS
	BEGIN
		IF(@NumberOfRecord<=(SELECT COUNT(*) FROM HumanResources.Employee))	
		BEGIN
			IF(@NumberOfRecord IS NOT NULL AND LEN(@NumberOfRecord)!=0)
				SELECT TOP(@NumberOfRecord) * FROM HumanResources.Employee
		END
		ELSE
			 RAISERROR('Invalid User Input',18,0)
	END
	GO
	
	EXEC usp_DisplayRecord 100
	GO
-----------------------------------------------------------------------------------------------------------------------------------------------
--6. Write Stored Procedure to find whether the table exists or not. 
--   If it exists, insert the data. 
--   If it is not exist, first create the table then insert the data

	CREATE PROCEDURE usp_CHECK
	(
		
		 @TABLENAME VARCHAR(100),
		 @VAL1 VARCHAR(100),
		 @VAL2 VARCHAR(100),
		 @QUERY VARCHAR(100) OUTPUT 
	)
	AS
	BEGIN
	IF((@VAL1 IS NOT NULL AND @VAL2 IS NOT NULL) AND (LEN(@VAL1)!=0 AND LEN(@VAL2)!=0))
		BEGIN
		IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(@TABLENAME) )
			BEGIN
				SET @QUERY=N' CREATE TABLE '+@TABLENAME+' ( c1 VARCHAR(100) , c2 VARCHAR(100)) ; '
				EXEC (@QUERY)
				SET @QUERY=N' INSERT INTO '+@TABLENAME+' VALUES ( '+@VAL1+ ' , '+@VAL2+' ) '
				EXEC(@QUERY)
				PRINT('CREATED')
			END
		ELSE
			 SET @QUERY=N' INSERT INTO '+@TABLENAME+' VALUES ( '+@VAL1+ ' , '+@VAL2+' ) '
			 EXEC(@QUERY)
			 PRINT('INSERTED')
		END
	ELSE
		RAISERROR('Invalid User Input',18,0)
	END
	GO

	DECLARE @ID VARCHAR(100)
	EXEC usp_CHECK 'dbo.ha','1','1',@ID OUTPUT
	PRINT @ID
	GO

-----------------------------------------------------------------------------------------------------------------------------------------

	ALTER PROCEDURE usp_CHECK
	(
		
		 @TABLENAME VARCHAR(100),
		 @C1 VARCHAR(100),
		 @C2 VARCHAR(100),
		 @VAL1 VARCHAR(100),
		  @VAL2 VARCHAR(100),
		  @QUERY VARCHAR(100) OUTPUT 
	)
	AS
	BEGIN
	IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(@TABLENAME) )
	--IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME =@TABLENAME)
		BEGIN
			SET @QUERY=N' CREATE TABLE '+@TABLENAME+' ( '+@C1+' VARCHAR(100) ,' +@C2+ ' VARCHAR(100)) ; '
			EXEC (@QUERY)
			SET @QUERY=N' INSERT INTO '+@TABLENAME+' VALUES ( '+@VAL1+ ' , '+@VAL2+' ) '
			EXEC(@QUERY)
			PRINT('CREATED')
		END
	ELSE
			 RAISERROR('TABLE ALREADY CREATED ',18,0)
	END
	GO

	DECLARE @ID VARCHAR(100)
	EXEC usp_CHECK 'dbo.ha','C1','C2','1','1',@ID OUTPUT
	PRINT @ID
	GO

