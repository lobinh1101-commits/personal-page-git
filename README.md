# Bài Thực Hành SQL: Thêm Dữ Liệu Vào Cơ Sở Dữ Liệu Quản Lý Sinh Viên

## Mục tiêu
- Sử dụng thành thạo câu lệnh `INSERT INTO` để thêm bản ghi mới vào các bảng trong MySQL.
- Hiểu cách thêm từng dòng hoặc nhiều dòng cùng lúc, cũng như cách bỏ qua các cột chấp nhận giá trị `NULL`.

## Nội dung bài tập
Tệp `QuanLySinhVien_Data.sql` thực hiện các thao tác:
1. Tạo cơ sở dữ liệu `QuanLySinhVien` và tạo các bảng `Class`, `Student`, `Subject`, `Mark`.
2. Thêm dữ liệu lớp học vào bảng `Class`.
3. Thêm học viên vào bảng `Student` (bao gồm trường hợp học viên không nhập số điện thoại).
4. Thêm các môn học vào bảng `Subject` bằng cú pháp chèn nhiều dòng (Multi-row Insert).
5. Thêm bảng điểm vào bảng `Mark`.

## Hướng dẫn sử dụng
1. Mở MySQL Workbench, phpMyAdmin hoặc terminal MySQL.
2. Mở file `QuanLySinhVien_Data.sql` và tiến hành thực thi toàn bộ đoạn mã (Execute/Run).
3. Kiểm tra kết quả hiển thị ở các bảng dữ liệu qua các câu lệnh `SELECT`.

## Đưa lên GitHub & Nộp bài
1. Tải file ZIP này về và giải nén.
2. Tạo/Mở repository trên GitHub và đẩy các file mã nguồn lên.
3. Sao chép liên kết repository trên GitHub và dán vào phần nộp bài.
