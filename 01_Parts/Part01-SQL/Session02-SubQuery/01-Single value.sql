USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Cú pháp chuẩn của lệnh SELECT: SELECT ... FROM <Table> WHERE <Cột> = <Value>
    - Một câu SELECT có thể trả về một value/cell/tập giá trị
    - <Value>: có thể là một giá trị cụ thể; hoặc một câu SQL khác, trả về 1 Cell
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách nhân viên
SELECT *
FROM Employees;

-- 2. Liệt kê các nhân viên ở London
SELECT *
FROM Employees
WHERE City = 'London';

--3. Liệt kê các nhân viên cùng quê với King Robert
SELECT *
FROM Employees
WHERE City = (SELECT City
              FROM Employees
              WHERE CONCAT(LastName, ' ', FirstName) = 'King Robert')
  AND FirstName <> 'Robert';

--4. Liệt kê tất cả các đơn hàng
SELECT *
FROM Orders;

-- 4.1. Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn 252kg
SELECT *
FROM Orders
WHERE Freight >= 252;

-- 4.2. Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn = trọng lượng đơn hàng 10555
Select *
FROM Orders
WHERE Freight >= (SELECT Freight FROM Orders WHERE OrderID = 10555)
  AND OrderID != 10555;
