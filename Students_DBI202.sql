create database Students_DBI202
Go
use Students_DBI202
go
Drop table  if exists dbo.Student
go
create table Student(
StudentID int identity (1000,1) primary key,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Gender nvarchar(10) check (Gender in (N'Nam',N'Nữ')),
DOB date
)
Go
Drop table  if exists dbo.Subject
go
create table Subject(
SubjectID varchar(6) primary key,
SubjectName nvarchar(30) not null,
credit tinyint, 
constraint CK_SubjectID CHECK (SubjectID LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]') 
)
Go
Drop table  if exists dbo.Course
go
Create table Course(
CourseID int primary key identity(1,1),
CourseName nvarchar(10) not null,
Semester varchar(10),
NumberOfStudents tinyint, 
SubjectID varchar(6) Foreign key references Subject(SubjectID)
)
Go
--Code for insert values to all table

insert into Student(FirstName,LastName,DOB,Gender)
values(N'Lê',N'Nhất Huy','2000-02-20', N'Nam'),
(N'Nguyễn',N'Thu Thủy','2002-10-21', N'Nữ'),
(N'Trần Thị',N'Thanh Nhàn','2004-10-22', N'Nữ'),
(N'Lê Nguyễn',N'Hoài Nhân','2003-02-02', N'Nam'),
(N'Trần',N'Bảo Thi','2004-01-01', N'Nữ')


insert into Subject(SubjectID, SubjectName, credit)
values('PRN211', N'Lập trình C#',3),
('DBI202', N'Cơ sở dữ liệu',3),
('SWE201',N'Kỹ thuật phần mềm',2),
('PRF192',N'Lập trình cơ bản với C',2),
('SWT301',N'Kiểm thử phần mềm',2)

insert into Course(CourseName,Semester,NumberOfStudents,SubjectID)
values(N'SE17A01','FA23',0,'PRF192'),
(N'SE1604','FA23',0,'SWE201'),
(N'SE18C06','SU23',0,'DBI202'),
(N'SE1605','FA23',0,'DBI202'),
(N'SE18B01','SU23',30,'PRN211'),
(N'SE17B02','SU23',30,'SWT301')

--Write your queries here
--2.	Write sql statement to create the table (- name the table: Enrolment-) from the entity that was adding into ERD at question 1. Apply as much as possible constraints for each column of the table
create table Enrollment(
StudentID int foreign key references Student(StudentID),
CourseID int foreign key references Course(CourseID),
Grade float check (Grade between 0 and 10),
Attendance smallint check (Attendance between 0 and 20),
Primary key(StudentID, CourseID) 
)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1000,3,1,5.5)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1000,4,0, 9.0)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1002,3,3, 4.5)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1002,4,3, 2.5)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1003,3,0, 9.5)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1003,4,0, 7.5)

insert into Enrollment(StudentID,CourseID,Attendance, Grade)
values(1004,5,1, 7.5)

--3.	Create a store procedure to enroll a student into a course. Do not allow duplicate enrollment: raise error if a student enrolls two times in the same course. 
if OBJECT_ID('usp_EnrollToCourse','p') is not null
drop proc usp_EnrollToCourse
go
create procedure usp_EnrollToCourse
@studentID int,
@courseID int,
@gpa FLOAT,
@attendance TINYINT
AS
Begin
If (@studentID is Null) or (@courseID is Null) RAISERROR('Wrong Arguments', 10,1)
Insert into Enrollment (StudentID, CourseID, Attendance, Grade) 
  values (@studentID, @courseID, @attendance, @gpa)
If @@rowcount<>1
Begin
RAISERROR('Something wrong.. Enrollment failed..',10,1)
Rollback Transaction
End

End
Go 


--4.	Create a function that calculate the total of credits of a student that enrolled in a semester. 
go
CREATE FUNCTION udf_calTotalCredits
(
@StudentID INT, @Semester VARCHAR(10)
)
RETURNS INT
AS
BEGIN
DECLARE @TotalCredits INT;
SELECT @TotalCredits = SUM(s.credit)
FROM Enrollment e
INNER JOIN Course c ON e.CourseID = c. CourseID
INNER JOIN Subject s ON c. SubjectID = s. SubjectID
WHERE e. StudentID = @StudentID AND c. Semester = @Semester;
RETURN ISNULL (@TotalCredits, 0)
END
go

--5.	Create a trigger to update number of students of a course (increase by 1) whenever a student enrolls into a course. 
IF OBJECT_ID('u_trgNumberOfStudent_EnrollCourse', 'tr') IS NOT NULL
    DROP TRIGGER u_trgNumberOfStudent_EnrollCourse
GO

CREATE TRIGGER u_trgNumberOfStudent_EnrollCourse
ON Enrollment
AFTER INSERT
AS
BEGIN
DECLARE @courseID INT SET @courseID= (SELECT CourseID FROM inserted)
UPDATE Course
SET NumberOfStudents = NumberOfStudents + 1 WHERE CourseID = @courseID
END
INSERT INTO Enrollment (StudentID, CourseID, Attendance, Grade) VALUES (1001,4,2,8.8)




