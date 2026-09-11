# Context menu

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa / Khi nào dùng

Sử dụng khi bấm chuột phải trên giao diện hoặc bấm các nút 3 chấm (⋮), nút có mũi tên xổ xuống (dropdown arrow).

Trong file thiết kế thành phần, chọn property **Type = Action** cho các item của context menu.

## Quy tắc sử dụng

### Icon

- Các chức năng trên context menu **nên có icon** để giúp người dùng dễ dàng nhận biết.
- Đối với những chức năng không có icon phù hợp, có thể để trống phần icon bên trái (vẫn giữ vị trí căn lề để các nhãn thẳng hàng).

### Line (đường phân cách)

- Khi các chức năng có liên quan đến nhau, có thể gom lại thành từng nhóm.
- Dùng đường line để ngăn cách giữa các nhóm với nhau.

## Spec chuẩn Dropdown/Context menu (từ bộ demo của giám đốc thiết kế)

- Khung menu: nền trắng, **bo góc 12px** (`--radius-dialog`), viền 1px `--stroke-neutral-light`, shadow `0 4px 16px rgba(16,24,40,0.12)`, padding dọc 8px, min-width 160–180px (≥ bề rộng trigger), max-width 360px.
- Mở cách trigger **4px**, position fixed z-index cao; căn `bottom-start` hoặc `bottom-end` theo vị trí trigger.
- Item: cao **32px**, padding trái 16px phải 12px, gap 8px, chữ 13px regular; icon 16px màu `--icon-neutral`; label tràn thì ellipsis; có thể kèm tag nhỏ 11px nền neutral bo 4px bên phải.
- Hover: nền `--bg-neutral-hover`. Item danger (Xóa): chữ + icon đỏ, hover nền danger-light. Item active: nền brand-light + chữ/icon brand. Disabled: mờ 45%.
- Đường phân nhóm: 1px `--stroke-neutral-light`, margin dọc 4px.
- Đóng bằng: chọn item, click ra ngoài, phím **Esc**. Animation vào/ra 0.12s fade + trượt lên 4px.

## Ghi chú

- Tài liệu gốc minh họa bằng hình ảnh; các giá trị chi tiết về kích thước/màu sắc nằm trong file thiết kế thành phần (XDS Web Components) của đội Product Design.
