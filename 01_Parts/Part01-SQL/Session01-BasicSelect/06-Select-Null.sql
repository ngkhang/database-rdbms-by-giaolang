USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Giá trị NULL
      - Khi tạo dữ liệu, có các field chưa xác định giá trị, bổ sung sau -> Giá trị này gọi là: NULL
      - Giá trị NULL không thể so sánh bằng toán tử so sánh. Phải dùng IS NULL, IS NOT NULL
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách nhân viên
SELECT *
FROM Employees;

-- 2. Ai chưa xác định khu vực ở, region null
SELECT *
FROM Employees
WHERE Region IS NULL;

-- 3. Những ai đã xác định đc khu vực cư trú?
SELECT *
FROM Employees
WHERE Region IS NOT NULL;

-- 4. Những nhân viên đại diện kinh doanh và xác định đc nơi cư trú
SELECT *
FROM Employees
WHERE Region IS NOT NULL
  AND Title = 'Sales Representative';

-- 5. Liệt kê danh sách khách hàng đến từ Anh Pháp Mĩ, có cả thông tin số region
SELECT *
FROM Employees
WHERE Country IN ('UK', 'France', 'USA')
  AND Region IS NOT NULL;
