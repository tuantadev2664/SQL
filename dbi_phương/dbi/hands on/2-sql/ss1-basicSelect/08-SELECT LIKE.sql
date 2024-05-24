USE Northwind
-----Lí thuyết----------
--CÚ PHÁP MỞ RỘNG SELCET
--Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
--gần đúng trên kiểu chuỗi,ví dụ liệt kê ai đó có tên là AN ,khác câu
--liệt kê ai đó tên bắt đầu bằng chữ "A"->tìm gần đúng
--tìm đúng->toán tử=
--tìm gần đúng,tìm có sự xuất hiện thì không dùng = mà mính sẽ dùng like
--LIKE'A'
--Để sử dụng toán tử like ,ta cần phải thêm hai thứ dó là "%" và "_"
--% đại diện cho 1  chuỗi  bất kì nào đó
--% đại diện cho 1  kí tự bất kì nào đó
--vd: NAME LIKE 'A%',bất kì ai có tên bắt đầu bằng chữ A
--NAME LIKE 'A_',có hai chữ cái và chữ cái đầu tiên bắt đầu bằng chữ A
--------------------------------
--1.In ra danh sách nhân viên 
SELECT *FROM Employees
--2.Ai có tên bắt đầu bằng chữ A
SELECT * FROM Employees WHERE FirstName = 'A%'--0 vì toán tử ss bằng
SELECT * FROM Employees WHERE FirstName LIKE 'A%'--2
--2.1.Nhân viên nào có tên bằng chữ A,in ra cả full name được ghép đầy đủ
SELECT EmployeeID,FirstName +' '+LastName AS FullName from Employees WHERE FirstName LIKE 'A%'
SELECT EmployeeID,CONCAT(firstName,' ',LastName) AS FullName from Employees WHERE FirstName LIKE 'A%'
--3.NNhân viên nào tên có chữ A cuối cùng
SELECT EmployeeID,CONCAT(firstName,' ',LastName) AS FullName from Employees WHERE FirstName LIKE '%A'
--4.Nhân viên nào tên có 4 kí tự 
--Dùng hàm kiểm tra độ dài của tên có bằng 4 hay ko-btvn
SELECT *FROM Employees WHERE FirstName LIKE '____'
--5.XEM danh sách các sản phẩm/món đồ đang có
SELECT *FROM Products
--6.Những sản phẩm nào có tên bắt đầu bằng ch
SELECT *FROM Products WHERE ProductName like 'CH%'
SELECT *FROM Products WHERE ProductName like '%CH%'
--Những sản phẩn trong tên có chữ ch,không quan tâm vị trí xuất hiện
--7.Những sản phẩm trong tên có 5 kí tự

SELECT *FROM Products WHERE ProductName LIKE '_____'
--8.NHỮNG SP TRONG TÊN SP mà từ cuối cùng là 5 kí tự
SELECT *FROM Products WHERE ProductName LIKE '% _____' --tên có ít nhất 2 từ  và từ cuối cùng có 5 kí tự,vô tình loại đi
--người tên chỉ có 5 kí tự
SELECT *FROM Products WHERE ProductName LIKE '% _____' OR ProductName LIKE '_____'