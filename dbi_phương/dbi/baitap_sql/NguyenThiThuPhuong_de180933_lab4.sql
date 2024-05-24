USE FUH_COMPANY
SELECT*FROM tblDepartment
SELECT*FROM tblEmployee
SELECT*FROM tblProject
SELECT*FROM tblDepLocation
SELECT*FROM tblDepartment
SELECT *FROM tblLocation
SELECT*FROM tblDepartment
SELECT*FROM tblDepLocation
SELECT*FROM tblDependent
SELECT*FROM tblWorksOn

SELECT*FROM tblEmployee
SELECT*FROM tblDependent

--1..Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
Select D.mgrSSN, E.empName, D.depNum, D.depName 
from tblDepartment D, tblEmployee E
where D.depName = N'Phòng Nghiên cứu và phát triển' and D.mgrSSN = E.empSSN
--2.Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SELECT P.proNum, P.proName, D.depName
FROM tblProject P, tblDepartment D
WHERE P.depNum = D.depNum AND D.depName = N'Phòng Nghiên cứu và phát triển';
--3.Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SELECT P.proNum, P.proName, D.depName
FROM tblProject P, tblDepartment D
WHERE P.depNum = D.depNum  AND P.proName =N'ProjectB'
--4.Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên
SELECT E.empSSN,E.empName FROM tblEmployee E WHERE E.supervisorSSN=(SELECT empSSN FROM tblEmployee WHERE empName='Mai Duy An')
--5.Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát.
SELECT E.empSSN, E.empName
FROM tblEmployee E
WHERE E.empSSN= (SELECT E.supervisorSSN  FROM tblEmployee E WHERE empName='Mai Duy An')

--6.Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu. Thông tin yêu cầu: mã số, tên vị trí làm việc.
SELECT l.locNum, L.locName
FROM tblProject P, tblLocation L
WHERE P.proName = 'ProjectA' AND P.locNum = L.locNum;

--7.Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. Thông tin yêu cầu: mã số, tên dự án
SELECT P.proNum, P.proName
FROM tblProject P
WHERE P.locNum = (SELECT l.locNum FROM tblLocation l WHERE l.locName = 'TP Hồ Chí Minh');

--8.Cho biết những người phụ thuộc trên 18 tuổi .Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.

SELECT D.depName, D.depBirthdate, E.empName
FROM tblDependent D
JOIN tblEmployee E ON D.empSSN = E.empSSN
WHERE YEAR(GETDATE()) - YEAR(D.depBirthdate) > 18;
--9.Cho biết những người phụ thuộc  là nam giới. Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào 
SELECT D.depName, D.depBirthdate, E.empName
FROM tblDependent D
JOIN tblEmployee E ON D.empSSN = E.empSSN Where d.depSex='M'
--10.Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
SELECT D.depNum, D.depName, L.locName
FROM tblDepartment D
JOIN tblDepLocation dep ON D.depNum = dep.depNum
join tblLocation l ON Dep.locNum=l.locNum
WHERE D.depName = 'Phòng Nghiên cứu và phát triển';

SELECT * FROM tblDepartment WHERE depName = 'Phòng Nghiên cứu và phát triển';

--11.Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
SELECT P.proNum, P.proName, D.depName
FROM tblProject P
JOIN tblDepartment D ON P.depNum = D.depNum
JOIN tblDepLocation DL ON D.depNum = DL.depNum
JOIN tblLocation L ON DL.locNum = L.locNum
WHERE L.locName = 'TP Hồ Chí Minh';
--12.Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển . Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
SELECT E.empName, D.depName, Dep.depRelationship
FROM tblEmployee E
JOIN tblDepartment D ON E.depNum = D.depNum
JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
WHERE E.depNum = (SELECT depNum FROM tblDepartment WHERE depName = 'Phòng nghiên cứu và phát triển') AND Dep.depSex = 'F';

  --13.Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên
SELECT E.empName, Dep.depName, Dep.depRelationship
FROM tblEmployee E
INNER JOIN tblDepartment D ON E.depNum = D.depNum
INNER JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
WHERE E.depNum= (SELECT depNum FROM tblDepartment WHERE depName = 'Phòng nghiên cứu và phát triển')
  AND YEAR(GETDATE()) - YEAR(Dep.depBirthdate) > 18;

  --14.Cho biết số lượng người phụ thuộc theo giới tính. Thông tin yêu cầu: giới tính, số lượng người phụ thuộc

