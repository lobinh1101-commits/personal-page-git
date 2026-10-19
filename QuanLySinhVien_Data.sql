-- =========================================================
-- CƠ SỞ DỮ LIỆU QUẢN LÝ SINH VIÊN - THÊM DỮ LIỆU (INSERT INTO)
-- File: QuanLySinhVien_Data.sql
-- =========================================================

-- Bước 1: Tạo và sử dụng Cơ sở dữ liệu QuanLySinhVien
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- ---------------------------------------------------------
-- Khởi tạo cấu trúc bảng (dành cho môi trường chưa có sẵn)
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS Class (
    ClassID INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(255) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

CREATE TABLE IF NOT EXISTS Student (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassID INT NOT NULL,
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE IF NOT EXISTS Subject (
    SubID INT AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS Mark (
    MarkID INT AUTO_INCREMENT PRIMARY KEY,
    SubID INT NOT NULL,
    StudentID INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubID, StudentID, ExamTimes),
    FOREIGN KEY (SubID) REFERENCES Subject (SubID),
    FOREIGN KEY (StudentID) REFERENCES Student (StudentID)
);

-- ---------------------------------------------------------
-- Bước 2: Thêm dữ liệu vào bảng Class
-- ---------------------------------------------------------
INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (1, 'A1', '2008-12-20', 1);

INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (2, 'A2', '2008-12-22', 1);

INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES (3, 'B3', CURRENT_DATE, 0);

-- ---------------------------------------------------------
-- Bước 3: Thêm dữ liệu vào bảng Student
-- ---------------------------------------------------------
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);

INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

-- ---------------------------------------------------------
-- Bước 4: Thêm dữ liệu vào bảng Subject
-- ---------------------------------------------------------
INSERT INTO Subject (SubID, SubName, Credit, Status)
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

-- ---------------------------------------------------------
-- Bước 5: Thêm dữ liệu vào bảng Mark
-- ---------------------------------------------------------
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

-- ---------------------------------------------------------
-- Kiểm tra dữ liệu vừa thêm
-- ---------------------------------------------------------
SELECT * FROM Class;
SELECT * FROM Student;
SELECT * FROM Subject;
SELECT * FROM Mark;
