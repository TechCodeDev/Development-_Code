--1.Create a batch that finds the average pay rate of the employees and then lists the details of
-- the employees who  have a pay rate less than the average pay rate.

	SELECT * FROM HumanResources.Employee HRE
	INNER JOIN HumanResources.EmployeePayHistory HREPH
	ON HREPH.BusinessEntityID=HRE.BusinessEntityID
	WHERE HREPH.Rate<(	
						SELECT AVG(HREPH1.Rate) FROM HumanResources.EmployeePayHistory HREPH1
					  )
	GO
	--OR

	DECLARE @avg MONEY
	SET @avg=(SELECT AVG(Rate) FROM HumanResources.EmployeePayHistory)
	SELECT BusinessEntityID,rate FROM HumanResources.EmployeePayHistory
    WHERE Rate <@avg 
    GO

------------------------------------------------------------------------------------------------------------------------------------------------
--2.Create a function that returns the shipment date of a particular order
	
	DROP FUNCTION dbo.ufn_ShipmentDate
	
	CREATE FUNCTION dbo.ufn_ShipmentDate(@ORDERID INT)
	RETURNS DATE
	AS
		BEGIN
		DECLARE @ShipDate DATE
		SET	@ShipDate=(SELECT ShipDate FROM Sales.SalesOrderHeader WHERE SalesOrderID=@ORDERID)
		RETURN @ShipDate
		END	
	GO

	SELECT SSOH.SalesOrderID,
		   dbo.ufn_ShipmentDate(SSOH.SalesOrderID) 
	FROM Sales.SalesOrderHeader SSOH
	

-------------------------------------------------------------------------------------------------------------------------------------------------
--3.Create a function that returns the credit card number for a particular order.
	
	--DROP FUNCTION dbo.ufn_CreditCardNumber

	CREATE FUNCTION dbo.ufn_CreditCardNumber(@OrderID INT)
	RETURNS VARCHAR(100)
	AS
		BEGIN
		DECLARE @Cardnumber VARCHAR(100)
		SET @Cardnumber=(
							SELECT SCC.CardNumber 
							FROM Sales.SalesOrderHeader SSOH
							INNER JOIN Sales.CreditCard SCC 
							ON SSOH.CreditCardID=SCC.CreditCardID
							WHERE SSOH.SalesOrderID=@OrderID
						 )	
		RETURN @Cardnumber	
		END
	GO

	SELECT SSOH.SalesOrderID,dbo.ufn_CreditCardNumber(SSOH.SalesOrderID) AS 'CARD NUMBER'
	FROM Sales.SalesOrderHeader SSOH

	--SELECT * FROM Sales.CreditCard
--------------------------------------------------------------------------------------------------------------------------------------------------------
--4.Create a function that returns a table containing the ID and the name of the customers who are 
-- categorized as individual customer (CustomerType = ‘I’). The function should take one parameter. 
-- The parameter value can be either Shortname or Longname. If the parameter value is Shortname, 
-- only the last name of the customer will be retrieved. If the value is Longname, then the 
-- full name will be retrieved.
	
	

	CREATE TYPE dbo.Customer_Type AS TABLE(ID INT , FName  VARCHAR(50) , MName  VARCHAR(50), LName  VARCHAR(50) )
    GO

	ALTER FUNCTION ufn_GetCustomerName
	(
		@NameType VARCHAR(20),
		@Customers AS Customer_Type READONLY
     )
	RETURNS @Result TABLE(ID INT , Name  VARCHAR(150)) 
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
			  INSERT INTO @Result SELECT ID , CONCAT('.',LName) FROM @Customers 
		   END
	   END
	RETURN;
	end
	GO


	DECLARE @A AS Customer_Type
	DECLARE @NAME VARCHAR(100),@MIDDLE VARCHAR(100),@LASTNAME VARCHAR(100)
	SET @NAME=(SELECT FirstName FROM Person.Person)
	INSERT INTO @A(ID,FName,MName,LName)VALUES(1,@NAME,'LOVE','YOU') 
	SELECT * FROM dbo.ufn_GetCustomerName('LONGNAME',@A) 
	Go


--------------------------------------------------------------------------------------------------------------------------------------------------------
--5.Create a user-defined function that accepts the account number of a customer and 
--  returns the customer’s name from the Depositor  table. Further, ensure that after 
--  creating the function, 
-- user is not able to alter or drop the Depositor table
	
	DROP FUNCTION dbo.ufn_CustomerName

	CREATE FUNCTION dbo.ufn_CustomerName(@AccountNumber VARCHAR(100))
	RETURNS VARCHAR(100)
	WITH SCHEMABINDING,ENCRYPTION
	AS
	BEGIN
		DECLARE @CustName VARCHAR(100)
		IF @AccountNumber IS NOT NULL
		SET @CustName= (
							SELECT PP.FirstName FROM Person.Person PP
							INNER JOIN Sales.Customer SC
							ON SC.PersonID=PP.BusinessEntityID
							WHERE SC.AccountNumber=@AccountNumber
						)
		RETURN @CustName
		END
	GO

	SELECT AccountNumber,
		   dbo.ufn_CustomerName(AccountNumber) AS 'CUSTOMER NAME',
		   PersonID AS 'PERSON ID' FROM Sales.Customer 
		   ORDER BY PersonID DESC

	
	exec sp_helptext 'dbo.ufn_CustomerName' 
	GO

 CREATE FUNCTION fn_custtype
  (
  @nameretrival varchar(50)
  )
  RETURNS TABLE
  AS
  RETURN
  (
		(SELECT c.CustomerID,'name'=CASE @nameretrival
				when 'longname'  then COALESCE(pc.FirstName+space(1)+pc.MiddleName+SPACE(1)+pc.LastName,
					  pc.FirstName+SPACE(1)+pc.MiddleName,pc.FirstName+SPACE(1)+pc.LastName,
					  pc.MiddleName+SPACE(1)+pc.lastname,pc.FirstName,pc.MiddleName,pc.LastName) 
				when 'shortname'  then pc.LastName
				ELSE 'n/a'
	    END
				FROM Sales.Customer c
				INNER JOIN Sales.Individual i
				ON c.CustomerID=i.CustomerID
				INNER JOIN Person.Contact pc
				ON pc.ContactID=i.ContactID
				WHERE c.CustomerType='I')
   )
 GO 