SELECT depSex , COUNT(*) AS 'Số lượng người phụ thuộc'
FROM tblDependent
GROUP BY depSex;
--15.Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
SELECT dep.depRelationship,COUNT(depRelationship) AS [Số lượng người phụ thuộc]FROM tblDependent Dep GROUP BY depRelationship
--16.Cho biết số lượng người phụ thuộc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT D.depNum , D.depName ,COUNT(Dep.depName) AS 'Số lượng người phụ thuộc'
FROM tblDepartment D
LEFT JOIN tblEmployee E ON D.depNum = E.depNum
LEFT JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
GROUP BY D.depNum, D.depName
ORDER BY D.depNum;
--17.Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ t
SELECT D.depNum, D.depName, COUNT(Dep.depName) AS 'Số lượng người phụ thuộc'
FROM tblDepartment D
LEFT JOIN tblEmployee E ON D.depNum = E.depNum
LEFT JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
GROUP BY D.depNum, D.depName
HAVING COUNT(Dep.depName) = (
    SELECT MIN(CountDep)
    FROM (SELECT COUNT(Dep.depName) AS CountDep FROM tblDependent GROUP BY E.empSSN) AS SubQuery
)
ORDER BY D.depNum;
--18.Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT D.depNum, D.depName, COUNT(Dep.depName) AS 'Số lượng người phụ thuộc'
FROM tblDepartment D
LEFT JOIN tblEmployee E ON D.depNum = E.depNum
LEFT JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
GROUP BY D.depNum, D.depName
HAVING COUNT(Dep.depName) = (
    SELECT MAX(CountDep)
    FROM (SELECT COUNT(Dep.depName) AS CountDep FROM tblDependent GROUP BY E.empSSN) AS SubQuery
)
ORDER BY D.depNum;
--19.Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN ,
       E.empName ,
       D.depName ,
       SUM(WO.workHours) AS 'Tổng số giờ tham gia dự án'
FROM tblEmployee E
LEFT JOIN tblDepartment D ON E.depNum = D.depNum
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
GROUP BY E.empSSN, E.empName, D.depName
ORDER BY E.empSSN;
--20.Cho biết tổng số giờ làm dự án của mỗi phòng ban. Thông tin yêu cầu: mã phòng ban,  tên phòng ban, tổng số giờ
SELECT D.depNum,D.depName,SUM(WO.workHours) AS 'Tổng số giờ tham gia dự án' FROM tblDepartment D JOIN tblEmployee E on E.depNum= D.depNum
JOIN tblWorksOn WO  ON E.empSSN = WO.empSSN 
GROUP BY D.depNum,D.depName
ORDER BY D.depNum

--21.Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT E.empSSN, E.empName,
       SUM(WO.workHours) AS 'Tổng số giờ tham gia dự án'
FROM tblEmployee E
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
GROUP BY E.empSSN, E.empName
HAVING SUM(WO.workHours) = (
    SELECT MIN(TotalWorkHours)
    FROM (
        SELECT empSSN, SUM(workHours) AS TotalWorkHours
        FROM tblWorksOn
        GROUP BY empSSN
    ) AS sub
)
--22.Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT E.empSSN, E.empName,
       SUM(WO.workHours) AS 'Tổng số giờ tham gia dự án'
