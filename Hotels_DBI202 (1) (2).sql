create database HOTEL
go
use HOTEL
go
create table tblCustomer
(
	CustID varchar (10) primary key,
	CustName nvarchar(40) not null,
	DOB date,
	Tel char(10) not null Check(Tel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
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


CREATE TABLE Service (
    ServiceID varchar(5) PRIMARY KEY,
    ServiceName nvarchar(50),
    ServiceCharge decimal(10,2) CHECK (ServiceCharge >= 0)
)

create table tblBookingdetail
(
OrderID varchar(10) not null,
TypeID varchar(3),
NumberOfR tinyint Check (NumberOfR>0),
constraint PK_RoomReservation Primary Key(TypeID,OrderID),
constraint FK_tblRoomReservation_tblRoomType foreign key (TypeID)
	references tblRoomType (TypeID) on update cascade,
constraint FK_tblRoomReservation_tblHotelOrder foreign key (OrderID)
	references tblHotelOrder (OrderID)
);

INSERT INTO Service 
VALUES ('S1', 'Wi-Fi', 5.00);
INSERT INTO Service 
VALUES ('S2', 'Minibar', 10.00);
INSERT INTO Service 
VALUES ('S3', 'Laundry', 15.00);


Insert into tblBookingdetail values('001','STD',2)
Insert into tblBookingdetail values('001','DLX',1)
Insert into tblBookingdetail values('002','SUT',1)
Insert into tblBookingdetail values('003','DLX',1)
Insert into tblBookingdetail values('003','SUT',1)
Insert into tblBookingdetail values('003','STD',2)
go

--Câu 2
--Cách đơn giản nhất
if OBJECT_ID('usp_newCust','p') is not null
	drop proc usp_newCust
go
create procedure usp_newCust
	@CustID varchar (10),
	@CustName nvarchar(40),
	@DOB date,
	@Tel char(10)
as 
	Insert into tblCustomer(CustID, CustName, DOB, Tel)
	values(@CustID, @CustName, @DOB, @Tel)	
	if @@ERROR<>0
		begin
		 RAISERROR('Add new customer fail ',16,1)
		 rollback transaction
		end


go
EXEC usp_newCust'KH005', N'Nguyễn Thị B', '1995-03-20', '0978123456';


--Bài 2 Cách 2: thêm biến result để nhận giá trị trả về của store procedure
if OBJECT_ID('usp_newCust1','p') is not null
	drop proc usp_newCust1
go
create procedure usp_newCust1
	@CustID varchar (10),
	@CustName nvarchar(40),
	@DOB date,
	@Tel char(10),
	@result int out	
as 
	Insert into tblCustomer(CustID, CustName, DOB, Tel)
	values(@CustID, @CustName, @DOB, @Tel)	
	if @@ERROR<>0
		begin
		 RAISERROR('Add new customer fail ',16,1)
		 set @result =-1;
		 rollback transaction
		end
go
--Gọi thủ tục có tham số out
Declare @resultSP int
EXEC usp_newCust1 @CustID = 'CH101', @CustName= N'Đặng Quang', @DOB ='2000-10-02', @Tel='0123456789', @result = @resultSP out
if @resultSP = -1
	print N'Lỗi thêm Customer'
else
	print N'Đã thêm thành công' 
--


-- Bài 3

--Cách 2: Thêm nhiều dòng 1 lần vào bảng tblRoomOrder
if OBJECT_ID('trg_assignRoomToAnOrder2','tr') is not null
drop trigger trg_assignRoomToAnOrder2
go
create trigger trg_AssignRoomToOrder2
on tblRoomOrder
after insert
as
begin
    if (exists (select 1 from inserted i
        inner join tblRoom r on i.RoomID = r.RoomID
        where r.Rstatus = 'NA'))
		begin
			raiserror('Room is not available, Cannot assign room. Rollback transaction.', 16, 1)
			rollback transaction;
		end
    else
		begin
			update tblRoom
			set Rstatus = 'NA'
			--where RoomID in (select RoomID from inserted);
			from inserted i
			inner join tblRoom r on i.RoomID = r.RoomID 
			
		end
end
--Test Trigger
--Test thêm  1 dòng vào bảng tblRoomOrder
Insert into tblRoomOrder(OrderID,RoomID)
values('004','R101')

Select * from tblRoom
Select * from tblRoomOrder

--Test thêm nhiều dòng 1 lần vào bảng tblRoomOrder
Insert into tblRoomOrder(OrderID,RoomID)
values('004','R301'),
('006','R201')

Insert into tblRoomOrder(OrderID,RoomID)
values('004','R301'),
('006','R201')

Insert into tblRoomOrder(OrderID,RoomID)
values('006','R302'),
('006','R401')



--4 
go
CREATE TRIGGER trg_assignRoomToAnOrder
ON tblRoomOrder
AFTER INSERT
AS
	DECLARE @roomId VARCHAR(4)
	DECLARE @available VARCHAR
	SELECT @roomId = RoomID FROM inserted
	SELECT @available = Rstatus FROM tblRoom r WHERE r.RoomID = @roomId
	IF @available = 'A'
		BEGIN
			UPDATE tblRoom
			SET Rstatus = 'NA'
			WHERE tblRoom.RoomID = @roomId
		END
	ELSE 
		BEGIN
			RAISERROR('Room not available',16,1)
			ROLLBACK TRANSACTION
		END
GO

--5.	Create a view to display information about customers who have booked rooms at the hotel more than once. Information about customers includes customer ID, customer name, date of birth, phone number, and the number of room reservations
go
create view customersBookedMoreone
as
select ho. CustID, c. CustName, c.DOB, c. Tel, COUNT (ho. CustID) numberReservation from tblHotelOrder ho join tblCustomer c on c.CustID = ho. CustID
group by ho. CustID, c. CustName, c.DOB, c.Tel
having COUNT (ho. CustID) > 1;
select * from customersBookedMoreOne;
--Test 5
insert into tblHotelOrder values ('004', '2023-05-30', 'KH002');
insert into tblRoomOrder values('004', 'R201', '2023-08-20', '2023-08-23')
insert into tblReservationDetail values ('004', 'R201', 'DLX');
