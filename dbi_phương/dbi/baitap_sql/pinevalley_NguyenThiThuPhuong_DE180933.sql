
CREATE DATABASE PineValleyCompany

USE PineValleyCompany 


CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductDescription nVARCHAR(255),
    ProductFinish nVARCHAR(255),
    ProductStandardPrice DECIMAL(10, 2)
)

CREATE TABLE ProductLine (
    ProductLineID INT PRIMARY KEY,
    ProductLineName nVARCHAR(255)
)


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName nVARCHAR(255),
    CustomerAddress nVARCHAR(255),
    CustomerPostalCode nVARCHAR(10)
)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE OrderLineItem (
    OrderID INT,
    ProductID INT,
    OrderedQuantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)

CREATE TABLE SalesTerritory (
    TerritoryID INT PRIMARY KEY,
    TerritoryName nVARCHAR(255)
)

CREATE TABLE Salesperson (
    SalespersonID INT PRIMARY KEY,
    SalespersonName nVARCHAR(255),
    SalespersonTelephone nVARCHAR(15),
    SalespersonFax nVARCHAR(15),
    TerritoryID INT,
    FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
)

CREATE TABLE RawMaterial (
    MaterialID INT PRIMARY KEY,
    UnitOfMeasure nVARCHAR(50),
    MaterialName nVARCHAR(255),
    MaterialStandardCost DECIMAL(10, 2)
)

CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY,
    VendorName nVARCHAR(255),
    VendorAddress nVARCHAR(255)
)

CREATE TABLE WorkCenter (
    WorkCenterID INT PRIMARY KEY,
    WorkCenterLocation nVARCHAR(255)
)

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName nVARCHAR(255),
    EmployeeAddress nVARCHAR(255),
    EmployeeType nVARCHAR(50),
    EmployeeManagerID INT,
    Skill nVARCHAR(255), -- Add Skill attribute
    UNIQUE (EmployeeID, EmployeeType),
    FOREIGN KEY (EmployeeManagerID) REFERENCES Employee(EmployeeID) -- Self-referential
)

CREATE TABLE Skill (
    SkillID INT PRIMARY KEY,
    SkillTitle nVARCHAR(255)
)



CREATE TABLE CustomerSalesTerritory (
    CustomerID INT,
    TerritoryID INT,
    PRIMARY KEY (CustomerID, TerritoryID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
)

CREATE TABLE ProductRawMaterial (
    ProductID INT,
    MaterialID INT,
    Quantity INT,
    PRIMARY KEY (ProductID, MaterialID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID)
)
DROP TABLE RawMaterialVendor

CREATE TABLE RawMaterialVendor (
    MaterialID INT,
    SupplierID INT,
    SupplyUnitPrice DECIMAL(10, 2),
    PRIMARY KEY (MaterialID, SupplierID),
    FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SvendorID)
)


CREATE TABLE WorkCenterEmployee (
    WorkCenterID INT,
    EmployeeID INT,
    PRIMARY KEY (WorkCenterID, EmployeeID),
    FOREIGN KEY (WorkCenterID) REFERENCES WorkCenter(WorkCenterID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)



CREATE TABLE RegularCustomer (
    CustomerID INT PRIMARY KEY,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE NationalAccount (
    CustomerID INT PRIMARY KEY,
    AccountManagerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (AccountManagerID) REFERENCES Employee(EmployeeID)
)
DROP TABLE UnionEmployee
CREATE TABLE UnionEmployee (
	UemployeeID INT PRIMARY KEY,
    EmployeeID INT ,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)
DROP TABLE ManagementEmployee
CREATE TABLE ManagementEmployee (
	MemployeeID INT PRIMARY KEY,
    EmployeeID INT ,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)
CREATE TABLE EmployeeSkill (
    EmployeeID INT,
    SkillID INT,
    PRIMARY KEY (EmployeeID, SkillID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
)
ALTER TABLE Product
ADD ProductLineID INT,
FOREIGN KEY (ProductLineID) REFERENCES ProductLine(ProductLineID)


CREATE TABLE  Supplier(
SvendorID INT,
ContractNumber NVARCHAR,
VendorID INT,
PRIMARY KEY (SvendorID),
FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
)



