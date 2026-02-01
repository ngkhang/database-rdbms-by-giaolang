USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Cú pháp chuẩn của lệnh SELECT: SELECT ... FROM <Table> WHERE <Cột> <Toán_Tử_So_Sánh> <Value>
    - <Cột>   <Toán_Tử_So_Sánh>           <Value>
                > >= < <= = !=        1 giá trị
                                 =   (Sub query chỉ có 1 value)
                                 IN  (Sub query có 1 cột nhưng nhiều value)
                > >= < <= =      ALL (Sub query 1 cột nhiều value)
                > >= < <= =      ANY (Sub query 1 cột nhiều value)
 ------------------------------------------------------------------------------------------------*/

CREATE TABLE Num
(
    Numbr int
)

SELECT *
FROM Num;
INSERT INTO Num
values (1);
INSERT INTO Num
values (1);
INSERT INTO Num
values (2);
INSERT INTO Num
values (9);
INSERT INTO Num
values (5);
INSERT INTO Num
values (100);
INSERT INTO Num
values (101);

-- 1. In ra những số > 5
SELECT *
FROM Num
WHERE Numbr > 5;

-- 2. In ra số lớn nhất trong các số đã nhập
SELECT *
FROM Num
WHERE Numbr >= ALL (SELECT * FROM Num);

-- 3. Số nhỏ nhất là số nào?
SELECT *
FROM Num
WHERE Numbr <= ALL (SELECT * FROM Num);

-- 4. Nhân viên nào lớn tuổi nhất
SELECT *
FROM Employees
WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees);

-- 5. Đơn hàng nào có trọng lượng nặng nhất
SELECT *
FROM Orders
WHERE Freight >= ALL (SELECT Freight FROM Orders);
