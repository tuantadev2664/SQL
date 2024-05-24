-------------------------------LÍ THUYẾT
--CÚ PHÁP MỞ RỘNG LỆNH SELECT
--Trong thực tế,có những dữ liệu,thông tin chưa xác định dược,không cos giá trị
--không có giá trị,không thể so sánh ><>=<=
--cấm tuyệt đối xài các toán tử so sánh kèm với giá tị null
--ta sẽ dùng các toán tử khác,IS NULL.IS NOT NUKK.NOT(IS NULL) D		dể lọc filter có giá trị null
------
--.1.in ra dánh sách nhân viên
SELECT*FROM Employees
--2.Ai chưa xác định khu vực,region null
SELECT *FROM Employees WHERE Region = 'NULL'--0 DÒNG VÌ KO CÓ AI tên là null
SELECT *FROM Employees WHERE Region = NULL--0 dòng vì ko được khai báo với dấu =(toán tử ss)
SELECT *FROM Employees WHERE Region is NULL\
--3.những ai đã xác định được khu vực cư trú
SELECT *FROM Employees WHERE NOT REGION is NULL--NOT PHẢI ĐI KÈM VỚI MỆNH ĐỀ
SELECT *FROM Employees WHERE Region is NOT NULL
--4.Những nhân viên đại diện kinh doanh và xác định được nơi cư trú
SELECT *FROM Employees WHERE Title = 'Sales Representative' AND Region IS NOT NULL
SELECT *FROM Employees WHERE Title = 'Sales Representative' AND  NOT Region IS NULL
--5.Liệt kê danh sách khách hàng đến từ anh pháp mĩ,có cả số fax và region
SELECT *FROM Customers WHERE Country IN ('UK','FRANCE','USA') AND fax IS NOT NULL AND Region IS NOT NULL