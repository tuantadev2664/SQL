USE Northwind
--Một databse sẽ có nhiều table là nơi chứa data được 
--data duoc luu duoi dang table,tách thành nhiều table(nghệ thuật design db,NF)
--Dùng lệnh select để xem/in dữ liệu table,hiển thị dưới dạng table
--Cú pháp chuẩn SELECT*FROM<TÊN-TABLE>
--                     *đại diện cho việc muốn lấy all of column
--Cu Phap Mo Rong:->
--SELECT ten cac cot muon lay,cach nhau dau phay FROM <TEN TABLE>
--SELECT có thể dùng các hàm xử lí các cột để độ lại thôNG Tin hien thị
--FROM>TEN TABLE>
--1.Xem thông tin của tất cả các khách hàng
SELECT *FROM Customers
INSERT INTO Customers(CustomerID,CompanyName,ContactName) VALUES('ALFKI','FPT','THANH')
INSERT INTO Customers(CustomerID,CompanyName,ContactName) VALUES('FPTU','FPT','THANH')

--DATA trả về có cell/ô có null,hiểu rằng dâta chưa xác định value
--2.xem thông tin nhân viên,xem hết các cột luôn
SELECT *FROM Employees
--3.Xem các sản phẩm có trong kho
SELECT *FROM Products
--4.Mua hàng thì thông tin sẽ ở table orders và ỏderDetails
SELECT *FROM Orders
--5.Xem thông tin công ty giao hàng
SELECT *FROM Shippers
INSERT INTO Shippers(CompanyName,Phone) VALUES('Fedex vietnam','(084)90...')

--6.Xem chi tiết mua hàng
SELECT *FROM  Orders --phần trên của bill siêu thị
SELECT *FROM [Order Details] --phần table kẻ giống lề những món hàng đã mua

--7.In ra thông tin khách hàng,chỉ gồm cột id,comName,Contactname,country
SELECT CustomerID, CompanyName,ContactName,Country FROM Customers
--8.in ra thong tin nhan vien.chi can id,name,lastname,title,date
--TÊN NGƯỜI tach thanh last va first->danh cho tieu chi nao do de sort
--in ra theo quy uoc cuamoi quoc gia
SELECT  EmployeeID,LastName,FirstName,Title,BirthDate FROM Employees
SELECT *FROM Employees
--9.IN RA THÔNG TIN NHÂN VIÊN,ghép tin,gộp vột,tính luôn tuổi
SELECT  EmployeeID,LastName + ' '+ FirstName AS Fullname,Title,BirthDate FROM Employees
SELECT  EmployeeID,LastName + ' '+ FirstName AS Fullname,Title,BirthDate,
					YEAR(GETDATE())- YEAR(BirthDate) AS AGE FROM Employees
--10.in ra thông tin chi tiết mua hàng
SELECT * FROM [Order Details]
SElECT *,UnitPrice*Quantity FROM [Order Details]
--cong thuc tih tong tien phai trả từng món,giảm giá,phần trăm
--sô lượng*đơn giá-giảm giả=>tiền phải trả
--sl*đơn giá -(số lượng *đơn giá*discount)=>phải trả
--số lượng *đơn giá(1-discount)
SElECT *,UnitPrice*Quantity*(1-Discount) AS Subtotal FROM [Order Details]