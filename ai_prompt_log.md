# Nhật Ký Tương Tác AI (AI Prompt Log) - AutoRide Project

## Session 1: Lựa chọn kiểu dữ liệu tối ưu cho các cột tài chính
- **Prompt:** "Khi lưu trữ thông tin tiền cọc, phí phạt trễ và phí đền bù hư hỏng trong MySQL, nên dùng kiểu dữ liệu `FLOAT`, `DOUBLE` hay `DECIMAL`? Tại sao?"
- **Phản hồi của AI:** Khuyên dùng `DECIMAL(12, 2)` vì `FLOAT` và `DOUBLE` sử dụng biểu diễn số thực dấu phẩy động (floating-point binary representation), dễ gây ra sai số làm tròn trong các phép tính tài chính kế toán. `DECIMAL` lưu trữ số dưới dạng định dạng chính xác (exact numeric quality).

## Session 2: Thiết kế quan hệ giữa Rentals và Inspections
- **Prompt:** "Biên bản kiểm tra xe (Inspections) nên liên kết với bảng Hợp đồng thuê xe (Rentals) theo quan hệ 1-1 hay 1-N? Phân tích ưu/nhược điểm."
- **Phản hồi của AI:** 
  - Nếu 1 xe chỉ kiểm tra 1 lần duy nhất khi trả: Có thể dùng 1-1.
  - Tuy nhiên, thực tế nghiệp vụ nên thiết kế 1-N (1 Rentals có thể có nhiều Inspections: kiểm tra lúc nhận xe, kiểm tra giữa chừng, kiểm tra lúc trả xe). Điều này giúp hệ thống linh hoạt và mở rộng về sau.

## Session 3: Xử lý ràng buộc toàn vẹn dữ liệu
- **Prompt:** "Nên dùng hành vi `ON DELETE RESTRICT` hay `ON DELETE CASCADE` cho khóa ngoại giữa `Inspections` và `Rentals`?"
- **Phản hồi của AI:** Nên sử dụng `ON DELETE RESTRICT` đối với các bảng lưu trữ dữ liệu pháp lý/kiểm toán như `Inspections`. Điều này ngăn chặn việc vô tình xóa một hợp đồng thuê xe (`Rentals`) khi hợp đồng đó đã phát sinh biên bản kiểm tra sự cố.
