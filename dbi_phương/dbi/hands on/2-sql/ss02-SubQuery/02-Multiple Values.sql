USE Northwind
--LÍ THUYẾT
--cÚ PHÁP CHUẨN CỦA CÂU LÊNH SELECT
--SELECT *FROM<TABLE>WHERE
--WHERE CỘT = VALUE NÀODDOS
--Where cột in(1 tập hợp nào đó)
--ví dụ city in("london","berlin",...)
--=>city='london' or city='berlin'
--Nếu có 1 câu sql mà trả về được  nhiều dòng thì ta có thể xem nó tương đương là
--1 tập hợp
--Ta có thể nhét/lồng 1 cột nhiều dòng vào trong mệnh đề in của câu sql bên ngoài
--*Cú pháp:
--where cột in(một câu select trả về 1 cột nhiều dòng-nhiều value cùng kiểu-tập hợp)

--------------------------------------
--Thực hành
--1.Liệt kê các nhóm hàng
SELECT *FROM Categories
--2.In ra các Món hàng thuộc nhóm 1,6,8
SELECT * FROM Products Where CategoryID in(1,6,8)
SELECT * FROM Products Where CategoryID = 1 OR CategoryID=6 OR CategoryID=8
--3.iN ra các nhóm hàng thuộc nhóm bia,rượu,thịt và hải sản
SELECT * FROM Products Where CategoryID  IN (SELECT CategoryID FROM Categories WHERE CategoryName IN ('Beverages','Meat/Poultry','Seafood'))
--4.Nhân viên quê london phụ trách những đơn hàng nào
SELECT *FROM Employees
SELECT *FROM Orders
SELECT  EmployeeID FROM Employees WHERE City='london'
SELECT *FROM Orders WHERE EmployeeID IN (SELECT  EmployeeID FROM Employees WHERE City='london')
--btvn
--1.Cac nhà cung cấp đến từ Mỹ cung cấp những mặt hàng nào
--2.Cac nhà cung cấp đến từ Mỹ cung cấp những nhóm hàng nào
--3.Các đơn hàng vận chuyển tới thành phố Sao Paulo được vận hcuyeern bởi hãng vận chuyển nào
--các công ty đã vận chuyển hàng tói sao paulo
--4.Khách hàng đến từ thành phố berlin,london,madrid có những đơn hàng nào
--liệt kê các đơn hàng của khách hàng đến từ berlin,london và madrid
