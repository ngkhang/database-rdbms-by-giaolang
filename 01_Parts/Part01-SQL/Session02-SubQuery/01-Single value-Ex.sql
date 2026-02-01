USE Northwind;

/**------------------------------------------------------------------------------------------------
  Exercise
    1. Liệt kê danh sách các công ty vận chuyển hàng
    2. Liệt kdanh sách các đơn hàng đc vận chuyển bởi công ty giao vận có mã số 1
    3. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận có tên Speedy Express
    4. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận có tên Speedy Express và trọng lượng từ 50-100
    5. Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix
    6. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet
 ------------------------------------------------------------------------------------------------*/

-- 1. Liệt kê danh sách các công ty vận chuyển hàng
SELECT *
FROM Shippers;

-- 2. Liệt kdanh sách các đơn hàng đc vận chuyển bởi công ty giao vận có mã số 1
SELECT *
FROM Orders
WHERE ShipVia = 1;

-- 3. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận có tên Speedy Express
SELECT *
FROM Orders
WHERE ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express');

-- 4. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận có tên Speedy Express và trọng lượng từ 50-100
SELECT *
FROM Orders
WHERE Freight BETWEEN 50 AND 100
  AND ShipVia = (SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express');

-- 5. Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix
SELECT *
FROM Products
WHERE CategoryID = (SELECT CategoryID FROM Products WHERE ProductName = 'Filo Mix')
  AND ProductName <> 'Filo Mix';

-- 6. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet
SELECT *
FROM Employees
WHERE BirthDate > (SELECT BirthDate FROM Employees WHERE FirstName = 'Janet');
