USE Northwind;

-- 1. In danh sách nhân viên
SELECT *
FROM Employees;

-- 2. Đếm xem mỗi khu vực có bao nhiêu nv
SELECT Region, COUNT(EmployeeID)
FROM Employees
GROUP BY Region;

SELECT Region, COUNT(*)
FROM Employees
GROUP BY Region;

-- 3. Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(OrderID)
FROM Orders
GROUP BY ShipCountry;

-- 4. Quốc gia nào có từ 50 đơn hàng trở lên
SELECT ShipCountry, COUNT(OrderID) AS [No. Orders]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrderID) >= 50

-- 5. Quốc gia nào có NHIỀU ĐƠN HÀNG NHẤT
SELECT ShipCountry, COUNT(OrderID)
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM Orders GROUP BY ShipCountry);

-- 6. LIỆT KÊ CÁC ĐƠN HÀNG CỦA K/H MÃ SỐ VINET
SELECT *
FROM Orders
WHERE CustomerID = 'VINET'

-- 7. K/H VINET đã mua bao nhiêu lần???
SELECT CustomerID, COUNT(*) AS [No. Bought]
FROM Orders
WHERE CustomerID = 'VINET'
GROUP BY CustomerID;            -- Kiểm tra CustomerID trước, rồi mới đếm

SELECT CustomerID, COUNT(*) AS [No. Bought]
FROM Orders
GROUP BY CustomerID
HAVING CustomerID = 'VINET';    -- Đếm hết tất cả, rồi mới lọc CustomerID
