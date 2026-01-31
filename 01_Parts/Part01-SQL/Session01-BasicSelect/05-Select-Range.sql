USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Mệnh đề range: BETWEEN, IN
    - Cú pháp mở rộng của Select
    - Lọc dữ liệu trong một đoạn cho trước

    - BETWEEN...AND:
        BETWEEN: <Cột> BETWEEN <Value_1> AND <Value_2>
        - Thay thề cho 2 mệnh đề >= <= AND
    - IN():
        IN: <Cột> IN (<Value_1>, <Value_2>)
        - Thay thề cho nhiều mệnh đề OR
        - Chỉ liệt kê được tập giá trị thì mới dùng được IN
        - Không dùng được với số thực
 ------------------------------------------------------------------------------------------------*/

-- 1. Liệt kê danh sách nhân viên sinh trong năm 1960...1970
SELECT *
FROM Employees
WHERE YEAR(BirthDate) >= 1960
  AND YEAR(BirthDate) <= 1970
ORDER BY BirthDate DESC;

SELECT *
FROM Employees
WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970
ORDER BY BirthDate DESC;

-- 2. Liệt kê các đơn hàng có trọng lượng từ 100..500
SELECT *
FROM Orders
WHERE Freight BETWEEN 100 AND 500;

-- 3. Liệt kê đơn hàng gửi tới Anh, Pháp, Mĩ
SELECT *
FROM Orders
WHERE ShipCountry = 'UK'
   OR ShipCountry = 'France'
   OR ShipCountry = 'USA';

SELECT *
FROM Orders
WHERE ShipCountry IN ('UK', 'France', 'USA');

-- 4. Liệt kê đơn hàng KO gửi tới Anh, Pháp, Mĩ
SELECT *
FROM Orders
WHERE ShipCountry NOT IN ('UK', 'France', 'USA');

-- 5. Liệt kê các đơn hàng trong năm 1996 loại trừ các tháng 6 7 8 9
SELECT *
FROM Orders
WHERE YEAR(ShippedDate) = 1996
  AND MONTH(ShippedDate) IN (6, 7, 8, 9);
