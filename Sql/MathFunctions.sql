
--ABS
-- A mathematical function that returns the absolute (positive) value of the specified numeric expression. 
--(ABS changes negative values to positive values. ABS has no effect on zero or positive values.)

SELECT ABS(-1.0), ABS(0.0), ABS(1.0);  

DECLARE @i INT;  
SET @i = -214748364;  
SELECT ABS(@i);  
GO
--------------------------------------------------------------------------------------------------------------------------------------
--ACOS
--A function that returns the angle, in radians, whose cosine is the specified float expression. This is also called arccosine.

SET NOCOUNT OFF;  
DECLARE @cos FLOAT;  
SET @cos = -1.0;  
SELECT 'The ACOS of the number is: ' + CONVERT(VARCHAR, ACOS(@cos)); 
--------------------------------------------------------------------------------------------------------------------------------------
--ASIN
--A function that returns the angle, in radians, whose sine is the specified float expression. This is also called arcsine.

DECLARE @angle FLOAT  
SET @angle = -1.01  
SELECT 'The ASIN of the angle is: ' + CONVERT(VARCHAR, ASIN(@angle))  
GO  
  
DECLARE @angle FLOAT  
SET @angle = -1.00  
SELECT 'The ASIN of the angle is: ' + CONVERT(VARCHAR, ASIN(@angle))  
GO  
    
DECLARE @angle FLOAT  
SET @angle = 0.1472738  
SELECT 'The ASIN of the angle is: ' + CONVERT(VARCHAR, ASIN(@angle))  
GO
--------------------------------------------------------------------------------------------------------------------------------------
--Tan
--A function that returns the angle, in radians, whose tangent is a specified float expression. This is also called arctangent.
SELECT 'The ATAN of -45.01 is: ' + CONVERT(varchar, ATAN(-45.01))  
SELECT 'The ATAN of -181.01 is: ' + CONVERT(varchar, ATAN(-181.01))  
SELECT 'The ATAN of 0 is: ' + CONVERT(varchar, ATAN(0))  
SELECT 'The ATAN of 0.1472738 is: ' + CONVERT(varchar, ATAN(0.1472738))  
SELECT 'The ATAN of 197.1099392 is: ' + CONVERT(varchar, ATAN(197.1099392))  
GO
  
--------------------------------------------------------------------------------------------------------------------------------------
--CEILING 
--This function returns the smallest integer greater than, or equal to, the specified numeric expression.

SELECT CEILING($123.45), CEILING($-123.45), CEILING($0.0);  
GO  
		--124.00		-123.00				0.00
--------------------------------------------------------------------------------------------------------------------------------------
--cos
--A mathematical function that returns the trigonometric cosine of the specified angle 
-- measured in radians - in the specified expression.

DECLARE @angle FLOAT;  
SET @angle = 14.78;  
SELECT 'The COS of the angle is: ' + CONVERT(VARCHAR,COS(@angle));  
GO  

--The COS of the angle is: -0.599465
--------------------------------------------------------------------------------------------------------------------------------------
--DEGREES
--This function returns the corresponding angle, in degrees, for an angle specified in radians.

SELECT 'The number of degrees in PI/2 radians is: '+CONVERT(VARCHAR, DEGREES((PI()/2)));  
GO 
--The number of degrees in PI/2 radians is: 90

--------------------------------------------------------------------------------------------------------------------------------------
--FLOOR 
--Returns the largest integer less than or equal to the specified numeric expression.
SELECT FLOOR(123.45), FLOOR(-123.45), FLOOR($123.45);  
       --123	     -124	          123.00

SELECT FLOOR(123.45), FLOOR(-123.45), FLOOR($123.45);  
	   --123		 -124			   123.00
--------------------------------------------------------------------------------------------------------------------------------------
--PI
select PI()
--3.14159265358979
--------------------------------------------------------------------------------------------------------------------------------------
--POWER 
--Returns the value of the specified expression to the specified power.
select POWER(2,3)
--8
--------------------------------------------------------------------------------------------------------------------------------------

--RAND
--Returns a pseudo-random float value from 0 through 1, exclusive.
	SELECT RAND(100), RAND(), RAND()    
	--0.715436657367485	0.28463380767982	0.0131039082850364

	DECLARE @counter SMALLINT;  
	SET @counter = 1;  
	WHILE @counter < 2
	BEGIN  
		  SELECT RAND() Random_Number  
		  SET @counter = @counter + 1  
	END;  
	GO  
	--0.640534425849198

--------------------------------------------------------------------------------------------------------------------------------------

--ROUND 
--Returns a numeric value, rounded to the specified length or precision.
SELECT ROUND(123.9994, -2), ROUND(123.9995, 3);  
GO  
--     100.0000	                124.0000

SELECT ROUND(123.4545, 2), ROUND(123.45, -2);  
--	   123.4500	                100.00


SELECT ROUND(150.75, 0);  
GO  
--151.00

SELECT ROUND(150.75, 0, 1);  
GO 
--150.00
--------------------------------------------------------------------------------------------------------------------------------------

--SIGN 
--Returns the positive (+1), zero (0), or negative (-1) sign of the specified expression.

SELECT SIGN(-125), SIGN(0), SIGN(564);  
--		1			0			1
--------------------------------------------------------------------------------------------------------------------------------------

--SQRT
--Returns the square root of the specified float value.
SELECT SQRT(1.00),SQRT(9), SQRT(10.00);  
--       1	        3	    3.16227766016838

--------------------------------------------------------------------------------------------------------------------------------------
--SQUARE
--Returns the square of the specified float value.

DECLARE @val INT
DECLARE @counts INT
set @counts=0
WHILE @counts<5
BEGIN
	SELECT SQUARE(@counts)
	SET @counts=@counts+1;
END
GO

select SQUARE(3) 
--9

--------------------------------------------------------------------------------------------------------------------------------------