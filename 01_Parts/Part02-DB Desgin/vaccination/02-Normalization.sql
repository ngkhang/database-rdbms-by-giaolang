/**------------------------------------------------------------------------------------------------
  SUMMARY

  - Tách đa trị (Multi-Valued) hay Composite (Multi-Column) dựa trên nhu cầu thống kê
  - Gom table -> Tìm đa trị/composite/ lookup table nếu cần
 ------------------------------------------------------------------------------------------------*/

CREATE DATABASE DBDESIGN_VACCINATION;

USE DBDESIGN_VACCINATION;

CREATE TABLE PersonV5
(
    ID        CHAR(11) PRIMARY KEY,
    LastName  NVARCHAR(30),
    FirstName NVARCHAR(10),
    Phone     VARCHAR(11) NOT NULL UNIQUE
);

INSERT INTO PersonV5
VALUES ('00000000001', N'NGUYỄN', N'AN', '09011234567');
INSERT INTO PersonV5
VALUES ('00000000002', N'LÊ', N'BÌNH', '09029876543');

CREATE TABLE VaccineV5
(
    VaccineName   VARCHAR(30) PRIMARY KEY, -- Hiện tại chưa quan tâm đến hiệu suất PK
    [Description] NVARCHAR(100)
);

INSERT INTO VaccineV5
VALUES ('AstraZeneca', '...');
INSERT INTO VaccineV5
VALUES ('Pfizer', '...');
INSERT INTO VaccineV5
VALUES ('Verocell', '...');
INSERT INTO VaccineV5
VALUES ('Moderna', '...');

CREATE TABLE VaccinationV5
(
    SEQ        INT IDENTITY PRIMARY KEY,
    NoVaccine  INT,
    InjectDate DATETIME,
    Lot        NVARCHAR(20),
    [Location] NVARCHAR(50), -- Đây là Composite, tách riêng thành cột city/quận... Và Lookup nếu muốn

    PersonID   CHAR(11) NOT NULL,
    FOREIGN KEY (PersonID) REFERENCES PersonV5 (ID),

    Vaccine    VARCHAR(30) REFERENCES VaccineV5 (VaccineName)
--     Cách 2:
--     Vaccine    VARCHAR(30),
--     FOREIGN KEY (Vaccine) REFERENCES VaccineV5 (VaccineName)

--     Cách 3:
--     Vaccine    VARCHAR(30),
--     CONSTRAINT FK_VCN_VC FOREIGN KEY (Vaccine) REFERENCES VaccineV5 (VaccineName)
);

INSERT INTO VaccinationV5 (NoVaccine, InjectDate, Lot, [Location], PersonID, Vaccine)
VALUES (1, GETDATE(), NULL, NULL, '00000000001', 'AstraZeneca');

INSERT INTO VaccinationV5 (NoVaccine, InjectDate, Lot, [Location], PersonID, Vaccine)
VALUES (2, '2021-12-20', NULL, NULL, '00000000001', 'AstraZeneca');

-- Error vì Vaccine: 'AZ' không tồn tại trong table VaccineV5 nhưng SEQ vẫn tăng
INSERT INTO VaccinationV5 (NoVaccine, InjectDate, Lot, [Location], PersonID, Vaccine)
VALUES (3, '2021-12-20', NULL, NULL, '00000000001', 'AZ');

INSERT INTO VaccinationV5 (NoVaccine, InjectDate, Lot, [Location], PersonID, Vaccine)
VALUES (1, '2021-12-20', NULL, NULL, '00000000002', 'Verocell');

SELECT *
FROM VaccineV5;
SELECT *
FROM PersonV5;
SELECT *
FROM VaccinationV5;

-- 1. Có bao nhiêu mũi vaccine 'AstraZeneca' đã được chích
--  Output: loại vaccine, tổng số mũi đã chích
SELECT vcn.Vaccine, COUNT(*) AS [Total Vaccine]
FROM VaccinationV5 vcn
WHERE vcn.Vaccine = 'AstraZeneca'
GROUP BY vcn.Vaccine;

-- 2. Ngày x có bao nhiêu mũi đã được chích
-- Output: ngày, tổng số mũi đã chích
SELECT vcn.InjectDate, COUNT(*) as [Total Injected Vaccine]
FROM VaccinationV5 vcn
WHERE vcn.InjectDate = '2021-12-20'
GROUP BY vcn.InjectDate;

-- 3. Thống kê số mũi chích của mỗi cá nhân
-- Output: Tên (full), di động, số mũi đã chích (0, 1, 2, 3)
SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name],
       p.Phone,
       COUNT(vcn.NoVaccine)                 AS [Total Injected Vaccine]
FROM PersonV5 p
         LEFT JOIN VaccinationV5 vcn ON p.ID = vcn.PersonID
GROUP BY p.FirstName, p.LastName, p.Phone;

-- 4. In ra thông tin chích của mỗi cá nhân
-- Output: Tên (full), di động, số mũi đã chích (0, 1, 2, 3), MÀU SẮC
SELECT CONCAT(p.FirstName, ' ', p.LastName)                                                   AS [Full Name],
       p.Phone,
       COUNT(vcn.NoVaccine)                                                                   AS [Total Injected Vaccine],
       IIF(COUNT(vcn.NoVaccine) = 0, 'RED', IIF(COUNT(vcn.NoVaccine) = 1, 'YELLOW', 'GREEN')) AS [Color Code]
FROM PersonV5 p
         LEFT JOIN VaccinationV5 vcn ON p.ID = vcn.PersonID
GROUP BY p.FirstName, p.LastName, p.Phone;

-- 5. Có bao nhiêu công dân đã chích ít nhất 1 mũi vaccine
SELECT COUNT(PersonID) AS [Number of Citizens Vaccinated]
FROM (SELECT PersonID FROM VaccinationV5 GROUP BY PersonID HAVING COUNT(*) >= 1) AS vaccinated_citizens;

-- 6. Những công dân nào chưa chích mũi nào?
-- Output: Tên (full), Phone
SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name], p.Phone
FROM PersonV5 p
WHERE p.ID NOT IN (SELECT DISTINCT PersonID FROM VaccinationV5);

-- 7. Công dân có phone 'X' đã chích những mũi nào
-- Output: Tên, thông tin chích (in gộp + chuỗi, tái nhập composite)
SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name],
       p.Phone,
       vcn.InjectDate,
       vcn.Vaccine,
       vcn.Lot,
       vcn.[Location]
FROM PersonV5 p
         LEFT JOIN VaccinationV5 vcn
                   ON p.ID = vcn.PersonID
WHERE p.Phone = '09011234567';

-- 8. Thống kê số mũi vaccine đã chích của mỗi loại vaccine
SELECT vc.VaccineName, COUNT(vcn.SEQ) AS [Total Injected Vaccine]
FROM VaccineV5 vc
         LEFT JOIN VaccinationV5 vcn ON vc.VaccineName = vcn.Vaccine
GROUP BY vc.VaccineName;
