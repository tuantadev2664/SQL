SELECT *FROM VnDict,EnDict--TÍCH ĐỀ CÁC
SELECT * FROM VnDict CROSS JOIN EnDict
--KO GHép bừa bãi nữa
SELECT  *FROM VnDict vn, EnDict en WHERE vn.Numbr=en.Numbr
--chuẩn thế giới
SELECT *FROM VnDict INNER JOIN EnDict on VnDict.Numbr=EnDict.Numbr
SELECT *FROM VnDict JOIN EnDict on VnDict.Numbr=EnDict.Numbr
--có thể dùng where hay k hông
--join chỉ là thêm data,gộp data lại nhiều hơn  
--THÍ NGHIỆM THÊM CHO INNER JOIN,GHÉP NGANG CÓ XEM XÉT MÔN ĐĂNG HỘ ĐỐI HAY KHÔNG
SELECT*FROM EnDict
SELECT*FROM VnDict
SELECT*FROM EnDict e,VnDict v WHERE E.Numbr=V.Numbr
SELECT*FROM  EnDict e,VnDict v WHERE e.Numbr>v .Numbr --ghép có chọn lọc nhưng ko dùng 
--dấu<>=--non-equi join
SELECT*FROM EnDict e,VnDict v WHERE e.Numbr!=v.Numbr --ghép có chọn lọc nhưng ko dùng
SELECT *FROM EnDict e JOIN VnDict v ON e.Numbr!= v.Numbr--chuẩn