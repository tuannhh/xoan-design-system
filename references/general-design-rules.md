# Nguyên tắc thiết kế chung — Xoăn Design System

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (liên hệ đội thiết kế Xoăn)

Bốn nguyên tắc nền tảng mọi ứng dụng Xoăn phải tuân theo. Khi thiết kế bất kỳ luồng thao tác hoặc form nào, đối chiếu từng nguyên tắc dưới đây.

## 1. Dễ học, dễ nhớ

- Các chức năng được **sắp xếp theo thứ tự tác nghiệp của người dùng trong thực tế** — không sắp theo logic kỹ thuật hay cấu trúc dữ liệu.
- Các chức năng chính, hay được sử dụng cần đặt tại **vị trí dễ nhận biết**.
- **Biểu tượng (icon) của các chức năng giống nhau phải đồng nhất** trên toàn ứng dụng và giữa các ứng dụng Xoăn.
- **Phím tắt** dễ nhớ, có tooltip, dễ thực hiện; phím tắt cho các chức năng giống nhau phải đồng nhất.
- Các chức năng phức tạp cần có **thông tin hướng dẫn ngay trên form** (inline help), không bắt người dùng đi tìm tài liệu.

**Cách áp dụng khi code:** đặt nút thao tác chính ở vị trí chuẩn (xem SKILL.md), dùng chung bộ icon cho cùng hành động (thêm/sửa/xóa/xuất khẩu...), thêm `title`/tooltip cho phím tắt, thêm text hướng dẫn ngắn dưới các trường phức tạp.

## 2. Dễ dàng nhập liệu

- Các thông tin cần nhập được **sắp xếp theo thứ tự phù hợp với thói quen thao tác** của người dùng nghiệp vụ.
- Luôn có **giá trị mặc định hợp lý** (ngày hôm nay, đơn vị hiện tại, trạng thái phổ biến nhất...).
- Có **hướng dẫn nhập liệu ngay trên màn hình** (placeholder, helper text).
- **Tự động nhập liệu thay người dùng khi có thể** (tự sinh mã, tự điền từ bản ghi liên quan, tự tính toán).

### Quy tắc chọn control theo số lựa chọn

| Số bản ghi/lựa chọn | Control | Yêu cầu |
|---|---|---|
| 2–3 | Radio button / Checkbox | Hiện hết lựa chọn, không cần mở |
| 4–8 | Dropdown | — |
| > 8 | Combo box | Bắt buộc AutoComplete + LoadOnDemand |

### Yêu cầu với Combo box

- Bật **LoadOnDemand** để đảm bảo hiệu năng với danh mục lớn.
- Có **AutoComplete** (gõ để lọc).
- Hỗ trợ **nhập liệu hoàn toàn bằng bàn phím** (không bắt buộc dùng chuột).
- Cho phép **thêm nhanh danh mục** ngay từ combo (không phải rời form đi tạo danh mục rồi quay lại).
- Hỗ trợ chức năng nhân bản (duplication) khi phù hợp.
- **Ẩn các chức năng không dùng đến** — không phô bày mọi tính năng của control.

## 3. Kiểm soát được thao tác người dùng

- **Chương trình phải phản hồi lại với mỗi thao tác của người dùng** — không có click nào "rơi vào im lặng".
- **Disable button hoặc hiện Busy Indicator ngay sau khi click** để chặn double-submit.
- Các chức năng xử lý **lâu hơn 5 giây cần có thanh tiến trình** (progress bar), không chỉ spinner.

**Cách áp dụng khi code:** mọi handler submit phải set trạng thái loading trước khi gọi API và khôi phục sau khi xong/lỗi; tác vụ dài (import, render, đồng bộ) cần progress theo % hoặc theo bước.

## 4. Kiểm soát được lỗi

- Có **cảnh báo khi người dùng thao tác sai**; nội dung cảnh báo **dễ hiểu**, viết bằng ngôn ngữ nghiệp vụ tiếng Việt, không hiện mã lỗi kỹ thuật thô.
- **Tự động focus vào trường đầu tiên bị lỗi** khi validate thất bại.

**Cách áp dụng khi code:** validate phía client trước khi submit; thông báo lỗi đặt ngay dưới trường lỗi; sau khi validate, scroll + focus vào trường lỗi đầu tiên theo thứ tự hiển thị.