FROM tblEmployee E
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
GROUP BY E.empSSN, E.empName
HAVING SUM(WO.workHours) = (
    SELECT MAX(TotalWorkHours)
    FROM (
        SELECT empSSN, SUM(workHours) AS TotalWorkHours
        FROM tblWorksOn
        GROUP BY empSSN
    ) AS subSELECT E.empSSN, E.empName, D.depName
FROM tblEmployee E
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
LEFT JOIN tblProject P ON WO.proNum = P.proNum
LEFT JOIN (
    SELECT empSSN, MIN(workHours) AS minWorkHours
    FROM tblWorksOn
    GROUP BY empSSN
) MinWorkHours ON E.empSSN = MinWorkHours.empSSN
WHERE WO.workHours = MinWorkHours.minWorkHours;
)
--23.Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN, E.empName, D.depName
FROM tblEmployee E
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
LEFT JOIN tblProject P ON WO.proNum = P.proNum
LEFT JOIN tblDepartment D ON E.depNum = D.depNum
WHERE WO.workHours = (
    SELECT MIN(workHours)
    FROM tblWorksOn
    WHERE empSSN = E.empSSN
);
--24.Cho biết những nhân viên nào lần thứ hai tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN, E.empName, D.depName
FROM tblEmployee E
JOIN tblWorksOn W1 ON E.empSSN = W1.empSSN
JOIN tblWorksOn W2 ON E.empSSN = W2.empSSN AND W1.proNum != W2.proNum
JOIN tblDepartment D ON E.depNum = D.depNum
GROUP BY E.empSSN, E.empName, D.depName
`q


--25.Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN, E.empName, D.depName
FROM tblEmployee E
JOIN (
    SELECT empSSN
    FROM tblWorksOn
    GROUP BY empSSN
    HAVING COUNT(DISTINCT proNum) >= 2
) W ON E.empSSN = W.empSSN
JOIN tblDepartment D ON E.depNum = D.depNum;
--26.Cho biết số lượng thành viên của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum, P.proName, COUNT(W.empSSN) AS 'Số lượng thành viên'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName;
--27.Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum, P.proName, COUNT(W.workHours) AS 'Tổng số giờ làm'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName;
--28.Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum, P.proName, COUNT(W.empSSN) AS 'số lượng thành viên ít nhất'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING COUNT(W.empSSN) = (
    SELECT MIN(MemberCount)
    FROM (
        SELECT COUNT(empSSN) AS MemberCount
        FROM tblWorksOn
        GROUP BY proNum
    ) AS ProjectMembers
);

--29.Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum, P.proName, COUNT(W.empSSN) AS 'số lượng thành viên nhiều nhất'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING COUNT(W.empSSN) = (
    SELECT MAX(MemberCount)
    FROM (
        SELECT COUNT(empSSN) AS MemberCount
        FROM tblWorksOn
        GROUP BY proNum
    ) AS ProjectMembers
);
--30.Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum, P.proName, SUM(W.workHours) AS 'Dự án có tổng số giờ làm ít nhất'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING SUM(W.workHours) = (SELECT MIN(TotalHours) FROM (SELECT SUM(WO.workHours) AS TotalHours FROM tblWorksOn WO GROUP BY WO.proNum) AS T);
--31.Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum, P.proName, SUM(W.workHours) AS 'tổng số giờ làm ít nhất'
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING SUM(W.workHours) = (SELECT MAX(TotalHours) FROM (SELECT SUM(WO.workHours) AS TotalHours FROM tblWorksOn WO GROUP BY WO.proNum) AS T);
--32.Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName AS 'Tên nơi làm việc', COUNT(DISTINCT DL.depNum) AS 'Số lượng phòng ban'
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
GROUP BY L.locName;
--33.Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc

SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', COUNT(DL.depNum) AS 'Số lượng chỗ làm việc'
FROM tblDepartment D
LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName
ORDER BY D.depNum;
--34.Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', MAX(CountLocs) AS ' Số lượng chỗ làm việc nhiều nhất'
FROM tblDepartment D
LEFT JOIN (
    SELECT depNum, COUNT(locNum) AS CountLocs
    FROM tblDepLocation
    GROUP BY depNum
) AS Subquery
ON D.depNum = Subquery.depNum
GROUP BY D.depNum, D.depName
HAVING MAX(CountLocs) = (
    SELECT MAX(CountLocs)
    FROM (
        SELECT depNum, COUNT(locNum) AS CountLocs
        FROM tblDepLocation
        GROUP BY depNum
    ) AS Subquery
);
--36.Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName AS 'Tên nơi làm việc', COUNT(DL.depNum) AS 'Số lượng phòng ban'
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
GROUP BY L.locName
HAVING COUNT(DL.depNum) = (
    SELECT MAX(NumDepartments)
    FROM (
        SELECT locNum, COUNT(depNum) AS NumDepartments
        FROM tblDepLocation
        GROUP BY locNum
    ) AS Subquery
);
--37.Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName AS 'Tên nơi làm việc', COUNT(DL.depNum) AS 'Số lượng phòng ban'
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
GROUP BY L.locName
HAVING COUNT(DL.depNum) = (
    SELECT MIN(NumDepartments)
    FROM (
        SELECT locNum, COUNT(depNum) AS NumDepartments
        FROM tblDepLocation
        GROUP BY locNum
    ) AS Subquery
);
--38.Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc


SELECT E.empSSN AS 'Mã số nhân viên', E.empName AS 'Họ tên nhân viên', COUNT(D.empSSN) AS 'Số lượng người phụ thuộc'
FROM tblEmployee E
JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
HAVING COUNT(D.empSSN) = (
    SELECT MAX(NumberofE) 
    FROM (SELECT COUNT(empSSN) AS NumberofE FROM tblDependent DEP GROUP BY Dep.empSSN) AS SUB
);
--39.Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
SELECT E.empSSN AS 'Mã số nhân viên', E.empName AS 'Họ tên nhân viên', COUNT(D.empSSN) AS 'Số lượng người phụ thuộc'
FROM tblEmployee E
JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
HAVING COUNT(D.empSSN) = (
    SELECT MIN(NumberofE) 
    FROM (SELECT COUNT(empSSN) AS NumberofE FROM tblDependent DEP GROUP BY Dep.empSSN) AS SUB
);

--40.Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN AS 'Mã số nhân viên', E.empName AS 'Họ tên nhân viên', D.depName AS 'Tên phòng ban'
FROM tblEmployee E
 left JOIN tblDependent D ON E.empSSN = D.empSSN
WHERE D.empSSN IS NULL;
--41.Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT D.depNum AS 'Mã số phòng ban', D.depName AS 'Tên phòng ban'
FROM tblDepartment D
LEFT JOIN tblEmployee E ON D.depNum = E.depNum
LEFT JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
WHERE Dep.empSSN IS NULL;
--42.Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN,E.empName,D.depName FROM tblEmployee E LEFT JOIN tblDepartment D  ON E.depNum=D.depNum
LEFT JOIN tblProject P ON D.depNum=P.depNum
GROUP BY E.empSSN, E.empName, D.depName
HAVING COUNT(proNum)=0

--43.Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT D.depNum, D.depName
FROM tblDepartment D
WHERE D.depNum NOT IN (
    SELECT DISTINCT E.depNum
    FROM tblEmployee E
    JOIN tblWorksOn W ON E.empSSN = W.empSSN
);
--44.Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT D.depNum AS 'Mã số phòng ban', D.depName AS 'Tên phòng ban'
FROM tblDepartment D
WHERE D.depNum NOT IN (
    SELECT DISTINCT E.depNum
    FROM tblEmployee E
    JOIN tblWorksOn W ON E.empSSN = W.empSSN
    JOIN tblProject P ON W.proNum = P.proNum
    WHERE P.proName = 'ProjectA'
);
--45.Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', COUNT(DISTINCT P.proNum) AS 'Số lượng dự án'
FROM tblDepartment D
LEFT JOIN tblProject P ON D.depNum = P.depNum
GROUP BY D.depNum, D.depName
ORDER BY D.depNum;
--46.Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', COUNT(P.proNum) AS 'Số lượng dự án'
FROM tblDepartment D
LEFT JOIN tblProject P ON D.depNum = P.depNum
GROUP BY D.depNum, D.depName
HAVING COUNT(P.proNum) = (
    SELECT MIN(ProjectCount)
    FROM (
        SELECT D.depNum, COUNT(P.proNum) AS ProjectCount
        FROM tblDepartment D
        LEFT JOIN tblProject P ON D.depNum = P.depNum
        GROUP BY D.depNum
    ) AS Subquery
)
ORDER BY D.depNum;
--47.Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', COUNT(P.proNum) AS 'Số lượng dự án'
FROM tblDepartment D
LEFT JOIN tblProject P ON D.depNum = P.depNum
GROUP BY D.depNum, D.depName
HAVING COUNT(P.proNum) = (
    SELECT MAX(ProjectCount)
    FROM (
        SELECT D.depNum, COUNT(P.proNum) AS ProjectCount
        FROM tblDepartment D
        LEFT JOIN tblProject P ON D.depNum = P.depNum
        GROUP BY D.depNum
    ) AS Subquery
)
ORDER BY D.depNum;
---48.Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. 
--Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý


SELECT D.depNum AS 'Mã phòng ban', D.depName AS 'Tên phòng ban', COUNT(E.empSSN) AS 'Số lượng nhân viên',
       P.proName AS 'Tên dự án quản lý'
FROM tblDepartment D
JOIN tblEmployee E ON D.depNum = E.depNum
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
LEFT JOIN tblProject P ON WO.proNum = P.proNum
GROUP BY D.depNum, D.depName, P.proName
HAVING COUNT(E.empSSN) > 5
--49.Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên
SELECT E.empSSN AS 'Mã nhân viên', E.empName AS 'Họ tên nhân viên'
FROM tblEmployee E
JOIN tblDepartment D ON E.depNum = D.depNum
LEFT JOIN tblDependent Dep ON E.empSSN = Dep.empSSN
WHERE D.depName = 'Phòng Nghiên cứu và phát triển' AND Dep.empSSN IS NULL;

--50.Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. 
--Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm
SELECT E.empSSN AS 'Mã nhân viên', E.empName AS 'Họ tên nhân viên', SUM(WO.workHours) AS 'Tổng số giờ làm'
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
WHERE D.empSSN IS NULL
GROUP BY E.empSSN, E.empName
HAVING SUM(WO.workHours) IS NOT NULL;
--51.Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
SELECT E.empSSN AS 'Mã nhân viên', E.empName AS 'Họ tên nhân viên',
       COUNT(D.empSSN) AS 'Số lượng người phụ thuộc', SUM(WO.workHours) AS 'Tổng số giờ làm'
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
LEFT JOIN tblWorksOn WO ON E.empSSN = WO.empSSN
GROUP BY E.empSSN, E.empName
HAVING COUNT(D.empSSN) > 3


--52.ho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) của nhân viên Mai Duy An.
--Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm

SELECT E.empSSN,E.empName,SUM(WO.workHours) AS'Tổng số giờ làm' FROM tblEmployee E  
LEFT JOIN tblWorksOn WO ON E.empSSN=WO.empSSN

WHERE E.supervisorSSN=(SELECT empSSN FROM tblEmployee WHERE empName='Mai Duy An')  
GROUP BY E.empSSN,E.empName













