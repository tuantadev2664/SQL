--lay ra sv và điểm của từng môn học với dkien grade ! = F
select st.FirstName + st.LastName  AS 'Full Name', sb.Name, en.Grade
from Student st
inner join Enrollment en
on st.ID = en.IdStudent
inner join Subject sb
on sb.ID = en.IdSubject
where grade<> 'F'

--Viết 1 thủ tục chèn dữ liệu vào bảng subject
go
alter procedure usp_Subject_Insert
@Name nvarchar(50),
@Description nvarchar(50),
@credit smallint
AS
	INSERT INTO subject(Name,Description,credit)
	Values(@Name,@Description,@credit)

EXEC usp_Subject_Insert @Name = N'C', @Description =N'NN LT C', @credit = 5

--1. View
go
Create View v_Subject1
AS
	Select Name, credit
	from Subject

Select * from v_Subject1

Insert into v_Subject1(Name,credit)
values(N'Kiểm thử',4)

--Tạo view có subject mà creadit >2
go
Create View v_Subject2
AS
	Select Name, credit
	from Subject
	where credit>2

--Chạy view
Select * from v_Subject2

--Tạo 1 view cho phep chi subject co credit >2 & tên bắt đầu = P
go
alter view v_subjectGrade
AS
	Select Name, credit
	from Subject
	where credit>2 AND Name like N'P%'
	with check option

Select * from v_subjectGrade

--Chèn
Insert into v_subjectGrade(Name, credit)
values(N'Python',5)

Insert into v_subjectGrade(Name, credit)
values(N'Python2',1) --error vì vi pham dieu kien With check option

--Viết thủ tục hiển thị số tín chỉ mà sv đã đạt được 
-- Tạo thủ tục
CREATE PROCEDURE GetTotalCreditsForStudent
    @StudentID INT
AS
BEGIN
    SELECT st.ID, SUM(sb.credit) AS TotalCredits
    FROM student st
    INNER JOIN Enrollment en ON st.ID = en.IdStudent
    INNER JOIN subject sb ON sb.ID = en.IdSubject
    WHERE en.Grade <> 'F' AND st.ID = @StudentID
    GROUP BY st.ID;
END;

--Viết thủ tục lấy điểm của sv nào đó và môn học 
go
create proc usp_Student_getGradeSubject
@studentID int,
@subjectName nvarchar(30)
AS
	select st.FirstName + st.LastName  AS 'Full Name', sb.Name, en.Grade
	from Student st
	inner join Enrollment en
	on st.ID = en.IdStudent
	inner join Subject sb
	on sb.ID = en.IdSubject
	where st.ID = @studentID AND sb.Name LIKE N'%'+@subjectName+'%'

Exec usp_Student_getGradeSubject @studentID = 1, @subjectName = N'P'
--functions
--Trả về 1 giá trị
--viết 1 hàm trả về số tín chỉ của một môn học nào đó
go
Create function ufn_getCredit(
@name nvarchar(30)
)
returns int
AS
Begin
	declare @soLuong int
	select @soluong =credit
	from subject
	where Name Like N'%'+@name+ '%'

	return @soLuong
End

select dbo.ufn_getCredit(N'DBI202')

Select * from subject
--Viết hàm lấy ra các môn học có stc> 3 --tham số
go
create function ufn_getSubject(
@credit int
)
returns table
AS
	return
		select * from subject
		where credit> @credit

--chạy function trả về bảng
Select * from ufn_getSubject(3)

--Tạo trigger in ra thông báo đã chèn thành công
create trigger trg_Subject 
ON Subject
For insert
AS
	print N'Đã chèn thành công!'

--Insert
Insert into Subject(Name, Credit)
values(N'Java',3)
create trigger trg_SubjectInfor 
ON Subject
For insert
AS
	--cần lấy ID, Name của dữ liệu chuẩn bị thêm vào
	declare @id int
	declare @name nvarchar(30)
	SET @id = (select id from inserted)
	SELECT @name = Name from inserted --ngắn gọn
	print @id
	print @name
	print N'Đã chèn '+ CAST(@id AS varchar) +' ,'+@name+ ' thành công!'
--Tạo trigger in ra thông báo chỉ cho phép chèn tin chi >=2
create trigger trg_SubjectAddByCredit
ON Subject
For insert
AS
	--cần lấy credit của dòng chuẩn bị được thêm vào
	declare @credit int
	Select @credit = credit from inserted
	IF @credit <2
		--Không được phép chèn
		Begin
			Raiserror(N'Lỗi yêu cầu số tín chỉ >=2', 16,1)
			rollback transaction --hủy thêm vào
		End
	else
	Begin
		--cần lấy ID, Name của dữ liệu chuẩn bị thêm vào
		declare @id int
		declare @name nvarchar(30)
		SET @id = (select id from inserted)
		SELECT @name = Name from inserted --ngắn gọn
		
		print N'Đã chèn '+ CAST(@id AS varchar) +' ,'+@name+ ' thành công!'
	End
	
	
	 
Insert into Subject(Name, Credit)
values(N'Lenin',1)

Insert into Subject(Name, Credit)
values(N'Lenin',3)
--Trigger 
--Tạo 1 trigger mỗi khi xóa dữ liệu ở bảng subject
--thì cập nhật email của student mà có Giới tính Nam bằng NULL
go
create trigger trg_Subject
ON Subject
FOR DELETE
AS
	Update Student 
	SET Email = NULL
	Where Gender = 'Nam'

delete from Subject
where ID= 23

select * from student

--
Declare @check int = 3 
select ID
from student
where exists (select IdStudent 
				from Enrollment
				where IdStudent = @check)
go
Declare @check int = 3 

IF exists (select IdStudent 
				from Enrollment
				where IdStudent = @check)
begin
	print N'Có sv có mã '+ CAST(@check AS nvarchar) +' trong bảng Enrollment'
end
Else
	print N'K Có sv có mã '+ CAST(@check AS nvarchar)  +N' trong bảng Enrollment'


	--
	CREATE PROCEDURE CheckStudentExistence
    @check INT
AS
BEGIN
    IF EXISTS (
        SELECT IdStudent
        FROM Enrollment
        WHERE IdStudent = @check
    )
    BEGIN
        PRINT N'Có sv có mã ' + CAST(@check AS NVARCHAR) + ' trong bảng Enrollment'
    END
    ELSE
    BEGIN
        PRINT N'Không có sv có mã ' + CAST(@check AS NVARCHAR) + N' trong bảng Enrollment'
    END
END



--CREATE PROCEDURE AddCustomer
  --  @Name VARCHAR(50),
 --   @Email VARCHAR(50),
  --  @Phone VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customers (Name, Email, Phone)
        VALUES (@Name, @Email, @Phone)
    END TRY
    BEGIN CATCH
        -- Error handling code goes here
        PRINT 'An error occurred while adding the customer.'
        PRINT 'Error message: ' + ERROR_MESSAGE()
    END CATCH
END