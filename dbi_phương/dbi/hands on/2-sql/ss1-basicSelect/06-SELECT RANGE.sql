USE Northwind
--------------------
--------------------LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG LỆNH SELECT
--Khi cần lọc dữ liệu trong 1 đoạn cho trước ,thay vì dùng >=	AND A<=,ta có thể thay thế bằng mệnh đề
--between,in
--CÚ PHÁP: cột BEWTEEN value 1 and value 2->between thay thế cho mệnh đề AND
--CÚ PHÁP: CỘT IN (MỘT Tập các giá trj liệt kê cách nhau dấu phẩy)->thay thể cho 1 loại OR


--1.	Liệt kê nhân viên sinh trong đoạn 1960-1970
SELECT*FROM Employees WHERE YEAR(BirthDate)>=1960 AND  YEAR(BirthDate)<=1970
SELECT*FROM Employees WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970
--2.Liệt kê các đơn hàng có trọng lượng từ 100-500--4
SELECT *FROM  Orders WHERE  Freight BETWEEN 100 AND 500-174
--3.Liệt kê các đơn hàng gọi tên anh pháp mĩ
SELECT *FROM Orders WHERE ShipCountry ='USA' OR ShipCountry='France' OR ShipCountry='UK'
SELECT *FROM Orders WHERE ShipCountry in ('USA','France','UK')
--4.Đơn hàng nào không gửi tới anh ,pháp,mĩ
SELECT *FROM Orders WHERE NOT (ShipCountry in ('USA','France','UK'))
SELECT *FROM Orders WHERE ShipCountry NOT in ('USA','France','UK')
--5.Liệt kê các đơn hàng trong năm 1996 ngoại trừ tháng 6.7.8.9.
SELECT *FROM Orders WHERE YEAR(OrderDate)=1996 AND MONTH(OrderDate) NOT IN (6,7,8,9)
----LƯU Ý:chỉ khi ta liệt kê khaofng giá trị mới chơi được in
--Khoảng số thực thì không làm được
--6.liệt kê đơn hàng có trọng lượng 100..110
SELECT*FROM Orders WHERE Freight>=100 AND Freight<=110 ORDER BY Freight DESC
SELECT*FROM Orders WHERE Freight BETWEEN 100 AND 110 ORDER BY Freight DESC
SELECT*FROM Orders WHERE Freight in()--100..110 vô số giá trị thực->không dùng in