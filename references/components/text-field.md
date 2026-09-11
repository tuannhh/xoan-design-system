# Text field (Trường văn bản)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)
> Spec hình ảnh chi tiết (kích thước/màu từng state): xem [input.md](input.md)

## Định nghĩa

Trường văn bản cho phép người dùng nhập và chỉnh sửa văn bản.

## Cách sử dụng — 3 kiểu hiển thị Label

### 1. Label nằm ngang (Horizontal Label)
- **Khi dùng:** form nhiều thông tin và label ngắn; tối ưu không gian theo chiều dọc để giảm cuộn trang.
- **Ưu điểm:**
  - Tiết kiệm không gian với form dày đặc thông tin.
  - Vị trí label và giá trị nhất quán giữa chế độ xem và chế độ sửa.
- **Nhược điểm:**
  - Label dài xuống nhiều dòng gây lỗi hiển thị.
  - Có thể lãng phí không gian hoặc làm bố cục form mất cân đối.

### 2. Label ở trên, control ở dưới
- **Khi dùng:** form không quá nhiều thông tin; label dài kèm giải thích; màn hình hẹp; form responsive trên mobile.
- **Ưu điểm:**
  - Dễ nhập liệu từ trên xuống dưới, không cần đảo mắt trái phải, trên dưới.
  - Phù hợp label dài; giữ bố cục cân đối.
  - Responsive tốt trên mọi thiết bị.
- **Nhược điểm:**
  - Form nhiều trường sẽ phải cuộn nhiều.

### 3. Không có Label (No Label)
- **Khi dùng:** ngữ cảnh đủ rõ để người dùng hiểu cần nhập gì mà không cần label; form rất ngắn (1–3 trường); tác vụ lặp lại thường xuyên.
- **Ví dụ:** ô tìm kiếm, bộ lọc dữ liệu, đăng nhập nhanh, nhập OTP, ô bình luận, tác vụ nhỏ trong sidebar/toolbar.
- **Ưu điểm:**
  - Giao diện gọn gàng, cô đọng; tiết kiệm không gian.
- **Nhược điểm:**
  - Placeholder biến mất khi nhập gây mơ hồ.
  - Vấn đề accessibility; dễ nhầm lẫn giữa các trường giống nhau.

> **Lưu ý:** Mỗi form nên chỉ dùng một kiểu label để đảm bảo đồng nhất giao diện.

## Trạng thái (States)

1. **Normal** — trạng thái mặc định.
2. **Hover** — khi di chuột lên trường.
3. **Focus** — khi trường đang được chọn để nhập.
4. **Readonly** — chỉ đọc, không sửa được.
5. **Error** — có lỗi nhập liệu.
6. **Validate** — đang/đã kiểm tra hợp lệ dữ liệu.
7. **Verifying** — đang xác minh giá trị.

(Chi tiết kích thước/màu sắc từng state: xem [input.md](input.md).)

## Hành vi (Behaviors)

- **Trạng thái Error:** tooltip thông báo lỗi tự động hiển thị khi focus vào trường lỗi.
- **Khi focus:** "Khi focus vào ô nhập liệu các giá trị tự động bôi đen hết để sửa giá trị nhanh hơn."
- **Sửa từng ký tự:** click vào vị trí cụ thể trong ô để bỏ bôi đen và chỉnh sửa từng ký tự.

## Khuyến nghị (Recommendations)

### 1. Đánh dấu trường tùy chọn thay vì trường bắt buộc
> Thay vì đánh dấu tất cả các trường bắt buộc thì hãy chỉ đánh dấu các trường tùy chọn.

Dùng nhãn "tùy chọn" cho các trường không bắt buộc.

### 2. Không phải lúc nào cũng cần gợi ý (placeholder)
- Placeholder giúp người dùng nhưng không bắt buộc với trường đơn giản (ví dụ: họ tên).
- Placeholder là cần thiết với các trường yêu cầu định dạng dữ liệu cụ thể.
