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
--note: identity for WarehouseID char(5) column is primary key)


Create table Warehouse(
 WarehouseID char(5) Primary Key,
 PhoneNum varchar(9),
 Address nvarchar(30) not null,
 WareLocation nvarchar(30),
 MaterialID varchar(5) FOREIGN KEY REFERENCES MATERIAL(MaterialID),
)

--Code for insert value to Warehouse table


insert into Warehouse(WarehouseID, PhoneNum, Address, WareLocation)
values ('WH001', '011111111', N'Đà Nẵng', N'TP-HCM')


insert into Warehouse(WarehouseID, PhoneNum, Address, WareLocation)
values('WH002', '022222222', N'Quảng Nam', N'TP-HCM')


insert into Warehouse(WarehouseID, PhoneNum, Address, WareLocation)
values('WH003', '033333333', N'Quảng Ngãi', N'TP-HCM')


insert into Warehouse(WarehouseID, PhoneNum, Address, WareLocation)
values('WH004', '044444444', N'Huế', N'TP-HCM')


insert into Warehouse(WarehouseID, PhoneNum, Address, WareLocation)
values('WH005', '055555555', N'Quảng Bình', N'TP-HCM')

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



INSERT MATERIAL
VALUES( 'VT01','XI MANG','BAO',50000,5000)
INSERT MATERIAL
VALUES( 'VT02',	'CAT'	,'KHOI',	45000,	50000)
INSERT MATERIAL
VALUES( 'VT03',	'GACH ONG',	'VIEN',	120,	800000)
INSERT MATERIAL
VALUES( 'VT04',	'GACH THE',	'VIEN',	110,	800000)
INSERT MATERIAL
VALUES( 'VT05',	'DA LON',	'KHOI',	25000,	100000)
INSERT MATERIAL
VALUES( 'VT06',	'DA NHO',	'KHOI',	33000,	100000)

INSERT CUSTOMER
VALUES( 'KH01',	'NGUYEN THI BE',	'TAN BINH',	8457895,	'bnt@yahoo.com')
INSERT CUSTOMER
VALUES( 'KH02',	'LE HOANG NAM',	'BINH CHANH',	9878987,	'namlehoang @abc.com.vn')
INSERT CUSTOMER
VALUES( 'KH03',	'TRAN THI CHIEU',	'TAN BINH',	8457895,null	)
INSERT CUSTOMER
VALUES( 'KH04',	'MAI THI QUE ANH',	'BINH CHANH	',null,null)
INSERT CUSTOMER
VALUES( 'KH05',	'LE VAN SANG',	'QUAN 10',	null	,'sanglv@hcm.vnn.vn')
INSERT CUSTOMER
VALUES( 'KH06',	'TRAN HOANG KHAI',	'TAN BINH',	8457897	,null)

INSERT INVOICE
VALUES( 'HD001','2022-05-12',	'KH01',N'Đà Nẵng')
INSERT INVOICE
VALUES( 'HD002','2022-05-25',	'KH02',N'Đà Nẵng')
INSERT INVOICE
VALUES( 'HD003','2022-05-25','KH01',N'Hội An')
INSERT INVOICE
VALUES( 'HD004','2022-05-25','KH04',N'Huế')
INSERT INVOICE
VALUES( 'HD005','2022-05-26','KH04',N'Đà Nẵng')
INSERT INVOICE
VALUES( 'HD006','2022-05-02','KH03',N'Huế')
INSERT INVOICE
VALUES( 'HD007','2022-06-22','KH04',N'Huế')
INSERT INVOICE
VALUES( 'HD008','2022-06-25','KH03',N'Đà Nẵng')
INSERT INVOICE
VALUES( 'HD009','2022-08-15','KH04',N'Huế')
INSERT INVOICE
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


--Code for answer

--3.	Write a procedure to search for invoices by customer name, displaying information including: InvoiceID, Invoicedate, delivery address, total amount in each invoice. Where the total amount is equal to the total quantity * selling price of the items. If the procedure executes without parameters, an error message is returned.
if OBJECT_ID('usp_SearchInvoicesByCustomerName','p') is not null
drop proc usp_SearchInvoicesByCustomerName
go
create proc usp_SearchInvoicesByCustomerName
    @CName nvarchar(30)
as
begin
if @Cname is null
BEGIN
RAISERROR (N'You have input parameter CustomerName for proc', 16, 1);
RETURN;
END
select i. InvoiceID, i. InvoiceDate, i. DeliveryAddress, di.Quanlity * di.SellingPrice as 'TotalAmount' from INVOICE as i 
join CUSTOMER as c on c.CustomerID = i.CustomerID
join DETAILINVOICE as di on di.InvoiceID = i.InvoiceID
where c.CustomerName like '%'+@Cname+'%';
end
go
exec usp_searchInvoicesByCustomerName 'NGUYEN THI BE';


--4
IF OBJECT_ID('utg_DetailInvoice_Insert', 'tr') IS NOT NULL
    DROP TRIGGER utg_DetailInvoice_Insert
GO

create trigger utg_DetailInvoice_Insert
on DETAILINVOICE
for insert
as
BEGIN
declare @saleQuantity int
declare @inventoryNumber int
declare @mid varchar(5)
select @mid = MaterialID from inserted
select @saleQuantity Quanlity from inserted select @inventoryNumber = InventoryNumber from MATERIAL where MaterialID = @mid
if (@salequantity < @inventoryNumber)
BEGIN
update MATERIAL
set InventoryNumber = InventoryNumber - @saleQuantity
END
else
BEGIN
RAISERROR('Inventory number is not enough', 16,1)
ROLLBACK TRANSACTION
END
END
GO



--5.	Write the statement Create a view named InvoicesInfo that display all invoices information, includes:
go
CREATE VIEW InvoicesInfo
AS
SELECT
I.InvoiceID, I.InvoiceDate, I.DeliveryAddress, 
SUM (DI.Quanlity * DI.SellingPrice) AS Total,
CASE
WHEN SUM(DI.Quanlity * DI.SellingPrice) > 5000000 THEN SUM(DI.Quanlity * DI.SellingPrice) * 0.1
WHEN SUM(DI.Quanlity * DI.SellingPrice) > 100000 AND SUM(DI.Quanlity * DI.SellingPrice) <= 5000000 THEN SUM(DI.Quanlity * DI.SellingPrice) * 0.05
ELSE 0
END AS Tax
FROM
INVOICE I
JOIN
DETAILINVOICE DI ON I.InvoiceID =  DI.InvoiceID
GROUP BY
I. InvoiceID, I. InvoiceDate, I. DeliveryAddress

