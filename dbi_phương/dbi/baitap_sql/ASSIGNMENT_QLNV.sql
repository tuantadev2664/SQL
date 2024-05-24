CREATE DATABASE QLNV
USE QLNV
--1.Tạo bảng Phòng Ban gồm: MaPhong, TenPB. MaPhong là thuộc tính tự động tăng (1,1).
Create table PhongBan(
 Maphong INT IDENTITY(1,1),
 TenPB NVARCHAR (255)
 PRIMARY KEY (Maphong)
)
--2.Tạo bảng NhanVien gồm: MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, cột 
--MaPhongBan là khóa ngoại tham chiếu đến bảng PhongBan
CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY,
    HoLot NVARCHAR(255),
    Ten NVARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(3),
    DiaChi NVARCHAR(255),
    Luong DECIMAL(10, 2),
    MaPhongBan INT,
    CONSTRAINT PK_NhanVien_PhongBan FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhong)
)
--3. Thêm cột MaNVQL vào bảng NhanVien và ràng buộc khóa ngoại đến bảng này
ALTER TABLE NhanVien
ADD MaNVQL INT
FOREIGN KEY (MaNVQL) REFERENCES NhanVien(MaNV)
-- Thêm cột MaTruongPhong vào bảng PhongBan, NgayNhanChuc, ràng buộc khóa ngoại đến bảng NhanVien

ALTER TABLE PhongBan
ADD MaTruongPhong INT;
ALTER TABLE PhongBan
ADD NgayNhanChuc DATE;
ALTER TABLE PhongBan
ADD FOREIGN KEY (MaTruongPhong) REFERENCES NhanVien(MaNV);
--5. Thêm ràng buộc duy nhất (UNIQUE) cho trường TenPB trong bảng PhongBan, thử nhập dữ liệu để kiểm tra ràng buộc
ALTER TABLE PhongBan
ADD CONSTRAINT UQ_TenPB UNIQUE (TenPB)

--6. Thêm ràng buộc kiểm tra (CHECK) cho cột GioiTinh trong bang NhanVien, yêu cầu là trường này chỉ nhận giá trị “Nam” hoặc “Nữ”, thử nhập dữ liệu để kiểm tra ràng buộc.ALTER TABLE NhanVien
ADD CONSTRAINT CHK_GioiTinh CHECK (GioiTinh IN (N'Nam', N'Nữ'));
--7. Thêm ràng buộc kiểm tra (DEFAULT) cho cột NgayNhanChuc trong bang PhongBan là ngày hiện tại.
ALTER TABLE PhongBan
ADD CONSTRAINT DF_PhongBan_NgayNhanChuc DEFAULT GETDATE() FOR NgayNhanChuc;
--8.Chèn dữ liệu vào 2 bảng này, sử dụng lệnh INSERT INTO
-- Thêm dữ liệu vào bảng PhongBan
-- Thêm dữ liệu vào bảng PhongBan
INSERT INTO PhongBan (TenPB) VALUES (N'Ban tài chính');
INSERT INTO PhongBan (TenPB) VALUES (N'Ban kế toán');
INSERT INTO PhongBan (TenPB) VALUES (N'Ban nhân sự');
INSERT INTO PhongBan (TenPB) VALUES (N'Ban quản trị');
INSERT INTO PhongBan (TenPB) VALUES (N'Ban kĩ thuật');

-- Thêm dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (216, N'Nguyễn', N'Thu Phương', '2004-02-19', N'Nữ', N'213 Ngũ Hành Sơn', 5000000, 16, 315);
INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (217, N'Nguyễn', N'Đăng Quý', '2004-06-17', N'Nam', N'29 Hải Châu', 6000000, 17, 316);
INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (218, N'Nguyễn', N'Vĩnh Trung', '2003-03-29', N'Nam', N'188 Nguyễn Lương Bằng', 7000000, 18, 317);
INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (219, N'Huỳnh', N'Văn Mạnh', '2003-11-9', N'Nam', N'321 Lê Văn Hiến', 8000000, 19, 318);
INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (220, N'Huỳnh', N'Kim Huy', '2003-06-20', N'Nam', N'342 Lê Văn Hiến', 5000000, 20,319);


INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (315, N'Nguyễn ', N'Văn Lan', '2000-01-01', N'Nam', N'23 Lê Duãn', 9000000, 16, NULL);

INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (316, N'Nguyễn ', N'Ánh Hồng', '2000-02-02', N'Nữ', N'25 Hải Châu', 8000000, 17, NULL);

INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (317, N'Nguyễn', N'Văn Minh', '2002-03-03', N'Nam', N'27 Lê Văn Hiến', 8000000, 18, NULL);

INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (318, N'Ngô', N'Hải Thanh', '2004-04-04', N'Nam', N'34 Lý Thương Kiệt', 9000000, 19, NULL);

INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL) 
VALUES (319, N'Lê', N'Minh Hà', '2000-05-05', N'Nam', N'Địa chỉ 5', 10000000, 20, NULL);


--9. Cập nhật Lương cho những NhanVien có mã phòng ban là 1 tăng lên 20%

UPDATE Nhanvien
SET Luong = luong*1.20
Where MaPhongBan = 1

--10. Xóa phòng ban có mã là 1. Có xóa được không? Nếu muốn xóa được thì phải làm gì?

--Không  xóa phòng ban có mã là 1 được vì phòng ban và nhân viên được liên kết thông qua khóa ngoại, 
--có một trường trong bảng nhân viên (MaPhongBan) tham chiếu đến bảng phòng ban(MaPhong)
--==>Để xóa:
-- xóa tất cả những nhân viên thuộc phòng ban đó trước. Sau đó mới xóa phòng ban.

--Xóa Nhân viên trong phòng ban có mã là 1:
DELETE FROM NhanVien WHERE MaPhongBan = 1;
--Xóa phòng ban có mã 1
DELETE FROM PhongBan WHERE Maphong = 1;


-- Cập nhật MaTruongPhong bằng mã nhân viên trưởng phòng đã có
UPDATE PhongBan
SET MaTruongPhong = 315
WHERE Maphong=16;

UPDATE PhongBan
SET MaTruongPhong = 316
WHERE Maphong=17;

UPDATE PhongBan
SET MaTruongPhong = 317
WHERE Maphong=18;

UPDATE PhongBan
SET MaTruongPhong = 318
WHERE Maphong=19;

UPDATE PhongBan
SET MaTruongPhong = 319
WHERE Maphong=20;

SELECT*FROM PhongBan
SELECT*FROM NhanVien

