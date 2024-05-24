USE ReportManage
---INSERT GIÁ TRỊ
INSERT INTO Users(Username,Password,Name,Gender,BirthDate,Age,Email) VALUES (N'phuong2004',N'p12345',N'Thu Phương','F',2004-02-19,19,N'phuong12@gmail.com')
INSERT INTO Users(Username,Password,Name,Gender,BirthDate,Age,Email) VALUES (N'mai2002',N'mai12365',N'Hồng Mai','F',2002-02-05,21,N'Maichan12@gmail.com')
INSERT INTO Users(Username,Password,Name,Gender,BirthDate,Age,Email) VALUES (N'Huy2003',N'Huy78954',N'Thanh Huy','M',2003-03-07,20,N'Huy212@gmail.com')
INSERT INTO Users(Username,Password,Name,Gender,BirthDate,Age,Email) VALUES (N'Dao2002',N'd19194',N'Hồng Đào','F',1990-02-19,33,N'Hongdao14@gmail.com')
INSERT INTO Users(Username,Password,Name,Gender,BirthDate,Age,Email) VALUES (N'Cuc2003',N'cuc15433',N'Kim Cúc','F',2003-02-24,20,N'cucnguyen12@gmail.com')


INSERT INTO Departments (Name) VALUES(N'Phòng hành chính')
iNSERT INTO Departments (Name) VALUES(N'Phòng Nhân sự')
iNSERT INTO Departments (Name) VALUES(N'Phòng kế toán')
iNSERT INTO Departments (Name) VALUES(N'Phòng thương mại')
iNSERT INTO Departments (Name) VALUES(N'Phòng địa chất')
SELECT *FROM Departments

INSERT INTO Employees (FirstName,LastName,Gender,BirthDate,Age,DepartmentId )VALUES (N'Mai Trinh',N'Nguyễn','F','2000-01-01',23,1)
INSERT INTO Employees (FirstName,LastName,Gender,BirthDate,Age,DepartmentId )VALUES (N'Văn Tài',N'Hồ','M','2000-01-07',23,2)
INSERT INTO Employees (FirstName,LastName,Gender,BirthDate,Age,DepartmentId )VALUES (N'Hồng Hà',N'Hoàng','F','2003-02-17',20,3)
INSERT INTO Employees (FirstName,LastName,Gender,BirthDate,Age,DepartmentId )VALUES (N'Duy Anh',N'Nguyễn','M','2002-09-13',22,4)
INSERT INTO Employees (FirstName,LastName,Gender,BirthDate,Age,DepartmentId )VALUES (N'Thu Thủy',N'Lê','F','1999-01-08',24,5)


INSERT INTO Categories(Name,DepartmentId) VALUES (N'Laptop',1)
INSERT INTO Categories(Name,DepartmentId) VALUES (N'Máy tính cầm tay',2)
INSERT INTO Categories(Name,DepartmentId) VALUES (N'Máy in',3)
INSERT INTO Categories(Name,DepartmentId) VALUES (N'Kim điện tử',4)
INSERT INTO Categories(Name,DepartmentId) VALUES (N'Đĩa nhạc',5)

INSERT INTO Status(Label) VALUES (N'Đang chờ')
INSERT INTO Status(Label) VALUES (N'Đang xử lí')
INSERT INTO Status(Label) VALUES (N'Đã xử lí')
INSERT INTO Status(Label) VALUES (N'Tiếp nhận thông tin')
INSERT INTO Status(Label) VALUES (N'Đang đưa vào hàng đợi')

INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,Description,UserId,EmployeeId) VALUES (1,1,2023-10-10,2023-15-10,N'vàng',4,1)
INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,Description,UserId,EmployeeId) VALUES (2,5,2023-12-10,2023-15-10,N'xanh',5,2)
INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,Description,UserId,EmployeeId) VALUES (3,2,2023-02-07,2023-15-10,N'cam',6,5)
INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,Description,UserId,EmployeeId) VALUES (4,3,2023-11-10,2023-15-10,N'trắng',7,3)
INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,Description,UserId,EmployeeId) VALUES (5,4,2023-09-12,2023-15-10,N'hồng',8,4)

SELECT*FROM Employees
SELECT*FROM Categories
SELECT *FROM Reports
select*from Departments
select*from Employees
select *from Status
select*from Users


-----------------------------------------
--2.Write code to Select all user Select all Usernames with their age ordered by age (ascending) then by username (descending). 
SELECT Username,Age FROM  Users  ORDER BY Age ASC,Username DESC

--3.Find all reports that don’t have an assigned employee. Order the results by open date in ascending order, then by description (ascending).
SELECT  * FROM Reports WHERE EmployeeId IS NULL ORDER BY OpenDate ASC,Description ASC

--Select only employees who have an assigned report and show all reports of each found employee. Order them by employee id (ascending)
--then by open date (ascending) and then by report Id (again ascending).

--SELECT  *FROM Reports WHERE EmployeeId IS NOT NULL ORDER BY EmployeeId ASC, OpenDate ASC,Description ASC

SELECT  E.FirstName + '' + E.LastName AS N'Tên nhân viên',r.* FROM Employees E JOIN Reports R ON R.EmployeeId=E.Id WHERE R.EmployeeId IS NOT NULL
ORDER BY R.EmployeeId,R.OpenDate,R.Id

--4.Select ALL categories and the number of employees in each category and order them alphabetically by category name.
--Required columns:CategoryName,Employees Number

SELECT C.Name,COUNT(E.id) AS 'Number of employee' FROM Categories C 
JOIN Reports R ON R.CategoryId=c.id
JOIN Employees E ON R.EmployeeId=E.Id
GROUP BY  C.Name
ORDER BY C.Name ASC

--5.Create a store procedure with the name sp_GetEmployee that receives how many employee of a given department

GO
CREATE PROC sp_GetEmployee
(
@department_id INT,
@tổng_nv INT OUT
)
as

    select @tổng_nv=COUNT(E.id)
	from Employees E
	WHERE E.DepartmentId = @department_id

	SELECT @tổng_nv AS N'Tổng số nhân viên'

	----------------
	--CHẠY CÂU LỆNH PROC
	DECLARE @Tong int
	EXEC sp_GetEmployee @department_id=4 , @tổng_nv=@Tong OUT


	
	

	


