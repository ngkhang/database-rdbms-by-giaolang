USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Cú pháp chuẩn của lệnh SELECT: SELECT ... FROM <Table> WHERE <Cột> = <Value>
    - Một câu SELECT có thể trả về một value/cell/tập giá trị
    - <Value>: có thể là một giá trị cụ thể; hoặc một câu SQL khác, trả về 1 Cell
 ------------------------------------------------------------------------------------------------*/

-- 1. Liệt kê các nhóm hàng
SELECT *
FROM Categories;

-- 2. In ra các món hàng/mặt hàng thuộc nhóm 1, 6, 8
SELECT *
FROM Products
WHERE CategoryID IN (1, 6, 8);

-- 3. In ra các món hàng thuộc nhóm bia/rượu, thịt, và hải sản
SELECT *
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName IN ('Seafood', 'Meat/Poultry', 'Beverages'))

-- 4. Nhân viên quê London phụ trách những đơn hàng nào
SELECT *
FROM Orders
WHERE EmployeeID IN (SELECT EmployeeID
                     FROM Employees
                     WHERE City = 'London')
