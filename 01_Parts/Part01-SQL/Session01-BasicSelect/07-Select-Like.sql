USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Toán tử LIKE
    - Cú pháp mở rộng của SELECT
    - Dùng để tìm dữ liệu theo kiểu gần đúng trên kiểu chuỗi
    - Sử dụng kèm với: % (đại diện cho 1 chuỗi bất kỳ) và _ (đại diện cho 1 ký tự bất kỳ)
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách nhân viên
SELECT *
FROM Employees;

-- 2. Nhân viên nào có tên bắt đầu chữ A
SELECT *
FROM Employees
WHERE FirstName LIKE 'A%';

-- 2.1 Nhân viên nào có tên bắt đầu chữ A, in ra cả fullname đc ghép đầy đủ
SELECT EmployeeID, (LastName + ' ' + FirstName) AS FullName, Title
FROM Employees
WHERE FirstName LIKE 'A%';

-- 3. Nhân viên nào tên có chữ A cuối cùng
SELECT EmployeeID, CONCAT(LastName, ' ', FirstName) AS FullName, Title
FROM Employees
WHERE LastName LIKE '%A';

-- 4. Nhân viên nào tên có 4 kí tự
SELECT *
FROM Employees
WHERE FirstName LIKE '____';

SELECT *
FROM Employees
WHERE LEN(FirstName) = 4;

-- 5. Xem danh sách các sản phẩm/món đồ đang có - Product
SELECT *
FROM Products;

-- 6. Những sản phẩm tên bắt đầu bằng Ch
SELECT *
FROM Products
WHERE ProductName LIKE 'Ch%';

--7. Những sản phẩm tên có 5 kí tự
SELECT *
FROM Products
WHERE ProductName LIKE '_____';

--8. Những sản phẩm trong tên sp mà từ cuối cùng là 5 kí tự
SELECT *
FROM Products
WHERE ProductName LIKE '_____'
   OR ProductName LIKE '% ______';
