USE Northwind
--LI THUYET--
--DB engine hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột,gom dât và tính toán trên dât gom này
-->nhóm hàm gom nhóm-aggregation
--COUNT() SUM() MIN() MAX() AVERAGE()
--*CÚ PHÁP
--SELECT CỘT....,HÀM GOM NHSOM...FROM<TABLE>
---->CÚ PHÁP MỞ RỘNG:
--SELECT CỘT....,HÀM GOM NHSOM...FROM<TABLE>...WHERE..GROUP BY(GOM THEO CỤM CỘT NÀO)

--SELECT CỘT....,HÀM GOM NHSOM...FROM<TABLE>...WHERE..GROUP BY(GOM THEO CỤM CỘT NÀO)HAVING...
--*HÀM COUNT(?) đếm số lần xuất hiện của một cái gì đó
--count (*)đếm số dòng trong một table,đếm tất cả,không care tiêu chuẩn nào
--count(*) from...WHERE..
--CHỌN RA những dòng thỏa tiêu chí where nào đó filter dã rồi mới đếm
--count(cột nào đó):
-------------------------
--1.In ra danh sách các nhân viên 
SELECT*FROM Employees
--2.đêm xem có bao nhiêu nhân viên
SELECT COUNT(*)  FROM Employees
SELECT COUNT(*) AS [Number of employees] FROM Employees
--3 có bao nhiêu nhân ciên ở london
SELECT COUNT(*) FROM Employees WHERE City = 'London'
SELECT COUNT(*)  AS [NO OF EMPS IN LONDON] FROM Employees WHERE City = 'London' 
--4.có bao nhiêu lượt thành phố xuất hiện -cứ xuất hiện tên thành phố là đếm
SELECT COUNT(City) FROM Employees
--5.Đếm bao nhiêu region
SELECT COUNT(Region) FROM Employees
--Phat hien count cot co null ko tinh
--6.Đếm xem có bao nhiêu dòng mà region là null
SELECT COUNT(*) FROM Employees WHERE RegioN IS NULL
SELECT COUNT(Region) FROM Employees WHERE RegioN IS NULL--null ko dem dc,ko value
SELECT * FROM Employees WHERE RegioN IS NULL
--7.Có bao nhiêu thanh phố trong table nhân viên
SELECT *FROM Employees 
SELECT city FROM Employees--9 dòng
SELECT DISTINCT City from Employees--5
--tui coi kết quả này là một table,mất quá trời công sức để lọc ra
--SUB QUERY MỚI,THAY 1 CÂU SELECT LÀ 1 TABLE VÀ BIẾN VÀO TRONG MỆNH ĐỀ FROM


SELECT *FROM (SELECT DISTINCT City from Employees) AS CITES
SELECT COUNT(*) FROM (SELECT DISTINCT City from Employees) AS CITES
SELECT COUNT(DISTINCT City) FROM Employees--5
--8.ĐẾM XEM "MỖI' thành phố có bao nhiêu nhân viên
--Khi câu hỏi có tinh toán(hàm aggregate)mà lại chưa từ khóa "mỗi" thì cách 
--viết có sự thay đổi,CHIA ĐỂ TRỊ,CHIA ĐỂ GOM
SELECT *FROM Employees
--SEATLE 2||TACOM 1|KIRLAND 1|REDMON 1|LONDON 4
--SỰ xuất hiện của nhóm
--đếm theo sự xuất hiện của nhóm,count ++ trong nhóm thoi,reset lại nhóm mới

  GROUP BY City
--ĐÉM VALUE CỦA CITY NHƯNG ĐẾM THEO NHÓM
--CHIA CITY THÀNH NHÓM,RỒI ĐẾM TRONG NHÓM

