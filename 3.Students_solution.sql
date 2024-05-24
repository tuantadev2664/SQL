create database DB_PE_DBI202_Enrollment
Go
use DB_PE_DBI202_Enrollment

drop table Student
create table Student(
StudentID int identity (1,1) primary key,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Gender nvarchar(10) check (Gender in (N'Nam',N'Nữ')),
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
Semester varchar(10) not null,
NumberOfStudents smallint check(NumberOfStudents between 0 and 35), 
SubjectID varchar(7) Foreign key references Subject(SubjectID)
)
Go
--Code for insert values to all table
insert into Student(FirstName,LastName,DOB,Gender)
values(N'Lê',N'Nhất Huy','2000-02-20', N'Nam'),
(N'Nguyễn',N'Thu Thủy','2002-10-21', N'Nữ'),
(N'Trần Thị',N'Thanh Nhàn','2004-10-22', N'Nữ'),
(N'Lê Nguyễn',N'Hoài Nhân','2003-02-02', N'Nam'),
(N'Trần Thanh',N'Thủy','2004-01-01', N'Nữ')


insert into Subject(SubjectID, SubjectName, credit)
values('PRN211', N'Lập trình C#',3),
('DBI202', N'Cơ sở dữ liệu',3),
('SWE201c',N'Kỹ thuật phần mềm',2),
('PRF192',N'Lập trình cơ bản C',2),
('SWT302',N'Kiểm thử phần mềm',2)

insert into Course(CourseName,Semester,NumberOfStudents,SubjectID)
values(N'SE17A01','FA23',0,'PRF192'),
(N'SE1604','FA23',0,'SWE201c'),
(N'SE18C06','SU23',0,'DBI202'),
(N'SE1605','FA23',0,'DBI202'),
(N'SE18B01','SU23',30,'PRN211'),
(N'SE17B02','SU23',30,'SWT302')
Go
-----------------------------------------------------------------
--2. Write sql statement to create table Enrolment. 
--Apply as much as possible constraints for each column of the table

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
-----------------------------------------------------------------
--3. Create a store procedure to enroll a student into a course. 
--Do not allow duplicate enrollment, 
--raise error if a student enrolled two times in the same course. 
go
--Cách 1
create procedure usp_enrollToCourse
@studentID int,
@courseID int,
@gpa FLOAT,
@attendance TINYINT
AS
Begin
  If (@studentID is Null) or (@courseID is Null)
     RAISERROR('Wrong Arguments',10,1) 

  Insert into Enrollment(StudentID,CourseID,Attendance, Grade)
		values(@studentID,@courseID,@attendance,@gpa)

  If @@rowcount<>1 
    Begin
      RAISERROR('Something wrong..Enrollment failed..',10,1)
      Rollback Transaction
    End
End
Go
--Cách 2
CREATE PROCEDURE usp_EnrollStudent
    @StudentID INT,
    @CourseID INT,
    @gpa FLOAT,
    @attendance TINYINT
AS
	BEGIN TRANSACTION	
    
	IF EXISTS (
        SELECT 1
        FROM Enrollment
        WHERE StudentID = @StudentID AND CourseID = @CourseID
    )
    BEGIN
        RAISERROR('The student is already enrolled in the course.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END 
    
    INSERT INTO Enrollment (StudentID, CourseID,Grade, attendance) 
    VALUES (@StudentID, @CourseID, @gpa, @attendance)
    
    COMMIT TRANSACTION;
-----------------------------------------------------------------
--4.Create a function that calculate the total of credits of a student 
--that enrolled in a semester.
go
create function GetTotalCredit(@studentID int,@sem varchar(10))
Returns smallint
AS
Begin
	declare @totalCredits smallint
      Select @totalCredits = (select sum(sb.credit)
	 from Subject sb 
	 inner join Course c
	 on sb.SubjectID = c.CourseID
	 inner join  Enrollment en on  c.CourseID = en.CourseID
	where en.StudentID = @studentID and c.Semester =@sem
	Group by en.StudentID)
	return @totalCredits
End
Go
-- Cách 2
go
CREATE FUNCTION udf_calTotalCredits
(
    @StudentID INT,
    @Semester VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCredits INT;

    SELECT @TotalCredits = SUM(s.credit)
    FROM Enrollment e
    INNER JOIN Course c ON e.CourseID = c.CourseID
    INNER JOIN Subject s ON c.SubjectID = s.SubjectID
    WHERE e.StudentID = @StudentID AND c.Semester = @Semester;

    RETURN ISNULL (@TotalCredits,0)
END
go
-----------------------------------------------------------------
--5.Create a trigger to update number of student of table course (increase by 1) whenever a student enrolls into a course.
go
IF OBJECT_ID('u_trgEnrollmentInsert', 'tr') is not null
    DROP TRIGGER u_trgEnrollmentInsert;
go
Create trigger trg_Enrollment_Insert ON Enrollment For Insert
AS
	Begin
	 declare @courseID int
	 Select @courseID=courseID from inserted
	 UPDATE Course SET NumberOfStudents = NumberOfStudents+1
	 where CourseID = @courseID
      If @@rowcount<>1 
       Begin
        RAISERROR('Something wrong..Enrollment failed..',10,1)
        Rollback Transaction
       End
	End

-----------------------------------------------------------------
go
IF OBJECT_ID('u_trgEnrollmentInsert', 'TR') is not null
    DROP TRIGGER u_trgEnrollmentInsert;
GO
--Cách 2: Lưu ý thêm rô
CREATE TRIGGER u_trgEnrollmentInsert
ON Enrollment
AFTER INSERT
AS
BEGIN
    DECLARE @cid INT;
    SELECT @cid = CourseID FROM inserted;
    UPDATE Course SET NumberOfStudents = NumberOfStudents + 1 WHERE CourseID = @cid
	If @@rowcount<>1 
       Begin
        RAISERROR('Something wrong..Enrollment failed..',10,1)
        Rollback Transaction
       End
END
GO

INSERT INTO Enrollment (StudentID, CourseID) VALUES (2004, 6);

SELECT * FROM Enrollment;

SELECT * FROM Course;