/**------------------------------------------------------------------------------------------------
  Exercise: 02-Exercise-ERD_1N_Relationship.txt

  2. Thiết kế ERD và DDL lưu trữ thông tin các thành viên trong lớp 12A5 ở trường THPT XYZ.
    - Lớp 12A5 có 48 học sinh, chia làm 4 tổ
    - Mỗi tổ có một tổ trưởng là học sinh có uy tín được các bạn bình bầu cử ra.
    - Thông tin cần lưu trữ bao gồm: mã số học sinh, tên, số di động, tên tổ (1, 2, 3, 4), tổ trưởng
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_CLASSES;

USE DBDESIGN_CLASSES;

CREATE TABLE Team
(
    TeamID   INT IDENTITY PRIMARY KEY,
    TeamName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Student
(
    StudentID    INT IDENTITY PRIMARY KEY,
    StudentName  VARCHAR(50) NOT NULL,
    StudentPhone VARCHAR(15) NOT NULL,
    TeamID       INT FOREIGN KEY REFERENCES Team (TeamID)
);

CREATE TABLE Leader
(
    LeaderID  INT IDENTITY PRIMARY KEY,
    StudentID INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Student (StudentID),
    TeamID    INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Team (TeamID)
);

INSERT INTO Team (TeamName)
VALUES ('Team 1'),
       ('Team 2'),
       ('Team 3'),
       ('Team 4');


INSERT INTO Student (StudentName, StudentPhone, TeamID)
VALUES (N'Nguyễn Văn A', '0987654321', 1),
       (N'Trần Thị B', '0987653321', 1),
       (N'Phạm Minh C', '0987654323', 1),
       (N'Hoàng Văn D', '0987654324', 1),
       (N'Võ Thị E', '0987654325', 1),
       (N'Bùi Văn F', '0987654326', 1),
       (N'Đặng Thị G', '0987654327', 1),
       (N'Ngô Văn H', '0987654328', 1),
       (N'Lý Thị I', '0987654329', 1),
       (N'Tô Văn J', '0987654330', 1),
       (N'Mạc Thị K', '0987654331', 1),
       (N'Vương Văn L', '0987654332', 1),

       (N'Trương Thị M', '0987654333', 2),
       (N'Hà Văn N', '0987654334', 2),

       (N'Phạm Văn Z', '0987657321', 3),

       (N'Hoàng Văn Z', '0987654368', 4),
       (N'Nguyễn Khang', '0987651321', 4);

INSERT INTO Leader (StudentID, TeamID)
VALUES (1, 1),
       (12, 2),
       (15, 3),
       (17, 4);
