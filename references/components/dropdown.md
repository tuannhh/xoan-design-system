# DropDownList (Menu thả xuống)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa

Sử dụng menu thả xuống khi người dùng cần chọn từ một số giá trị, ví dụ: khi người dùng cần chọn khách hàng hoặc loại thanh toán.

## Khi nào dùng (Usage)

- Sử dụng dropdown list khi trình bày cho người dùng một danh sách dài các tùy chọn (**nhiều hơn 5 và nhỏ hơn 10 tùy chọn**).
- **Ít hơn 5 tùy chọn** → dùng **Radio button**; **nhiều hơn 10 tùy chọn** → dùng **Combobox** (xem [combobox.md](combobox.md)).
- Việc hiển thị các label tương tự như bên **Text field** (xem [text-field.md](text-field.md)).
- Các trạng thái cũng tương đồng với **Text field**.

## Quy tắc hiển thị danh sách xổ ra (popover)

- Khi kích thước của text trong danh sách xổ ra **nhỏ hơn** DropDownList thì **min-width của danh sách bên dưới sẽ bằng kích thước của DropDownList**.
- Khi kích thước của text trong danh sách xổ ra **lớn hơn** kích thước của DropDownList thì hiển thị width của danh sách **theo độ rộng của text** để đảm bảo đọc được đầy đủ thông tin; nếu quá dài có thể cân nhắc hiển thị **2 dòng**.

## Phím tắt (Keyboard)

| Phím | Chức năng |
|------|-----------|
| ARROW UP | Di chuyển lên trên 1 item |
| ARROW DOWN | Di xuống dưới 1 item |
| ENTER | Submit item đang chọn và đóng popover |

## Khuyến nghị (Recommendations)

### Sắp xếp tùy chọn
- **Nên:** Sắp xếp các lựa chọn trong danh sách theo một thứ tự hợp lý (theo thứ tự bảng chữ cái, thứ tự thời gian, thứ tự quan trọng, v.v.).
- **Không nên:** Tránh việc để các giá trị lộn xộn không theo một thứ tự nào.

### Placeholder khi chưa có giá trị được chọn
- **Nên:** Khi không có giá trị nào được chọn trước, hãy viết một câu gợi ý người dùng lựa chọn giá trị phù hợp trong placeholder.
  - Ví dụ: dùng câu như **"Chọn nhà cung cấp"** hoặc **"Chọn tài khoản"** ở định dạng văn bản gợi ý (mờ). Nếu không thể làm mờ văn bản thì sử dụng chỉ báo.
- **Không nên:** Tránh việc để trống, không gợi ý hoặc không có chỉ báo cho người dùng biết tại đây chọn được giá trị.
