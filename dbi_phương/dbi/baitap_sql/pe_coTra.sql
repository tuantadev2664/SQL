--2.
CREATE TABLE Class (
    ID INT,
    Name NVARCHAR(50),
    SchoolYear INT,
    NumberOfStudents INT CHECK (NumberOfStudents > 0),
    CONSTRAINT PK_class PRIMARY KEY(ID),
    CONSTRAINT UC_TenPB UNIQUE(Name)
);

INSERT INTO Class (ID, Name, SchoolYear, NumberOfStudents) VALUES
(1, 'Class A', 2023, 30),
(2, 'Class B', 2023, 25),
(3, 'Class C', 2023, 28),
(4, 'Class D', 2023, 22),
(5, 'Class E', 2023, 35);
INSERT INTO Students (StudentID, StudentName, ClassID) VALUES
(1, 'Student 1', 1),  
(2, 'Student 2', 1),  
(3, 'Student 3', 2), 
(4, 'Student 4', 2), 
(5, 'Student 5', 3);  
--3.Write a query to select information of a student with ID, Full Name, Age 
--The result is ordered by age (ascending) then by ID (descending). (0.5 mark)

SELECT StudentID ,StudentName ,Age
FROM Students
ORDER BY Age ASC, ID DESC;
--4.4.Write a query to select all information of student with their grade (1 mark)
--Required columns in the result: Full Name, Subject Name, Grade.
SELECT
    s.StudentName,
    sub.SubjectName ,
    g.Grade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Subjects sub ON g.SubjectID = sub.SubjectID;


--5.5.Write a query to count total of credits that a student who enrolled with the grade must not be ‘F’. (1 mark)
SELECT s.StudentName , SUM(sub.Credits) AS TotalCredits
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Subjects sub ON g.SubjectID = sub.SubjectID
WHERE g.Gradeid <> 'F'
GROUP BY s.StudentName;
--6.Create a user defined stored procedure with the name usp_getNumberOfStudent 
--of a class. (Number of student is a calculate column).
 --Required columns in the result: ID, Class Name, Number of students
 GO
CREATE PROCEDURE usp_getNumberOfStudent(
    @ClassID INT
	)
AS
BEGIN
    SELECT
        c.ID,
        c.Name AS [Class Name],
        COUNT(s.StudentID) AS [Number of students]
    FROM Class c
    LEFT JOIN Students s ON c.ID = s.ClassID
    WHERE c.ID = @ClassID
    GROUP BY c.ID, c.Name;
END;




