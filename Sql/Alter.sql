-- ALTER
--1. Existing Table without records 

-- ADD A COLUMN

ALTER TABLE MA_Country_bkp 
ADD Remarks VARCHAR(100)


ALTER TABLE MA_Country_bkp 
ADD Remarks1 VARCHAR(100) ,Remarks2 VARCHAR(100)
 
-- DROP A COLUMN

ALTER TABLE MA_Country_bkp 
DROP COLUMN XYZ


ALTER TABLE MA_Country_bkp 
DROP COLUMN Remarks1 ,Remarks2

-- ADD A COLUMN CONSTRIANT
ALTER TABLE MA_Country_bkp 
ADD CONSTRAINT PK_MA_Country_bkp_CountryIC PRIMARY KEY(CountryIC),
GO



ALTER TABLE MA_Country_bkp 
ADD CONSTRAINT PK_MA_Country_bkp_CountryIC PRIMARY KEY(CountryIC),
	CONSTRAINT UQ_MA_Country_bkp_Name UNIQUE(Name)
GO
 
-- drop A COLUMN CONSTRIANT
ALTER TABLE MA_Country_bkp 
DROP CONSTRAINT PK_MA_Country_bkp_CountryIC



ALTER TABLE MA_Country_bkp 
DROP CONSTRAINT PK_MA_Country_bkp_CountryIC, 
				UQ_MA_Country_bkp_Name 


-- ALTER A COLUMN CHNAGE SIZE
ALTER TABLE MA_Country_bkp 
ALTER COLUMN Remarks VARCHAR(50)


-- ALTER A COLUMN CHNAGE DATA TYPE
ALTER TABLE MA_Country_bkp 
ALTER COLUMN ModifiedDate DATE NOT NULL


--2. Existing Table with records
ALTER TABLE MA_Country WITH CHECK
ADD CONSTRAINT UQ_MA_Country_Name UNIQUE(Name)
GO
