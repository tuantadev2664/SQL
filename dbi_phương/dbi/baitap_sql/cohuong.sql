--CAU1 
go
CREATE PROC ketquadau
as

begin
--day la khu vuc de viet lenh	
	select *from ketqua
	Where diem>=5
end
go
exec ketquadau

--Cau 2
go excec ketquadau
create proc themmonhoc_ketqua
( 
	@mamonhoc varchar(2),
	@tenmonhoc nvarchar(25),
	@sotiet int,
	@diem decimal
as
begin
--them mot mon hoc moi vap
		insert DMMV
		VALUES(@mamonhoc,@tenmonhoc,@sotiet)
		--THEM DEIM CHO TAT Ca cac sinh vien
		insert ketqua(maSV,MAMH,lanthi,diem)
		select MASV,@mamonhoc,1,@diem
		from dmsv 

		--thuc thi
		exec themmonhoc_ketqua '06','sql',90,9 

		--CAU3:so sanh hai mon ho co cung tiet hay khong
		create proc sp_sosanhsotiet
		(
		@mamh1 varchar(2)
		@mamh2 varchar
		)
		as
		begin
		declare @sotiet1 int
		declare @sotiet2
		@sotiet1=(select sotiet from dmmh wwhere mamh =@mamh1)
		@sotiet2=(select sotiet from dmmh wwhere mamh =@mamh2)
		if(@sotiet1=@sotiet2)
			print 'hai mon hoc cung so tiet'
		else
			print'hai mon hoc ko cung so tiet'

		end
		go
		exec  sp_sosanhsotiet '01' '04'


		--cach 2
		create proc sp_sosanhsotiet
		(
		@mamh1 varchar(2)
		@mamh2 varchar
		@tenmonhoc1 nvarchar(25)
		@tenmonhoc2 nvarchar(25)
		)
		as
		begin
		declare @sotiet1 int
		declare @sotiet2 int 
		declare @tenmh1 nvarchar(25)
		declare @tenmh2 nvarchar(25)

		@sotiet1=(select sotiet from dmmh wwhere mamh =@mamh1)
		@sotiet2=(select sotiet from dmmh wwhere mamh =@mamh2)
		print  'so sanh' + @tenmh1 + 'vaf' + @tenmh2 
		if(@sotiet1=@sotiet2)
			print N'hai mon hoc cung so tiet'
		
		else
			print'hai mon hoc ko cung so tiet'

		end
		go
		exec  sp_sosanhsotiet '01' '04'

		--CAU4:Thuwcj hieejn kieerm tra xem max sv,max mon hoc ,xem thu sinh vien dau hay rot
		create proc sp_travedaurot
		(
		@masv varchar(3),
		@mamh varchar(10)
		@lanthu int,
		@ketqua nvarchar(10) output
		as
		begin
		declare @diemso decimal
		select @diemso=  diem from ketqua where masv=@masv and mamh=@mamh and lanthi=@lanthi
		if(deimso>5)
			select @ketqua= N'dau'
		else
			select @ketqua=N'rot'
		end
		go
		declare @ketqua nvarchar(10)
		select @ketqua =''
		

		exec sp_travedaurot '01','01',1,@ketqua
		output
		select @ketqua as 'ketqua'
		



	
