# Bài Tập CSĐL: Quản Lý Bán Hàng (QuanLyBanHang)

## Mô tả
Cơ sở dữ liệu Quản Lý Bán Hàng gồm 4 bảng:
- **Customer**: Lưu trữ thông tin khách hàng.
- **Order**: Lưu trữ thông tin đơn hàng/hóa đơn.
- **Product**: Lưu trữ danh sách các sản phẩm/mặt hàng.
- **OrderDetail**: Lưu trữ chi tiết đơn hàng (quan hệ nhiều - nhiều giữa Order và Product).

## Các ràng buộc được sử dụng (Constraints)
- `PRIMARY KEY`: Khóa chính cho các bảng (`cID`, `oID`, `pID`, và khóa chính tổng hợp `(oID, pID)` trong OrderDetail).
- `FOREIGN KEY`: Khóa ngoại liên kết giữa các bảng (`Order.cID` -> `Customer.cID`, `OrderDetail.oID` -> `Order.oID`, `OrderDetail.pID` -> `Product.pID`).
- `CHECK`: Kiểm tra tuổi (`cAge > 0`), giá tiền (`pPrice >= 0`), số lượng mua (`odQTY > 0`).
- `NOT NULL`: Đảm bảo các trường dữ liệu quan trọng không bị rỗng.
- `AUTO_INCREMENT`: Tự động tăng khóa chính.

## Hướng dẫn sử dụng
1. Mở MySQL Workbench hoặc phpMyAdmin.
2. Mở file `QuanLyBanHang.sql` và chạy toàn bộ câu lệnh.
3. Kiểm tra các bảng và dữ liệu đã khởi tạo thành công.
