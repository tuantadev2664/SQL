﻿create database HOTEL
go
use HOTEL
go
create table tblCustomer
(
	CustID varchar (10) primary key,
	CustName nvarchar(40) not null,
	DOB date,
	Tel char(10) not null Check(Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
go
Insert into tblCustomer values('KH001',N'Nguyễn Thanh Thúy','1988-05-18','0905678541')
Insert into tblCustomer values('KH002',N'Trần Anh Tuấn','1980-03-28','0935678789')
Insert into tblCustomer values('KH003',N'Lâm Thùy Dương','1981-06-20','0935654321')
go
create table tblRoomType
(
	TypeID varchar(3) primary key,
	TypeName nvarchar(30),
	TypePrice decimal(10,0) check (TypePrice >=0)
);
go
Insert into tblRoomType values('STD','Standard',700000)
Insert into tblRoomType values('DLX','Deluxe',1200000)
Insert into tblRoomType values('SUT','Suite',2000000)
go
create table tblRoom
(
	RoomID varchar(4) primary key,
	Rstatus varchar(2),
	TypeID varchar(3)foreign key(TypeID) references tblRoomType(TypeID) on update cascade	
);
go
Insert into tblRoom values('R101','A','STD')
Insert into tblRoom values('R102','A','STD')
Insert into tblRoom values('R201','A','DLX')
Insert into tblRoom values('R301','A','SUT')
go
create table tblHotelOrder
(
	OrderID varchar(10) primary key,
	OrderDate date default getdate(),
	CustID varchar (10) not null foreign key references tblCustomer(CustID) on update cascade
);
go
Insert into tblHotelOrder values('001', '2023-4-15', 'KH001')
Insert into tblHotelOrder values('002', '2023-4-18', 'KH002')
Insert into tblHotelOrder values('003', '2023-5-25', 'KH001')
go
create table tblRoomOrder
(
	OrderID varchar(10) not null foreign key(OrderID) references tblHotelOrder(OrderID),
	RoomID varchar(4) not null foreign key(RoomID) references tblRoom(RoomID) on update cascade,
	checkIn date,
	checkOut date, 
	constraint pk_rO primary key(OrderID,RoomID)
);
go
Insert into tblRoomOrder values('001','R101','2023-04-25','2023-04-29')
Insert into tblRoomOrder values('001','R102','2023-04-25','2023-04-29')
Insert into tblRoomOrder values('001','R201','2023-04-25','2023-04-29')
Insert into tblRoomOrder values('003','R301','2023-05-10','2023-05-12')
go
create table tblBookingdetail
(
	OrderID varchar(10) foreign key(OrderID) references tblHotelOrder(OrderID),
	TypeID varchar(3) foreign key(TypeID) references tblRoomType(TypeID) on update cascade,
	numberOfR int check (numberOfR >0),
	constraint pk_b primary key(TypeID, OrderID)
);
go
Insert into tblBookingdetail values('001','STD',2)
Insert into tblBookingdetail values('001','DLX',1)
Insert into tblBookingdetail values('002','SUT',1)
Insert into tblBookingdetail values('003','DLX',1)
Insert into tblBookingdetail values('003','SUT',1)
Insert into tblBookingdetail values('003','STD',2)
go

create procedure sp_newCust
	@CustID varchar (10),
	@CustName nvarchar(40),
	@DOB date,
	@Tel char(10)
	
as 
	Insert into tblCustomer(CustID, CustName, DOB, Tel)
	values(@CustID, @CustName, @DOB, @Tel)	
	if @@rowcount<>1
		begin
		 RAISERROR('Add new customer fail ',10,1)
		 return -1;
		end
go

CREATE TRIGGER trg_UpdateRoomStatus
ON tblRoomOrder
AFTER INSERT
AS
BEGIN
	   if EXISTS (select tblRoom.RoomID
			  from tblRoom INNER JOIN inserted ON tblRoom.RoomID = inserted.RoomID
			  where Rstatus ='NA'
			  )
			begin
				RAISERROR('Room is not available',10,1)
				ROLLBACK TRANSACTION
			end
		else
			begin
				UPDATE tblRoom
				SET Rstatus = 'NA'
				FROM tblRoom
				INNER JOIN inserted ON tblRoom.RoomID = inserted.RoomID
			end
END;
go
create view VwListCust
as
	select c.CustID, CustName, DOB, Tel, count(OrderID) as 'Number of bookings'
	from tblCustomer c inner join tblHotelOrder h on c.CustID=h.CustID
	group by c.CustID, CustName, DOB, Tel
	having count(OrderID)>1

