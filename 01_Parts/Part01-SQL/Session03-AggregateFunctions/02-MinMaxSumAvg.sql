USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Aggregate Functions/Aggregation (cnt)
    - SUM(), MIN(), MAX(), AVG()

  - Chú ý:
    - Cột xuất hiện trong SELECT hảm ý đếm theo cột này - cột này phải xuất hiện trong GROUP BY
 ------------------------------------------------------------------------------------------------*/

-- 1. Liệt kê danh sách nhân viên
SELECT *
FROM Employees;

-- 2. Năm sinh nào là bé nhất (tuổi max)
SELECT MIN(BirthDate)
FROM Employees;

-- 3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
SELECT *
FROM Employees
WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees);

SELECT *
FROM Employees
WHERE BirthDate >= ALL (SELECT BirthDate FROM Employees);

-- 4.1. Trọng lượng nào là lớn nhất trong các đơn hàng đã bán
SELECT MAX(Freight)
FROM Orders;

--4.2. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
SELECT *
FROM Orders
WHERE Freight >= ALL (SELECT MAX(Freight) FROM Orders);

SELECT *
FROM Orders
WHERE Freight <= ALL (SELECT MIN(Freight) FROM Orders);

-- 5. Tính tổng khối lượng của các đơn hàng đã vận chuyển
SELECT SUM(Freight) AS [Total Freight]
FROM Orders;

-- 6. Trung bình các đơn hàng nặng bao nhiêu?
SELECT AVG(Freight) AS [Avg of Order]
FROM Orders;

-- 7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT *
FROM Orders
WHERE Freight >= (SELECT AVG(Freight) FROM Orders);

-- 8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT COUNT(OrderID) AS [No. Orders]
FROM Orders
WHERE Freight >= (SELECT AVG(Freight) FROM Orders);








