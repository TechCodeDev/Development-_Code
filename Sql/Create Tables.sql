CREATE DATABASE CRMS_DB_Dev
GO

USE CRMS_DB_Dev
GO

CREATE SCHEMA crms
GO

CREATE TABLE [crms].[Ma_Country]  
(
	CountryID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	IsActive BIT  CONSTRAINT DF_Ma_Country_IsActive DEFAULT 1,
	[RowGUID] VARCHAR(50) CONSTRAINT DF_Ma_Country_RowGUID DEFAULT NEWID(),
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_Country_CountryID PRIMARY KEY(CountryID,Name),
	CONSTRAINT UQ_Ma_Country_Name UNIQUE(Name)
)
GO

EXEC sp_help [crms.Ma_Country]  
INSERT INTO [crms].[Ma_Country](Name) VALUES('India') 
SELECT * FROM [crms].[Ma_Country] 



CREATE TABLE [crms].[Ma_State]  
(
	StateID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	CountryID INT NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_State_IsActive DEFAULT 1,
	[RowGUID] VARCHAR(50) CONSTRAINT DF_Ma_State_RowGUID DEFAULT NEWID(),
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_State_StateID PRIMARY KEY(StateID),
	CONSTRAINT FK_Ma_State_CountryID_Ma_Country_CountryID FOREIGN KEY(CountryID) 
														  REFERENCES [crms].[Ma_Country](CountryID),
	CONSTRAINT UQ_Ma_State_Name UNIQUE(Name)
)
GO

EXEC sp_help [crms.Ma_State]  
INSERT INTO [crms].[Ma_State](Name , CountryID) VALUES('Karnataka',1) 
INSERT INTO [crms].[Ma_State](Name , CountryID) VALUES('Test1',0) 
SELECT * FROM [crms].[Ma_State] 

CREATE TABLE [crms].[Ma_City]  
(
	CityID INT IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL,
	StateID INT NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_City_IsActive DEFAULT 1,
	RowGUID UNIQUEIDENTIFIER CONSTRAINT DF_Ma_City_RowGIUD DEFAULT NEWID() ROWGUIDCOL,
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_City_CityID PRIMARY KEY(CityID),
	CONSTRAINT FK_Ma_City_StateID_Ma_State_StateID FOREIGN KEY(StateID) 
														  REFERENCES [crms].[Ma_State](StateID),
	CONSTRAINT UQ_Ma_City_Name UNIQUE(Name)
)
GO


EXEC sp_help [crms.Ma_City]  

SELECT * FROM [crms].[Ma_City] 

CREATE TABLE [crms].[Ma_Vehicles]  
(
	VehiclesID INT,
	VehiclesType VARCHAR(50) NOT NULL,
	Name VARCHAR(50) NOT NULL,
	FuelType VARCHAR(50) NOT NULL,  
	TransmissionType VARCHAR(50) NOT NULL,  
	SeatingCapacity TINYINT NOT NULL,
	PermitType VARCHAR(50) NOT NULL,  
	IsActive BIT  CONSTRAINT DF_Ma_Vehicles_IsActive DEFAULT 1,
	RowGUID UNIQUEIDENTIFIER CONSTRAINT DF_Ma_Vehicles_RowGIUD DEFAULT NEWID() ROWGUIDCOL,
	Remarks VARCHAR(100) NULL
	
	CONSTRAINT PK_Ma_Vehicles_VehiclesID PRIMARY KEY(VehiclesID),
	CONSTRAINT CK_Ma_Vehicles_VehiclesType CHECK(VehiclesType IN('Scooter','Car')),
	CONSTRAINT CK_Ma_Vehicles_FuelType CHECK(FuelType IN('Petrol','Diesel','Electric')),
	CONSTRAINT CK_Ma_Vehicles_TransmissionType CHECK(TransmissionType IN('Manuel','Automatics')),
	CONSTRAINT CK_Ma_Vehicles_PermitType CHECK(PermitType IN('State','National')),
	CONSTRAINT CK_Ma_Vehicles_SeatingCapacity CHECK(SeatingCapacity IN(2,5,7)),
	)
GO

insert into crms.Ma_Vehicles(VehiclesID,VehiclesType,Name,FuelType,TransmissionType,SeatingCapacity,PermitType)
values(1,'Car','Datsun','Petrol','Manuel',5,'National')

insert into crms.Ma_Vehicles(VehiclesID,VehiclesType,Name,FuelType,TransmissionType,SeatingCapacity,PermitType)
values(2,'Car','BMW','Diesel','Automatics',7,'National'),
	  (3,'Car','BMW','Diesel','Automatics',7,'National'),
	  (4,'Car','BMW','Diesel','Automatics',7,'National')

select * from crms.Ma_Vehicles
