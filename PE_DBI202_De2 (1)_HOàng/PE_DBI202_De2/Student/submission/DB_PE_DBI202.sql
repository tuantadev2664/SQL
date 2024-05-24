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

-- Create the table's chema
CREATE TABLE Enrolment
(
    PRIMARY KEY (StudentID, CourseID),
    StudentID   INT,
                CONSTRAINT fk_sid FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    CourseID    INT,
                CONSTRAINT fk_cid FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    Attendance  INT 
                CHECK(Attendance >= 0),
    gpa         DECIMAL 
                CHECK(GPA >= 0)
)

-- Insert records into table
INSERT INTO Enrolment VALUES
(1, 1, 4, 8),
(1, 2, 5, 0),
(2, 3, 0, 9);
GO

/*
 * Question 3
 */
CREATE PROCEDURE enroll_student @student_id INT, @course_id INT
AS
BEGIN
    -- Start transaction
    BEGIN TRANSACTION;

    -- Check if the the student has enrolled in that course
    IF 
    (
        SELECT COUNT(*) 
          FROM Enrolment 
         WHERE StudentID = @student_id
           AND CourseId = @course_id
    ) > 0
    BEGIN
        -- Rollback the transaction
        ROLLBACK TRANSACTION;

        -- Raise an exception then return
        RAISERROR ('A student may only enrol in a course once.', 16, 1);
        RETURN;
    END

    -- Insert new enrolment into table, with the initial number of absent slot is zero
    INSERT INTO Enrolment(StudentID, CourseID, Attendance) 
         VALUES (@student_id, @course_id, 0);

    -- Commit the transaction
    COMMIT TRANSACTION;
END;
GO

/*
 * Question 4
 */
CREATE FUNCTION total_credits
(
    @student_id INT,
    @Semester   VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @credits INT

    -- SQL query to find the total number of credits
    SELECT  @credits = SUM(Credit)

      FROM  Enrolment
            JOIN Course
            ON Enrolment.CourseID = Course.CourseID
            JOIN Subject
            ON Course.SubjectID = Subject.SubjectID
     WHERE  Enrolment.StudentID = @student_id
       AND  Course.Semester = @Semester;

    /*
     * Return the number of credits (if any)
     *
     * Return NULL if student not found 
     * or has not enrolled in any course in the semester
     */
    RETURN @credits
END;
GO

/*
 * Question 5
 */
CREATE TRIGGER increment_number_of_students_in_a_course
ON Enrolment
AFTER INSERT
AS
BEGIN
    DECLARE @course_id INT
    DECLARE @number_of_students INT
    DECLARE old_values CURSOR
    FOR 
        SELECT  inserted.CourseID,
                NumberOfStudents
          FROM  inserted
                JOIN Course
                ON inserted.CourseID = Course.CourseID

    OPEN old_values
    FETCH NEXT FROM old_values INTO @course_id, @number_of_students
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE  Course
           SET  NumberOfStudents = @number_of_students + 1
         WHERE  CourseID = @course_id
        
        FETCH NEXT FROM old_values INTO @course_id, @number_of_students
    END
    CLOSE old_values
    DEALLOCATE old_values
END;
GO

/*
 * End of candidate's work
 */