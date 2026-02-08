/**------------------------------------------------------------------------------------------------
  SUMMARY

  - 1st Normal Form (1NF)
  - Việc tách bảng sẽ làm data phân mảnh, nằm nhiều nơi. Phải JOIN table khi muốn lấy data
  - Khi chỉnh sửa data (update/insert/delete) phải đồng bộ trên các table liên quan
 ------------------------------------------------------------------------------------------------*/

-- CREATE DATABASE DBDESIGN_PHONEBOOK;
USE DBDESIGN_PHONEBOOK;

CREATE TABLE PersonV5
(
    NickName NVARCHAR(30) PRIMARY KEY, -- Hiện tại chưa tối ưu PK
    Title    NVARCHAR(30),
    Company  NVARCHAR(40)
);

CREATE TABLE PhongTypeV5
(
    TypeName    NVARCHAR(20) NOT NULL,
    Description NVARCHAR(50),

    PRIMARY KEY (TypeName) -- Hiện tại chưa tối ưu PK
);

CREATE TABLE PhoneBookV5
(
    Phone    CHAR(11) NOT NULL , -- Hiện tại chưa tối ưu PK

    TypeName NVARCHAR(20) REFERENCES PhongTypeV5 (TypeName),
    NickName NVARCHAR(30) REFERENCES PersonV5 (NickName),

    CONSTRAINT PK_PhoneBookV5 PRIMARY KEY (Phone)
);

INSERT INTO PhongTypeV5
VALUES (N'Di động');
INSERT INTO PhongTypeV5
VALUES (N'Nhà/Để bàn');
INSERT INTO PhongTypeV5
VALUES (N'Công ty');

INSERT INTO PersonV5
VALUES (N'hoangnt', 'Lecturer', 'FPTU HCMC');
INSERT INTO PersonV5
VALUES (N'annguyen', 'Student', 'FPTU HCMC');
INSERT INTO PersonV5
VALUES (N'binhle', 'Student', 'FPTU HLL');

INSERT INTO PhoneBookV5
VALUES ('098x', N'Di động', N'hoangnt');
INSERT INTO PhoneBookV5
VALUES ('090x', N'Di động', N'annguyen');
INSERT INTO PhoneBookV5
VALUES ('091x', N'Nhà/Để bàn', N'annguyen');
INSERT INTO PhoneBookV5
VALUES ('091x', N'Di động', N'binhle');
INSERT INTO PhoneBookV5
VALUES ('092x', N'CÔNG ty', N'binhle');
