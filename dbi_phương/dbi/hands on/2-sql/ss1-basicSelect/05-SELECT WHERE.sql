--Cu Phap Mo Rong:->
--Ta muốn sắp xếp dữ liệu-sort theo một tiêu chí nào đó
--Thường sẽ là tăng dần -ascending/asc hoặc giảm dần-descending/desc
--Mặc định : sx tăng dần
--A<B<C
--1<2<3
--Ta co thể sort trên nhiều cột
-----------------------------------
--Menh de where:dung lam bo loc,filter/loc ra nhung du lieu theo 1 tieu chi nao do
--Lọc ra những ssv có quê ở tiền giang và điểm trung bình trên a
--CÚ PHÁP DÙNG BỘ LOC:
--SELECT *(cột bạn muốn in ra)From <tên table>where<điều kiện lọc>
--*Dieu kien loc:Tìm từng dòng,với cái cột có giá trị cần lọc
--Lọc theo tên cột với value thế nào,lấy tên cột,xem value trong cell
--để viết đk lọc ta cần: 
--tên cột,value của cột(cell),toán tử(operator)< >= <= = !=, <>(!=)
--Nhiều điều kiện lcoj đi kèm nhau,dùng thêm toán tử logic: and,or,not
--VÍ DỤ: where city =N 'binh duong'
--		where city = N'hau giAng' AND gpa>=8
--Lọc liên quan ddees kiểu giá trị,ta quan tâm đến datatypes
--Số nguyên,thực ghi số ra như truyền thống 5,10,3.14,9.8
--Chuỗi kí tư: 'A','ahihi'
--Ngày tháng : '2004-01-01'
-------------------------------
--THỰC HÀNH
--1.In ra danh sách các khách hàng
SELECT *FROM Customers--92  
--2.In ra danh sách khách hàng đến từ ý
SELECT *FROM Customers WHERE Country='Italy'
--3.In ra danh sách khách hàng đến từ Mĩ
SELECT *FROM Customers WHERE Country='USA'
--4.In ra danh sách khách hàng đến từ mĩ,ý
--Đời thường có thể nói:những khách hàng đế từ mĩ và ý.ý hoặc mĩ
SELECT *FROM Customers WHERE Country='USA'OR Country='Italy'
--Sort theo ý,mĩ để gọn cùng cụm cho dễ theo dõi
SELECT *FROM Customers WHERE Country='USA' OR Country='Italy' ORDER BY Country
--5.In ra khách hàng đến từ thủ đô nước đất
SELECT *FROM Customers WHERE Country='Germany' AND City='Berlin'
--6.In ra các thông tin của nhân viên
SELECT *FROM Employees
--7.In ra thông tin nhân viên có năm sinh từ năm 1960 trở lại gần đây
SELECT *FROM Employees WHERE YEAR(BirthDate)>=1960
--8.In ra thông tin nhân viên có tuổi từ 60 trở lên
SELECT YEAR(GETDATE())-YEAR(BirthDate) AS age,* FROM Employees WHERE YEAR(GETDATE())-YEAR(BirthDate) >= 60
--9.Những nhân viên nào ở london
SELECT *FROM Employees WHERE City='London'
--10.Những ai không ở london
SELECT *FROM Employees WHERE City!='London'
--vi diệu
--Đảo mệnh đề!!!
SELECT *FROM Employees WHERE NOT (City='London')
--11.in ra hồ sơ nhân viên có mã số là 1
--đi vào ngân hàng giao dịch,hoặc đưa stk,kèm cmnd,filter theo cmnd
SELECT *FROM Employees WHERE EmployeeID =1
--SELECT mà có where key chỉ có 1 dòng trả về,distinct là vô nghĩa
SELECT *FROM Employees WHERE EmployeeID =1
--SELECT mà có where key chỉ có 1 dòng trả về
SELECT DISTINCT EmployeeID, City FROM Employees WHERE EmployeeID =1 ORDER BY EmployeeID
--Công thức full không che của select :
--SELECT ------------FROM--------WHERE---GROUP BY----HAVING----ORDER BY
--      DISTINCT      1,N TABLE
--      HÀM()
--      NESTED QUERY,SUBquery
--12.Xem thông tin của bên đơn hàng
SELECT *FROM Orders--830
--13.Xem thông tin đơn hàng sắp xếp giảm dần theot trọng lượng
SELECT *FROM Orders ORDER BY Freight DESC
--14.In thông tin đơn hàng trọng lượng lớn hơn 50kg
SELECT *FROM Orders WHERE Freight>=500 ORDER BY Freight DESC
--15.iN RA THÔNG TIN ĐƠN HÀNG SẮP XẾP GIẢM DẦN theo trọng lượng 100-500 và ship bởi công ty giao vận số 1
SELECT *FROM Orders WHERE Freight>=100 AND Freight<=500 AND ShipVia=1 --52/174/830

--16.và không ship tới london
--Rât cẩn thận khi trong mệnh đề where mà lại có AND OR TRỘN VỚI NHAU,Ta phải xafitheem dấu ngoặc để phân tach filter
--(SS AND OR khác nữa) AND (ss khác)
-- nếu không ngoặc thì làm từ trái sang phải
--va ko ship toqai london
SELECT *FROM Orders WHERE Freight>=100 AND Freight<=500 AND ShipVia=1 AND ShipCity<>'London'
--17.liet ke kh den tu my hoac mexico
SELECT *FROM Customers WHERE Country='USA'OR Country = 'Mexico'
--18.Liệt kê kh ko đến từ mỹ và mexico
SELECT *FROM Customers WHERE NOT (Country='USA'OR Country = 'Mexico')
SELECT *FROM Customers WHERE  (Country<>'USA'AND Country !='Mexico')
--19.Liệt kê các nhân viên sinh ra trong khoảng 1960-1970
SELECT *FROM Employees ORDER BY BirthDate DESC
SELECT *FROM Employees WHERE YEAR(BirthDate)>=1960 AND YEAR(BirthDate)<=1970