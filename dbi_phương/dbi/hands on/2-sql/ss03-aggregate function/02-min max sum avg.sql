USE Northwind
--LI THUYET--
--DB engine hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột,gom dât và tính toán trên dât gom này
-->nhóm hàm gom nhóm-aggregation
--COUNT() SUM() MIN() MAX() AVG()
--*CÚ PHÁP
--SELECT CỘT....,HÀM GOM NHSOM...FROM<TABLE>
---SELECT CỘT ..HÀM GOM NHÓM()..FROM <TABLE> WHERE....GROUP BY....HAVING

-------------------------
---Thực hành----
--1.Liệt kê danh sách các nhân viên
SELECT *FROM Employees
--2.Năm sinh nào là bé nhất
SELECT MIN(BirthDate)  FROM Employees
--3.Ai sinh năm bé nhất
SELECT *  FROM Employees WHERE BirthDate=(SELECT MIN(BirthDate)  FROM Employees)
SELECT *  FROM Employees WHERE BirthDate <= ALL(SELECT MIN(BirthDate)  FROM Employees)
SELECT *  FROM Employees WHERE BirthDate <= ALL(SELECT BirthDate FROM Employees)
--4.Trong các đơn hàng,đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
--4.1.Trọng  lượng nào là lớn nhất trong các đơn hàng
SELECT * FROM Orders ORDER BY Freight DESC
SELECT MAX(Freight) FROM Orders
SELECT *FROM Orders WHERE Freight =(SELECT MAX(Freight) FROM Orders)
--->>= ALL(tat ca cac trọng lượng)
--5.Tính tổng khoosiluwowjng các đơn hàng đã vận chuyển
SELECT *FROM Orders
SELECT COUNT (*) FROM Orders
SELECT SUM(Freight) AS [freight in total] FROM Orders
--6.Trung bình các đơn hàng nặng bao nhiêu
SELECT  AVG(Freight) FROM Orders
--7.Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT *FROM Orders WHERE Freight >= (SELECT  AVG(Freight) FROM Orders)
--8.CÓ BAO NHIÊU ĐƠN HÀN CÓ TRỌNG LƯỢNG NẶNG HƠN TRỌN LƯỢNG TRUNG BÌNH CỦA TẤT CAE
SELECT COUNT (*) FROM (SELECT *FROM Orders WHERE Freight >= (SELECT  AVG(Freight) FROM Orders)) AS AVG
SELECT COUNT(*)  AS [NO AGE] FROM Orders WHERE Freight >= (SELECT  AVG(Freight) FROM Orders)
SELECT COUNT(*)  FROM Orders WHERE Freight>=(SELECT  AVG(Freight) FROM Orders)
--CHỈ LỚN HƠN TBINH MỚI ĐẾM,KO CHIA NHÓM
--cột sh tỏng select hàm ý đếm theoo cột này!cột phải xuất hiện trong group by

--Cột xuất hiện trong select hầm ý đếm cái gì đó của tỉnh
--chuyên ngành,<đếm của chuyên ngành>->chia theo chuyên ngành mà đếm
--group by chuyên ngành
--có quyền group by trên nhiều cột
--mã chuyeenngafnh,tên chuyên ngành >sl,sv>->group by mã CN,TÊN cn
--ôn tập thêm
--1.Inn ra danh sách nhân viên
SELECT *FROM Employees ORDER BY Region
--2.ĐẾM xem khu vực có bao nhiêu nhân viên
SELECT COUNT(* )FROM Employees --9NV
SELECT COUNT(* )FROM Employees GROUP BY Region--4 null ,5 w/a
--2 nhóm region,2 cum region
SELECT Region, COUNT(*) FROM Employees GROUP BY Region --9NV,ĐÚNG DO ĐẾM DÒNG
-- 0 và 5 do null ko được xem là value ddeeer đếm nhưng vẫn là 1 value để ddc chia nhóm
--Nhóm ko có giá trị
SELECT COUNT(Region) FROM Employees GROUP BY Region --9NV
--SAI DO ĐẾM NULL
--3.KHẢO SÁT ĐƠN HÀNG
SELECT * FROM Orders
--mỗi quốc gia có bao nhiêu đơn hàng
SELECT COUNT(*) FROM Orders GROUP BY ShipCountry
SELECT ShipCountry,COUNT(*)  FROM Orders GROUP BY ShipCountry
--4.Quốc giA nào TỪ 100 ĐƠN
SELECT  ShipCountry,COUNT(*) AS [NO ORDERS] FROM Orders GROUP BY ShipCountry HAVING COUNT(*)>=100
SELECT MAX([NO ORDERS])from( SELECT ShipCountry,COUNT(*) AS [NO ORDERS] FROM Orders GROUP BY ShipCountry ) AS[COUNTRY]
--LẤY ĐC MAX
SELECT  ShipCountry,COUNT(*) AS [NO ORDERS] FROM Orders GROUP BY ShipCountry HAVING COUNT(*)=(SELECT MAX([NO ORDERS])from( SELECT ShipCountry,COUNT(*) AS [NO ORDERS] FROM Orders GROUP BY ShipCountry ) AS[COUNTRY])
--6.liệt các đơn hàng của k/h có ãm số vinet
SELECT * FROM Orders WHERE CustomerID='VINET'
--7.VINET ĐÃ MUA BAO NHIÊU LẦN
SELECT COUNT(*) FROM ORDERS  WHERE CustomerID='VINET'
SELECT CustomerID, COUNT(*) FROM ORDERS  WHERE CustomerID='VINET' GROUP BY CustomerID
SELECT CustomerID, COUNT(*) FROM ORDERS  GROUP BY CustomerID HAVING CustomerID='VINET'