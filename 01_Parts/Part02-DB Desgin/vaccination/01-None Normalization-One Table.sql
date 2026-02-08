/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Multi-Valued:
    - Một cell chứa nhiều info độc lập/bình đẳng, ngang bằng nhau về ngữ nghĩa
    - Example: Address: 1 Le Loi, Quan 1, TPHCM; 1 Vo Van Ngan, Quan Thu Duc, TPHCM.
  - Composite-Valued:
    - Chứa một value duy nhất, mỗi value này gom chung nhiều phần nhỏ (mỗi phần có vai trò riêng), gom thành 1 thứ khác
    - Example: Address: 76/3 Duong so 7, Quan Thu Duc, TPHCM.
    - Gộp N info vào 1 cell: Dễ, nhanh nhưng khó thống ké, sort -> Tách cột sẽ trả lại đúng ngữ nghĩa cho từng info
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_VACCINATION;

USE DBDESIGN_VACCINATION;

/**
  Version 1: Đa trị - Multi-Valued
    - Pros:
        - Chỉ cần 1 table để lưu trữ, dễ SELECT, không cần JOIN table
    - Cons:
        - Không thống kê được, khó cắt chuỗi do cột đa trị
    - Solution: Quan tâm thống kê, số liệu (số mũi tiêm, Số người tiêm vaccine theo từng loại,...)
        ---> Thêm cột/dòng, tách table/cột
 */
CREATE TABLE VaccinationV1
(
    ID            CHAR(11) PRIMARY KEY,
    LastName      NVARCHAR(30),
    FirstName     NVARCHAR(10),
    Phone         VARCHAR(11) NOT NULL UNIQUE,
    InjectionInfo NVARCHAR(255),
);

INSERT INTO VaccinationV1
VALUES ('00000000001', N'NGUYỄN', N'AN', '090X',
        N'AZ Ngày 28.9.2021 ĐH FPT | AZ Ngày 28.10.2021 BV LÊ VĂN THỊNH, Q. TĐ');

/**
  Version 2: Thêm cột - Composite-Valued
    - Pros: Tương tự Version 1, không tồn tại cột đa trị
    - Cons:
        - Tốn không gian bộ nhớ vì các cell phải chừa chỗ cho giá trị NULL
        - Có cột là Composite-Valued, khó thống kê
    - Solution: Nơi cần nhiều info thì nhiều dòng.
        ---> Thêm dòng, tách table
 */
CREATE TABLE VaccinationV2
(
    ID        CHAR(11) PRIMARY KEY,
    LastName  NVARCHAR(30),
    FirstName NVARCHAR(10),
    Phone     VARCHAR(11) NOT NULL UNIQUE,

--     InjectionInfo NVARCHAR(255),
    Dose1     NVARCHAR(100),
    Dose2     NVARCHAR(100)
);

/**
  Version 3: Thêm dòng
    - Pros: Không cần chừa chỗ cho NULL, chỉ cần thêm dòng mới
    - Cons:
        - Vẫn tồn tại cột Composite-valued, không thống kê được
    - Solution: Tách cột composite thành các cột nhỏ hơn, đưa về đúng ý nghĩa chi từng phần info
 */
CREATE TABLE PersonV3
(
    ID        CHAR(11) PRIMARY KEY,
    LastName  NVARCHAR(30),
    FirstName NVARCHAR(10),
    Phone     VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE VaccinationV3
(
    ID       CHAR(11) PRIMARY KEY,
    PersonID CHAR(11) NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES PersonV3 (ID),
    Dose     NVARCHAR(100)
);

/**
  Version 4: Thêm hàng
    - Pros: Các cột chứa giá trị là Single-valued, tường minh ngữ nghĩa; dễ thống ké, sort
    - Cons: Nhiều fields
 */
CREATE TABLE PersonV4
(
    ID        CHAR(11) PRIMARY KEY,
    LastName  NVARCHAR(30),
    FirstName NVARCHAR(10),
    Phone     VARCHAR(11) NOT NULL UNIQUE
);

CREATE TABLE VaccinationV4
(

    ID          CHAR(11) PRIMARY KEY,
    NoVaccine   INT,
    PersonID    CHAR(11) NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES PersonV4 (ID),

--     Dose     NVARCHAR(100)
    InjectDate  DATETIME,
    VaccineName NVARCHAR(50),
    Lot         NVARCHAR(20),
    [Location]  NVARCHAR(50)
);

INSERT INTO PersonV4
VALUES ('00000000001', N'NGUYỄN', N'AN', '0901x');
INSERT INTO PersonV4
VALUES ('00000000002', N'LÊ', N'BÌNH', '090X');

INSERT INTO VaccinationV4
VALUES ('VACCINE0001', 1, '00000000001', GETDATE(), 'AZ', NULL, NULL);

SELECT *
FROM PersonV4;

SELECT *
FROM VaccinationV4;

SELECT *
FROM PersonV4 p
         LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID;

SELECT p.ID, p.FirstName, COUNT(v.NoVaccine) AS 'No.Does'
FROM PersonV4 p
         LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID
GROUP BY p.ID, p.FirstName;

SELECT p.ID,
       p.FirstName,
       IIF(COUNT(v.NoVaccine) = 0, 'Noop', IIF(COUNT(v.NoVaccine) = 1, 'YELLOW', 'GREEN')) AS STATUS
FROM PersonV4 p
         LEFT JOIN VaccinationV4 v ON p.ID = v.PersonID
GROUP BY p.ID, p.FirstName;

INSERT INTO VaccinationV4
VALUES ('VACCINE0002', 2, '00000000001', GETDATE(), 'AZ', NULL, NULL);
