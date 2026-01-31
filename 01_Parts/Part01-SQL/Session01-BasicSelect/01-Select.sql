USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Một DB là nơi chứa data
  - Data lưu dưới dạng Table hoặc tách ra nhiều table
  - Syntax: SELECT chuẩn: SELECT * FROM <Tên_Table>
                 mở rộng: SELECT <Cột_muốn_lấy_1>, <Cột_muốn_lấy_2> FROM <Tên_Table>
                        : SELECT <Hàm_xử_lý> FROM <Tên_Table>
 ------------------------------------------------------------------------------------------------*/

-- 1. Xem thông tin của tất cả các khách hàng đang giao dịch với mình
SELECT *
FROM Customers;

-- 2. Xem thông tin nhân viên, xem hết các cột luôn
SELECT *
FROM Employees;

-- 3. Xem các sản phẩm có trong kho
SELECT *
FROM Products;

-- 4. Mua hàng, thì thông tin sẽ nằm ở table Orders và OrderDetails
SELECT *
FROM Orders;

-- 5. Xem thông tin công ty giao hàng
SELECT *
FROM Shippers;

-- 6. Xem chi tiết mua hàng
SELECT *
FROM Orders;
SELECT *
FROM [Order Details];

-- 7. In ra thông tin khách hàng, chỉ gồm cột Id, ComName, ContactName, Country
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers;

-- 8. In ra thông tin nhân viên, chỉ cần Id, Last, First, Title, DOB
SELECT EmployeeID, LastName, FirstName, Title, BirthDate
FROM Employees;

-- 9. In ra thông tin nhân viên, ghép tên cho đẹp/gộp cột, tính luôn tuổi giùm tui
SELECT CONCAT(LastName, FirstName) AS FullName, YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees;

SELECT CONCAT(LastName, FirstName) AS FullName, DATEDIFF(year, BirthDate, CURRENT_TIMESTAMP) AS Age
FROM Employees;

-- 10. In ra thông tin chi tiết mua hàng
SELECT *
FROM [Order Details];

SELECT *, (Quantity * UnitPrice * (1 - Discount)) AS SubTotal
FROM [Order Details];