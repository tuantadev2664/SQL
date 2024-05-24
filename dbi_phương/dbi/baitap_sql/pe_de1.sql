-- phun
--part 1
--STEP 1: MAPPING REGULAR ENTITY TYPES

--Scientist(sid*,fName,LName,country)
--invention(iid*,Iname,Year)
--RAREA(sid*,rarea*)
--STEP 2: MAPPING OF WEAK ENTITY TYPES

--STEP 3: MAPPING OF BINARY 1:1 RELATION TYPES

--STEP 4: MAPPING OF BINARY 1:N RELAYION TYPES

--STEP 5: MAPPING OF BINARY M:N RELATIONSHIP TYPES
--scientis_invention(SID*,IID*,SnAM,RAREA,COUNTRY)

--STEP 6: MAPPING OF MULTIVATED ATRRIBUTES
--S_RAREA(sid*,Sarea*)
--STEP 7: MAPPING OF N-ARY RELATIONSHIP TYPES

--the result of convert ERD TO RM IS:
--Scientist(sid*,fName,LName,country)
--invention(iid*,Iname,Year)
--RAREA(sid*,rarea*)
--scientis_invention(SID*,IID*,SnAM,RAREA,COUNTRY)
--PART 2
create database Ordersystem
use Ordersystem
drop table Customer
CREATE TABLE Customer(
	CustomerID INT NOT NULL IDENTITY  (1,1),
	LastName nvarchar(50),
	firstName nvarchar(100),
	Phone nvarchar(15),
	Address nvarchar(100),
	City nvarchar(50),
	Country nvarchar(50)
	CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)
)
CREATE TABLE Product(
	ProductCode INT NOT NULL IDENTITY (1,1),
	Name nvarchar(100),
	Scale nvarchar(50),
	Vendor varchar(100),
	Description varchar(50),
	BuyPrice decimal(10,2),
	Inventory int 
	CONSTRAINT PK_Product PRIMARY KEY(ProductCode)
	)
	drop table Orders
	alter table Orders
	alter table  OrderDetails
	drop  FK_OrderDetails_orders 
	drop   FK_Orders_Customers 
CREATE TABLE Orders(
  OrderID int iDENTITY,
  CustomerID int,
  OrderDate date,
  RequiredDate date,
  ShippedDate date,
  status nvarchar(50),
  comment nvarchar(100)
  CONSTRAINT PK_Orders PRIMARY KEY(OrderID)
  
  CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)
CREATE TABLE OrderDetails (
  OrderID int,
  ProductCode int,
  Quantity int,
  Price decimal(10,2),
  CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductCode),
  
  CONSTRAINT FK_OrderDetails_Product FOREIGN KEY (ProductCode) REFERENCES Product(ProductCode)
);
alter table OrderDetails
add CONSTRAINT FK_OrderDetails_orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

INSERT INTO Customer (LastName, FirstName, Phone, Address, City, Country)
VALUES (N'Nguyễn', N'Thu Phương', N'123-456-7890', N'43 Ngũ Hành Sơn', N'Đà Nẵng', N'Việt Nam');

INSERT INTO Customer (LastName, FirstName, Phone, Address, City, Country)
VALUES (N'Ngô', N'Lan Anh ', N'987-654-3210', N'44 An Thuwojng', N'Đà Nẵng', N'Việt Nam');

INSERT INTO Product (Name, Scale, Vendor, Description, BuyPrice, Inventory)
VALUES (N'Máy tính', N'Small', N'DELL', N'yellow', 1000000.99, 100);

INSERT INTO Product (Name, Scale, Vendor, Description, BuyPrice, Inventory)
VALUES (N'TV',N'Large', N'HP', N'white', 15.99, 50);


INSERT INTO Orders (CustomerID, OrderDate, RequiredDate, ShippedDate, Status, Comment)
VALUES (1, '2023-11-03', '2023-11-10', '2023-11-08', N'Shipped', N'Order comment 1');

INSERT INTO Orders (CustomerID, OrderDate, RequiredDate, ShippedDate, Status, Comment)
VALUES (2, '2023-11-04', '2023-11-11', '2023-11-09', N'Shipped', N'Order comment 2');
--Thêm dữ liệu đơn hàng khác nếu cần

