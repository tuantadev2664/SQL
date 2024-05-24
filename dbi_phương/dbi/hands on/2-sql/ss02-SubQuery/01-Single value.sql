USE Northwind
---------------------------------------
--LÍ THUYẾT
--cÚ PHÁP CHUẨN CỦA CÂU LÊNH SELECT
--SELECT *FROM<TABLE>WHERE
--WHERE CỘT = VALUE NÀODDOS
--WHERE CỘT LIKE [PATTREN] NÀO ĐÓ E.G. '_____'
--WHERE CỘT BETWEEN RANGE
--WHERE CỘT IN(TẬP HỢP GIÁ TRỊ ĐƯỢC LIỆT KÊ)
--Một câu select có thể trả về đúng 1 value/cell
--Một câu select có thể trả về một tập value
--Tập kết quả này đồng nhất(các giá trị khác nhau của một biến)
***
--where cột = 1 value nào đó-đã học,e.g YEAR(DOB)=2003
--          =Thay value này bằng 1 sql khác miễn trả về 1 cell
--Kĩ thuật viết câu sql theo kiểu hỏi gián tiếp
--trong câu sql chứa câu sql khác
-------------------------------------
--THỰC HÀNH
--1.iN RA DS NHÂN VIÊN
SELECT *FROM Employees
SELECT FirstName  FROM Employees WHERE EmployeeID =1--return 1 cell
SELECT FirstName  FROM Employees--trả về 1 tập giá trị/cột /phép chiếu
--2.Liệt kê các nhân viên ở LONDON
SELECT *FROM Employees WHERE City ='London'
--3.Những ai cùng quê với King Robert
SELECT *FROM Employees WHERE FirstName='Robert'
SELECT City FROM Employees WHERE FirstName='Robert' --1 value london
--đáp án cho câu 3
SELECT *FROM Employees 
	Where City =(SELECT City FROM Employees WHERE FirstName='Robert') AND FirstName<>'Robert'
	--câu này chưa full điểm,trong kết quả vẫn còn robert
--tìm cùng quê robert thi không cần nói lại robert
 --4.Liệt kê các đơn hàng 
 SELECT *FROM Orders ORDER BY Freight DESC
 --4.1.Liệt kê tất cả các đơn hàng trọng lượng lớn hơn 252kg
 SELECT *FROM Orders WHERE Freight>=252
 --4.2.LIệt kê các đơn hàng có trọng lượng lớn hơn hay = trọng lượng đơn hàng 10555
 SELECT *FROM Orders
			WHERE  Freight>=  (SELECT Freight FROM Orders
					WHERE OrderID=10555) 
					--xuất hiện luôn 10555
SELECT *FROM Orders
WHERE  Freight>=  (SELECT Freight FROM Orders
					WHERE OrderID=10555 ) AND OrderID<>10555
					--btvn
					--1.Liệt kê danh sách các công ty vận chuyển hàng
					SElECT * FROM  Shippers
					--2.Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có mã số 
					--là 1
					SElECT *FROM Orders WHERE ShipVia=1
					
					--3.Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao
					--vận có tên Speedy express
					SELECT *FROM Orders WHERE ShipVia= (SElECT ShipperID FROM Shippers WHERE CompanyName='Speedy Express')
					--4.Liệt kê danh sách các đơn hàng được vận chuyển bởi cty giao vận có 
					--ten Speedy express và trọng lượng từ 50-100
					SELECT *FROM Orders WHERE ShipVia= (SElECT ShipperID FROM Shippers WHERE CompanyName='Speedy Express') AND (Freight between 50 AND 100)

					SELECT *FROM Orders WHERE ShipVia= (SElECT ShipperID FROM Shippers WHERE CompanyName='Speedy Express') AND Freight >=50 AND Freight<=100


					--5.Liệt kê các mặt hàng cùng chủng loại và mặt hàng filo mix
					--filo mix la san pham
					 SElECT *FROM Categories
					 SELECT *FROM Products
					 SELECT *FROM Products WHERE CategoryID =(SELECT CategoryID FROM Products WHERE ProductName  ='Filo Mix')

					--6.Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet
					SELECT *FROM Employees WHERE  BirthDate>(SELECT BirthDate FROM Employees Where FirstName='Janet')