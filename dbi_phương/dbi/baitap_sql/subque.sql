Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương'
from NhanVien
where Luong> (Select Luong
			from NhanVien
			where MaNV = 'NV003')

--2.Lấy ra TT nhân viên gồm MaNV, HoTen, Luong, MaPB
--của lương TB của các nhân vien ở phòng ban số 4
Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương', MaPhongBan
from NhanVien
where Luong > (Select AVG(Luong)
			from NhanVien
			where MaPhongBan=4)
	AND MaPhongBan <>4
	Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương'
from NhanVien
where Luong> (Select Luong
			from NhanVien
			where MaNV = 'NV003')

--2.Lấy ra TT nhân viên gồm MaNV, HoTen, Luong, MaPB
--của lương TB của các nhân vien ở phòng ban số 4
Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương', MaPhongBan
from NhanVien
where Luong > (Select AVG(Luong)
			from NhanVien
			where MaPhongBan=4)
	AND MaPhongBan <>4
	Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương'
from NhanVien
where Luong> (Select Luong
			from NhanVien
			where MaNV = 'NV003')

--2.Lấy ra TT nhân viên gồm MaNV, HoTen, Luong, MaPB
--của lương TB của các nhân vien ở phòng ban số 4
Select MaNV, HoLot+' ' +Ten AS 'Họ tên', Luong AS 'Lương', MaPhongBan
from NhanVien
where Luong > (Select AVG(Luong)
			from NhanVien
			where MaPhongBan=4)
	AND MaPhongBan <>4