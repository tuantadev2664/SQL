CREATE DATABASE SE17D01Assigment
USE SE17D01Assigment


-- 1.Tạo bảng Phòng Ban 
CREATE TABLE PhongBan (
MaPhong int NOT NULL IDENTITY(1,1), -- MaPhong là thuộc tính tự động tăng (1,1)
TenPB NVARCHAR(50),
CONSTRAINT PK_PhongBan PRIMARY KEY(MaPhong)
)

-- 2.Tạo bảng Nhân Viên
CREATE TABLE NhanVien (
MaNV VARCHAR(50) NOT NULL,
HoLot NVARCHAR(50) NOT NULL,
Ten NVARCHAR(50) NOT NULL,
NgaySinh DATE NOT NULL,
GioiTinh NVARCHAR(50) NOT NULL,
DiaChi NVARCHAR(100),
Luong DECIMAL(18,2) NOT NULL,
MaPhongBan int NOT NULL,
CONSTRAINT PK_NhanVien PRIMARY KEY(MaNV),
CONSTRAINT FK_NhanVien_MaPhongBan FOREIGN KEY(MaPhongBan) REFERENCES PhongBan(MaPhong)
)

-- 3.Thêm cột MaNVQL vào bảng NhanVien và ràng buộc khóa ngoại đến bảng này
ALTER TABLE NhanVien
ADD MaNVQL VARCHAR(50)

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_MaNVQL FOREIGN KEY(MaNVQL) REFERENCES NhanVien(MaNV)

-- 4.Thêm cột MaTruongPhong vào bảng PhongBan, NgayNhanChuc, ràng buộc khóa ngoại đến bảng NhanVien
ALTER TABLE PhongBan
ADD MaTruongPhong VARCHAR(50)

ALTER TABLE PhongBan
ADD NgayNhanChuc DATE

ALTER TABLE PhongBan
ADD CONSTRAINT FK_NhanVien_MaTruongPhong FOREIGN KEY(MaTruongPhong) REFERENCES NhanVien(MaNV)

-- 5.Thêm ràng buộc duy nhất (UNIQUE) cho trường TenPB trong bảng PhongBan, 
--   thử nhập dữ liệu để kiểm tra ràng buộc. --> 8
ALTER TABLE PhongBan
ADD CONSTRAINT UC_TenPB UNIQUE(TenPB)

-- 6.Thêm ràng buộc kiểm tra (CHECK) cho cột GioiTinh trong bang NhanVien, yêu cầu là trường này
--   chỉ nhận giá trị “Nam” hoặc “Nữ”, thử nhập dữ liệu để kiểm tra ràng buộc.
ALTER TABLE NhanVien
ADD CONSTRAINT CK_GioiTinhNhanVien CHECK (GioiTinh IN ('Nam',N'Nữ'))

-- 7.Thêm ràng buộc kiểm tra (DEFAULT) cho cột NgayNhanChuc trong bang PhongBan là ngày hiện tại.
ALTER TABLE PhongBan
ADD CONSTRAINT DF_NgayNhanChuc DEFAULT GETDATE() FOR NgayNhanChuc

          -------------------- TO RESET THE DATE WHEN GET SOME ERRORS ------------------------		
                                   DROP TABLE PhongBan
                                   DROP TABLE NhanVien
                                   ALTER TABLE PhongBan
                                   DROP CONSTRAINT FK_NhanVien_MaTruongPhong 
                                   ALTER TABLE NhanVien
                                   DROP CONSTRAINT FK_NhanVien_MaNVQL
           --------------------------------------------------------------------------------------

-- 8.Chèn dữ liệu vào 2 bảng này, sử dụng lệnh INSERT INTO
INSERT INTO PhongBan (TenPB, NgayNhanChuc)
VALUES 
   (N'Phòng Nhân sự', DEFAULT),
   (N'Phòng Kế toán', NULL);
--bi loi vi rang buoc duy nhat
INSERT INTO PhongBan (TenPB, NgayNhanChuc)
VALUES  (N'Phòng Nhân sự', DEFAULT)



INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan, MaNVQL)
VALUES ('NV001', N'Nguyễn', N'Văn A', '2000-01-01', 'Nam', N'Hà Nội', 10000000, 1, NULL),
       ('NV002', N'Trần', N'Thị B', '2000-02-02', N'Nữ', N'Hồ Chí Minh', 12000000, 2, NULL)


-- Update giá trị cho các cột đang có giá trị NULL
UPDATE PhongBan
SET MaTruongPhong = 'NV001'
WHERE MaPhong = 2

UPDATE PhongBan
SET MaTruongPhong = 'NV002'
WHERE MaPhong = 1

         --FK_NhanVien_MaNVQL là khóa ngoại self-reference (tự tham chiếu đến chính bảng đó)--
		 -- + Khóa ngoại self-reference (MaNVQL tham chiếu đến MaNV trong cùng bảng) không bắt 
		 --   buộc phải trùng khớp giá trị với khóa chính.
		 -- + Tuy nhiên, MaNVQL bắt buộc phải có giá trị nằm trong tập hợp giá trị của cột MaNV.

UPDATE NhanVien 
SET MaNVQL = 'NV001'
WHERE MaNV = 'NV002';

UPDATE NhanVien
SET MaNVQL = 'NV001' 
WHERE MaNV = 'NV003';

---------------------ADD MORE---------------------------

INSERT INTO PhongBan (TenPB, NgayNhanChuc)
VALUES
   (N'Phòng Marketing', DEFAULT),
   (N'Phòng Kinh doanh', DEFAULT)

INSERT INTO NhanVien (MaNV, HoLot, Ten, NgaySinh, GioiTinh, DiaChi, Luong, MaPhongBan)
VALUES
  ('NV003', N'Lê', N'Văn C', '1990-03-04', 'Nam', N'TP HCM', 15000000, 1),
  ('NV004', N'Trần', N'Thị D', '1995-04-05', N'Nữ', N'Hà Nội', 13000000, 2)


UPDATE PhongBan
SET MaTruongPhong = 'NV002'
WHERE MaPhong = 3

UPDATE PhongBan
SET MaTruongPhong = 'NV001'
WHERE MaPhong = 2

UPDATE NhanVien
SET MaNVQL = 'Nv002'
WHERE MaNV = 'NV003';

UPDATE NhanVien  
SET MaNVQL = 'NV001'
WHERE MaNV = 'NV004';
-- 9.Cập nhật Lương cho những NhanVien có mã phòng ban là 1 tăng lên 20%.
UPDATE NhanVien 
SET Luong = Luong * 1.2
WHERE MaPhongBan = 1

-- 10. Xóa phòng ban có mã là 1. Có xóa được không? Nếu muốn xóa được thì phải làm gì?
       -- Không xóa bằng cách trực tiếp với phòng ban có mã = 1 được vì có ràng buộc khóa ngoại FK_NhanVien_MaPhongBan 
	   -- tham chiếu đến khóa chính MaPhong của bảng PhongBan
	   -- >> Nếu muốn xóa thì ta phải xóa ràng buộc khóa ngoại FK_NhanVien_MaPhongBan ở bảng NhanVien trước

ALTER TABLE NhanVien
DROP CONSTRAINT FK_NhanVien_MaPhongBan

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_MaPhongBan FOREIGN KEY(MaPhongBan) REFERENCES PhongBan(MaPhong) on update cascade on delete cascade

ALTER TABLE PhongBan
DROP CONSTRAINT FK_NhanVien_MaTruongPhong

ALTER TABLE PhongBan
ADD CONSTRAINT FK_NhanVien_MaTruongPhong FOREIGN KEY(MaTruongPhong) REFERENCES PhongBan(MaTruongPhong) on update cascade on delete cascade

DELETE FROM PhongBan
WHERE MaPhong = 1

SELECT *FROM NhanVien
SELECT *FROM PhongBan
