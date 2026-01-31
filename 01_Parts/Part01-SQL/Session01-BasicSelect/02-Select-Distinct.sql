USE Northwind;

/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Distinct: Select hỗ trợ loại trừ dòng trùng nhau: SELECT DISTINCT <Các_Cột> FROM <Tên_Table>
    - Khi đi kèm với ID/Key, Distinct vô hiệu - vì Id/Key không thể trùng nhau
 ------------------------------------------------------------------------------------------------*/

-- 1. Liệt kê danh sách nhân viên
SELECT DISTINCT Title
FROM Employees;

SELECT DISTINCT TitleOfCourtesy
FROM Employees;

-- 2. In ra thông tin khách hàng
SELECT *
FROM Customers;

-- 3. Có bao nhiêu quốc gia xuất hiện trong thông tin k/h, in ra
SELECT DISTINCT Country
FROM Customers;