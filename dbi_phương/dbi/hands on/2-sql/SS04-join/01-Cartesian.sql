CREATE DATABASE Cartesian
--database tuwong đương 1 kho thùng chứa data bên trong
--data bên trong được cát dưới dạng kệ có ngăn-TABLE
CREATE TABLE EnDict --ddl-1 nhánh của sql-data definition language
(
	Numbr int,
	EnDesc varchar(30)
)
--từ diển tiesng anh số đém
--1 one
--1 true
--CHÈN DATA
SELECT *FROM EnDict --DML data manupulation langua

INSERT INTO EnDict VALUES(1,'One')
INSERT INTO EnDict VALUES(2,'Two')
INSERT INTO EnDict VALUES(3,'Three')
----Phần này thêm vào cho outer join
INSERT INTO EnDict VALUES(4,'Four')
CREATE TABLE VnDict --ddl-1 nhánh của sql-data definition language
(
	Numbr int,
	VnDesc nvarchar(30) --nvarchar()String lưu tiếng viêtk
						--varchar()String lưu tiếng anh
)
//DROP TABLE VnDict
INSERT INTO VnDict VALUES(1,N'một')
INSERT INTO VnDict VALUES(2,N'hai')
INSERT INTO VnDict VALUES(3,N'ba')
---cho outer join
INSERT INTO VnDict VALUES(5,N'năm')
SELECT * FROM EnDict
SELECT *FROM VnDict
--nếu bôi đen cả 2 lệnh này thì nó ko phải choice,nó là 2 cau riêng biệt và đưa ra kết quả riêng biệt
--JOIN LÀ GỘP CHUNG 1 THÀNH 1 BẢNG TẠM THỜI TRONG RAM,KO ẢNH HƯỞNG DỮ LIỆU CỦA MỖI
--TABLE
--JOIN LÀ SELECT CÙNG LÚC NHIỀU TABLE
SELECT *FROM VnDict,EnDict--SINH TABLE MỚI,tạm thời lúc chạy
--sốc cột bằng tổng 2 bên
--số dòng bằng tích hai bên
SELECT *FROM VnDict,EnDict ORDER BY EnDesc
SELECT *FROM VnDict,EnDict ORDER BY Numbr
--GHÉP TABLR,JOIN BỊ TRÙNG TÊN CỘT,dufng alias(as) đặt tên giả để tham chiếu và chỉ định
--cột thuộc table nào
SELECT*FROM VnDict,EnDict ORDER BY VnDict.Numbr
--Tham chiếu cột qua tên table
SELECT  *FROM VnDict  vn,EnDict en ORDER BY en.Numbr
--đặt tên giả cho table và dùng để tham chiếu cho các cột
SELECT vn.Numbr,vn.VnDesc,en.EnDesc *FROM VnDict  vn,EnDict en ORDER BY en.Numbr
SELECT vn.*,en.EnDesc FROM VnDict  vn,EnDict en ORDER BY en.Numbr
--Cú pháp thứ 2
--Tui biết rằng có cặp ghép xài đc vì có tương hợp trong cell nào đó
SELECT * FROM VnDict vn, EnDict en WHERE vn.Numbr=en.Numbr
--ghép có chọn lọc khi tìm tương quan của cột/cell để ghép--inner join
--đa phần tương quan theo toán tử=
--còn có thể ghép theo >= <= > <

----

   