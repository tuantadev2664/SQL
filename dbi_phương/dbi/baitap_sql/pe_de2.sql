-- 1. Create tables and insert data

CREATE TABLE Customers (
  CustomerID int PRIMARY KEY,
  FirstName varchar(50),
  LastName varchar(50),
  Phone varchar(15),
  Address varchar(100) 
);

INSERT INTO Customers VALUES 
(1, 'John', 'Doe', '0123456789', '123 Main St, New York'),
(2, 'Jane', 'Doe', '0987654321', '456 Park Ave, New York'),
(3, 'Bob', 'Smith', '1235554567', '789 Elm St, Chicago');


CREATE TABLE Products (
  ProductID int PRIMARY KEY,
  ProductName varchar(100),
  UnitPrice decimal(10,2)
);

INSERT INTO Products VALUES
(1, 'Product 1', 10.99), 
(2, 'Product 2', 15.49),
(3, 'Product 3', 8.99);


CREATE TABLE Orders (
  OrderID int PRIMARY KEY,
  CustomerID int,
  OrderDate date,
  ShipperID int,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders VALUES
(1, 1, '2023-06-01', 1),
(2, 2, '2023-06-15', 2), 
(3, 3, '2023-06-28', 3);


CREATE TABLE OrderDetails (
  OrderID int,
  ProductID int,
  Quantity int,
  PRIMARY KEY (OrderID, ProductID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails VALUES
(1, 1, 10),
(1, 2, 5),
(2, 1, 20),
(3, 3, 15);

-- 2. Quantity constraint

ALTER TABLE OrderDetails 
ADD CONSTRAINT chk_quantity CHECK (Quantity > 0);

-- 3a. Customers in Da Nang

SELECT CustomerID, FirstName, LastName, Phone, Address
FROM Customers
WHERE Address LIKE '%Da Nang%';

-- 3b. Calculate order total

SELECT OrderID, ProductID, Quantity, UnitPrice, Quantity * UnitPrice AS Total
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID;

-- 3c. Best selling items in June

CREATE VIEW BestSellersJune AS
SELECT TOP 1 WITH TIES OD.ProductID, SUM(Quantity) AS TotalQty  
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE MONTH(OrderDate) = 6
GROUP BY OD.ProductID
ORDER BY TotalQty DESC;

-- 3d. Orders over $500

SELECT O.OrderID, O.CustomerID, O.RequiredDate, O.ShippedDate, SUM(OD.Quantity * P.UnitPrice) AS TotalAmount
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY O.OrderID, O.CustomerID, O.RequiredDate, O.ShippedDate
HAVING SUM(OD.Quantity * P.UnitPrice) > 500;

-- 4. Function for order total

CREATE FUNCTION fn_OrderTotal (@OrderID int)
RETURNS decimal(10,2)
AS
BEGIN
  DECLARE @Total decimal(10,2)

  SELECT @Total = SUM(OD.Quantity * P.UnitPrice)
  FROM OrderDetails OD
  JOIN Products P ON OD.ProductID = P.ProductID
  WHERE OD.OrderID = @OrderID
  
  RETURN @Total
END

-- 5. Generate database script

BACKUP DATABASE OrderSystem 
TO DISK = 'C:\Backup\OrderSystem.bak';