Create database DB_FE_DBI202_A
Go
Use DB_FE_DBI202_A
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
create table Warehouse
(
	WarehouseID char(5) primary key,
	phoneNUmber varchar(10) check (len(phoneNumber) = 10 ),
	address nvarchar(50)
)


--Code for insert value to Warehouse table
insert into Warehouse (WarehouseID, address, phoneNUmber)
values('WH001', N'Hội An', '0123456789'),
('WH002', N'Đà Nẵng', '0123456781'),
('WH003', N'Vinh', '0123456782'),
('WH004', N'Hà Tĩnh', '0123456783'),
('WH005', N'Hải Phòng', '0123456784')

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
VALUES( 'VT01','XI MANG','BAO',50000,5000, 'wh001')
INSERT MATERIAL
VALUES( 'VT02',	'CAT'	,'KHOI',	45000,	50000, 'wh002')
INSERT MATERIAL
VALUES( 'VT03',	'GACH ONG',	'VIEN',	120,	800000, 'wh003')
INSERT MATERIAL
VALUES( 'VT04',	'GACH THE',	'VIEN',	110,	800000, 'wh004')
INSERT MATERIAL
VALUES( 'VT05',	'DA LON',	'KHOI',	25000,	100000, 'wh005')
INSERT MATERIAL
VALUES( 'VT06',	'DA NHO',	'KHOI',	33000,	100000, 'wh005')

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
/*
 * Question 3
 */
 alter procedure sp_search_invoices
 (	
	@customerName varchar(30)
 )
 as
 begin
	if(@customerName is null)
	begin
		raiserror('wrong arguments', 16,1)
		return -1
	end

	select DETAILINVOICE.InvoiceID, InvoiceDate, DeliveryAddress, sum(Quanlity * SellingPrice) AS totalOfInvoice
	from CUSTOMER
	join INVOICE on CUSTOMER.CustomerID = INVOICE.CustomerID
	JOIN DETAILINVOICE ON INVOICE.InvoiceID = DETAILINVOICE.InvoiceID
	where CustomerName like  '%' + @customerName + '%'
	group by DETAILINVOICE.InvoiceID, InvoiceDate, DeliveryAddress
 end

 --exec sp_search_invoices 
 --select * from INVOICE
 --select * from DETAILINVOICE
 /*
 * Question 4
 */
 create trigger tr_insert_DetailInvoice
 on DETAILINVOICE
 after insert
 as
 begin
		declare @InventoryNumber int,
		@quantity int,
		@materialID varchar(5)
		set @quantity = (select quanlity from inserted)
		set @materialID = (select MaterialID from inserted)
		set @InventoryNumber = (select InventoryNumber from MATERIAL where  MATERIAL.MaterialID = @materialID)
		if(@InventoryNumber < @quantity)
		begin
			rollback
			raiserror('the quantity of Material  must be greater than or equal to the sale quantity', 16, 1)
			return
		end

		update MATERIAL
		set InventoryNumber = InventoryNumber - @quantity
		where MaterialID = @materialID
 end
 go
 --select * from MATERIAL
 --select * from DETAILINVOICE
 --select * from INVOICE

 --INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
 --values('HD004', 'VT01', 2000, 57000)


 --solution

 go
 alter trigger test 
 on DETAILINVOICE
 for insert
 as
 begin 
	declare @saleQTT int, @InvenQTT int
	select @saleQTT = Quanlity, @InvenQTT = InventoryNumber 
	from MATERIAL join inserted on MATERIAL.MaterialID = inserted.MaterialID
	if(@saleQTT > @InvenQTT)
	begin
		raiserror('the quantity of Material  must be greater than or equal to the sale quantity', 16, 1)
		rollback
		return
	end
	update MATERIAL
	set InventoryNumber = InventoryNumber -  @saleQTT
	from MATERIAL join inserted on MATERIAL.MaterialID = inserted.MaterialID
 end
 select * from MATERIAL
 select * from DETAILINVOICE
 select * from INVOICE

 INSERT DetailInvoice(InvoiceID,MaterialID,Quanlity, SellingPrice)
 values('HD002', 'VT02', 20000, 57000)

 /*
 * Question 5
 */
 alter view V_InvoicesInfo
 as
	select DETAILINVOICE.InvoiceID, InvoiceDate, DeliveryAddress, sum(Quanlity * SellingPrice) AS totalOfInvoice,
		case 
			when sum(Quanlity * SellingPrice) > 5000000 then sum(Quanlity * SellingPrice) * 0.1
			when sum(Quanlity * SellingPrice) > 100000 and sum(Quanlity * SellingPrice) < 5000000 then sum(Quanlity * SellingPrice) * 0.05
			else 0 
		end as Tax
	from CUSTOMER
	join INVOICE on CUSTOMER.CustomerID = INVOICE.CustomerID
	JOIN DETAILINVOICE ON INVOICE.InvoiceID = DETAILINVOICE.InvoiceID
	group by DETAILINVOICE.InvoiceID, InvoiceDate, DeliveryAddress
 go

 select * from V_InvoicesInfo