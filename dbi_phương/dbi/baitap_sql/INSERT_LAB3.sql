
USE LAB3
--chèn giá trị vào các bảng
-- ProductLine table
INSERT INTO ProductLine (ProductLineID, ProductLineName)
VALUES  (1, N'Điện thoại di động')
INSERT INTO ProductLine (ProductLineID, ProductLineName)
VALUES  (2, N'Máy tính cầm tay')
INSERT INTO ProductLine (ProductLineID, ProductLineName)
VALUES  (3, N'Máy giặt')
INSERT INTO ProductLine (ProductLineID, ProductLineName)
VALUES  (4, N'Máy lọc nước')
 SELECT *FROM ProductLine
    

--  Product table
INSERT INTO Product (ProductID, ProductLineID, ProductDescription, ProductFinish, ProductStandardPrice)
VALUES(1, 1, N'Điện thoại Samsung', N'Vàng', 10000000);

INSERT INTO Product (ProductID, ProductLineID, ProductDescription, ProductFinish, ProductStandardPrice)
VALUES(2, 3, N'Máy giặt Toshiba', N'Nâu', 2000000);

INSERT INTO Product (ProductID, ProductLineID, ProductDescription, ProductFinish, ProductStandardPrice)
VALUES(3, 2, N'Máy tính Casio', N'Xanh da trời', 600000);

INSERT INTO Product (ProductID, ProductLineID, ProductDescription, ProductFinish, ProductStandardPrice)
VALUES(4, 4, N'Máy lọc nước Kangaroo', N'Đen', 6000000);

SELECT *FROM Product
--WorkCenter
INSERT INTO WorkCenter (WorkCenterID, Location)
VALUES(1, N'Xưởng sản xuất Điện thoại')
INSERT INTO WorkCenter (WorkCenterID, Location)
VALUES(2, N'Xưởng sản xuất máy tính')
INSERT INTO WorkCenter (WorkCenterID, Location)
VALUES(3, N'Xưởng sản xuất máy giặt')
INSERT INTO WorkCenter (WorkCenterID, Location)
VALUES(4, N'Xưởng sản xuất máy lọc nước')
SELECT*FROM WorKCenter

--ProductIn

INSERT INTO ProductIn (ProductID, WorkCenterID)
VALUES(1, 1)
INSERT INTO ProductIn (ProductID, WorkCenterID)
VALUES(2, 2)
INSERT INTO ProductIn (ProductID, WorkCenterID)
VALUES(3, 3)
INSERT INTO ProductIn (ProductID, WorkCenterID)
VALUES(4, 4)
SELECT*FROM ProductIn
--rawmaterial
INSERT INTO RawMaterial (MaterialID,UnitOfMeasure,MaterialName, MaterialStandardCost)
VALUES(1,4, N'Nhựa', 100000)
INSERT INTO RawMaterial (MaterialID,UnitOfMeasure, MaterialName, MaterialStandardCost)
VALUES(2,3, N'Thép', 200000)
INSERT INTO RawMaterial (MaterialID,UnitOfMeasure, MaterialName, MaterialStandardCost)
VALUES(3,2, N'Silicon', 300000)
INSERT INTO RawMaterial (MaterialID, UnitOfMeasure,MaterialName, MaterialStandardCost)
VALUES(4,1, N'Than hoạt tính', 300000)


SELECT*FROM RawMaterial
--ProductUses
INSERT INTO ProductUses (ProductID, MaterialID, GoesIntoQuantity)
VALUES(1, 3, 2)
INSERT INTO ProductUses (ProductID, MaterialID, GoesIntoQuantity)
VALUES(2, 1, 3)
INSERT INTO ProductUses (ProductID, MaterialID, GoesIntoQuantity)
VALUES(3, 2, 3)
INSERT INTO ProductUses (ProductID, MaterialID, GoesIntoQuantity)
VALUES(4, 4, 2)

SELECT*FROM ProductUses
   
