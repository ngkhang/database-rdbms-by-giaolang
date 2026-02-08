/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Mở rộng table theo chiều dọc (Vertical Expansion - Thêm hàng) - Không tách table
    - Không chứa cột có dữ liệu NULL
    - Dễ query mà không cần JOIN table
    - Thêm data thì thêm hàng

  - Nếu mở rộng theo chiều dọc và tất cả dữ liệu trong cùng table -> Vi phạm PK, redundancy data
  ---> Decomposition table: Tách data có dữ liệu trùng lặp ra 1 table khác.
 ------------------------------------------------------------------------------------------------*/

-- CREATE DATABASE DBDESIGN_PHONEBOOK;
-- USE DBDESIGN_PHONEBOOK;

/**
  - Version 3.1: Vertical Expansion (Mở rộng theo chiều dọc)
    - Pros:
        - SELECT là tìm được tất cả các số di động, không cần JOIN table
        - Không phí không gian lưu trữ giá trị NULL
    - Cons:
        - Không biết số điện thoại đó là loại nào (nhà, công ty, cá nhân, ...)
        - Vi phạm PK, redundancy, data trùng lặp (Nickname)

  --> Phân tách table: Tách các phần trùng lặp ra table khác.
 */
CREATE TABLE PhoneBookV3_SingleColumn
(
    NickName    NVARCHAR(30),
    PhoneNumber VARCHAR(50) -- Storage only a phone number
);

INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'hoangnt', '098x');

-- INSERT INTO PhoneBookV3_SingleColumn
-- VALUES (N'annguyen', '090x', '091x', NULL);
INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'annguyen', '090x');
INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'annguyen', '091x');

-- INSERT INTO PhoneBookV3_SingleColumn
-- VALUES (N'binhle', '090x', '091x', '092x');
INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'binhle', '090x');
INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'binhle', '091x');
INSERT INTO PhoneBookV3_SingleColumn
VALUES (N'binhle', '092x');

SELECT *
FROM PhoneBookV3_SingleColumn;

SELECT NickName, COUNT(*) AS [No Phones]
FROM PhoneBookV3_SingleColumn
GROUP BY (NickName);

/**
  - Version 3.2: Vertical Expansion (Mở rộng theo chiều dọc) + Type of Phone
    - Pros:
        - SELECT là tìm được tất cả các số di động, không cần JOIN table
        - Không phí không gian lưu trữ giá trị NULL
        - Biết số điện thoại đó là loại nào (nhà, công ty, cá nhân, ...)
    - Cons:
        - Vi phạm PK, redundancy, data trùng lặp (Nickname)

  --> Phân tách table: Tách các phần trùng lặp ra table khác.
 */
CREATE TABLE PhoneBookV3_SingleColumn_2
(
    NickName    NVARCHAR(30),
    PhoneNumber VARCHAR(50), -- Storage only a phone number
    PhoneType   NVARCHAR(20) -- Home, Work, Mobile
);

INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'hoangnt', '098x', 'Work');

-- INSERT INTO PhoneBookV3_SingleColumn_2
-- VALUES (N'annguyen', '090x', '091x', NULL);
INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'annguyen', '090x', 'Home');
INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'annguyen', '091x', 'Mobile');

-- INSERT INTO PhoneBookV3_SingleColumn_2
-- VALUES (N'binhle', '090x', '091x', '092x');
INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'binhle', '090x', 'Home');
INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'binhle', '091x', 'Mobile');
INSERT INTO PhoneBookV3_SingleColumn_2
VALUES (N'binhle', '092x', 'Work');

SELECT *
FROM PhoneBookV3_SingleColumn_2;

SELECT *
FROM PhoneBookV3_SingleColumn_2
WHERE PhoneType = 'Mobile';