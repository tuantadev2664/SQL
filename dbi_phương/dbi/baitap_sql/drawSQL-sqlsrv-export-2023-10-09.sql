CREATE DATABASE PINE_VALLEY
USE PINE_VALLEY
DROP TABLE Product
CREATE TABLE Product(
ProductID int,
productName nvarchar(50) not null,
productFinish nvarchar(100),
productStandardPrice  decimal(6,2),
CONSTRAINT PK_PRODUCT Primary key (productID)
)
CREATE TABLE Territory(
TerritoryID int,
TerritoryName nvarchar(50)
CONSTRAINT PK_TERRITORY Primary key(TerritoryID)
)
CREATE TABLE ProductLine(
ProductLineID int ,
productLineName nvarchar(50) not null
CONSTRAINT PK_PRODUCTLINE Primary key(productLineID)
)
CREATE TABLE SalesPerson(
SalesPersonID int,
SalesPersonName nvarchar(50),
SalesPersonTelephone nvarchar(50),
SalespersonFax nvarchar(50),
CONSTRAINT PK_SALESPERSON Primary key(SalespersonID)
)
CREATE TABLE Customer(
CustomerID int,
CustomeName nvarchar(100),
CustomerAddress nvarchar(200),
CustomerPostCode nvarchar(100),
CONSTRAINT PK_CUSTOMER Primary key(CustomerID)
)
CREATE TABLE Orders (
    OrderID INT,
    OrderDate DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY (OrderID)
);
CREATE TABLE WorkCenter(
	CenterID INT,
	Locations nvarchar,
	CONSTRAINT PK_WORKCENTER Primary key (CenterID)
	)
CREATE TABLE Employees(
	EmployeeID INT,
	EmployeeName nvarchar(200),
	EmployeeAddress nvarchar(200),
	EmployeeType nvarchar(100),
	CONSTRAINT PK_EMPLOYEES Primary key (EmployeeID)
	)
CREATE TABLE Skills(
SkillID INT,
SkillName nvarchar(200),
Descriptions nvarchar(300)
CONSTRAINT PK_SKILLS Primary key(SkillID)
)
CREATE TABLE Vendors(
VendorID INT,
VendorName nvarchar(200),
VendorAddress nvarchar(200),
CONSTRAINT PK_VENDOR Primary key(VendorID)
)
CREATE TABLE Raw_Material(
MaterialID int,
UnitOfMeasure nvarchar(200),
MaterialName nvarchar(200),
MaterialStandard nvarchar(200),
CONSTRAINT PK_RAWMATERIAL Primary key (MaterialID)
)
ALTER TABLE ProductLine ADD  CONSTRAINT UK_Product_Name Unique(productLineName)

ALTER TABLE Product 
ADD  ProductLineID INT NOT NULL

ALTER TABLE Product
ADD CONSTRAINT FK_ProductProductLine FOREIGN KEY (ProductLineID) REFERENCES ProductLine(ProductLineID)

ALTER TABLE SalesPerson 
ADD TerritoryID INT NOT NULL

AlTER TABLE SalesPerson 
ADD CONSTRAINT FK_SalePersonTerritory FOREIGN KEY(TerritoryID) REFERENCES Territory(TerritoryID)

CREATE TABLE Product_WorkCenter(
ProductID INT ,
WorkCenterID int,
CONSTRAINT PK_Productr_WorkerCenter primary key (ProductID,WorkCenterID) 
)
CREATE TABLE 











