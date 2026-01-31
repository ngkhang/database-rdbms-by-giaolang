USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Mệnh đề WHERE: Cú pháp mở rộng của Select: Dùng làm bộ lọc/filter để lấy ra data cần thiết theo 1 tiêu chí nào đó
    SELECT <Các_Cột> FROM <Tên_Table> WHERE <Điều_kiện_lọc>
    - <Điều_kiện_lọc>: Tìm từng dòng với cột có value cần lọc (lấy tên cột, xem value trong cell có thỏa điều kiện
  không)
    - Sử dụng các toán tử (operators), chú ý data types
    - Khi WHERE với key, chỉ trả về 1 giá trị, nếu thỏa điều kiện, DISTINCT vô nghĩa
    - Dùng () để gom nhóm, phân tách thứ tự filter

  - Công thức đầy đủ SELECT:
    SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ..
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách nhân viên
SELECT *
FROM Customers;

-- 2. In ra ds kh đến từ Ý
SELECT *
FROM Customers
WHERE Country = 'Italy';

-- 3. In ra ds kh đến từ Mĩ
SELECT *
FROM Customers
WHERE Country = 'USA';

-- 4. In ra những k/h đến từ Mĩ, Ý
SELECT *
FROM Customers
WHERE Country = 'USA'
   OR Country = 'Italy';

SELECT *
FROM Customers
WHERE Country = 'USA'
   OR Country = 'Italy'
ORDER BY Country;

-- 5. In ra k/h đến từ thủ đô nước Đức
SELECT *
FROM Customers
WHERE Country = 'Germany'
  AND City = 'Berlin';

-- 6. In ra thông tin của nhân viên
SELECT *
FROM Employees;

-- 7. In ra thông tin nhân viên có năm sinh từ 1960 trở lại gần đây/đổ lại
SELECT *
FROM Employees
WHERE YEAR(BirthDate) > YEAR(1960);

-- 8. In ra thông tin nhân viên có tuổi từ 60 trở lên
SELECT *
FROM Employees
WHERE YEAR(GETDATE()) - YEAR(BirthDate) > 60;

-- 9. Những NV nào ở Luân Đôn
SELECT *
FROM Employees
WHERE City = 'London';

-- 10. Những NV nào ko ở London
SELECT *
FROM Employees
WHERE City != 'London';

SELECT *
FROM Employees
WHERE City <> 'London';

SELECT *
FROM Employees
WHERE NOT (City = 'London');

-- 11. In ra hồ sơ nhân viên có mã số là 1
SELECT *
FROM Employees
WHERE EmployeeID = 1;

-- 12. Xem thông tin bên Đơn hàng
SELECT *
FROM Orders;

-- 13. Xem thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng
SELECT *
FROM Orders
ORDER BY Freight DESC;

-- 14. In thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng >= 500kg
SELECT *
FROM Orders
WHERE Freight >= 500
ORDER BY Freight DESC;

-- 15. In thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng từ 100 đến 500
SELECT *
FROM Orders
WHERE Freight >= 100
  AND Freight <= 500
ORDER BY Freight DESC;

-- 16. In thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng từ [100,500] và ship
-- bởi cty giao vận số 1, và ko ship tới London
SELECT *
FROM Orders
WHERE Freight >= 100
  AND Freight <= 500
  AND ShipVia = 1
  AND ShipCity <> 'London'
ORDER BY Freight DESC;

-- 17. Liệt kê k/h đến từ Mĩ hoặc Mexico
SELECT *
FROM Customers
WHERE Country = 'USA'
   OR Country = 'Mexico';

-- 18. Liệt kê k/h KO đến từ Mĩ hoặc Mexico
SELECT *
FROM Customers
WHERE NOT (Country = 'USA'
    OR Country = 'Mexico');

-- 19. Liệt kê các nhân viên sinh ra trong đoạn [1960, 1970]
SELECT *
FROM Employees
WHERE YEAR(BirthDate) >= 1960
  AND YEAR(BirthDate) <= 1970
ORDER BY BirthDate DESC;
