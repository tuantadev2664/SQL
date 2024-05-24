create database DB_PE_DBI202
Go
use DB_PE_DBI202

create table Student(
StudentID int identity (1,1) primary key,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Gender nvarchar(10) check (Gender in (N'Nam',N'N?')),
DOB date
)
Go
create table Subject(
SubjectID varchar(7) primary key,
SubjectName nvarchar(30) not null,
credit smallint
)
Go
Create table Course(
CourseID int primary key identity(1,1),
CourseName nvarchar(10) not null,
Semester varchar(10),
NumberOfStudents smallint, 
SubjectID varchar(7) Foreign key references Subject(SubjectID)
)
Go
--Code for insert values to all table
insert into Student(FirstName,LastName,DOB,Gender)
values(N'L�',N'Nh?t Huy','2000-02-20', N'Nam'),
(N'Nguy?n',N'Thu Th?y','2002-10-21', N'N?'),
(N'Tr?n Th?',N'Thanh Nh�n','2004-10-22', N'N?'),
(N'L� Nguy?n',N'Ho�i Nh�n','2003-02-02', N'Nam'),
(N'Tr?n Thanh',N'Th?y','2004-01-01', N'N?')


insert into Subject(SubjectID, SubjectName, credit)
values('PRN211', N'L?p tr�nh C#',3),
('DBI202', N'C? s? d? li?u',3),
('SWE201c',N'K? thu?t ph?n m?m',2),
('PRF192',N'L?p tr�nh c? b?n C',2),
('SWT302',N'Ki?m th? ph?n m?m',2)

insert into Course(CourseName,Semester,NumberOfStudents,SubjectID)
values(N'SE17A01','FA23',0,'PRF192'),
(N'SE1604','FA23',0,'SWE201c'),
(N'SE18C06','SU23',0,'DBI202'),
(N'SE1605','FA23',0,'DBI202'),
(N'SE18B01','SU23',30,'PRN211'),
(N'SE17B02','SU23',30,'SWT302')

/* 
 * Begin of candidate's work 
 */

/*
 * Question 2
 */

 -- Create the table's schema
 create table Enrolment
 (
	StudentID int foreign key (StudentID) references Student(StudentID),
	CourseID int foreign key (CourseID) references Course(CourseID),
	Attendance int check (Attendance between 0 and 20),
	Gpa float check(Gpa between 0 and 10),
	primary key (StudentID, CourseID)
 )

 -- Insert records into table
 insert into Enrolment(StudentID, CourseID, Attendance, Gpa) 
 values (1, 6, 10, 8),
 (2, 5, 9, 9),
 (3, 4, 7, 9.5)

 /*
 * Question 3
 */
 alter procedure spr_EnrollStudent
 (
	@StudentID int,
	@CourseID int,
	@Attendance int,
	@Gpa float
 )
 as
 begin
	begin transaction 
	--if not exists (select 1 from student where StudentID = @StudentID)
	--begin
	--	rollback
	--	raiserror('data invalid studentID', 16, 1)
	--end
	--if not exists (select 1 from Course where CourseID = @CourseID)
	--begin
	--	rollback
	--	raiserror('data invalid course', 16, 1)
	--end
	if exists (select 1 from Enrolment where StudentID = @StudentID and CourseID = @CourseID)
	begin
		
		raiserror('data is duplicate', 16, 1)
		rollback
		return
	end
	insert into Enrolment(StudentID, CourseID, Attendance, Gpa) 
	values(@StudentID, @CourseID, @Attendance, @Gpa)
	commit transaction				

	--đi tham khảo
	--If @@rowcount<>1
	--Begin
	--	RAISERROR('Something wrong.. Enrollment failed..',16,1)
	--	Rollback
	--End
 end
 go

 exec  spr_EnrollStudent 1, 2, null, null

 select * from enrolment
 select * from student
 select * from course
/*
 * Question 4
 */
 alter function fc_CalcTotalCredits
 (
	@studentID int,
	@semester varchar(10)
 )
 returns int
 as
 begin
	declare @total int
	select @total = sum(Subject.credit)
	from Enrolment 
	join course on Enrolment.CourseID = Course.CourseID
	join Subject on Course.SubjectID = Subject.SubjectID
	where Enrolment.StudentID = @studentID and course.Semester = @semester
	return isnull (@total,0)
 end
 go

 --select dbo.fc_CalcTotalCredits(5, 'SU23')

 --select * from Enrolment
 --select * from Course
 --select * from Subject

 /*
 * Question 5
 */
 create trigger tr_Update_Num_Of_Student
 on enrolment
 after insert
 as
 begin
	declare @courseID int
	set @courseID = (select CourseID from inserted)
	update Course
	set NumberOfStudents  = NumberOfStudents + 1
	where CourseID = @CourseID

	If @@rowcount<>1 
       Begin
        RAISERROR('Something wrong..Enrollment failed..',10,1)
        Rollback Transaction
       End
 end
 go

 select * from Enrolment
 select * from Course
 select * from Subject

 insert into Enrolment(StudentID, CourseID)
 values(2, 6)