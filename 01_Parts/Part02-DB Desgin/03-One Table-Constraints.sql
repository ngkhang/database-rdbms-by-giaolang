/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Constraint:
    - Primary key (PK - Khóa chính):
        - Có thể là 1 hoặc nhiều cột cùng làm PK
        - Giá trị của nó trên mọi dòng/record/row (mọi cell của cột) không trùng lặp (unique) và khác NULL
        - Tạo value cho PK:
            - Cách 1: Tự nhập, DB Engine sẽ kiểm tra và tự báo vi phạm PK Constraint
            - Cách 2: DB Engine tự generate
                - Số tự tăng: IDENTITY(<Start>, <Step>). Mặc định IDENTITY = IDENTITY(1,1)
        - Khi xóa row có auto generated key, DB Engine không tạo lại số đã mất
 ------------------------------------------------------------------------------------------------*/

-- CREATE DATABASE DBDESIGN_ONETABLE;

USE DBDESIGN_ONETABLE;

CREATE TABLE Registration
(
--     SEQ int PRIMARY KEY,        -- Tự nhập
    SEQ       int PRIMARY KEY IDENTITY, -- Số tự tăng: IDENTITY(<Start>, <Step>) - Default: IDENTITY(1,1)  )
    FirstName NVARCHAR(10),
    LastName  NVARCHAR(30),
    Email     VARCHAR(50),
    Phone     VARCHAR(11),
    RegDate   DATETIME DEFAULT GETDATE()
)

INSERT INTO Registration
VALUES (N'An', N'Nguyễn', 'an@...', '090x', null);
INSERT INTO Registration(FirstName, LastName, Email, Phone)
VALUES (N'Bình', N'Lê', 'binh@...', '091x');
