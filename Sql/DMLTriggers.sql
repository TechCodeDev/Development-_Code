/*

IN SQL SERVER THERE ARE 3 TYPES OF TRIGGERS
1. DML TRIGGERS 
2. DDL TRIGGERS
3. LOGON TRIGGER

In general, a trigger is a special kind of stored procedure that automatically executes when 
an event occurs in the database server.

DML stands for Data Manipulation Language. INSERT, UPDATE, and DELETE statements are DML 
statements. DML triggers are fired, when ever data is modified using INSERT, UPDATE, and DELETE events.

DML triggers can be again classified into 2 types.
1. After triggers (Sometimes called as FOR triggers)
2. Instead of triggers

After triggers, as the name says, fires after the triggering action. The INSERT, UPDATE, and 
DELETE statements, causes an after trigger to fire after the respective statements complete execution.

On ther hand, as the name says, INSTEAD of triggers, fires instead of the triggering action. 
The INSERT, UPDATE, and DELETE statements, can cause an INSTEAD OF trigger to fire INSTEAD 
OF the respective statement execution.

*/



-------------------------------------------------EMPLOYEE DATABASE---------------------------------------------------------------------
CREATE DATABASE EMP_DEV
GO

---------------------------------------------------CREATE SCHEME---------------------------------------------------------------
CREATE SCHEMA emp

-----------------------------------------------CREATE TABEL EMP DETAILS------------------------------------------------------------------

CREATE TABLE emp.Ma_EmployeeDetails
(
	Id int identity(1,1) NOT NULL,
	Name varchar(50) NOT NULL,
	Salaray int NOT NULL,
	Gender char(1) NOT NULL,
	DepartmentId INT NOT NULL,
	
	CONSTRAINT CK_Ma_EmployeeDetails_GENDER  CHECK(GENDER IN('M','F','O'))
)
GO

SELECT * FROM emp.Ma_EmployeeDetails

CREATE TABLE emp.Tr_Complte_Details
(
	ID int identity(1,1) NOT NULL,
	COMPLETEVALUE VARCHAR(50) NOT NULL
)
GO
----------------------------------------------CREATE TRIGGER FOR INSERT IN TABLE EMP.MA_EMPLOYEEDETAILS------------------------------------------------------------------------

CREATE TRIGGER emp.TR_Ma_EmployeeDetails_ForInsert
ON emp.Ma_EmployeeDetails
FOR INSERT 
AS
BEGIN
	DECLARE @Id INT,@DepartmentId INT,@Salary INT;
	DECLARE @Name VARCHAR(50) ,@Gender CHAR(1) ;
	SELECT @Id=Id,
		   @DepartmentId=DepartmentId, 
		   @Salary=Salaray,@Name=Name
		   FROM inserted
	INSERT INTO emp.Tr_Complte_Details(COMPLETEVALUE) values(@Name+'As a'+CONVERT(varchar(10),@Id)+'Who is Working For Salary OF'+CONVERT(varchar(10),@Salary)) 
END
GO

SELECT * FROM EMP.TR_COMPLTE_DETAILS
INSERT INTO emp.Ma_EmployeeDetails(Name,Salaray,Gender,DepartmentId) values('Latha K',2500,'M',2) 

----------------------------------------------CREATE TRIGGER FOR DELETE IN TABLE EMP.MA_EMPLOYEEDETAILS------------------------------------------------------------------------

CREATE TRIGGER emp.TR_Ma_EmployeeDetails_ForDelete
ON emp.Ma_EmployeeDetails
FOR DELETE 
AS
BEGIN
	DECLARE @Id INT,@DepartmentId INT,@Salary INT;
	DECLARE @Name VARCHAR(50) ,@Gender CHAR(1) ;
	SELECT @Id=Id,
		   @DepartmentId=DepartmentId, 
		   @Salary=Salaray,@Name=Name
		   FROM deleted
	INSERT INTO emp.Tr_Complte_Details(COMPLETEVALUE) values(@Name+'Who is Working For Salary OF'+Cast(@Salary AS VARCHAR(10))+'Is Deleted') 
