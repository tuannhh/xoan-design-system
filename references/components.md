# Bộ component XDS Web Components

> Nguồn: bộ XDS Web Components — tài liệu nội bộ Xoăn (liên hệ đội thiết kế Xoăn).

Khi dựng UI cho ứng dụng Xoăn, dùng các component theo quy chuẩn XDS thay vì tự chế. Nếu dự án đã có thư viện component nội bộ (Xoăn UI kit / XDS package), **luôn ưu tiên import từ thư viện đó** thay vì viết component mới; chỉ tự dựng khi thư viện chưa có, và khi đó phải theo đúng quy tắc dưới đây.

## Spec chi tiết từng component (trích xuất từ Figma XDS v2.0)

Khi dùng component nào, đọc file spec tương ứng trong thư mục `components/`:

| Component | File spec |
|---|---|
| Input (trường nhập liệu) | [components/input.md](components/input.md) |
| Tab | [components/tab.md](components/tab.md) |
| Tree (cây phân cấp) | [components/tree.md](components/tree.md) |
| Date time picker | [components/date-time-picker.md](components/date-time-picker.md) |
| Icon (quy tắc dùng icon) | [components/icon.md](components/icon.md) |
| **Bảng tra hành động → file icon SVG có sẵn** | [components/icons-map.md](components/icons-map.md) |
| Thư viện icon (phân loại 43 nhóm) | [components/icons-library.md](components/icons-library.md) |

Component chưa có file spec: áp dụng quy tắc chung bên dưới và tham chiếu Figma.

## Design tokens cơ bản (tổng hợp từ spec đã trích xuất)

Các giá trị dưới đây được đo trực tiếp từ bản export Figma XDS v2.0 (xem chi tiết trong từng file spec):

| Token | Giá trị | Nguồn |
|---|---|---|
| Màu primary / focus | `#245FDF` | icon.md, input.md |
| Màu selected/accent (date picker) | `#4262F0` | date-time-picker.md |
| Màu chữ chính | `#1F2229` | date-time-picker.md, input.md |
| Placeholder | `#9DA2AC` | input.md |
| Border mặc định | `#CED1D6` | input.md |
| Nền disabled | `#F2F2F4` | input.md |
| Danger/Error | `#F04438` | icon.md, input.md |
| Success | `#12B76A` | icon.md |
| Warning | `#F79009` | icon.md |
| Info | `#2E90FA` | icon.md |
| Hover/range nhạt | `#E7EBFD` | date-time-picker.md |
| Font | Inter, 13px (body) | input.md |
| Chiều cao input | 32px | input.md |
| Corner radius input | 8px | input.md |
| Corner radius popup/calendar | 4px | date-time-picker.md |
| Kích thước icon chuẩn | 12 / 16 / 20 / 24px (mở rộng đến 48px) | icon.md |

Khi cần token chưa có trong bảng, đọc file spec liên quan hoặc tham chiếu Figma — **không tự bịa giá trị**.

## Khi cần spec chưa có trong bộ tài liệu này

Áp dụng các quy tắc chuẩn bên dưới và file spec trong `components/`. Nếu vẫn thiếu giá trị cụ thể (kích thước, màu, state), báo người dùng liên hệ đội thiết kế Xoăn để lấy spec từ nguồn nội bộ — **tuyệt đối không tự suy đoán giá trị**.

## Button

- **Primary:** một màn hình/form chỉ có **một** nút Primary — hành động chính của ngữ cảnh (Lưu, Thêm mới, Đồng ý...). Luôn ở ngoài cùng bên phải.
- **Secondary:** các hành động phụ, đặt bên trái nút Primary.
- **Nút More (⋯):** gom các hành động ít dùng; luôn nằm ngay bên phải nút Primary.
- Sau khi click: **disable hoặc hiện busy indicator** cho đến khi xử lý xong (chặn double-submit).
- Nút nguy hiểm (Xóa) cần confirm trước khi thực hiện.

## Control nhập liệu

| Tình huống | Component |
|---|---|
| 2–3 lựa chọn | Radio / Checkbox |
| 4–8 lựa chọn | Dropdown |
| > 8 lựa chọn / danh mục | Combo box (AutoComplete + LoadOnDemand + thêm nhanh + thao tác được hoàn toàn bằng bàn phím) |
| Ngày tháng | Date picker, mặc định giá trị hợp lý (thường là hôm nay) |
| Số tiền/số lượng | Input số có định dạng phân tách hàng nghìn theo chuẩn Việt Nam |

Mọi trường nhập liệu:
- Có label rõ ràng; trường bắt buộc đánh dấu `*`.
- Có placeholder/helper text hướng dẫn khi cách nhập không hiển nhiên.
- Giá trị mặc định hợp lý; tự động điền khi suy ra được từ ngữ cảnh.
- Lỗi validate hiển thị ngay dưới trường, tiếng Việt dễ hiểu; focus trường lỗi đầu tiên.

## Bảng dữ liệu (Grid/Table)

- Đặt trong màn hình Danh sách nền xám, có khoảng cách với lề (không tràn sát mép).
- Toolbar phía trên bảng: tiêu đề trái — thao tác phải (xem `layout-patterns.md`).
- Click dòng → mở chi tiết (trang, popup hoặc drawer tùy biến thể đã chọn).
- Có tìm kiếm/lọc cho danh sách dài; phân trang hoặc load-on-demand cho dữ liệu lớn.

## Popup / Drawer

- **Popup nhỏ:** thêm/sửa danh mục đơn giản.
- **Popup full màn hình:** form rất nhiều thông tin.
- **Drawer phải:** xem nhanh chi tiết từng dòng mà không rời danh sách; cho phép co kéo độ rộng.
- Nút Lưu/Hủy của popup ghim ở đáy popup; nút đóng (×) ở góc trên phải.

## Feedback & trạng thái

- Toast/notification xác nhận sau khi thao tác thành công.
- Busy indicator cho mọi xử lý; **progress bar cho tác vụ > 5 giây**.
- Empty state có hướng dẫn hành động tiếp theo (không để bảng trống trơn).

## Icon & phím tắt

- **Icon lấy từ bộ SVG đóng gói sẵn trong `assets/icons/`** — tra bảng hành động → icon tại [components/icons-map.md](components/icons-map.md). Không search internet, không dùng bộ icon khác; màu icon qua token `assets/tokens.css`.
- Cùng một hành động → cùng một icon trên toàn bộ ứng dụng và giữa các app Xoăn (thêm, sửa, xóa, xuất khẩu, nạp lại...).
- Phím tắt đồng nhất giữa các chức năng giống nhau, có tooltip hiển thị phím tắt.
