/**------------------------------------------------------------------------------------------------
  SUMMARY

  - 1 Database chứa nhiều table, 1 table chứa nhiều entity
  - DDL - Data Definition Language (Phân nhánh của SQL):
    - CREATE DATABASE|TABLE <Database/Table>
    - DROP DATABASE|TABLE <Table>
    - ALTER DATABASE|TABLE ADD|DROP ...

  - DML - Data Manipulation Language /DQL - Data Query Language (chỉ dùng với SELECT)
    - INSERT INTO <Table> VALUE (<Value>)

  - Ràng buộc dữ liệu: Constraint trên data/cell/column
    - Cách thiết kế database/table với các ràng buộc cho các cell/column nào đó có value thỏa điều kiện
    - Đặt ra quy tắc/rule cho việc nhập data.
    - Mặc định, Database Engine sẽ tự đặt tên cho các constraint khi sử dụng DDL. Có thể đặt tên cho constraint (Constraint name) để phân biệt:
        ALTER TABLE <Table> ADD CONSTRAINT <Constraint_Name> <Constraint_Type> (<Column_Constrainted>);
    - Xóa constraint:  ALTER TABLE <Table> DROP CONSTRAINT <Constraint_Name>;
    - Một số constraint:
        - NOT NULL: giá trị khi thêm vào không được trống (Default: NULL - cho phép trống giá trị)
        - Primary Key (PK): PRIMARY KEY
            - Dùng làm "chìa khóa" để tìm ra/xác định duy nhất 1 data/object/entity.
            - Cột này là 1 Constraint, không trùng lặp
            - Đã bao hàm: NOT NULL
 ------------------------------------------------------------------------------------------------*/

-- Tạo cấu trúc/dàn khung/nơi chứa dữ liệu/data
--  1 Database có nhiều table
CREATE DATABASE DBDESIGN_ONETABLE;
USE DBDESIGN_ONETABLE;

-- Tạo table để lưu trữ
--  1 Table lưu trữ nhiều entity
CREATE TABLE StudentV1
(
    StudentID CHAR(8),
    LastName  NVARCHAR(40),
    FirstName NVARCHAR(10),
    DOB       DATETIME,
    Address   NVARCHAR(50)
)

-- Thao tác với data trong table - DML/DQL (Dành riêng cho SELECT)

SELECT *
FROM StudentV1;

-- Thêm đầy đủ data cho các field
INSERT INTO StudentV1
VALUES ('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh');

-- Thêm data cho một vài cột, miễn cột cho phép trống value
INSERT INTO StudentV1
VALUES ('SE123457', N'Lê', N'Bình', '2003-2-1', NULL);
INSERT INTO StudentV1(StudentID, LastName, FirstName)
VALUES ('SE123459', N'Trần', N'Dũng');
INSERT INTO StudentV1(LastName, FirstName, StudentID)
VALUES (N'Phạm', N'Em', 'SE123460');

-- Constraint
CREATE TABLE StudentV2
(
    StudentID CHAR(8) PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME,
    Address   NVARCHAR(50)
);

INSERT INTO StudentV2
VALUES ('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh');

-- Error:
-- INSERT INTO StudentV2(StudentID, LastName, FirstName)
-- VALUES (NULL, NULL, NULL);
-- INSERT INTO StudentV2(StudentID, LastName, FirstName)
-- VALUES ('AHIHI', NULL, NULL);
-- INSERT INTO StudentV2
-- VALUES ('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh');
-- INSERT INTO StudentV2
-- VALUES (NULL, NULL, NULL, NULL, NULL);

INSERT INTO StudentV2
VALUES ('GD123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh');
INSERT INTO StudentV2
VALUES ('SE123457', N'Lê', N'Bình', '2003-2-1', NULL);
INSERT INTO StudentV1
VALUES ('SE123458', N'Võ', N'Cường', NULL, NULL);
INSERT INTO StudentV2(StudentID, LastName, FirstName)
VALUES ('SE123459', N'Trần', N'Dũng');

-- Cho phép giá trị khi insert là NULL
CREATE TABLE StudentV3
(
    StudentID CHAR(8) PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL
);

-- Cách khai báo PK riêng ra
CREATE TABLE StudentV4
(
    StudentID CHAR(8)      NOT NULL,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

    PRIMARY KEY (StudentID)
);

INSERT INTO StudentV4
VALUES ('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh');

-- Chủ động đặt tên cho các constraint
CREATE TABLE StudentV5
(
    StudentID CHAR(8)      NOT NULL,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

    --PRIMARY KEY(StudentID) -- Tự db engine đặt tên cho constraint
    CONSTRAINT PK_STUDENTV5 PRIMARY KEY (StudentID) -- Chủ động đặt tên cho constraint
);

-- Khai báo các constraint sau khi đã tạo table: ALTER TABLE <Table> ADD CONSTRAINT <Constraint_Name> <Key> (<Column>)
CREATE TABLE StudentV6
(
    StudentID CHAR(8)      NOT NULL,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL

    --PRIMARY KEY(StudentID)
    -- CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID)
);
ALTER TABLE StudentV6
    ADD CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID);

-- Xóa constraint
ALTER TABLE StudentV6
    DROP CONSTRAINT PK_STUDENTV6;