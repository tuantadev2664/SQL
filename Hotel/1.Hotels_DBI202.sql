create database Hotels_DBI202
go
use Hotels_DBI202
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

--Write your queries here

/*
 * Question 2
 */

 create table tblHotelOrder_RoomType
 (
	OrderID varchar(10) foreign key(OrderID) references tblHotelOrder(OrderID),
	TypeID varchar(3)foreign key(TypeID) references tblRoomType(TypeID) on update cascade,
	numberOfR int check (numberOfR > 0),
	primary key (OrderID, TypeID)
 )

 insert into tblHotelOrder_RoomType values
 ('001', 'DLX', 1),
 ('001', 'STD', 2),
 ('003', 'SUT', 1)

 --select * from tblHotelOrder
 --select * from tblRoomType

 /*
 * Question 3
 */

 alter procedure sp_addNewCustomer
 (
	@CustomerID varchar(10),
	@CustomerName nvarchar(40),
	@DOB date,
	@Tel char(10)
 )
 as
 begin
	insert into tblCustomer values
	(@CustomerID, @CustomerName, @DOB, @Tel)
	if @@rowcount<>1
		begin
		 RAISERROR('Add new customer fail ',10,1)
		 return -1;
		end
 end
 go

 exec sp_addNewCustomer 'KH004',N'Truong Anh Tuan','2004-06-27','0888150629'

 /*
 * Question 4
 */

 create trigger tr_assignARoomToOrder
 on tblRoomORder
 after insert
 as
 begin
	declare @OrderID varchar(10), 
	@RoomID varchar(4)
	select @RoomID = RoomID from inserted
	select @OrderID =  OrderID from inserted
	if exists (select 1 from tblRoom where RoomID = @RoomID and Rstatus like 'NA')
	begin
		raiserror('Not Available', 16, 1)
		rollback
		return
	end
	update tblRoom
	set Rstatus = 'NA'
	where RoomID = @RoomID

 end
 go

 -- Solution
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

 Insert into tblRoomOrder values('002','R101','2023-04-25','2023-04-29')

 select *from tblRoomOrder
 select * from tblRoom
 Insert into tblRoomOrder values('003','R101','2023-04-25','2023-04-29')

 /*
 * Question 5
 */
Create View V_InfoCustomer as

select tblCustomer.*, count (tblHotelOrder.OrderID) as 'number of room reservations'
from tblCustomer
join tblHotelOrder on tblCustomer.CustID = tblHotelOrder.CustID
group by tblCustomer.CustID, CustName, DOB, Tel
having count (tblHotelOrder.OrderID) > 1

select * from V_InfoCustomer

--solution
create view VwListCust
as
	select c.CustID, CustName, DOB, Tel, count(OrderID) as 'Number of bookings'
	from tblCustomer c inner join tblHotelOrder h on c.CustID=h.CustID
	group by c.CustID, CustName, DOB, Tel
	having count(OrderID)>1