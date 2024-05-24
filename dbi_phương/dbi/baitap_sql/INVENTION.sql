CREATE DATABASE INVENTION
GO 
USE INVENTION
-- CHÈN DỮ LIỆU VÀO CÁC BẢNG --> chỉ để test (đề không có)
-- Chèn dữ liệu vào bảng Customer
INSERT INTO Customer (CustomerID, LastName, FirstName, Phone, Address, City, Country)
VALUES
    ('C1', 'Smith', 'John', 123456789, '123 Main St', 'New York', 'USA'),
    ('C2', 'Johnson', 'Alice', 987654321, '456 Elm St', 'Los Angeles', 'USA'),
    ('C3', 'Williams', 'David', 555555555, '789 Oak St', 'Chicago', 'USA'),
    ('C4', 'Brown', 'Mary', 111111111, '567 Pine St', 'Houston', 'USA'),
    ('C5', 'Jones', 'Robert', 999999999, '234 Birch St', 'Miami', 'USA')

-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, RequiredDate, ShippedDate, Status, Comment)
VALUES
    ('O1', 'C1', '2023-01-10', '2023-01-15', '2023-01-12', 'Shipped', 'Fast delivery'),
    ('O2', 'C2', '2023-06-15', '2023-02-20', '2023-02-18', 'Shipped', 'Excellent service'),
    ('O3', 'C3', '2023-03-20', '2023-03-25', '2023-03-22', 'Shipped', 'Good quality'),
    ('O4', 'C4', '2023-06-05', '2023-04-10', '2023-04-08', 'Shipped', 'Satisfied customer'),
    ('O5', 'C5', '2023-06-12', '2023-05-17', '2023-05-15', 'Shipped', 'Repeat order')

-- Chèn dữ liệu vào bảng Product
INSERT INTO Product (ProductCode, Name, Scale, Vendor, Description, BuyPrice, Inventory)
VALUES
    ('P1', 'Laptop', 15, 'Dell', 'High-performance laptop', 999.99, 100),
    ('P2', 'Smartphone', 10, 'Samsung', 'Latest smartphone model', 799.99, 200),
    ('P3', 'Tablet', 12, 'Apple', 'Popular tablet device', 599.99, 150),
    ('P4', 'TV', 40, 'Sony', '4K Ultra HD TV', 1199.99, 50),
    ('P5', 'Camera', 8, 'Canon', 'Professional DSLR camera', 1499.99, 75)

-- Chèn dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (OrderID, ProductCode, Qty, Price)
VALUES
    ('O1', 'P1', 2, 999),
    ('O1', 'P2', 3, 799),
    ('O2', 'P3', 10, 599),
    ('O3', 'P4', 2, 1199),
    ('O4', 'P5', 10, 1499),
    ('O4', 'P2', 2, 799),
    ('O5', 'P1', 4, 999),
    ('O5', 'P4', 10, 1199),
    ('O5', 'P3', 3, 599);

-- 1. Write commands to create all the tables and insert appropriate data into the tables. There 
--    must be primary key, foreign key according to the diagram.
CREATE TABLE Customer (
CustomerID VARCHAR(20) PRIMARY KEY,
LastName NVARCHAR(20),
FirstName NVARCHAR(20),
Phone int,
Address NVARCHAR(20),
City NVARCHAR(20),
Country NVARCHAR(20)
)

CREATE TABLE Orders (
OrderID VARCHAR(20) PRIMARY KEY,
CustomerID VARCHAR(20),
OrderDate DATE,
RequiredDate DATE,
ShippedDate DATE,
Status NVARCHAR(20),
Comment NVARCHAR(20),
CONSTRAINT FK_Order_Customer FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
)

CREATE TABLE Product (
ProductCode VARCHAR(20) PRIMARY KEY,
Name NVARCHAR(20),
Scale int, 
Vendor NVARCHAR(20),
Description NVARCHAR(100),
BuyPrice DECIMAL(10,2),
Inventory int,	
)

CREATE TABLE OrderDetail (
OrderID VARCHAR(20),
ProductCode VARCHAR(20),
Qty int,
Price int
CONSTRAINT PK_OrderDetail PRIMARY KEY(OrderID, ProductCode),
CONSTRAINT FK_OD_Order FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_OD_Product FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode),
)

-- 2. Create constraint for table OrderDetail whose Qty is always greater than 0 (0.5 point) 
ALTER TABLE OrderDetail
ADD CONSTRAINT CK_OrderDetail CHECK(Qty > 0)

-- 3. Write SQL commands that do the following: (4.0 point) 
-- a. Display customers in Da Nang, including IDcustomer, Firstname, Lastname, Phone, Address 
SELECT *
FROM Customer
WHERE City LIKE N'%Chicago%'

-- b. Calculate the amount of each order with Total = Quantity * Price, 
SELECT OD.Price * OD.Qty AS 'Total' 
FROM OrderDetail OD
INNER JOIN Orders O
ON O.OrderID = OD.OrderID

-- c. Create a view to store the best-selling items in June. If the number is the same, show all 
GO
CREATE VIEW [BestSellingItemsInJune] AS
SELECT TOP 1 WITH TIES
    OD.ProductCode,
    P.Name AS ProductName,
    SUM(OD.Qty) AS TotalQuantitySoldInJune
FROM
    Orders O
JOIN
    OrderDetail OD ON O.OrderID = OD.OrderID
JOIN
    Product P ON OD.ProductCode = P.ProductCode
WHERE
    MONTH(O.OrderDate) = 6
GROUP BY
    OD.ProductCode, P.Name
ORDER BY
    TotalQuantitySoldInJune DESC;

SELECT * FROM [BestSellingItemsInJune]

-- d. Display details of each order with a total amount > 500 including the following 
--    information: Order1.orderID, Customerid, RequiredDate,ShippedDate, amount 
SELECT Order1.OrderID, Order1.CustomerID, Order1.RequiredDate, Order1.ShippedDate, ORDER2.Qty * Order2.Price AS 'Amount' 
FROM ((Orders Order1
INNER JOIN OrderDetail Order2 ON Order1.OrderID = Order2.OrderID)
INNER JOIN Customer C ON C.CustomerID = Order1.CustomerID)
WHERE ORDER2.Qty * Order2.Price > 500

--4. Write a function that calculates the total amount of an order with the invoice code as the parameter (1 point)
GO
CREATE FUNCTION UF_CountOrder(@OrderID VARCHAR(20))
RETURNS int
AS
BEGIN
DECLARE @RESULT int
     IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
	    BEGIN    
	        SELECT @RESULT = Order2.Price * Order2.Qty
		    FROM Orders Order1
		    INNER JOIN OrderDetail Order2
		    ON Order1.OrderID = Order2.OrderID
			WHERE Order1.OrderID = @OrderID -- đừng quên -- amen -- amen 

	        RETURN @RESULT
	    END
	 
	 ELSE
	    BEGIN
	       RETURN NULL
	    END
	 RETURN @RESULTs
END

GO
SELECT * FROM Orders
SELECT * FROM OrderDetail
SELECT DBO.UF_CountOrder ('O2') AS 'Thông tin'
SELECT DBO.UF_CountOrder ('O8') AS 'Thông tin'