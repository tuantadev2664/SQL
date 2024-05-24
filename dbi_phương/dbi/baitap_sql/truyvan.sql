use QLNV
SELECT * FROM NhanVien
SELECT * FROM PhongBan

--1.Liệt kê thông tin gồm MaNV, HoLot, Ten, Luong




SELECT MaNV,HoLot,Ten,Luong FROM NhanVien WHERE HoLot LIKE N'Nguyễn%'
--cua nhan vien có họ Nguyễn


--2. Liệt kê thông tin gồm MaNV, Họ tên 
--lương từ 12tr-15tr
SELECT MaNV,HoLot  FROM NhanVien WHERE Luong BETWEEN 12000000 AND 15000000

--sap xep theo luong giam dan, MaNV tang dan
SELECT  Luong ,MaNV FROM NhanVien ORDER BY Luong DESC,MaNV ASC

--3. Liệt kê cac thong tin gom MaNV, HoTen, Tuổi
--sx theo Tuoi giảm dần
SELECT MaNV,CONCAT(HoLot,' ',Ten) AS 'Họ tên' ,YEAR(getdate())-YEAR(NgaySinh) AS 'Tuổi'
from NhanVien ORDER BY  YEAR(getdate())-YEAR(NgaySinh) DESC

--4. Liệt kê các thong tin gom MaNV, HoTen, của nhân viên có NVQL
SELECT MaNV,CONCAT(HoLot,' ',Ten) AS 'Họ tên'  FROM NhanVien WHERE MaNVQL IS NOT NULL


--5. Liệt kê thông tin gồm MaNV, HoTen cua nhan vien thuộc phòng ban số 1
SELECT MaNV, CONCAT(HoLot,' ',Ten) AS 'Họ tên'  FROM NhanVien WHERE MaPhongBan=16
--Liệt kê thông tin gồm MaNV, HoTen, Luong va Tên phòng ban mà nv đang làm việc
SELECT MaNV,CONCAT(HoLot,' ',Ten) AS 'Họ tên',Luong, TenPB FROM NhanVien JOIN PhongBan ON NhanVien.MaPhongBan=PhongBan.Maphong 
--7. Liệt kê các thong tin gom MaNV, HoTen, của nhân viên có NVQL là NV001, NV004
select MaNV, HoLot + ' '+ Ten AS 'Họ Tên'
from   NhanVien
where MaNVQL = 'NV001' OR MaNVQL = 'NV004'

--Cach 2
select MaNV, HoLot + ' '+ Ten AS 'Họ Tên'
from   NhanVien
where MaNVQL IN ('NV001','NV004')
--Liệt kê thông tin gồm MaNV, HoLot, Tên, MaNVQL, HoLot và Tên của người quản lý
Select * from NhanVien
Select nv.MaNV, nv.HoLot, nv.Ten, nv.MaNVQL, nvql.HoLot, nvql.Ten 
from NhanVien nv
INNER JOIN NhanVien nvql
ON nv.MaNVQL = nvql.MaNV

--Liệ kê thông tin phòng ban, tên NV của phòng ban,kể cả phòng ban đó có nhân viên hay không
SELECT pb.Maphong,pb.TenPB,nv.Ten  FROM PhongBan pb LEFT JOIN NhanVien nv on pb.Maphong=nv.MaPhongBan
SELECT pb.Maphong,pb.TenPB,nv.Ten  FROM  NhanVien nv  LEFT JOIN PhongBan pb on pb.Maphong=nv.MaPhongBan

--đếm bao nhiêu nhân viên
SELECT COUNT(MaNV)  AS 'Số lương' FROM NhanVien
--tính tb lương
SELECT AVG(Luong)  AS 'TBL' FROM NhanVien
--ĐẾM CÓ BAO NHIÊU NHÂN VIÊN THEO TỪNG PHÒNG BAN
SELECT MaPhongBan, COUNT(MaNV) as 'Số lượng'FROM NhanVien GROUP BY MaPhongBan 
--chỉ lấy phòng ban nào có số lượng lớn hơn 3
--having đi kèm group by ddeere lọc theo nhóm
--where chỉ để lọc theo dòng thỏa mãn điềuh kiện
select MaPhongBan, count(MaNV) as 'Số lượng NV'
from NhanVien
group by MaPhongBan
having count(MaNV)>=3

