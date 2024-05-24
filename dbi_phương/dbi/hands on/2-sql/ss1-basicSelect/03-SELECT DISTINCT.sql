
USE Northwind

--Cu Phap Mo Rong:->
--SELECT ten cac cot muon lay,cach nhau dau phay FROM <TEN TABLE>
--SELECT có thể dùng các hàm xử lí các cột để độ lại thôNG Tin hien thị
--FROM>TEN TABLE>
--Khi ta SELCT ít cột thì có nguye cơ các dữ liệu bị trùng lại
--không pahri ta bị sai,không phải người thiết kế và người nhập lieeuh bị sai
--Do chúng ta có nhiều in4 trùng nhau,nếu chỉ tập trùng vào data này thì trùng nau là chắc chắn xảy ra
--Người dân việt nam được quản lí in4 bao gồm:ID,TÊN,DOB,...tên thành phố sinh sống
--Lệnh select hỗ trợ việc loại trừ dòng trùng nhau
--SELECT DISTINCT TÊN-CÁC-CỘT FROM TÊN -TABLE
--1.Liệt kê ra danh sách nhân viên
SELECT *FROM Employees
--Phân tiach:9 người nhưng chicr có 4 title
SELECT TitleOfCourtesy FROM Employees
SELECT DISTINCT TitleOfCourtesy FROM Employees
SELECT DISTINCT EmployeeID, TitleOfCourtesy FROM Employees
--Nếu distinct đi kèm với key thì vô dụng
--2.in ra thông tin của khách hàng
SELECT *FROM Customers --92 rows
--3.Có bao nhiêu quốc gia xuất hiện
SELECT DISTINCT Country FROM Customers--22 ROWS
