/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Database: kho/tủ/nơi chứa data bên trong
  - Data bện trong được lưu trữ dưới dạng kệ có ngăn - Table
  - Các nhánh của SQL:
    - DDL: Data Definition Language
    - DML: Data Manipulation Language

  - JOIN:
    - Kỹ thuật gộp chung nhiều table thành 1 table tạm, nằm trong RAM, không ảnh hưởng đến các table gốc
    - JOIN ~ SELECT cùng lúc nhiều tables
    - CROSS JOIN:
        - Số cột = tổng các cột tables; Số dòng/record = Tích các dòng của các table
    - INNER/OUTER JOIN (EQUI JOIN):
        - Ghép các tables có chọn lọc, tìm ra các điểm chung/tương quan giữa các cột/cell
        - Thông thường dùng các toán tử: =, >=, <=, != để lọc
 ------------------------------------------------------------------------------------------------*/

USE Northwind;

CREATE DATABASE Cartesian;
USE Cartesian;

DROP TABLE EnDict;

CREATE TABLE EnDict
(
    Number int,
    EnDesc VARCHAR(30)
)

INSERT INTO EnDict
VALUES (1, 'One');
INSERT INTO EnDict
VALUES (2, 'Two');
INSERT INTO EnDict
VALUES (3, 'Three');
INSERT INTO EnDict
VALUES (4, 'Four');

DROP TABLE EnDict;

CREATE TABLE VnDict
(
    Number int,
    ViDesc NVARCHAR(30)
)

INSERT INTO VnDict
VALUES (1, N'Một');
INSERT INTO VnDict
VALUES (2, N'Hai');
INSERT INTO VnDict
VALUES (3, N'Ba');
INSERT INTO VnDict
VALUES (5, N'Năm');

-- Cú pháp CROSS JOIN ngắn
SELECT *
FROM VnDict,
     EnDict;

-- Ghép table, sẽ báo lỗi nếu trùng cột. Sừ dụng tham chiếu tên cột qua table hoặc Alias (AS)
-- SELECT * FROM VnDict, EnDict ORDER BY Number; -- Trùng cột Number

-- Tham chiếu qua cột của table
SELECT *
FROM VnDict,
     EnDict
ORDER BY VnDict.Number;

-- Alias cho table và dùng để tham chiếu cho các cột
SELECT *
FROM VnDict vn,
     EnDict en
ORDER BY vn.Number;

SELECT *
FROM VnDict vn,
     EnDict en
ORDER BY vn.Number;

SELECT vn.*, en.EnDesc
FROM VnDict vn,
     EnDict en
ORDER BY en.Number;

SELECT vn.*, en.*
FROM VnDict vn,
     EnDict en
ORDER BY en.Number;

-- Cú pháp CROSS JOIN chuẩn: CROSS JOIN
SELECT *
FROM VnDict
         CROSS JOIN EnDict
ORDER BY EnDict.Number;

-- Ghép chọn lọc tìm tương quan/điểm chung của cột để ghép -> INNER/OUTER JOIN
SELECT *
FROM VnDict,
     EnDict
WHERE VnDict.Number = EnDict.Number;