SELECT City, COUNT(City) AS[NO EMPLOYEES]  FROM Employees GROUP BY City
SELECT EmployeeID, City, COUNT(City) AS[NO EMPLOYEES]  FROM Employees GROUP BY City,EmployeeID
-->vô nghĩa
--CHOT HA:Khi xài hàm gom nhóm,bạn có quyền kê cột ở select nhưng cột lẻ đó
--bắt buộc phải xuất hiện trong mệnh đề group by
--để đảm bảo logic:cột hiển thị và số lượng đi kèm,
--đếm gom theo cột hiển thị thì mới logic
--cứ theo cột city mà gom,cột city nằm ở select là hợp lí
-->Muốn hiển thị số lượng của gì đó thì gom nhóm theo gì đó
--Nếu bạn gom theo key/ọ vô nghĩa vì mỗi thằng mỗi nhóm
--mã sv->đếm cái gì?
--mã chuyển ngành--đếm số sv chuyên ngành
--điểm thi--đếm sl đạt điểm đó
--Có cột để gom nhóm,cột đó sẽ dùng để hiển thị số lượng kết quả
 
 SELECT City, COUNT(City) AS[NO EMPLOYEES]  FROM Employees GROUP BY City

 --9.Thành phố nào có từ 2 nhân viên trở lên
 --2 chặng
--9.1.Các thành phố có bao nhiêu nhân viên
--9.2.Đếm xong mỗi tp,ta lọc lại kết quả sau đếm
--FILTER SAU ĐẾM,WHERE SAU ĐẾM,WHERE SAU KHI ĐÃ GOM NHÓM->HAVING
SELECT City, COUNT(City) AS[NO EMPLOYEES]  FROM Employees GROUP BY City
SELECT City, COUNT(*) AS[NO EMPLOYEES]  FROM Employees GROUP BY City
SELECT City, COUNT(City) AS[NO EMPLOYEES]  FROM Employees GROUP BY City
				HAVING COUNT(*)>=2
--10.Đếm số nhân viên của 2 thành phỐ seatle vÀ LONDON
SELECT COUNT(*)FROM Employees WHERE City IN ('London','Seattle')
--ko chia nhóm
SELECT City, COUNT(*) FROM Employees WHERE City IN ('London','Seattle') GROUP BY City
--11.trong hai tpho ,london seatle,tp nao có nhiều hơn 3 nhân cơvieen
SELECT City, COUNT(*) FROM Employees WHERE City IN ('London','Seattle') GROUP BY City HAVING COUNT(*)>3

--10.Thành phố nào có nhiều nhân viên nhất(btvn)
--12.ĐẾM XEm có bao nhiêu đơn hàng đã bán ra
SELECT *FROM Orders
SELECT COUNT(*) AS [NO ORDERS] FROM Orders
SELECT COUNT(OrderID) AS [NO ORDERS] FROM Orders
--830 mà đơn khác nhau.đếm mã đơn hay cả đơn đê như nhau
--nết cột có value là null ăn hàn
--ĐẾM XEM NƯỚC MĨ CÓ BAO NHIÊU ĐƠN HÀNG
--Đi tìm mỹ mà đến,lọc mỹ rồi tính tiếp
--ko phải là câu gom chi nhóm, ko phải mỗi quốc gia bao nhiêu đơn hàng
SELECT COUNT(*) AS [NO USA ORDERS] FROM Orders WHERE ShipCountry = 'USA'
--mỗi qg có bao nhiêu thì group by
--12.1.Mĩ ,anh,pháp chiếm tổng cộng bao nhiêu đơn hàng
SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('USA','UK','France')--hoặc dùng or
--12.2mĩ,anh ,pháp,mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry,COUNT(*) AS[NO ORDERS] FROM Orders WHERE ShipCountry IN ('USA','UK','France') GROUP BY ShipCountry
--12.4.TRong 3 quốc gia anh pháp mĩ,quốc gia nào có tu 100 đơn hàng trở lên
SELECT ShipCountry,COUNT(*) AS[NO ORDERS] FROM Orders WHERE ShipCountry IN ('USA','UK','France') GROUP BY ShipCountry HAVING COUNT(*)>100

--13.Đếm xem có bao nhiêu mặt hàng có trong kho
--14.Đếm xem có bao nhiêu luwotj quốc gia đã mua hàng
--15.Đếm xem có bao nhiêu quốc gia đã mua hàng(mỗi quốc gia đếm 1 lần)
--16.Đếm số lượng đơn hàng của mỗi quốc gia
--17.Đếm xem quốc gia nào có từ 10 đơn hàng trở lên
--18.ĐẾm xem mỗi chủng loại hàng có bao nhiêu mawtjhafng(bia rượu có 5sp,thủy sản 10sp)