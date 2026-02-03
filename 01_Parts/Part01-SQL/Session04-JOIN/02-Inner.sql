/**------------------------------------------------------------------------------------------------
  SUMMARY

  - JOIN
    - CROSS JOIN:
            SELECT ... FROM       T1, T2       WHERE ...
                            T1 CROSS JOIN T2
        - Với cách viết rút gọn, có thể dùng WHERE; Còn với keyword: CROSS JOIN thì không

    - INNER JOIN:
            SELECT ... FROM T1     JOIN     T2 ON <Join_Condition>
                                INNER JOIN
        - Ghép các table có điểm tương quan/điểm chung/ Common Column
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

-- Tích Đề-Các - CROSS JOIN
-- Form 1:
SELECT *
FROM VnDict,
     EnDict;

-- Form 2:
SELECT *
FROM VnDict
         CROSS JOIN EnDict;

-- Để lấy ra các cột chung/tương quan (Common Column), dùng WHERE
SELECT *
FROM VnDict
         CROSS JOIN EnDict
WHERE VnDict.Number = EnDict.Number;

-- Ghép có chọn lọc (Non-Equi JOIN): không dùng dấu =
SELECT *
FROM VnDict,
     EnDict
WHERE VnDict.Number > EnDict.Number;
