INSERT INTO ProductLine(ProductLineID,ProductLineName) VALUES (1,N'Máy asus')
INSERT INTO ProductLine(ProductLineID,ProductLineName) VALUES (2,N'Máy HP')
SELECT *FROM ProductLine
INSERT INTO Product(ProductID,ProductDescription,ProductFinish,ProductStandardPrice,ProductLineID) VALUES (111,N'Máy asus K112',NULL,1000,1)
INSERT INTO Product(ProductID,ProductDescription,ProductFinish,ProductStandardPrice,ProductLineID) VALUES (112,N'Máy asus K113',NULL,2000,1)
INSERT INTO Product(ProductID,ProductDescription,ProductFinish,ProductStandardPrice,ProductLineID) VALUES (113,N'Máy asus K114',NULL,3000,1)
Update ProductLine
SET ProductLineName=N'Asus'
WHERE ProductLineID=1

DELETE 
ALTER TABLE Product
DROP CONSTRAINT FK_Product_ProductLine 
ALTER TABLE Product
ADD constraint FK_Product_ProductLine FOREIGN KEY(ProductLineID) References ProductLine(ProductLineID) on update cascade