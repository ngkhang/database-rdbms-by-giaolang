/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Relationship: One-to-Many
    - Note:
        - Table 1 tạo trước, Table N tạo sau
        - Tên cột của khóa ngoại (Foreign Key)/tham chiếu không cần trùng tên bên 1-key, nhưng phải trùng data type
        - Khi muốn xóa table 1 (có quan hệ 1-N), phải xóa Table N trước vì nó đang được tham chiếu bởi table khác
    - Syntax: Khai báo Foreign Key:
        - Cách 1: <Column_Name>  <Data_type> REFERENCES <Table_1> (<Column_Name_Ref_Table_1>)
        - Cách 2: <Column_Name>  <Data_type> FOREIGN KEY REFERENCES <Table_1> (<Column_Name_Ref_Table_1>)
        - Cách 3:
            <Column_Name>  <Data_type>,
            CONSTRAINT <Constraint_Name>
                FOREIGN KEY (<Column_Name>) REFERENCES <Table_1> (<Column_Name_Ref_Table_1>)
  - Note:
    - Set giá trị default cho column: DEFAULT <Value>

  - Constraint liên quan đến hành vi xóa/sửa data ở ràng buộc khóa chính (PK)/khóa ngoại (FK)
    - Type: CASCADE, SET NULL, SET DEFAULT
                           Cột table 1      |     Cột table N
        - CASCADE:          Ảnh hưởng       |    Ảnh hưởng theo
        - SET NULL:         Ảnh hưởng       |   Mang giá trị NULL
        - SET DEFAULT:      Ảnh hưởng       |   Mang giá trị Default
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_ONEMANY;

USE DBDESIGN_ONEMANY;

-- Ont-to-many: Table 1
CREATE TABLE MajorV1
(
    MajorID   CHAR(2) PRIMARY KEY,
    MajorName NVARCHAR(40) NOT NULL
);
INSERT INTO MajorV1
VALUES ('SE', N'Kĩ thuật phần mềm');
INSERT INTO MajorV1
VALUES ('IA', N'An toàn thông tin');

-- One-to-many: Table N
CREATE TABLE StudentV1
(
    StudentID CHAR(8)      NOT NULL,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

--     Cách 1:
--     MajorID   CHAR(2) REFERENCES MajorV1 (MajorID),

--     Cách 2:
    MajorID   CHAR(2) FOREIGN KEY REFERENCES MajorV1 (MajorID),
);
INSERT INTO StudentV1
VALUES ('SE1', N'NGUYỄN', N'AN', NULL, NULL, 'SE');

-- Error: Vì MajorID = 'gd' không tồn tại trong Major table
INSERT INTO StudentV1
VALUES ('SE2', N'LÊ', N'BÌNH', NULL, NULL, 'gd');

-- Các cách khai báo khác với FK
CREATE TABLE MajorV2
(
    MajorID   CHAR(2) PRIMARY KEY,
    MajorName NVARCHAR(40) NOT NULL
);

CREATE TABLE StudentV2
(
    StudentID CHAR(8) PRIMARY KEY,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

--     Khai báo FK và Constraint riêng lẻ
    MajorID   CHAR(2),
    CONSTRAINT FK_StudentV2_MajorV2
        FOREIGN KEY (MajorID) REFERENCES MajorV2 (MajorID)
);

-- Xóa Constraint
ALTER TABLE StudentV2
    DROP CONSTRAINT FK_StudentV2_MajorV2;

-- Thêm Constraint
ALTER TABLE StudentV2
    ADD CONSTRAINT FK_StudentV2_MajorV2 FOREIGN KEY (MajorID) REFERENCES MajorV2 (MajorID);

-- Constraint: CASCADE
CREATE TABLE MajorV3
(
    MajorID   CHAR(2) PRIMARY KEY,
    MajorName NVARCHAR(40) NOT NULL
);

CREATE TABLE StudentV3
(
    StudentID CHAR(8) PRIMARY KEY,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

    MajorID   CHAR(2),
    CONSTRAINT FK_StudentV3_MajorV3
        FOREIGN KEY (MajorID) REFERENCES MajorV3 (MajorID)
            ON DELETE CASCADE   -- Cột trong Table 1 xóa, Cột trong Table N xóa
            ON UPDATE CASCADE   -- Cột trong Table 1 sửa, Cột trong Table N sửa
)

-- Constraint: SET NULL
CREATE TABLE MajorV4
(
    MajorID   CHAR(2) PRIMARY KEY,
    MajorName NVARCHAR(40) NOT NULL
);

CREATE TABLE StudentV4
(
    StudentID CHAR(8) PRIMARY KEY,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

    MajorID   CHAR(2),
    CONSTRAINT FK_StudentV4_MajorV4
        FOREIGN KEY (MajorID) REFERENCES MajorV4 (MajorID)
            ON DELETE SET NULL    -- Cột trong Table 1 xóa, Cột trong Table N về NULL
            ON UPDATE CASCADE
);

-- Constraint: SET DEFAULT
CREATE TABLE MajorV5
(
    MajorID   CHAR(2) PRIMARY KEY,
    MajorName NVARCHAR(40) NOT NULL
);

CREATE TABLE StudentV5
(
    StudentID CHAR(8) PRIMARY KEY,
    LastName  NVARCHAR(40) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    DOB       DATETIME     NULL,
    Address   NVARCHAR(50) NULL,

    MajorID   CHAR(2) DEFAULT 'SE',  -- Set giá trị default
    CONSTRAINT FK_StudentV5_MajorV5
        FOREIGN KEY (MajorID) REFERENCES MajorV5 (MajorID)
            ON DELETE SET DEFAULT    -- Cột trong Table 1 xóa, Cột trong Table N về có giá trị Default
            ON UPDATE CASCADE
);