END
GO

SELECT * FROM EMP.MA_EMPLOYEEDETAILS
DELETE emp.Ma_EmployeeDetails where Id=2

----------------------------------------------CREATE TRIGGER FOR UPDATE IN TABLE EMP.MA_EMPLOYEEDETAILS------------------------------------------------------------------------

CREATE TRIGGER emp.TR_Ma_EmployeeDetails_ForUpdate
ON emp.Ma_EmployeeDetails
FOR UPDATE 
AS
BEGIN
	SELECT * FROM inserted
	SELECT * FROM deleted
END
GO
---------------------------------------------SAMPLE EXAMPLE FOR UPDATE TRIGGERS-------------------------------------------------------------------------------------------------

CREATE trigger tr_tblEmployee_ForUpdate
on tblEmployee
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldName nvarchar(20), @NewName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewName = Name, 
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldName = Name, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
          -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
			if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblEmployeeAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End
---------------------------------------------------------Instead Of Insert--------------------------------------------------------------------------------- 

CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfInsert
ON vWEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @DeptId INT
	
	--CHECK IF THERE IS A VALID DEPARTMENTID
	--FOR THE GIVEN DEPARTMENTNAME
	SELECT @DeptId = DeptId 
	FROM tblDepartment 
	JOIN inserted
	ON inserted.DeptName = tblDepartment.DeptName
 
	--IF DEPARTMENTID IS NULL THROW AN ERROR
	--AND STOP PROCESSING
	IF(@DeptId is null)
	BEGIN
		RAISERROR('Invalid Department Name. Statement terminated', 16, 1)
		RETURN
	END
 
	--FINALLY INSERT INTO TBLEMPLOYEE TABLE
	INSERT INTO tblEmployee(Id, Name, Gender, DepartmentId)
	SELECT Id, Name, Gender, @DeptId
	FROM inserted
END

---------------------------------------------------------INSTEAD Of UPDATE------------------------------------------------------------------------------------------------------

CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfUpdate
ON vWEmployeeDetails
INSTEAD OF UPDATE
AS
BEGIN
		-- if EmployeeId is updated
		IF(UPDATE(Id))
		BEGIN
			RAISERROR('Id cannot be changed', 16, 1)
			RETURN
		END
 
		-- If DeptName is updated
		IF(Update(DeptName)) 
		BEGIN
			DECLARE @DeptId int

			SELECT @DeptId = DeptId
			FROM tblDepartment
			JOIN inserted
			on inserted.DeptName = tblDepartment.DeptName
  
			IF(@DeptId is NULL )
			BEGIN
				RAISERROR('Invalid Department Name', 16, 1)
				RETURN
			End
  
			UPDATE tblEmployee set DepartmentId = @DeptId
			FROM inserted
			JOIN tblEmployee
			ON tblEmployee.Id = inserted.id
		End
 
		-- If gender is updated
		IF(UPDATE(Gender))
		BEGIN
			UPDATE tblEmployee set Gender = inserted.Gender
			FROM inserted
			JOIN tblEmployee
			ON tblEmployee.Id = inserted.id
		End
 
		-- If Name is updated
		IF(UPDATE(Name))
		BEGIN
			UPDATE tblEmployee set Name = inserted.Name
			FROM inserted
			JOIN tblEmployee
			ON tblEmployee.Id = inserted.id
		End
End

---------------------------------------------------------INSTEAD Of DELETE------------------------------------------------------------------------------------------------------

Create Trigger tr_vWEmployeeDetails_InsteadOfDelete
on vWEmployeeDetails
INSTEAD OF DELETE
AS
BEGIN
 Delete tblEmployee 
 from tblEmployee
 join deleted
 on tblEmployee.Id = deleted.Id
 
 --Subquery
 --Delete from tblEmployee 
 --where Id in (Select Id from deleted)
End
