CREATE DATABASE Shopping
USE Shopping
DROP TABLE ProductLine
CREATE TABLE ProductLine(
ProductLineID int primary key,
productLineName nvarchar(50) not null)
DROP TABLE Product
CREATE TABLE Product(
ProductID int,
productName nvarchar(50) not null,
productDescription nvarchar(100),
productFinish nvarchar(100),
productStandardPrice  decimal(6,2),
CONSTRAINT PK_PRODUCT Primary key(ProductID)
)
CREATE TABLE Territory(
TerritoryID int,
TerritoryName nvarchar(50),
CONSTRAINT PK_territory Primary key(TerritoryId)
)
--th�m c?t 
ALTER TABLE ProductLine
	ADD ProductlineDes nvarchar(50)
--th�m c?t ProductLineID v�o b?ng product
ALTER TABLE Product 
ADD  ProductLineID INT NOT NULL
--Th�m r�ng bu?c kh�a ngo?i v�o b?ng product
ALTER TABLE Product 
ADD CONSTRAINT FK_ProductProductLine foreign key (ProductLineID) 
REFERENCES ProductLine(ProductLineID)
--kh�ng th? x�a b?ng productline ???c v� r�ng bu?c kh�a ngo?i
--v� th? ph?i x�a r�ng bu?c kh�o ngo?i

-- th�m r�ng bu?c duy nh?t cho c?t productalineName
ALTER TABLE ProductLine ADD  CONSTRAINT UK_Product_Name Unique(productLineName)
ALTER TABLE Product
DROP CONSTRAINT FK_ProductProductLine
--ch?nh s?a t? ??ng t?ng,cho c?t territoryID	

ALTER TABLE Territory
DROP CONSTRAINT PK_Territory

ALTER TABLE Territory
ADD TerritoryID int identity(1,1)

SELECT*FROM ProductLine
SELECT*FROM Product
SELECT*FROM Territory