--customers
INSERT INTO Customer (CustomerID, CustomersName, House_NumberCustomer, StreetCustomer, CityCustomer, CustomersPostalCode, CustomerIsRegular, CustomerIsNational)
VALUES(1, N'Thu Phương', 12, N'An Dương Vương', N'Huế', 456, N'Y', N'Y')
INSERT INTO Customer (CustomerID, CustomersName, House_NumberCustomer, StreetCustomer, CityCustomer, CustomersPostalCode, CustomerIsRegular, CustomerIsNational)
VALUES(2, N'Đăng Qúy', 23, N'Hải Châu', N'Đà Nẵng', 789, N'N', N'Y')
INSERT INTO Customer (CustomerID, CustomersName, House_NumberCustomer, StreetCustomer, CityCustomer, CustomersPostalCode, CustomerIsRegular, CustomerIsNational)
VALUES(3, N'Kim Huy', 34, N'Lê Duẫn', N'Quãng Nam', 457, N'Y', N'Y')
INSERT INTO Customer (CustomerID, CustomersName, House_NumberCustomer, StreetCustomer, CityCustomer, CustomersPostalCode, CustomerIsRegular, CustomerIsNational)
VALUES(4, N'Vĩnh Trung', 74, N'Lê Duẫn', N'Quãng Nam', 345, N'Y', N'Y')
INSERT INTO Customer (CustomerID, CustomersName, House_NumberCustomer, StreetCustomer, CityCustomer, CustomersPostalCode, CustomerIsRegular, CustomerIsNational)
VALUES(5, N'Văn Mạnh', 311, N'Lê Văn Hiến', N'Đà Nẵng', 145, N'Y', N'Y')
SELECT*FROM Customer

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES(11, 1, '11-10-2023')
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES(12, 2, '12-10-2023')
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES(13, 3, '12-10-2023')
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES(14, 4, '12-10-2023')
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES(15, 5, '12-10-2023')

SELECT*FROM Orders

INSERT INTO OrderLine (ProductID, OrderID, OrderedQuantity)
VALUES(1, 12, 2)
INSERT INTO OrderLine (ProductID, OrderID, OrderedQuantity)
VALUES(2, 13, 3)
INSERT INTO OrderLine (ProductID, OrderID, OrderedQuantity)
VALUES(3, 14, 4)
INSERT INTO OrderLine (ProductID, OrderID, OrderedQuantity)
VALUES(4, 15, 5)
INSERT INTO OrderLine (ProductID, OrderID, OrderedQuantity)
VALUES(3, 11, 4)

SELECT*FROM OrderLine
INSERT INTO NationalCustomer (nCustomerID)
VALUES (1);

--  RegularCustomer
INSERT INTO RegularCustomer (rCustomerID)
VALUES (1)
INSERT INTO RegularCustomer (rCustomerID)
VALUES (3)
INSERT INTO RegularCustomer (rCustomerID)
VALUES (4)
INSERT INTO RegularCustomer (rCustomerID)
VALUES (5)

SELECT *FROM RegularCustomer
--NationalCustomer
INSERT INTO NationalCustomer (nCustomerID)
VALUES (1)
INSERT INTO NationalCustomer (nCustomerID)
VALUES (2)
INSERT INTO NationalCustomer (nCustomerID)
VALUES (3)
INSERT INTO NationalCustomer (nCustomerID)
VALUES (4)
INSERT INTO NationalCustomer (nCustomerID)
VALUES (5)
SELECT*FROM NationalCustomer
--SaleTeritory
INSERT INTO SaleTerritory (SaleTerritoryID, SaleTerritoryName)
VALUES(1, N'miền Bắc')
INSERT INTO SaleTerritory (SaleTerritoryID, SaleTerritoryName)
VALUES(2, N'miền Trung')
INSERT INTO SaleTerritory (SaleTerritoryID, SaleTerritoryName)
VALUES(3, N'miền Nam')
INSERT INTO SaleTerritory (SaleTerritoryID, SaleTerritoryName)
VALUES(4, N'nước ngoài')

SELECT *FROM SaleTerritory
--  DoBussinessIn 
INSERT INTO DoBussinessIn (SaleTerritoryID, rCustomerID)
VALUES(4, 1)
INSERT INTO DoBussinessIn (SaleTerritoryID, rCustomerID)
VALUES(2, 3)
INSERT INTO DoBussinessIn (SaleTerritoryID, rCustomerID)
VALUES(1, 4)
INSERT INTO DoBussinessIn (SaleTerritoryID, rCustomerID)
VALUES(3, 5)
SELECT*FROM DoBussinessIn

