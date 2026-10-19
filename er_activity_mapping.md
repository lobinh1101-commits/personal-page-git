# Báo Cáo Đối Chiếu Luồng Nghiệp Vụ UML & Mô Hình Dữ Liệu ERD

## 1. Phân Tích Khoảng Trống Dữ Liệu (Data Gaps Analysis)

| STT | Luồng Nghiệp Vụ UML (Activity Diagram) | Cấu Trúc Cơ Sở Dữ Liệu Cũ (Legacy DB) | Khoảng Trống Dữ Liệu (Data Gap) & Hậu Quả |
| :--- | :--- | :--- | :--- |
| **1** | Quản lý trạng thái vòng đời hợp đồng (BOOKED -> ACTIVE -> COMPLETED). | Trạng thái dùng `VARCHAR(50)`, không giới hạn chuẩn. | Nhân viên có thể nhập sai chính tả (ví dụ: `Active`, `active_car`), làm sai lệch báo cáo và thiếu kiểm soát tiến trình. |
| **2** | Tính toán khấu trừ tài chính khi trả xe (Tiền hoàn = Cọc - Phí trễ - Phí hỏng xe). | Không có các cột `security_deposit`, `late_fee`, `damage_fee`. | Kế toán không có cơ sở dữ liệu để tính số tiền hoàn trả thực tế, dẫn đến nguy cơ thất thoát doanh thu nghiêm trọng. |
| **3** | Kiểm tra tình trạng xe khi bàn giao/trả xe (Inspection). | Không có bảng `Inspections` lưu biên bản kiểm tra. | Không lưu vết được thời điểm hư hỏng, mô tả vị trí va quệt, người kiểm tra, dẫn đến tranh chấp pháp lý với khách hàng. |

---

## 2. Giải Thích Sự Bắt Buộc Của Cột `damage_fee` (< 200 từ)

Cột `damage_fee` là điều kiện tiên quyết để đảm bảo tính toàn vẹn dữ liệu và toàn vẹn tài chính trong hệ thống AutoRide. 

Trong quy trình nghiệp vụ trả xe, rủi ro phát sinh hư hỏng (trầy xước, vỡ đèn, hỏng nội thất) là một nhánh rẽ bắt buộc phải xử lý. Nếu thiếu `damage_fee`:
1. **Thất thoát tài chính**: Kế toán không thể hạch toán tự động khoản tiền đền bù trực tiếp trên hệ thống, buộc phải hoàn lại 100% tiền cọc cho khách hoặc ghi chép thủ công ngoài sổ sách.
2. **Sai lệch công thức nghiệp vụ**: Công thức hoàn tiền $	ext{Refund} = 	ext{Deposit} - 	ext{Late Fee} - 	ext{Damage Fee}$ sẽ bị vỡ, làm hỏng luồng thanh toán tự động.
3. **Mất khả năng đối soát**: Không thể đối chiếu giữa biên bản kiểm tra xe (`Inspections`) và hóa đơn thanh toán thực tế.

Do đó, `damage_fee` kết hợp cùng kiểu dữ liệu `DECIMAL(12,2)` là cột bắt buộc giúp đóng kín luồng tài chính của hợp đồng thuê xe.
