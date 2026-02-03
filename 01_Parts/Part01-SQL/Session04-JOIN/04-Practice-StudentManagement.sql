/**------------------------------------------------------------------------------------------------
  SUMMARY

  - COUNT(*): CHỉ cần có dòng/row thì vẫn tính là 1, dù cho cell mang giá trị NULL
 ------------------------------------------------------------------------------------------------*/

DROP DATABASE StudentManagement;

CREATE DATABASE StudentManagement;

USE StudentManagement;

CREATE TABLE Major
(
    MajorID   char(2) PRIMARY KEY, -- PK Primary Key - Khóa chính
    MajorName varchar(30),
    Hotline   varchar(11)
);

INSERT INTO Major
VALUES ('SE', 'Software Engineering', '090x');
INSERT INTO Major
VALUES ('IA', 'Information Assurance', '091x');
INSERT INTO Major
VALUES ('GD', 'Graphic Design', '092x');
INSERT INTO Major
VALUES ('JP', 'Japanese', '093x');
INSERT INTO Major
VALUES ('KR', 'Korean', '094x');

DROP TABLE Student;

CREATE TABLE Student
(
    StudentID char(8) PRIMARY KEY,               -- PK Primary Key - Khóa chính
    LastName  nvarchar(30),
    FirstName nvarchar(10),
    DOB       date,
    Address   nvarchar(50),
    MajorID   char(2) REFERENCES Major (MajorID) -- FK Foreign Key - Khóa ngoại
);

INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE3', N'Trần', N'Ba', 'SE');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('SE6', N'Võ', N'Sáu', 'IA');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('GD8', N'Huỳnh', N'Tám', 'GD');

INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('JP9', N'Ngô', N'Chín', 'JP');

-- TỪ TỪ HÃY THÊM VÀO ĐỂ XEM FULL-OUTER JOIN RA SAO
INSERT
INTO Student(StudentID, LastName, FirstName, MajorID)
VALUES ('UNK', N'Đặng', N'Mười', NULL);


--1. In ra thông tin chi tiết của SV kèm thông tin chuyên ngành
SELECT s.*, m.MajorName, m.Hotline
FROM Student s
         LEFT JOIN Major m ON s.MajorID = m.MajorID;

SELECT s.*, m.MajorName, m.Hotline
FROM Student s
         JOIN Major m ON s.MajorID = m.MajorID;

SELECT s.*, m.MajorName, m.Hotline
FROM Student s,
     Major m
WHERE s.MajorID = m.MajorID;

--2. In ra thông tin chi tiết của sv kèm info chuyên ngành. Chỉ quan tâm sv SE và IA
SELECT s.*, m.MajorName, m.Hotline
FROM Student s
         JOIN Major m ON s.MajorID = m.MajorID
WHERE m.MajorID IN ('SE', 'IA');

SELECT s.*, m.MajorID, m.MajorName, m.Hotline
FROM Student s,
     Major m
WHERE s.MajorID = m.MajorID
  AND m.MajorID IN ('SE', 'IA')

--3. In ra thông tin các sinh viên kèm chuyên ngành. Chuyên ngành nào chưa có sv cũng in ra luôn
SELECT s.*, m.MajorName, m.Hotline
FROM Student s
         RIGHT JOIN Major m ON s.MajorID = m.MajorID;

SELECT s.*, m.MajorName, m.Hotline
FROM Major m
         LEFT JOIN Student s ON s.MajorID = m.MajorID;

--4. Có bao nhiêu chuyên ngành???
SELECT COUNT(MajorID) AS [No. Major]
FROM Major;

--5. Mỗi chuyên ngành có bao nhiêu sinh viên???
SELECT MajorID, COUNT(StudentID) AS [No. Students]
FROM Student
GROUP BY MajorID;

--6. Chuyên ngành nào có từ 3 sv trở lên???
SELECT MajorID
FROM Student
GROUP BY MajorID
HAVING COUNT(MajorID) >= 3;

--7. Chuyên ngành có ít sinh viên nhất
SELECT MajorID
FROM Student
GROUP BY MajorID
HAVING COUNT(MajorID) <= ALL (SELECT COUNT(MajorID)
                              FROM Student
                              GROUP BY MajorID);

--8. Đếm số sv của chuyên ngành SE
SELECT COUNT(*) AS [No. Student]
FROM Student
WHERE MajorID = 'SE';

SELECT MajorID, COUNT(MajorID) AS [No. Students]
FROM Student
WHERE MajorID = 'SE'
GROUP BY MajorID;

--9. Đếm số sinh viên của mỗi chuyên ngành
SELECT m.MajorID, m.MajorName, COUNT(*) AS [No students]
FROM Student s
         INNER JOIN Major m ON s.MajorID = m.MajorID
GROUP BY m.MajorID, m.MajorName;

--10. câu 10 điểm nè...
SELECT m.MajorID, m.MajorName, COUNT(StudentID) AS [No students]
FROM Major m
         LEFT JOIN Student s ON m.MajorID = s.MajorID
GROUP BY m.MajorID, m.MajorName;

SELECT m.MajorId, m.MajorName, COUNT(StudentID)
FROM Student s
         RIGHT JOIN Major m ON s.MajorID = m.MajorID
GROUP BY m.MajorId, m.MajorName;
