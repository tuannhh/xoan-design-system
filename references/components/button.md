# Button (Nút)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa

Button (Nút) cho phép người dùng thực hiện các hành động và lựa chọn chỉ với 1 lần nhấn.

## Màu sắc (7 màu được hỗ trợ)

| Màu | Mô tả |
|---|---|
| Brand | Màu chính của app |
| Info | Màu nút thông tin |
| Warning | Màu cho các nút cảnh báo |
| Danger | Màu cho các nút nguy hiểm |
| Success | Màu các nút thành công |
| Neutral | Màu nút trung tính tối |
| Neutral Inverse | Màu nút trung tính sáng |

## Các loại Button

### Primary Button
- Nút hành động chính, dùng màu Brand.
- Nền đặc (solid fill), không viền, chữ trắng.
- **Thường chỉ có một nút Primary trên mỗi màn hình.**
- Dùng cho các hành động chính: Lưu, Gửi, Đăng nhập, Mua.

### Secondary Button
- Nút hỗ trợ, mức độ nổi bật thấp hơn Primary.
- Nền rỗng có viền (stroke), chữ đen.
- Có thể có nhiều nút Secondary cùng kiểu trên một màn hình.
- Dùng cho: Hủy, Quay lại, các lựa chọn không quan trọng.

### Link Button
- Hiển thị dạng liên kết — văn bản có thể nhấn.
- Dùng để điều hướng mà không cần nhấn mạnh hành động.

### Icon Button
- Chỉ có icon, không có chữ.
- Dùng cho hành động nhanh: tìm kiếm, xóa, sửa, đóng.

### Button Split
- Nút gồm 2 phần: hành động chính + mũi tên dropdown.
- Nhấn mũi tên sẽ hiển thị các tùy chọn liên quan đến hành động chính.

## Thông số (Specifications)

- Chiều rộng tối thiểu: **80px**
- Bo góc (border radius): **8px**

## Trạng thái (States)

1. **Enable** — trạng thái mặc định, cho biết component có thể tương tác.
2. **Disable** — không tương tác được, hiển thị mờ/xám.
3. **Hover** — khi di chuột lên nút.
4. **Pressed** — khi chạm/nhấn chuột/thao tác bàn phím.
5. **Focus** — khi điều hướng bằng phím Tab.

### Quy tắc Focus
> Trạng thái focus luôn có một viền bên ngoài dày **2px** và cách với button là **2px**.

## Hướng dẫn sử dụng (Usage Guidelines)

### Độ dài văn bản
- Nhãn nút phải ngắn gọn, khuyến nghị tối đa khoảng 3 từ.
- Ví dụ: dùng "Thêm mới" thay vì "Thêm mới hồ sơ nhân viên".

### Khuyến nghị trong Form
- **Tránh dùng trạng thái Disable cho nút trong form; nên để Enable mặc định.**
- Khi người dùng nhấn mà chưa nhập đủ thông tin, hiển thị thông báo lỗi thay vì khóa nút.
- Cách này tránh việc người dùng bối rối không biết làm gì để nút được kích hoạt.

### Phân cấp (Hierarchy)
- Chọn loại button theo mức độ nhấn mạnh của hành động.
- Đảm bảo trạng thái Enable của nút này phân biệt rõ với trạng thái Disable của các nút khác.
