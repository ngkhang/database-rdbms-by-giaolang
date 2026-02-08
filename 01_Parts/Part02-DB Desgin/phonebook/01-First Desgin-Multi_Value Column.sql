/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Cột đa trị (Multi-Valued Column):
    - Khi một cell chứa nhiều value cùng kiểu, gọi là cột đa trị (Multi-Valued Column)
  - Table không đạt chuẩn 1 (No Normalization Form): Khi 1 table có cột đa trị.
  - Nâng cấp/chuẩn table, mở rộng theo 2 hướng:
    - Chiều ngang (Horizontal Expansion - Thêm cột)
    - Chiều dọc (Vertical Expansion - Thêm dòng)
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_PHONEBOOK;
USE DBDESIGN_PHONEBOOK;

/**
  - Version 1:
    - All phone numbers are storage in a single column
    - Not have PK
    - Pros:
        - SELECT là tìm được tất cả các số di động, không cần JOIN table
    - Cons:
        - Không phân biệt giữa các loại số điện thoại (nhà, công ty, cá nhân, ...)
        - Format string trong cột phone number không đồng nhất -> Không tìm được Delimitter (dấu phân cách) để cắt chuỗi
        - Không có PK, trùng lặp dữ liệu
 */
CREATE TABLE PhoneBookV1
(
    NickName    NVARCHAR(30),
    PhoneNumber VARCHAR(50) -- Storage 3 phone numbers
);

INSERT INTO PhoneBookV1
VALUES (N'hoangnt', '098x');
INSERT INTO PhoneBookV1
VALUES (N'annguyen', '090x, 091x');
INSERT INTO PhoneBookV1
VALUES (N'binhle', '090x | 091x | 092x');
INSERT INTO PhoneBookV1
VALUES (N'cuongvo', '090x, 091x, 092x');
INSERT INTO PhoneBookV1
VALUES (N'dungpham', '090x-091x - 092x');
