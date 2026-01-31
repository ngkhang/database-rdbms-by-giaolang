USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Order By: Cú pháp mở rộng của Select:
    SELECT <Các_Cột> FROM <Tên_Table> ORDER BY <Tên_Colum(s)_Sort> <Kiểu_Sort>
    - <Kiểu_Sort>: tăng dần (ASCENDING - ASC) - default; Giảm dần (DESCENDING - DESC)
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách nhân viên
SELECT *
FROM Customers;

-- 2. In ra ds nv tăng dần theo năm sinh
SELECT *
FROM Employees
ORDER BY YEAR(BirthDate);
SELECT *
FROM Employees
ORDER BY BirthDate;

-- 3. In ra ds nv GIẢM dần theo năm sinh
SELECT *
FROM Employees
ORDER BY BirthDate DESC;

-- 4. Tính tiền chi tiết mua hàng
SELECT *
FROM [Order Details]

SELECT *, UnitPrice * Quantity * (1 - Discount) AS SubTotal
FROM [Order Details]

-- 5. Tính tiền chi tiết mua hàng, sắp xếp giảm dần theo số tiền
SELECT *, UnitPrice * Quantity * (1 - Discount) AS SubTotal
FROM [Order Details]
ORDER BY SubTotal DESC

-- 6. In ra danh sách nhân viên giảm dần theo tuổi
SELECT EmployeeID, LastName, FirstName, BirthDate, YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees
ORDER BY Age DESC;