--  SalePersons 
INSERT INTO SalePersons (SaleID, SaleTerritoryID, SaleName, SaleFax, PhoneNumber)
VALUES(20, 1, N'Minh Trang', '555-1234','123-456-7890' )
INSERT INTO SalePersons (SaleID, SaleTerritoryID, SaleName, SaleFax, PhoneNumber)
VALUES(22, 2, N'Hà Anh', '555-1345', '123-456-987')
INSERT INTO SalePersons (SaleID, SaleTerritoryID, SaleName, SaleFax, PhoneNumber)
VALUES(18, 4, N'Bảo Anh', '555-1444','123-456-143')
INSERT INTO SalePersons (SaleID, SaleTerritoryID, SaleName, SaleFax, PhoneNumber)
VALUES(26, 3, N'Hà Thu', '555-2334', '123-456-765')

SELECT*FROM SalePersons
--Emplloyee
INSERT INTO Employee (EmployeeID, EmployeeName, House_NumberEmployee, StreetEmployee, CityEmployee, EmployeeType)
VALUES(1, N'Thanh Xuân', '11', N'Lê Duẫn', N'Đà nẵng', 'M')
INSERT INTO Employee (EmployeeID, EmployeeName, House_NumberEmployee, StreetEmployee, CityEmployee, EmployeeType)
VALUES(2, N'Thanh Hạ', '43', N'Ngũ Hành Sơn', N'Đà nẵng', 'U')
INSERT INTO Employee (EmployeeID, EmployeeName, House_NumberEmployee, StreetEmployee, CityEmployee, EmployeeType)
VALUES(3, N'Thanh Thu', '23', N'Nguyễn Tất Thành', N'Đà nẵng', 'M')


SELECT*FROM Employee

--Skills
INSERT INTO Skill (SkillID, SkillName, Descriptions)
VALUEs(1, N'Tiếng Anh', N'Giao tiếp hiệu quả')
INSERT INTO Skill (SkillID, SkillName, Descriptions)
VALUEs(2, N'Quản lý thời gian', N'Đẩy nhanh tiến độ')
INSERT INTO Skill (SkillID, SkillName, Descriptions)
VALUEs(3, N'Phân tích dữ liệu', N'Nghiên cứu thị trường')

SELECT *FROM Skill

--  EmployeeHasSkill
INSERT INTO EmployeeHasSkill (EmployeeID, SkillID)
VALUES (1, 3)
INSERT INTO EmployeeHasSkill (EmployeeID, SkillID)
VALUES (2, 2)
INSERT INTO EmployeeHasSkill (EmployeeID, SkillID)
VALUES (3, 1);
SELECT*FROM EmployeeHasSkill
-- unionE
INSERT INTO unionE (uEID)
VALUES (2)
SELECT*FROM unionE
-- managementE
INSERT INTO managementE (mEID)
VALUES (1)
INSERT INTO managementE (mEID)
VALUES (3)
SELECT*FROM managementE
--  WorkIn
INSERT INTO WorkIn (WorkCenterID, uEID)
VALUES (1, 2)
SELECT*FROM WorkIn
--Vendor
INSERT INTO Vendor (VendorID, VendorName, VendorHouse_Number, VendorStreet, VendorCity)
VALUES (1, N'An Mobile', 123, N'Ngô Gia Tự', N'Hà Nội');
INSERT INTO Vendor (VendorID, VendorName, VendorHouse_Number, VendorStreet, VendorCity)
VALUES (2, N'Minh Materials', 789, N'Phan Đình Phùng', N'Hà Nội');
INSERT INTO Vendor (VendorID, VendorName, VendorHouse_Number, VendorStreet, VendorCity)
VALUES (3, N'SE Water Solutions', 101, N'Bạch Đằng', N'Đà Nẵng');
INSERT INTO Vendor (VendorID, VendorName, VendorHouse_Number, VendorStreet, VendorCity)
VALUES (4, N'AI Components', 456, N'Điện Biên Phủ', N'Hồ Chí Minh');
SELECT*FROM Vendor



-- Suppiled
INSERT INTO Suppiled (MaterialID, VendorID, SuppliesUnitPrice)
VALUES (1, 2, 80000.00)
INSERT INTO Suppiled (MaterialID, VendorID, SuppliesUnitPrice)
VALUES (2, 4, 150000.00)
INSERT INTO Suppiled (MaterialID, VendorID, SuppliesUnitPrice)
VALUES (3, 1, 250000.00)
INSERT INTO Suppiled (MaterialID, VendorID, SuppliesUnitPrice)
VALUES (4, 3, 250000.00)

SELECT*FROM Suppiled





   
   







    