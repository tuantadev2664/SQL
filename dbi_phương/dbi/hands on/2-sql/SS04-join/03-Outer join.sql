--1.liệt kê các tập từ điển anh - việt
SELECT *FROM EnDict e, VnDict v WHERE e.Numbr=v.Numbr
SELECT*FROM EnDict e INNER JOIN  VnDict v ON  e.Numbr=v.Numbr
SELECT*FROM EnDict e JOIN VnDict v ON  e.Numbr=v.Numbr
--3 CÂU TƯƠNG ĐƯƠNG KQ
--HỤT MẤT TUI TỪ 4-FOUR VA 5- NĂM
--mún xh chỉ có tích đề các
SELECT *FROM EnDict e, VnDict v
SELECT*FROM EnDict
SELECT*FROM VnDict
--3.Tui muốn xh tiếng anh làm  chuẩn,tìm nghĩa tv tương đuwong
--nếu ko có tương đương thì cũng hiện ra
SELECT *FROM EnDict e LEFT JOIN VnDict v ON e.Numbr=v.Numbr
SELECT *FROM EnDict e LEFT OUTER JOIN VnDict v ON e.Numbr=v.Numbr
--TÔI MUỐN LẤY TIẾNG VIỆT LÀM MỐC
SELECT *FROM VnDict v  LEFT JOIN EnDict e ON e.Numbr=v.Numbr
--vẫn lấy tv làm đầu nhưng để tv bên tay phải
SELECT *FROM EnDict e RIGHT OUTER JOIN VnDict v ON e.Numbr=v.Numbr
SELECT *FROM VnDict v  RIGHT JOIN EnDict e ON e.Numbr=v.Numbr
SELECT *FROM VnDict v  RIGHT JOIN EnDict e ON e.Numbr=v.Numbr
--5.Dù chung và riêng của mỗi bên,lấy tất cả,chấp nhận FA Ở 1 VÊ
SELECT *FROM EnDict e FULL OUTER JOIN VnDict v ON e.Numbr=v.Numbr
SELECT *FROM EnDict e FULL  JOIN VnDict v ON e.Numbr=v.Numbr
--full outer,thu tu table ko quan trong,viet truoc viet sau deu duoc
--left va rigth thi co chuyen
SELECT *FROM EnDict e LEFT JOIN VnDict v ON e.Numbr=v.Numbr--4 LAM MOC
SELECT *FROM VnDict e LEFT JOIN EnDict v ON e.Numbr=v.Numbr--5 LAM MOC
--OUTER join sinh ra de dam bao ket noi ghep bang
--ko bi mat mat data
--di inner join,join - chỉ tìn chung 2 bên
----sau khi tìm ra được data,a vẫn có quyền filter tiếp
--cell nào đó,where như bth
--6.in ra bộ từ điển anh-việt
--(anh chuẩn) của những con số từ 3 trở lên
SELECT *FROM EnDict e LEFT JOIN VnDict v ON e.Numbr=v.Numbr
							WHERE E.Numbr
SELECT *FROM EnDict e LEFT JOIN VnDict v ON e.Numbr=v.Numbr
							WHERE v.Numbr>=3
--7.	In từ điển anh việt việt anh >3
SELECT *FROM EnDict e FULL OUTER JOIN VnDict v ON e.Numbr=v.Numbr WHERE e.Numbr
--có 4 mất 5
SELECT *FROM EnDict e FULL OUTER JOIN VnDict v ON e.Numbr=v.Numbr WHERE V.Numbr
--CÓ 5 MÂT 4
SELECT *FROM EnDict e FULL OUTER JOIN VnDict v ON e.Numbr=v.Numbr WHERE v.Numbr>=3 OR e.Numbr>=3

