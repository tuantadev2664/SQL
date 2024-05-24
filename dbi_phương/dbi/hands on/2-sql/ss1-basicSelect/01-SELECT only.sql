USE Northwind --chọn để chơi với thùng chứa nào đó
SELECT * FROM Customers
SELECT * FROM Employees

----------------------
--li thuyet
--1.DBE cung cap câu lệnh Select để
--in ra man hinh cai gi do__print_sout
--in ra dữ liệu có trong table
--dủng cho mục đích nào đó thì kết quả hiển thị luôn là table
-------------------------
--1.hôm nay là ngày bao nhiêu
SELECT GETDATE()

SELECT GETDATE() AS [hôm nay là ngày]
--Hôm nay là tháng mấy
SELECT MONTH(GETDATE()) AS [Hôm nay là tháng mấy?]
--3.tri tuyet doi cu -5 la mấy
SELECT ABS(-5) AS [3.tri tuyet doi cu -5 la mấy]
--4.5+5 là mấy
SELECT 5+5 AS [5+5 là mấy]
--5.in ra tên của mình
SELECT N'Nguyễn Thị Thu Phương' AS [my full name is]
SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG' AS [My full name is]
--tính tuổi
SELECT YEAR(GETDATE())- 2004
--SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG' + (YEAR(GETDATE())- 2004)+'years old'->loi vi lon xon kieu data
SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG ' + CONVERT(VARCHAR,YEAR(GETDATE())- 2004)+' years old'	SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG ' + CAST(YEAR(GETDATE())- 2004 AS varchar)+' years old'	AS [My profile]
SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG ' + CONVERT(VARCHAR,YEAR(GETDATE())- 2004)+' years old'	SELECT N'NGUYỄN'  +  N'THỊ THU PHƯƠNG ' + CAST(YEAR(GETDATE())- 2004 AS varchar)+' years old'	AS Myprofile
--7.Phép nhân hai số
SELECT 10*10 AS [10*10=]