----------------view-------------------
new view-->add

select* from  tenview
drop view ten_View
------------------thu tuc--------------

--tao thu tuc luu tru de thong qua thu tuc nay co the bo ung 1 ban ghi moi cho bang MAHANG
--(THỦ TỤC PHẢI KTRA TÍNH HỢP LỆ CỦA DƯ LIỆU)
drop proc  sp_themMaHang
CREATE PROC sp_themMaHang
g..giabs
(
	@mahang varchaa(5),
	@tenhang nvarchar(200),
	@macongty varchar(5),
	@maloaihang vaerchar(5)
	@soluong float,
	@donvitinh nvarchar(30)
	@giaban float
	)

	as
	begin
	declare @kiemtrakhoachinh int 
	select @kiemtrakhoachinh = count (mahang)  from matHang where mahang=@mahang
	declare @kiemtrakhoangoai int
	select @kiemtrakhoangoai = count (macongty)  from nhacungcung where mahang=@macongty
	if(@kiemtrakhoangoai=0)--tuc lafnaf cung cấp vớ mã hcue có
	begin
		print'chua có mã nhà cung cấp'
		return

	end
	declare @kiemtraloaihang
	select @kiemtrakhoangoai = count (mslosihsng)  from Loaihang where maloaihang=@maloaihang
	if(@kiemtrakhoangoai=0)--tuc lafnaf cung cấp vớ mã hcue có
	begin
		print'chua có mã loai hang nay'
		return

	end
	if(@kiemtrakhoachinh=0)
	--chua co du lieu
	--nhieu lenh thi co begin end
	begin

	insert mahang values(@mahang,@tenhang,@macongty,@giaban)


	
	else
		print 'da trung khoa chinh'
	
	


	

	go
	exec sp_theMatnhang 'mh10',N'kho bo'....

	--tao thu tuc luu tru co chuc nang thong ke so luong ban cua mat hàng ban duoc cua mot mat hang co mâ
	--bat kì
	go
	create proc sp_tongsoluong
	(
	@mahang nvarchar(5)
	)
	as
	begin
			Select @mahang,sum(chitietdonhang.soluong) as'tong sl bán'
			from chitietdonhang,mahang whre chitietdonhang.mahang=mathang.mahang
			and chitietdonhang.mahang=@mahang
			group by mahang.mahang


	end

	go exec tongsoluong 'mh01' 


	---hàm------------


	--viết hàm trả về 1 bảng trong đó cho biết tổng số luwojng hàng bán được của mỗi mặt hàng
	--sử dụng hà này để thống kê xem số luwojg hàng(hiện có và đã bán)của mỗi mặt hàng là bnhiu

	crrate function fn_tôngsoluongban
	(
		@mahang nvarchar(5)
	)
	returns float
	as
	begin
			delare @soluongban float
		
			Select @soluongban = sum(chitietdonhang.soluong)
			from chitietdonhang,mahang whre chitietdonhang.mahang=mathang.mahang
			and chitietdonhang.mahang=@mahang
			group by mathang.mahang
			return  @soluongban

		
	end
	
	go
	select dinstinct chititedonhang,mathang.soluong,dbo.fn_tongsoluongban('mh01'),
	MAHANG.SOLUONG -dbo.fn_tongsoluongban('mh01') 'SO UONG HIENCOS'
	FROM chtiietdonhang,mahang where chitietdathang.mathang ='mh01' and mathang.mahang=chitietdathang.mahang
	 --------trigger----------------
	 --cập nhật số luwong trên bảng 'MAHANG' khi thêm dữ liệu vào bảng 'nhatkibanhang'

	 create trigger trg_nhatkibanhang_insert
		on nhatkibanhang
		for insert 
	as
		update mathang
		set 
			mmathang.soluong =mathang.soluong-inserted.soluong
		from
			mathang inner join inserted on mathang.mahang = inserted.mahang  
		
		
	