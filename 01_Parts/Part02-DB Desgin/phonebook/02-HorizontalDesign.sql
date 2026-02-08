/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Mở rộng table theo chiều ngang (Horizontal Expansion - Thêm cột)
    - Các cell không chứa dữ liệu (NULL) vẫn tốn không gian lưu trữ
    - Khi thêm cột, phải sửa query

  ---> Mở rộng theo chiều dọc (Vertical Expansion - Thêm hàng)
 ------------------------------------------------------------------------------------------------*/

-- CREATE DATABASE DBDESIGN_PHONEBOOK;
-- USE DBDESIGN_PHONEBOOK;

/**
  - Version 2: Horizontal Expansion (Mở rộng theo chiều ngang)
    - Pros:
        - SELECT là tìm được tất cả các số di động, không cần JOIN table
        - Không cần tự quy ước cách nhập, loại số điện thoại
    - Cons:
        - Với các cell không có dữ liệu (NULL), phí không gian lưu trữ
        - Càng thêm nhiều cột, những cell không có data (NULL) và phải sửa query

  --> Hạn chế việc sửa cấu trúc table, chỉ thêm dữ liệu, không thêm cột table.
        Thêm hàng (mở rộng theo chiều dọc - Vertical Expansion)
 */
CREATE TABLE PhoneBookV2
(
    NickName    NVARCHAR(30),

--     PhoneNumber VARCHAR(50) -- Storage 3 phone numbers
    HomePhone   VARCHAR(50),
    MobilePhone VARCHAR(50),
    WorkPhone   VARCHAR(50)
);

INSERT INTO PhoneBookV2
VALUES (N'cuongvo', NULL, NULL, NULL);
INSERT INTO PhoneBookV2
VALUES (N'hoangnt', '098x', NULL, NULL);
INSERT INTO PhoneBookV2
VALUES (N'annguyen', '090x', '091x', NULL);
INSERT INTO PhoneBookV2
VALUES (N'binhle', '090x', '091x', '092x');

SELECT *
FROM PhoneBookV2;

SELECT p.NickName, p.WorkPhone
FROM PhoneBookV2 p
WHERE NickName = N'cuongvo';
