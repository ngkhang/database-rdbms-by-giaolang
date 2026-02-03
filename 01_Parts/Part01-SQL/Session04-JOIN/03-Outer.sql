/**------------------------------------------------------------------------------------------------
  SUMMARY

  - OUTER JOIN
    - Thứ tự/Vị trí của các table ảnh hưởng kết quả
    - Ghép có chọn lọc
    - Lấy tất cả phần chung tables và phần riêng của table làm chuẩn
    - Không thấy điểm chung so với table chuẩn thì giá trị table vần tồn tại, các phần không có mang giá trị NULL
    - Đảm bảo không mất mát data khi kết nối các tables

    - LEFT/RIGHT/FULL JOIN:
        SELECT ... FROM <T1>                          <T2> ON <Join_Condition>
                              <LEFT/LEFT OUTER> JOIN
                              <RIGHT/RIGHT OUTER> JOIN
                              <FULL/FULL OUTER> JOIN
        - LEFT JOIN:
            - Lấy T1 (table bên trái làm gốc)
            - Thứ tự table quan trọng
        - RIGHT JOIN:
            - Lấy T2 (table bên phải làm gốc)
            - Thứ tự table quan trọng
        - FULL JOIN:
            - Lấy tất cả, phần nào không có mang giá trị NULL
            - Thứ tự table không quan trọng
 ------------------------------------------------------------------------------------------------*/

-- Initial data

-- CREATE DATABASE Cartesian;
-- USE Cartesian;
--
-- DROP TABLE EnDict;
--
-- CREATE TABLE EnDict
-- (
--     Number int,
--     EnDesc VARCHAR(30)
-- )
--
-- INSERT INTO EnDict
-- VALUES (1, 'One');
-- INSERT INTO EnDict
-- VALUES (2, 'Two');
-- INSERT INTO EnDict
-- VALUES (3, 'Three');
-- INSERT INTO EnDict
-- VALUES (4, 'Four');
--
-- DROP TABLE EnDict;
--
-- CREATE TABLE VnDict
-- (
--     Number int,
--     ViDesc NVARCHAR(30)
-- )
--
-- INSERT INTO VnDict
-- VALUES (1, N'Một');
-- INSERT INTO VnDict
-- VALUES (2, N'Hai');
-- INSERT INTO VnDict
-- VALUES (3, N'Ba');
-- INSERT INTO VnDict
-- VALUES (5, N'Năm');

USE Cartesian;

-- 1. Liệt kê cho tôi các cặp từ điển Anh-Việt
SELECT *
FROM VnDict,
     EnDict
WHERE VnDict.Number = EnDict.Number;

SELECT *
FROM VnDict
         INNER JOIN EnDict ON VnDict.Number = EnDict.Number;

SELECT *
FROM VnDict
         JOIN EnDict ON VnDict.Number = EnDict.Number;

-- 2. Lấy tiếng Anh làm chuẩn, tìm các nghĩa TV tương đương
SELECT *
FROM EnDict
         LEFT JOIN VnDict ON EnDict.Number = VnDict.Number;

SELECT *
FROM EnDict
         LEFT OUTER JOIN VnDict ON EnDict.Number = VnDict.Number;

-- 3. Lấy tiếng Việt làm chuẩn, tìm các nghĩa TV tương đương
SELECT *
FROM VnDict
         LEFT OUTER JOIN EnDict ON VnDict.Number = EnDict.Number;

SELECT *
FROM EnDict
         RIGHT OUTER JOIN VnDict ON VnDict.Number = EnDict.Number;

-- 5. Dù chung và riêng của mỗi bên, lấy tất cả
SELECT *
FROM VnDict
         FULL OUTER JOIN EnDict ON VnDict.Number = EnDict.Number;

SELECT *
FROM EnDict
         FULL OUTER JOIN VnDict ON VnDict.Number = EnDict.Number;

-- 6. In ra bộ từ điển Anh Việt (Anh làm chuẩn) của những con số từ 3 trở lên
SELECT *
FROM EnDict en
         LEFT OUTER JOIN VnDict vi ON vi.Number = en.Number
WHERE en.Number >= 3;

SELECT *
FROM VnDict vi
         RIGHT OUTER JOIN EnDict en ON vi.Number = en.Number
WHERE en.Number >= 3;

-- 7. In ra bộ từ điển Anh Việt Việt Anh của những con số từ 3 trở lên
SELECT *
FROM VnDict vi
         FULL OUTER JOIN EnDict en ON vi.Number = en.Number
WHERE vi.Number >= 3 OR en.Number >= 3;




