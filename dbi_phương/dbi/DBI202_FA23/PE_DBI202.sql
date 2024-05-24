Create database DB_FE_DBI202

Go
Use DB_FE_DBI202
Go

CREATE TABLE CUSTOMER
	(
	CustomerID varchar(5)  PRIMARY KEY,
	CustomerName nvarchar(30) NOT NULL,
	CusAddress nvarchar(50),
	Cuctel varchar(10) ,
	Email varchar(30)
	)
--Create table for Warehouse 
(--note: identity for WarehouseID char(5) column is primary key)
drop table wareHouse
CREATE TABLE  wareHouse(
 wareHouseId char(5) primary key,
 phoneNumber nvarchar(15),
 address nvarchar(50),
 
 )

--Code for insert value to Warehouse table


CREATE TABLE MATERIAL
	(
	MaterialID varchar(5) PRIMARY KEY,
	MaterialName nvarchar(30) NOT NULL,
	Unit nvarchar(20),
	PurchasePrice   int CHECK (PurchasePrice>0),
	InventoryNumber int CHECK (InventoryNumber>=0),
	WarehouseID char(5) references Warehouse(WarehouseID)
	)
CREATE TABLE INVOICE
	(
	InvoiceID varchar(10) PRIMARY KEY,
	InvoiceDate datetime CHECK(InvoiceDate<=getdate()),
	CustomerID varchar(5) FOREIGN KEY REFERENCES Customer(CustomerID),
	DeliveryAddress nvarchar(50)
	)
CREATE TABLE DETAILINVOICE 
	(
	InvoiceID varchar(10) FOREIGN KEY REFERENCES INVOICE(InvoiceID),
	MaterialID varchar(5) FOREIGN KEY REFERENCES MATERIAL(MaterialID),
	PRIMARY KEY (InvoiceID,MaterialID ),
	Quanlity int,
	Promotion int,
	SellingPrice int
	)

	INSERT INTO wareHouse (wareHouseId,phoneNumber,address) VALUES(1,N'123-5456-789',N'Đà Nẵng')
	INSERT INTO wareHouse (wareHouseId,phoneNumber,address) VALUES(2,N'123-1256-390',N'Hà Giang')
	INSERT INTO wareHouse (wareHouseId,phoneNumber,address) VALUES(3,N'133-2356-129',N'Huế')
	INSERT INTO wareHouse (wareHouseId,phoneNumber,address) VALUES(4,N'223-5434-289',N'Quảng Bình')
	INSERT INTO wareHouse (wareHouseId,phoneNumber,address) VALUES(5,N'113-1256-908',N'Quảng Trị')



INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)VALUES( 'VT01','XI MANG','BAO',50000,5000,1)
INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)
VALUES( 'VT02',	'CAT'	,'KHOI',	45000,	50000,2)
INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)
VALUES( 'VT03',	'GACH ONG',	'VIEN',	120,	800000,3)
INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)
VALUES( 'VT04',	'GACH THE',	'VIEN',	110,	800000,4)
INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)
VALUES( 'VT05',	'DA LON',	'KHOI',	25000,	100000,5)
INSERT MATERIAL(MaterialID,MaterialName,Unit ,PurchasePrice  ,InventoryNumber,WarehouseID)
VALUES( 'VT06',	'DA NHO',	'KHOI',	33000,	100000,4)

INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH01',	'NGUYEN THI BE',	'TAN BINH',	8457895,	'bnt@yahoo.com')
INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH02',	'LE HOANG NAM',	'BINH CHANH',	9878987,	'namlehoang @abc.com.vn')
INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH03',	'TRAN THI CHIEU',	'TAN BINH',	8457895,null	)
INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH04',	'MAI THI QUE ANH',	'BINH CHANH	',null,null)
INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH05',	'LE VAN SANG',	'QUAN 10',	null	,'sanglv@hcm.vnn.vn')
INSERT CUSTOMER(CustomerID ,CustomerName,CusAddress,Cuctel  ,Email )
VALUES( 'KH06',	'TRAN HOANG KHAI',	'TAN BINH',	8457897	,null)

INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD001','2022-05-12',	'KH01',N'Đà Nẵng')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD002','2022-05-25',	'KH02',N'Đà Nẵng')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD003','2022-05-25','KH01',N'Hội An')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD004','2022-05-25','KH04',N'Huế')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD005','2022-05-26','KH04',N'Đà Nẵng')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD006','2022-05-02','KH03',N'Huế')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD007','2022-06-22','KH04',N'Huế')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD008','2022-06-25','KH03',N'Đà Nẵng')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD009','2022-08-15','KH04',N'Huế')
INSERT INVOICE(InvoiceID ,InvoiceDate ,CustomerID ,DeliveryAddress )
VALUES( 'HD010','2022-08-30','KH01',N'Hội An')

INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES('HD001','VT01',5,52000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD001','VT05',	10,	30000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD002','VT03',	10000,	150)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD003','VT02',	20,	55000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD004','VT03',	50000,	150)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD004',	'VT04',	20000,	120)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD005',	'VT05',	10,	30000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD006',	'VT04',	10000,	120)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD007',	'VT04',	20000,	125)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD008',	'VT01',	100,	55000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD009',	'VT02',	25,	48000)
INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
VALUES( 'HD010',	'VT01',	25,	57000)

SELECT *FROM INVOICE
SELECT*FROM CUSTOMER
SELECT *FROM MATERIAL
SELECT *FROM wareHouse
SELECT* FROM DETAILINVOICE


--Code for answer
---CAU 3:

go
create proc search_invoice
@customerName nvarchar
AS
BEGIN
SELECT i.InvoiceID,i.InvoiceDate,i.DeliveryAddress,SUM(d.Quanlity*d.SellingPrice) AS 'TOTAL AMOUNT' FROM  INVOICE i
join CUSTOMER cu ON I.CustomerID=CU.CustomerID
join DETAILINVOICE D ON I.InvoiceID=D.InvoiceID
group by i.InvoiceID,i.InvoiceDate,i.DeliveryAddress
END

--CAU 4
go
Create trigger insert_detailInvoicde
ON DETAILINVOICE
For insert
AS
	
	
	declare @InvoiceID varchar(10) 
	declare @MaterialID varchar(5) 
	
	declare @Quanlity int
	declare @Promotion int 
	declare @SellingPrice int


	Select @Quanlity = Quanlity from inserted
	IF @Quanlity<= (select Quanlity from DETAILINVOICE)
		--Không được phép chèn
		Begin
			Raiserror(N' must be greater than or equal to the sale quantity.', 16,1)
			rollback transaction --hủy thêm vào
		End
	ELSE
	BEGIN
	update DETAILINVOICE
	set  @InvoiceID= (SELECT i.InvoiceID  FROM inserted i)
	set @MaterialID =( SELECT i.MaterialID  FROM inserted i)
	set @Promotion=(SELECT i.Promotion  FROM inserted i)
	set @Quanlity=(SELECT i.Quanlity  FROM inserted i)
	set @SellingPrice=(SELECT i.SellingPrice FROM inserted i)
	END
	

	--CAU 5
	--TẠO VIEW
go
Create View InvoicesInfo 
AS
select i.InvoiceID,i.InvoiceDate,i.DeliveryAddress, SUM(d.Quanlity*d.SellingPrice) AS'TOTAL' from INVOICE i
join DETAILINVOICE  d on d.InvoiceID =i.InvoiceID
GROUP BY  i.InvoiceID,i.InvoiceDate,i.DeliveryAddress
go

--
--TÍNH TAX

go
CREATE PROCEDURE calculate_tax
AS
DECLARE @TAX

SELECT TOTAL from  InvoicesInfo 
IF TOTAL>500000
	@TAX = TOTAL-10%.total
ELSE IF
	@TAX = TOTAL-10%.total
ELSE
	@TAX=0
	





	
