-- 1. Tạo cơ sở dữ liệu QuanLyBanHang
CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

-- 2. Tạo bảng Customer (Khách hàng)
CREATE TABLE IF NOT EXISTS Customer (
    cID INT AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(50) NOT NULL,
    cAge TINYINT CHECK (cAge > 0)
);

-- 3. Tạo bảng Order (Hóa đơn)
-- Lưu ý: 'Order' là từ khóa bảo lưu trong SQL nên được đặt trong cặp dấu ``
CREATE TABLE IF NOT EXISTS `Order` (
    oID INT AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    oTotalPrice INT CHECK (oTotalPrice >= 0),
    CONSTRAINT fk_order_customer FOREIGN KEY (cID) REFERENCES Customer(cID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. Tạo bảng Product (Sản phẩm)
CREATE TABLE IF NOT EXISTS Product (
    pID INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    pPrice INT NOT NULL CHECK (pPrice >= 0)
);

-- 5. Tạo bảng OrderDetail (Chi tiết hóa đơn)
CREATE TABLE IF NOT EXISTS OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),
    PRIMARY KEY (oID, pID),
    CONSTRAINT fk_orderdetail_order FOREIGN KEY (oID) REFERENCES `Order`(oID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_orderdetail_product FOREIGN KEY (pID) REFERENCES Product(pID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Thêm dữ liệu mẫu (Sample Data)
INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bếp Điện', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);
