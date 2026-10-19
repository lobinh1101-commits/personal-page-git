-- =========================================================
-- AUTORIDE DATABASE - SCHEMA DESIGN & MIGRATION SCRIPT
-- File: autoride_db.sql
-- =========================================================

CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- ---------------------------------------------------------
-- 1. LEGACY SCHEMA & MIGRATION (FOR DEMONSTRATION)
-- ---------------------------------------------------------

-- Drop existing tables if re-running
DROP TABLE IF EXISTS Inspections;
DROP TABLE IF EXISTS Rentals;
DROP TABLE IF EXISTS Cars;

-- Create base Cars table
CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- Create initial legacy Rentals table
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status VARCHAR(50) DEFAULT 'BOOKED',
    FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- ---------------------------------------------------------
-- 2. DDL: UPGRADE DATABASE SCHEMA TO FIX DATA GAPS
-- ---------------------------------------------------------

-- Upgrade Rentals table with ENUM status and financial columns (DECIMAL type to prevent rounding errors)
ALTER TABLE Rentals 
    MODIFY COLUMN status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'BOOKED',
    ADD COLUMN security_deposit DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (security_deposit >= 0),
    ADD COLUMN late_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (late_fee >= 0),
    ADD COLUMN damage_fee DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (damage_fee >= 0);

-- Create Inspections table to handle vehicle return inspection reports
CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    CONSTRAINT fk_inspections_rentals 
        FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- ---------------------------------------------------------
-- 3. DML: REAL-WORLD SCENARIO SIMULATION
-- ---------------------------------------------------------

-- Step A: Insert a sample car
INSERT INTO Cars (model_name, license_plate) 
VALUES ('Toyota Camry 2023', '30H-123.45');

-- Step B: Customer "Nguyen Van A" books & receives car with 10,000,000 VND security deposit
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit)
VALUES (1, 'Nguyen Van A', '2026-10-15 08:00:00', 'ACTIVE', 10000000.00);

-- Step C: Customer returns car with damaged left headlight. Staff creates an Inspection record
INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (1, '2026-10-19 10:30:00', 'Vỡ đèn pha bên trái do va quệt', 'Tran Van B');

-- Step D: Update Rental status to COMPLETED, record fees (late_fee = 0, damage_fee = 2,000,000 VND)
UPDATE Rentals 
SET 
    return_date = '2026-10-19 10:30:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- ---------------------------------------------------------
-- 4. QUERY: CALCULATE ACTUAL REFUND TO CUSTOMER
-- ---------------------------------------------------------

SELECT 
    r.rental_id AS 'Mã Hợp Đồng',
    r.customer_name AS 'Tên Khách Hàng',
    c.model_name AS 'Tên Xe',
    c.license_plate AS 'Biển Số',
    r.security_deposit AS 'Tiền Cọc (VND)',
    r.late_fee AS 'Phí Trễ (VND)',
    r.damage_fee AS 'Phí Hư Hỏng (VND)',
    i.damage_description AS 'Chi Tiết Hư Hỏng',
    (r.security_deposit - r.late_fee - r.damage_fee) AS 'Số Tiền Hoàn Trả Khách (VND)',
    r.status AS 'Trạng Thái Hợp Đồng'
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = 1;
