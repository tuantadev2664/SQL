use Northwind
----
--LÍ THUYẾT
--SELECT*FROM<TABLE>WHERE
--WHERE CỘT TOÁN TỬ SO SÁNH với value cần lọc
--cột> >= < <= != value
--            dùng câu sub-query tùy ngữ cảnh
--cột               =(sub chỉ có 1 value)
--cột                in(sub chỉ có 1 cột nhưng nhiều value)
-- cột > >= < <= ALL(1 câu sub 1 cột nhiều value)
--               ANY (1 câu sub 1 cột nhiều value)
---------------------
--THỰC HÀNH--
--tạo 1 table có một cột ên là numbr,chỉ chứa 1 đống dòng các số nguyên
CREATE TABLE num 
(
	numbr int

)
SELECT*FROM num
INSERT INTO num values(1)
INSERT INTO num values(1)
INSERT INTO num values(2)
INSERT INTO num values(1)
INSERT INTO num values(9)
INSERT INTO num values(5)
INSERT INTO num values(100)
INSERT INTO num values(101)
--1.In ra những số >5
SELECT *FROM num WHERE numbr>5
--2.In ra số lớn nhất trong các số đã nhập
--số lớn nhất trong 1 đám được định nghĩa là lớn hết đám đó ngoại trừ chính nó
SELECT *FROM num WHERE numbr>=ALL(SELECT*FROM num)
--3.TÌM MIN
SELECT *FROM num WHERE numbr<=ALL(SELECT*FROM num)
SELECT *FROM num WHERE numbr>ALL(SELECT*FROM num)--rỗng 
--4.nhân viên nào lớn tuổi nhất
SELECT *FROM Employees WHERE BirthDate<=ALL(SELECT BirthDate FROM Employees)
--5.Đơn hàng nào có trọng lượng nặng nhất
SELECT *FROM Orders WHERE Freight>=ALL(SELECT Freight FROM Orders)
