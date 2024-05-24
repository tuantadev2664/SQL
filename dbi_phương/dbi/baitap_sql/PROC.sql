DECLARE @ten nvarchar (30)
DECLARE @tuoi int

SET @ten = N'Kiệt' --set giá trị 1 dòng
print @ten
SET @tuoi =20
--Print @ten
--print @tuoi
SELECT @ten +' ' +CAST (@tuoi AS NVARCHAR)+N' tuổi' AS N'Thông tin'

--1.lấy thông tin nhân viên :MANV,HOTEN,TUOI
--CÓ TUỔI LƠN HƠN TUỔI CỦA KIỆT
go
DECLARE @tuoi int =20
Select MaNV, HoLot +  ' '+Ten AS 'Họ tên', YEAR(getdate())-YEAR(NgaySinh) AS 'Tuổi'
from NhanVien
where YEAR(getdate())-YEAR(NgaySinh)> @tuoi
----1.lấy thông tin nhân viên :MANV,HOTEN,TUOI
--CÓ TUỔI LƠN HƠN TUỔI CỦA KIỆT VÀ  QUÊ BẮT ĐẦU BẰNG CHỮ QUẢNG

go
DECLARE @tuoi int =20
DECLARE @que nvarchar(30) = N'Quảng'
Select MaNV, HoLot +  ' '+Ten AS 'Họ tên', YEAR(getdate())-YEAR(NgaySinh) AS 'Tuổi'
from NhanVien
where YEAR(getdate())-YEAR(NgaySinh)> @tuoi AND DiaChi LIKE N''+@que+'%'
--Nếu tuổi lớn hơn >28,bonus=10
--cập nhật vào lương
--Lấy ra lương 
--3.Lấy ra LTB của NV phòng ban số 4
--Nếu ltb > 3000, bonus =10
	--cập nhật vào lương của nhân viên ở phòng ban này
DECLARE @ltb decimal 
DECLARE @bonus decimal
Select @ltb= AVG(Luong)
from NhanVien
where MaPhongBan=4
print @ltb
IF @ltb< 3000
	BEGIN
		SET @bonus = 10
		--Cap nhat vao luong
		Update NhanVien
		SET Luong = Luong +@bonus
		WHERE MaPhongBan=4
	END

Select * from NhanVien

--Viết thủ tục lấy ds nhân viên
go
CREATE PROCEDURE sp_NhanVien_getALL
AS
	SELECT*FROM NhanVien
--THỰC THI SP
EXEC sp_NhanVien_getALL


	--2. Viết thủ tục lấy danh sách nhân viên thuộc PB nào đó
go
create proc sp_NhanVien_getByMaPB
@maPB int
AS
	Select * from NhanVien
	where MaPhongBan = @maPB

--chaỵ
EXEC sp_NhanVien_getByMaPB @maPB =4
--3.Viết Thủ tục lấy danh sách nhân viên theo giới tính và địa chỉ
go
CREATE PROC sp_NhanVien_getByGioiTinhDiaChi
@gioiTinh nvarchar(30),
@diaChi nvarchar(30)
AS
	SELECT*FROM NhanVien
	WHERE GioiTinh LIKE N'' +@gioiTinh +'' AND DiaChi LIKE N'%' + @diaChi +'%'
--CHẠY
EXEC sp_NhanVien_getByGioiTinhDiaChi @gioiTinh = N'Nữ', @diaChi = N'Quảng'

--4.Viết thủ tục lấy ra số lượng nhân viên của phòng ban nào đó
go
create proc sp_NhanVien_getSoLuongByMaPB
@maPB int,
@soLuong int OUT
AS
	Select @soLuong= count(MaNV)
	from NhanVien
	where MaPhongBan = @maPB
Select @soLuong AS 'Số lượng nhân viên'
--Chạy Tham số Output khác so với tham số in
DECLARE @kq int
EXEC sp_NhanVien_getSoLuongByMaPB @maPB = 4, @soLuong =@kq OUT



