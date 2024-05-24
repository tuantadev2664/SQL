
USE Northwind
--Cu Phap Mo Rong:->
--Ta muốn sắp xếp dữ liệu-sort theo một tiêu chí nào đó
--Thường sẽ là tăng dần -ascending/asc hoặc giảm dần-descending/desc
--Mặc định : sx tăng dần
--A<B<C
--1<2<3
--Tac so thể sort trên nhiều cột
-SELECT .......FROM<TÊN TABLE> ORDERBY <TÊN CỘT MUỐN SORT> <KIỂU SORT>
--1.in ra ds nhân viên
SELECT *FROM Employees
--2.IN ra ds nhân viên tăng dần theo năm sinh
SELECT *FROM Employees ORDER BY BirthDate 
--3.IN ra ds nhân viên giảm dần theo năm sinh
SELECT *FROM Employees ORDER BY BirthDate DESC
--4.tính tiền chi tiết mua hàng
SELECT *,UnitPrice*Quantity*(1-Discount) AS Subtotal  FROM [Order Details]
--5.tính tiền chi tiết mua hàng,sắp xếp giảm dần theo số tiền
SELECT *,UnitPrice*Quantity*(1-Discount) AS Subtotal  FROM [Order Details] ORDER BY Subtotal DESC
--6 In ra danh sách nhân viên giảm dần theo tuổi
SELECT *FROM Employees
SElECT EmployeeID,FirstName,BirthDate,  YEAR(GETDATE())- YEAR(BirthDate) AS AGE FROM Employees ORDER BY  Age DESC