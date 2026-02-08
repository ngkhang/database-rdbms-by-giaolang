/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Mở rộng table theo chiều dọc (Vertical Expansion - Thêm hàng) - Decomposition table không có Constraint
    - Để lấy toàn bộ data, phải JOIN table vì data phân mảnh
    - Tách các data trùng lặp ra table khác -> Fix redundancy
    - Không có Constraint (PK, FK,...), dữ liệu khi chỉnh sửa (insert, update, delete) không tính nhất quán

  ---> 1st Normal Form (1NF):
    - Xuất hiện Constraint: PK và FK đảm bảo tính nhất quán
    - Những dữ liệu cố định, để người dùng nhập/chọn từ data đã có (table khác)
 ------------------------------------------------------------------------------------------------*/

-- CREATE DATABASE DBDESIGN_PHONEBOOK;
USE DBDESIGN_PHONEBOOK;

CREATE TABLE PersonV4_1
(
    NickName NVARCHAR(30),
    Title    NVARCHAR(30),
    Company  NVARCHAR(40)
);

/**
  - Version 4.1: Vertical Expansion (Mở rộng theo chiều dọc) - Không có Constraint
    - Pros:
        - Không phí không gian lưu trữ giá trị NULL
        - Biết số điện thoại đó là loại nào (nhà, công ty, cá nhân, ...)
        - Giải quyết được redundancy, data trùng lặp
    - Cons:
        - Tính ko nhất quán (inconsistency) của loại phone ('Cell', 'CELL', 'cell')

  --> Constraints xuất hiện với PK và FK
 */
CREATE TABLE PhoneBookV4_1
(
    Phone     char(11),
    PhoneType nvarchar(20),
    NickName  nvarchar(30) -- Không có FK
);

INSERT INTO PersonV4_1
VALUES (N'hoangnt', 'Lecturer', 'FPTU HCMC');
INSERT INTO PersonV4_1
VALUES (N'annguyen', 'Student', 'FPTU HCMC');
INSERT INTO PersonV4_1
VALUES (N'binhle', 'Student', 'FPTU HLL');

INSERT INTO PhoneBookV4_1 VALUES('098x', 'Cell', N'hoangnt');

INSERT INTO PhoneBookV4_1 VALUES('090x', 'CELL', N'annguyen');
INSERT INTO PhoneBookV4_1 VALUES('091x', 'Home', N'annguyen');

INSERT INTO PhoneBookV4_1 VALUES('090x', 'work', N'binhle');
INSERT INTO PhoneBookV4_1 VALUES('091x', 'cell', N'binhle');
INSERT INTO PhoneBookV4_1 VALUES('092x', 'cell', N'binhle');
