/**------------------------------------------------------------------------------------------------
  SUMMARY

  - CSV file: file text có dấu tab (\t), hàm ý hàng và cột, dễ dàng import nhanh vào SQL, Excel
  - Phụ thuộc hàm (Functional Dependency - FD)
    - Tồn tại 1 ánh xạ/mối quan hệ giữa A và B: Y = F(x)
 ------------------------------------------------------------------------------------------------*/
/**
  Thiết kế csdl lưu đc thông tin phường/xã, quận/huyện, tỉnh/tp
    - Đây là 1 phần của địa chỉ đc tách ra cho nhu cầu thống kê (1 phần của Composite field)
 */

CREATE DATABASE DBDESIGN_VNLOCATIONS;

USE DBDESIGN_VNLOCATIONS;

/**
  Table mẫu:
    - Trùng lặp cụm Info: tỉnh-quận
    - Tồn tại phụ thuộc logic giữa tình và quận/huyện
 */
CREATE TABLE Locations
(
    Province NVARCHAR(50),
    District NVARCHAR(50),
    Ward     NVARCHAR(50)
);

/**
  Version 1: Table ProvincesV1
    - Chỉ lookup cho 63 tỉnh: 10581 row = 10581 xã/phường khác nhau nhưng chỉ có 63 tỉnh thành
 */
CREATE TABLE ProvincesV1
(
    ProvinceName NVARCHAR(50)
);

-- Lấy danh sách 63 tỉnh thành từ table mẫu để insert vào table lookup
SELECT DISTINCT Province
FROM Locations;

-- Cách 1:
-- INSERT INTO Provinces (ProvinceName)
-- VALUES (N'Thành phố Cần Thơ');
-- INSERT INTO Provinces (ProvinceName)
-- VALUES (N'Tỉnh Vĩnh Long');

-- Cách 2:
-- INSERT INTO Provinces (ProvinceName)
-- VALUES (N'Thành phố Cần Thơ'),
--        (N'Tỉnh Vĩnh Long');

-- Cách 3: Copy từ tệp data (CSV)

-- Cách 4: Sub query
INSERT INTO ProvincesV1 SELECT DISTINCT Province FROM Locations;

/**
  Version 1: Table DistrictsV1
    - Tạo table lookup cho quận/huyện
    - Phải dựa vào tỉnh/tp để suy ra quận/huyện (vì một số tỉnh/tp có tên quận/huyện trùng lặp)
    - Province/City có liên mối liên hệ với District. FD: Province/City --> District
    - Table chứa các FD kiểu phụ thuộc ngang giữa các cột: Tách bảng (vế bên trái và vế phải) ra 2 table và thêm FK
 */
CREATE TABLE DistrictsV1
(
    DistrictName NVARCHAR(50)
);

-- Một số tỉnh có tên quận/huyện trùng lặp
SELECT DISTINCT District
FROM Locations;

--------------------------------------------------------------------------------
/**
  Version 2
 */
CREATE TABLE ProvincesV2
(
    ProvinceName NVARCHAR(50) PRIMARY KEY
);

CREATE TABLE DistrictsV2
(
--     DistrictName NVARCHAR(50) PRIMARY KEY,                                    -- Hiện tại không có tên quận trùng nhau
    DistrictName NVARCHAR(50) NOT NULL,

    ProvinceName NVARCHAR(50) NOT NULL REFERENCES ProvincesV2 (ProvinceName), -- Tham chiếu đảm bảo không nhập tên tỉnh không tồn tại
    PRIMARY KEY (DistrictName, ProvinceName)                                  -- Constraint: Composite Key - Dùng Natural Key (key tự nhiên)
);

CREATE TABLE WardsV2
(
    WardName     NVARCHAR(50) NOT NULL,
    DistrictName NVARCHAR(50) NOT NULL -- REFERENCES DistrictsV2 (DistrictName)
--     PRIMARY KEY (WardName, DistrictName)
);

INSERT INTO ProvincesV2 (ProvinceName) (SELECT DISTINCT Province FROM Locations);

SELECT *
FROM ProvincesV2;

INSERT INTO DistrictsV2
SELECT DISTINCT District, Province
FROM Locations
ORDER BY District;

SELECT *
FROM DistrictsV2;

INSERT INTO WardsV2
SELECT DISTINCT Ward, District
FROM Locations;

SELECT *
FROM WardsV2;

-- TPHCM có những Quận nào?
SELECT DistrictName
FROM DistrictsV2
WHERE ProvinceName = N'Thành phố Hồ Chí Minh';

-- Danh phường của quận 1, TP HCM
SELECT WardName
FROM WardsV2
WHERE DistrictName = N'Quận 1';

-- Huyện Châu Thành của Tiền Giang có những xã nào
-- TODO: Huyện Châu Thành trùng lặp
SELECT w.WardName
FROM WardsV2 w
         LEFT JOIN DistrictsV2 d ON w.DistrictName = d.DistrictName
WHERE d.DistrictName = N'Huyện Châu Thành'
  AND d.ProvinceName = N'Tỉnh Tiền Giang';

-- Huyện Ba Tri của Bến Tre có những xã nào
SELECT w.WardName
FROM WardsV2 w
         LEFT JOIN DistrictsV2 d ON w.DistrictName = d.DistrictName
WHERE d.DistrictName = N'Huyện Ba Tri'
  AND d.ProvinceName = N'Tỉnh Bến Tre';

SELECT *
FROM WardsV2
ORDER BY DistrictName;

SELECT *
FROM WardsV2
WHERE DistrictName = N'Huyện Châu Thành';