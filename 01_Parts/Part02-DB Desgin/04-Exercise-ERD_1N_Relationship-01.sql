/**------------------------------------------------------------------------------------------------
  Exercise: 02-Exercise-ERD_1N_Relationship.txt

  1. Thiết kế ERD và DDL (SQL Server) để lưu trữ thông tin về các seminar/buổi giảng/phụ đạo của các thầy cô
    - Mỗi giảng viên có thể tổ chức nhiều seminar/buổi phụ đạo khác nhau
    - Mỗi seminar/buổi phụ đạo chỉ do một giảng viên phụ trách
    - Thông tin lưu trữ bao gồm:
        + Giảng viên: mã, tên, email, phone, bộ môn (SE, CF, ITS, Incubator)
        + Seminar/Phụ đạo:
            Ngày giờ, loại hình tổ chức (seminar/phụ đạo/workshop), chủ đề, tóm tắt nội dung
            Phòng học (nếu tiến hành offline), online-link (nếu tiến hành online), số lượng tham gia
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_ACTIVITIES;

USE DBDESIGN_ACTIVITIES;

CREATE TABLE LECTURER
(
    LecturerID CHAR(8) PRIMARY KEY,          -- Mã giảng viên
    LectName   NVARCHAR(30) NOT NULL UNIQUE, -- Tên giảng viên
    LectEmail  NVARCHAR(50) NOT NULL UNIQUE, -- Email
    Phone      CHAR(10),                     -- Phone number
    Major      NVARCHAR(30),                 -- Bộ môn, có thể Lookup
);

INSERT INTO LECTURER
VALUES ('00000001', N'HÒA.ĐNT', 'hoadnt@', '090x', 'CF');

CREATE TABLE ACTIVITY
(
    SEQ        INT IDENTITY PRIMARY KEY,
    Topic      NVARCHAR(30),  -- Chủ đề
    StartDate  DATETIME,      -- Ngày giờ
    Intro      NVARCHAR(200), -- Tóm tắt nội dung
    ActType    NVARCHAR(30),  -- Loại hình tổ chức:workshop, seminar, phụ đạo
    Seats      INT,           -- Số lượng
    Room       NVARCHAR(50),  -- Hyperlink của Zoom, Meet, Phòng

    LecturerID CHAR(8) REFERENCES LECTURER (LecturerID),
);

INSERT INTO ACTIVITY (Topic, StartDate, Intro, ActType, Seats, Room, LecturerID)
VALUES (N'Nhập môn Machine Learning', '2021-11-3 08:30:00', N'...', 'Seminar',
        100, N'Phòng seminar Thư viện FUHCM', '00000001');

INSERT INTO ACTIVITY (Topic, StartDate, Intro, ActType, Seats, Room, LecturerID)
VALUES (N'Giới thiệu về YOLO V4', '2021-11-3 14:30:00', N'...', 'Seminar',
        100, N'Phòng seminar Thư viện', '00000001');

INSERT INTO ACTIVITY (Topic, StartDate, Intro, ActType, Seats, Room, LecturerID)
VALUES (N'Giới thiệu về YOLO V4 (part 2)', '2021-12-3 08:00:00', N'...', 'Workshop',
        100, N'Phòng seminar Thư viện', '00000001');

SELECT *
FROM ACTIVITY;

SELECT *
FROM LECTURER;
