create database CLUB_Mng
go
use CLUB_Mng
go
create table tblMembers
(
	memID varchar (10) primary key,
	FullName nvarchar(40) not null,
	phone varchar(10) not null Check(phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	memAdd nvarchar(80),
	DOB date,
	Email varchar(50)
);
go
Insert into tblmembers values('M001',N'Nguyễn Thanh Thúy','0905678541',N'47 Trần Văn Trà- Đà Nẵng','2002-05-18','thuy123@gmail.com')
Insert into tblmembers values('M002',N'Trần Minh Trung','0905678678',N'20 Lê Văn Hiến- Đà Nẵng','2000-03-10','trungmt@gmail.com')
Insert into tblmembers values('M003',N'Lâm Thanh Tân','0905679878',N'85 Phù Đổng- Đà Nẵng','2001-05-17','lamthanhtan@gmail.com')
go
create table tblClubs
(
	clubID int IDENTITY (1, 1) Primary key,
	clubName nvarchar(40) not null,
	creation_date date,
	club_description nvarchar (100),
	memID varchar (10) foreign key (memID) references tblMembers(memID)
);
go
Insert into tblClubs values(N'Câu lạc bộ lập trình','2020-09-05',N'Câu lạc bộ dành cho các bạn yêu thích lập trình', 'M001')
Insert into tblClubs values(N'Câu lạc bộ bóng đá','2019-03-07',N'Câu lạc bộ dành cho các bạn yêu bóng đá', 'M002')
Insert into tblClubs values(N'Câu lạc bộ khiêu vũ','2020-10-08',N'Câu lac bộ dành cho các bạn yêu thích khiêu vũ', 'M003')
go

/*
 * Question 2
 */

CREATE table tblMembersClubs
(
	memID varchar (10) foreign key (memID) references tblMembers(memID),
	clubID int foreign key (clubID) references tblClubs(clubID),
	join_date date not null,
	primary key (memID, clubID)
)
go
insert into tblMembersClubs (memID, clubID, join_date) values
('M001', 1, '2024-03-16'),
('M002', 2, '2024-03-17'),
('M003', 3, '2024-03-18')
go

/*
 * Question 3
 */

 create procedure pr_addMember
 (
	@memID varchar (10),
	@FullName nvarchar(40),
	@phone varchar(10) ,
	@memAdd nvarchar(80),
	@DOB date,
	@Email varchar(50)
 )
 as
 begin
	insert into tblMembers(memID, FullName, phone, memAdd, DOB, Email)
	values(@memID, @FullName, @phone, @memAdd, @DOB, @Email)
	if @@rowcount<>1
		begin
		 RAISERROR('Add new member fail ',16,1)
		 return -1;
		end
 end
 go


 /*
 * Question 4
 */
create trigger tr_ConstraintMember
 on tblMembersClubs
 after insert
 as
 begin
	declare @numOfClus int
	select @numOfClus = count(tblMembersClubs.clubID)
				from tblMembersClubs
				join tblClubs on tblMembersClubs.clubID = tblClubs.clubID
				join inserted on tblMembersClubs.memID = inserted.memID
				group by tblMembersClubs.memID
	if  ( @numOfClus > 5)
		begin
			raiserror('no join more than 5 clubs ', 16, 1)
			rollback
		end
 end
 go

 /*
 * Question 5
 */
 create view V_displayClubs as
 select count(tblMembersClubs.memID)
 from tblClubs 
 join tblMembersClubs on tblClubs.clubID = tblMembersClubs.clubID
 group by tblClubs.clubID
 having count(tblMembersClubs.memID) > 10
 go


	


