Create database LAB3
use LAB3

--Bảng lưu trữ thông tin về các dòng sản phẩm
CREATE TABLE ProductLine(
ProductLineID int,
ProductLineName nvarchar(50) NOT NULL,
constraint PK_ProductLine PRIMARY KEY(ProductLineID)
)
-- Bảng lưu trữ thông tin về các sản phẩm
CREATE TABLE Product(
ProductID int,
ProductLineID int NOT NULL,
ProductDescription nvarchar(50) NOT NULL,
ProductFinish nvarchar(50),
ProductStandardPrice decimal(6,2),
constraint PK_Product PRIMARY KEY(ProductID),
constraint FK_Product_ProductLine FOREIGN KEY(ProductLineID) References ProductLine(ProductLineID) ON UPDATE CASCADE
)

-- Bảng lưu trữ thông tin về trung tâm sản xuất
CREATE TABLE WorKCenter(
WorkCenterID int,
constraint PK_WorKCenter PRIMARY KEY(WorkCenterID),
Location nvarchar(50),
)
-- Bảng liên kết sản phẩm và trung tâm sản xuất
CREATE TABLE ProductIn(
ProductID int NOT NULL,
WorkCenterID int NOT NULL,
constraint PK_ProductIn PRIMARY KEY(ProductID,WorkCenterID),
constraint FK_ProductIn_Product FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON UPDATE CASCADE,
constraint FK_ProductIn_WorkCenter FOREIGN KEY(WorkCenterID) REFERENCES WorkCenter(WorkCenterID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về nguyên vật liệu
CREATE TABLE RawMaterial(
MaterialID int,
UnitOfMeasure int,
MaterialName nvarchar(50) NOT NULL,
MaterialStandardCost decimal(6,2),
constraint PK_RawMaterial PRIMARY KEY(MaterialID) 
)
-- Bảng liên kết sản phẩm và nguyên vật liệu
CREATE TABLE ProductUses(
ProductID int NOT NULL,
MaterialID int NOT NULL,
GoesIntoQuantity int,
constraint PK_ProductUses PRIMARY KEY(ProductID,MaterialID),
constraint FK_ProductUses_Product FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON UPDATE CASCADE,
constraint FK_ProductUses_RawMaterial FOREIGN KEY(MaterialID) REFERENCES RawMaterial(MaterialID) ON UPDATE CASCADE,
)
-- Bảng lưu trữ thông tin về khách hàng
CREATE TABLE Customer(
CustomerID int,
CustomersName nvarchar(50) NOT NULL,
House_NumberCustomer int,
StreetCustomer nvarchar(50),
CityCustomer nvarchar(50),
CustomersPostalCode int not null,
CustomerIsRegular nvarchar(50) NOT NULL,
CustomerIsNational nvarchar(50) NOT NULL,
constraint PK_Customer PRIMARY KEY(CustomerID),
constraint CK_CustomerType check(CustomerIsRegular in ('N','Y') AND CustomerIsNational in('N','Y'))
)
-- Bảng lưu trữ thông tin về đơn hàng
CREATE TABLE Orders (
OrderID int,
CustomerID int NOT NULL,
OrderDate date,
constraint PK_Order PRIMARY KEY(OrderID),
constraint FK_Orders_Customer FOREIGN KEY(CustomerID) References Customer(CustomerID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về dòng sản phẩm trong đơn hàng
CREATE TABLE OrderLine(
ProductID int NOT NULL,
OrderID int NOT NULL,
OrderedQuantity int,
constraint PK_OrderLine PRIMARY KEY(ProductID,OrderID),
constraint FK_OrderLine_Product FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON UPDATE CASCADE,
constraint FK_OrderLine_Orders FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về khách hàng loại "National Account"
CREATE TABLE NationalCustomer(
nCustomerID int,
CONSTRAINT PK_NationalCustomer PRIMARY KEY(nCustomerID),
CONSTRAINT FK_NationalCustomer_Customer FOREIGN KEY (nCustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về khách hàng loại "Regular"
CREATE TABLE RegularCustomer(
rCustomerID int,
CONSTRAINT PK_RegularCustomer PRIMARY KEY(rCustomerID),
CONSTRAINT FK_RegularCustomer_Customer FOREIGN KEY (rCustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về lãnh đạo kinh doanh
CREATE TABLE SaleTerritory(
SaleTerritoryID int,
SaleTerritoryName nvarchar(50) NOT NULL,
constraint PK_SaleTerritory PRIMARY KEY(SaleTerritoryID)
)
-- Bảng liên kết khách hàng regular và lãnh đạo kinh doanh
CREATE TABLE DoBussinessIn(
SaleTerritoryID int NOT NULL,
rCustomerID int NOT NULL,
constraint PK_DoBussinessIn PRIMARY KEY(SaleTerritoryID,rCustomerID),
constraint FK_DoBussinessIn_SaleTerritory FOREIGN KEY(SaleTerritoryID) REFERENCES SaleTerritory(SaleTerritoryID) ON UPDATE CASCADE,
constraint FK_DoBussinessIn_RegularCustomer FOREIGN KEY(rCustomerID) REFERENCES RegularCustomer(rCustomerID) ON UPDATE CASCADE,
)
-- Bảng lưu trữ thông tin về nhân viên bán hàng
CREATE TABLE SalePersons(
SaleID int,
SaleTerritoryID int NOT NULL,
SaleName nvarchar(50) NOT NULL,
SaleFax nvarchar(50) NOT NULL,
PhoneNumber varchar(50),
constraint PK_SalePersons PRIMARY KEY(SaleID),
constraint FK_SalePersons_SaleTerritory FOREIGN KEY(SaleTerritoryID) REFERENCES SaleTerritory(SaleTerritoryID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về nhân viên
CREATE TABLE Employee(
EmployeeID int,
EmployeeName nvarchar(50) NOT NULL,
House_NumberEmployee nvarchar(50),
StreetEmployee nvarchar(50),
CityEmployee nvarchar(50),
EmployeeType nvarchar(50) NOT NULL,
constraint PK_Employee PRIMARY KEY(EmployeeID),
constraint CK_EmployeeType check(EmployeeType in ('M','U'))
)
-- Bảng lưu trữ thông tin về kỹ năng
CREATE TABLE Skill(
SkillID int,
SkillName nvarchar(50) NOT NULL,
Descriptions nvarchar(50),
constraint PK_Skill PRIMARY KEY(SkillID)
)
-- Bảng liên kết nhân viên và kỹ năng
CREATE TABLE EmployeeHasSkill(
EmployeeID int NOT NULL,
SkillID int NOT NULL,
constraint PK_EmployeeSkill PRIMARY KEY(EmployeeID,SkillID),
CONSTRAINT FK_EmployeeSkill_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON UPDATE CASCADE,
CONSTRAINT FK_EmployeeSkill_Skill FOREIGN KEY (SkillID) REFERENCES Skill(SkillID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về nhân viên loại "Union"
CREATE TABLE unionE(
uEID int,
CONSTRAINT PK_unionE PRIMARY KEY(uEID),
CONSTRAINT FK_unionE_Employee FOREIGN KEY (uEID) REFERENCES Employee(employeeID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về nhân viên loại "Management"
CREATE TABLE managementE(
mEID int,
CONSTRAINT PK_managementE PRIMARY KEY(mEID),
CONSTRAINT FK_managementE_Employee FOREIGN KEY (mEID) REFERENCES Employee(employeeID) ON UPDATE CASCADE
)
-- Bảng liên kết nhân viên loại Union và trung tâm sản xuất
CREATE TABLE WorkIn(
WorkCenterID int NOT NULL,
uEID int NOT NULL,
constraint PK_WorkIn PRIMARY KEY(WorkCenterID,uEID),
constraint FK_WorkIn_WorkCenter FOREIGN KEY(WorkCenterID) REFERENCES WorkCenter(WorkCenterID) ON UPDATE CASCADE,
constraint FK_WorkIn_unionE FOREIGN KEY(uEID) REFERENCES unionE(uEID) ON UPDATE CASCADE
)
-- Bảng lưu trữ thông tin về nhà cung cấp
CREATE TABLE Vendor(
VendorID int,
VendorName nvarchar(50) NOT NULL,
VendorHouse_Number int,
VendorStreet nvarchar(50),
VendorCity nvarchar(50),
constraint PK_Vendor PRIMARY KEY(VendorID)
)
-- Bảng liên kết nguyên vật liệu và nhà cung cấp
CREATE TABLE Suppiled(
MaterialID int NOT NULL,
VendorID int NOT NULL,
SuppliesUnitPrice   DECIMAL(6,2) ,  
constraint PK_Suppiled PRIMARY KEY(MaterialID,VendorID),
constraint FK_Suppiled_RawMateSSrial FOREIGN KEY(MaterialID) REFERENCES RawMaterial(MaterialID) ON UPDATE CASCADE,
constraint FK_Suppiled_Supplier FOREIGN KEY(VendorID) REFERENCES Vendor(VendorID) ON UPDATE CASCADE
)
ALTER TABLE Product
ALTER COLUMN ProductStandardPrice DECIMAL(10, 2);

ALTER TABLE  RawMaterial
ALTER COLUMN MaterialStandardCost DECIMAL(10, 2);

ALTER TABLE  Suppiled
ALTER COLUMN SuppliesUnitPrice DECIMAL(10, 2);