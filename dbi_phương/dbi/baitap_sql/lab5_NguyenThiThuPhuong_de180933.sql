USE ABCCompany
SELECT *FROM KHACHHANG
SELECT *FROM VATTU
SELECT *FROM HOADON
SELECT *FROM CHITIETHOADON
--1.Write function name: StudenID_ Func1 with parameter @mavt, return the sum
--of sl*giaban corresponding.
go
CREATE FUNCTION StudenID_Func1 
(
@mavt nvarchar(5)
)
returns int
as
begin
	DECLARE @sum int
	SELECT @sum=(  SELECT SUM(SL*GiaBan) FROM CHITIETHOADON
	WHERE MaVT=@maVT)
	RETURN @sum

end
go

SELECT dbo.StudenID_Func1(N'VT01') as 'Tổng';


--2.Write  function to return a total of the HoaDon (@MahD is a parameter) 
go
CREATE FUNCTION total_hoaDon
(@MaHD nvarchar(10)
)
RETURNS int
AS
BEGIN
    DECLARE @Total int
    SELECT @Total = SUM(SL * GiaBan)
    FROM CHITIETHOADON
    WHERE MaHD = @MaHD
    RETURN @Total
END
go

SELECT dbo.total_hoaDon(N'HD001') as 'Tổng hóa đơn'

--3.Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure
--help user update @diachi corresponding @makh.
go
CREATE PROC StudenID_Proc1
	@makh nvarchar(5),
	@diachi nvarchar(50)
AS
BEGIN
	UPDATE KHACHHANG
	SET DiaChi=@diachi
	WHERE MaKH = @makh
END

go

EXEC  StudenID_Proc1 N'KH05', N'QUAN 10';

--4.Write procedure to add an item into Hoadon

go
create proc uph_addItem_Hoadon
@MaHD nvarchar(10),
@Ngay datetime ,
@MaKH nvarchar(5)
as

	begin
		insert into HOADON(MaHD,MaKH,Ngay)values
		(@MaHD,@MaKH,@Ngay)
	end
go

exec uph_addItem_Hoadon @MaHD='HD012',
@Ngay= '2000-09-15',
@MaKH ='KH04'
--5.	Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data
--into Chitiethoadon, the trigger will update the Tongtien in HoaDon(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).
ALTER TABLE HOADON
ADD Tongtien int;

go
create TRIGGER StudentID_Trig1 
ON CHITIETHOADON
AFTER INSERT
AS
BEGIN
  DECLARE @MaHD nvarchar(10);
  DECLARE @Tongtien int;
  SELECT @MaHD = MaHD FROM inserted;
  SELECT @Tongtien = SUM(sl*giaban) FROM CHITIETHOADON WHERE MaHD = @MaHD;
  UPDATE HOADON SET Tongtien = @Tongtien WHERE MaHD = @MaHD;
END;

INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, GiaBan) VALUES ('HD002', 'VT05', 5, 52000);





--6.	Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’
go
create view StudentID_View1
as
	select k.MaKH,k.TenKH,k.Email,k.DiaChi,k.DT
	from KHACHHANG k inner join HOADON h
	on k.MaKH=h.MaKH inner join CHITIETHOADON c
	on h.MaHD=c.MaHD inner join VATTU v
	on c.MaVT=v.MaVT
	where v.TenVT LIKE N'Gach Ong'
go


select * from StudentID_View1







