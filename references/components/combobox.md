# ComboBox

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa

Combobox là một thành phần giao diện người dùng (UI component) kết hợp giữa ô nhập liệu (input) và danh sách chọn (dropdown).

Dùng Combobox khi danh sách có **nhiều hơn 10 tùy chọn** (ít hơn thì dùng DropDownList/Radio button — xem [dropdown.md](dropdown.md)).

## Các dạng Combobox (4 biến thể)

1. Combobox Single
2. Combobox Multiple
3. Combobox Single Split
4. Combobox Multiple Split

## Combobox Single

Cho phép người dùng chọn **duy nhất 1 giá trị** từ danh sách, giúp nhập liệu chính xác và đồng nhất (ví dụ: Quốc gia, Tỉnh thành).

### Quy tắc hiển thị các tùy chọn
- Hiển thị tối đa **5–10 item** (tùy loại danh sách), sau đó scroll để load thêm.
- Với dữ liệu động: **load trước tối đa 20 item**, sau đó scroll chuột thì load thêm (**Load on demand**).
- Cho phép **gõ tìm kiếm trực tiếp tại control** để lọc kết quả tìm kiếm.
- Hỗ trợ các định dạng danh sách:
  - Danh sách đơn lẻ (chỉ text)
  - Danh sách phức tạp (có ảnh, thông tin chính/phụ)
  - Dạng bảng (table)
  - Dạng cây (tree)

## Combobox Multiple

Vẫn là dạng Combobox thường nhưng **cho chọn nhiều giá trị cùng lúc**.

### Quy tắc hiển thị
- Khi chọn nhiều giá trị, chỉ hiển thị ra ngoài **tối đa 2 tag** người dùng chọn sau cùng.
- Các tag còn lại được **gộp thành ô số** (ví dụ: "3").
- **Không đẩy giao diện thành nhiều dòng** gây xô lệch bố cục.
- Item nào chọn đầu tiên sẽ **ưu tiên hiển thị bên ngoài**.
- Trong danh sách xổ ra: các item được chọn có **tiêu đề chính màu Brand** và có **icon check ở cuối** dòng.
- **Không sử dụng checkbox ở đầu** item — gây tốn diện tích.

## Combobox Single Split

- Xổ xuống chọn giá trị tại popover, có **icon ở cuối** để mở **danh sách tìm kiếm nâng cao**.
- Dùng khi cần tra cứu sâu hơn: ví dụ chọn khách hàng, nhà cung cấp.

## Combobox Multiple Split

- Kết hợp Combobox Multiple (chọn nhiều giá trị) với phần split mở tìm kiếm nâng cao như Combobox Single Split. (Tài liệu nguồn không mô tả chi tiết thêm cho biến thể này.)

## Thêm giá trị mới (Add new)

- Khi xổ ra, gõ tìm kiếm giá trị cần chọn mà **không có trong danh sách** thì hiển thị **Link button "Nhấn Enter để thêm mới"**.
- Hỗ trợ **icon 3 chấm** để hiển thị lại danh sách các giá trị, cho phép **Sửa, Xóa, Di chuyển thứ tự**.

## Ghi chú

- Tài liệu nguồn của trang ComboBox không liệt kê riêng bảng phím tắt và các trạng thái; hành vi label/trạng thái áp dụng tương tự [text-field.md](text-field.md), và phím tắt điều hướng danh sách tương tự [dropdown.md](dropdown.md).