INSERT INTO OrderDetails (OrderID, ProductCode, Quantity, Price)
VALUES (1, 1, 5, 54.95);

INSERT INTO OrderDetails (OrderID, ProductCode, Quantity, Price)
VALUES (1, 2, 3, 47.97);
--Thêm dữ liệu chi tiết đơn hàng khác nếu cần

select* from Orders
select* from Customer
select* from OrderDetails
select *from Product

--2.. Create constraint for table OrderDetail whose Qty is always greater than 0 (0.5 point)

ALTER TABLE OrderDetails
ADD CONSTRAINT CHK_Quantity_GT_0 CHECK (Quantity > 0);

--3.Write SQL commands that do the following: (4.0 point) 
--a. Display customers in Da Nang, including IDcustomer, Firstname, Lastname, Phone, 
--Address

SELECT CustomerID,firstName,LastName,Phone,Address FROM Customer where City=N'Đà Nẵng'

--b. Calculate the amount of each order with Total = Quantity * Price
SELECT  od.OrderID,SUM(Quantity*Price) AS 'Total' FROM OrderDetails od group by od.OrderID

--. Create a view to store the best-selling items in June. If the number is the same, 
--show all

go
CREATE VIEW BestsellingIteminJune AS
SELECT
    P.ProductCode,
    P.Name,
    SUM(Od.Quantity) AS TotalQuantity
FROM
    Product P
JOIN
    OrderDetails Od ON P.ProductCode = Od.ProductCode
JOIN
    Orders O ON Od.OrderID = O.OrderID
WHERE
    MONTH(O.OrderDate) = 11
GROUP BY
    P.ProductCode, P.Name;

--DROP VIEW BestsellingIteminJune;
--chạy câu lệnh view
Select * from dbo.BestsellingIteminJune

SELECT TOP 1
    Productcode,
    Name,
    TotalQuantity
FROM
    dbo.BestsellingIteminJune
ORDER BY
    TotalQuantity DESC;

	--cach 2
	SELECT
    ProductCode,
    Name,
    TotalQuantity
FROM
    dbo.BestsellingIteminJune
WHERE
    TotalQuantity = (SELECT MAX(TotalQuantity) FROM dbo.BestsellingIteminJune);

	

--Display details of each order with a total amount >500 including the following 
--information: Order1.orderID, Customerid,RequiredDate,ShippedDate, amount
SELECT
    O.OrderID,
    O.CustomerID,
    O.RequiredDate,
    O.ShippedDate,
    SUM(OD.Quantity * od.Price) AS Amount
FROM
    Orders O
JOIN
    OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY
    O.OrderID, O.CustomerID, O.RequiredDate, O.ShippedDate
HAVING
    SUM(OD.Quantity * od.Price) > 50;

	---


---Write a function that calculates the total amount of an order with the invoice code as the 
--parameter (1 point)
--DROP FUNCTION dbo.ufn_calculateTotalAmount;

go

CREATE function ufn_calculateTotalAmount(@invoideCode int)

RETURNS DECIMAL(10,2)
AS
BEGIN
	Declare  @totalAmount DECIMAL(10,2)
	SELECT @TotalAmount = SUM(Quantity * Price)
    FROM OrderDetails
  
    WHERE OrderID = @invoideCode;
	if @totalAmount is not null
		return @totalAmount  
	return 0
end
go
SELECT * FROM sys.objects WHERE name = 'ufn_calculateTotalAmount' AND type_desc = 'SQL_SCALAR_FUNCTION';


SELECT dbo.ufn_calculateTotalAmount(1) AS 'TotalAmount' 


---
go
create view bestselling as
select top 1    p.ProductCode,p.Name,count(o.orderID) as number_items  from  Orders o 
join OrderDetails od on  o.OrderID=od.OrderID
join Product p on od.ProductCode=p.ProductCode
where MONTH(o.OrderDate)=11
group by  p.ProductCode,p.Name

SELECT*FROM  bestselling




	








	







