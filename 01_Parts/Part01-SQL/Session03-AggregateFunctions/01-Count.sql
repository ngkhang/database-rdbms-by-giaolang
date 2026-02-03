USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Aggregate Functions/Aggregation:
    - DB Engine hỗ trợ các hàm để thao tác trên nhóm dòng/cột, tính toán xử lý dựa trên nhóm data được gom này.
    - Cú pháp chuẩn:    SELECT ..., <Aggregate_Fun> FROM <Table>
              mở rộng:  SELECT ..., <Aggregate_Fun> FROM <Table> GROUP BY <Cụm_Cột_Để_Gom>
              mở rộng:  SELECT ..., <Aggregate_Fun> FROM <Table> GROUP BY <Cụm_Cột_Để_Gom> HAVING ...
    - Hàm COUNT(): đếm số lần xuất hiện của 1 thứ gì đó:
        - COUNT(*) FROM ...: Đếm số dòng/record trong table (không quan tâm tiêu chuẩn khác)
        - COUNT(*) FROM ... WHERE ...: Chọn/Filter ra các data thỏa điều kiện -> Đếm số dòng/record trong table
        - COUNT(<Cột>) FROM ...: Đếm số dòng/record trong table dựa trên 1 cột. Nếu cell chứa NULL thì không đếm
    - HAVING: filter sau đếm, where sau khi gom nhóm

    - Chú ý:
        - Khi xài gom nhóm, có thể liệt kê tên cột lẻ nhưng cột lẻ đó phải xuất hiện trong mệnh đề GROUP BY
        - Khi gom theo Key, vô nghĩa vì Key không trùng
 ------------------------------------------------------------------------------------------------*/

-- 1. In ra danh sách các nhân viên
SELECT *
FROM Employees;

-- 2. Đếm xem có bao nhiêu nhân viên
SELECT COUNT(*) AS [Number of Employees]
FROM Employees;

-- 3. Có bao nhiêu NV ở London
SELECT COUNT(*) AS [No. Employees In London]
FROM Employees
WHERE City = 'London';

-- 4. Có bao nhiêu lượt thành phố xuất hiện - cứ xh tên tp là đếm, ko care lặp lại hay ko
SELECT COUNT(City)
FROM Employees;

-- 5. Đếm xem có bao nhiêu Region
SELECT COUNT(Region)
FROM Employees;

-- 6. Đếm xem có bao nhiêu khu vực null, có bao nhiêu dòng region null
SELECT COUNT(*)
FROM Employees
WHERE Region IS NULL;

-- 7. Có bao nhiêu thành phố trong table NV
SELECT COUNT(*)
FROM (SELECT DISTINCT City FROM Employees) AS Cities;

SELECT COUNT(DISTINCT City)
FROM Employees;

-- 8. Đếm xem MỖI thành phố có bao nhiêu nhân viên
SELECT City, COUNT(EmployeeID) AS [No. Employees]
FROM Employees
GROUP BY City;

-- 9. HÃY CHO TUI BIẾT TP NÀO CÓ TỪ 2 NV TRỞ LÊN
SELECT City, COUNT(City) AS [No. Employees]
FROM Employees
GROUP BY City
HAVING COUNT(*) >= 2;

-- 10. Đếm số nhân viên của 2 thành phố Seattle và London
SELECT City, COUNT(EmployeeID) AS [No. Employees]
FROM Employees
WHERE City IN ('London', 'Seattle')
GROUP BY City;

-- 11. Trong 2 tp, London và Seattle, tp nào có nhiều hơn 3 nv
SELECT City, COUNT(EmployeeID)
FROM Employees
WHERE City IN ('London', 'Seattle')
GROUP BY City
HAVING COUNT(EmployeeID) >= 3;

-- 12. Đếm xem có bao nhiêu đơn hàng đã bán ra
SELECT COUNT(*) AS [No. Orders]
FROM Orders;

-- 12.1. Nước Mĩ có bao nhiêu đơn hàng
SELECT COUNT(*) AS [No. USA Orders]
FROM Orders
WHERE ShipCountry = 'USA';

-- 12.2. Mĩ Anh Pháp chiếm tổng cộng bao nhiêu đơn hàng
SELECT COUNT(*) AS [No. Orders]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France');

-- 12.3. Mĩ Anh Pháp, mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(OrderID) AS [No. Orders]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')
GROUP BY ShipCountry;

-- 12.4. Trong 3 quốc gia A P M, quốc gia nào có từ 100 đơn hàng trở lên
SELECT ShipCountry, COUNT(OrderID)
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')
GROUP BY ShipCountry
HAVING COUNT(OrderID) >= 100;
