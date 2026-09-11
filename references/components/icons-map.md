# Bảng tra icon chuẩn XDS — hành động → file SVG

Bộ SVG tại **`assets/icons/`** là gói lõi đã xác minh từ XDS Web Components. Đây không phải toàn bộ thư viện icon trong Figma.

## Quy tắc bắt buộc khi dùng icon

1. Tra theo thứ tự: `assets/icons/` → bảng này → trang Icons trong Figma XDS. Thiếu trong bundle không đồng nghĩa XDS không có.
2. Trong Vue, dùng `XIcon.vue`; không inline SVG và không tạo map path riêng trong component.
3. **Không sửa path/hình dạng icon.** Các file đã được set sẵn `stroke-width="1.5"` theo quy chuẩn XDS (KHÔNG đổi về 2). Giữ `stroke="currentColor"` — đổi màu bằng CSS `color` với token trong `assets/tokens.css`:
   - Mặc định: `color: var(--xds-icon-neutral)` (#6B707A)
   - Nhấn mạnh/primary: `var(--xds-primary)` · Nguy hiểm: `var(--xds-danger)` · Thành công: `var(--xds-success)` · Cảnh báo: `var(--xds-warning)` · Thông tin: `var(--xds-info)`
4. Kích thước chuẩn: 16/20/24/32px theo token `--xds-icon-*` (mặc định 24px; icon trong button/input thường 16px). Icon tương tác đứng riêng lẻ cần vùng chạm tối thiểu 40px trên desktop và 48px trên màn hình touch/coarse pointer. Set qua `width`/`height`, không scale méo.
5. Icon có trong Figma nhưng chưa có trong bundle: xuất đúng vector/tên từ Figma, thêm vào `assets/icons/`, cập nhật bảng này và chạy `python3 scripts/build-icon-registry.py`. Chỉ dùng Tabler/tự vẽ khi đã xác minh Figma không có.
6. Danh sách 21 hành động có icon quy định cứng toàn hệ thống (Thêm, Sửa, Xóa, In, Tìm kiếm, Reload, Thiết lập, Bộ lọc, Nhập/Xuất khẩu, xem dạng card/kanban/danh sách...): xem mục "Icon dùng chung" trong [../conventions.md](../conventions.md).

## Hành động CRUD & thao tác dữ liệu

| Hành động | File icon |
|---|---|
| Thêm mới | `plus.svg` |
| Sửa | `pencil.svg` |
| Xóa | `trash.svg` |
| Lưu | `device-floppy.svg` |
| Nhân bản / Sao chép | `copy.svg` |
| Tìm kiếm | `search.svg` |
| Lọc / Bỏ lọc | `filter.svg` / `filter-off.svg` |
| Nạp lại / Làm mới | `refresh.svg` |
| Sắp xếp tăng / giảm / đổi chiều | `sort-ascending.svg` / `sort-descending.svg` / `arrows-sort.svg` |
| Xuất khẩu / Nhập khẩu | `file-export.svg` / `file-import.svg` |
| Tải xuống / Tải lên | `download.svg` / `upload.svg` |
| In | `printer.svg` |
| Chia sẻ | `share.svg` |
| Gửi | `send.svg` |

## Điều hướng & bố cục

| Hành động | File icon |
|---|---|
| Mở rộng / Thu gọn | `chevron-down.svg` / `chevron-up.svg` |
| Sang trang trước / sau | `chevron-left.svg` / `chevron-right.svg` |
| Về trang đầu / cuối (phân trang) | `chevrons-left.svg` / `chevrons-right.svg` |
| Quay lại / Tiến / Lên / Xuống | `arrow-left.svg` / `arrow-right.svg` / `arrow-up.svg` / `arrow-down.svg` |
| Nút More (thao tác khác) | `dots.svg` (ngang) / `dots-vertical.svg` (dọc) |
| Menu | `menu-2.svg` |
| Xem dạng lưới card / danh sách | `layout-grid.svg` / `list.svg` |
| Đóng (popup, tag, drawer) | `x.svg` |
| Xác nhận / Đồng ý | `check.svg` |
| Trang chủ | `home.svg` |
| Link ngoài / Liên kết | `external-link.svg` / `link.svg` |

## Trạng thái & thông báo

| Ý nghĩa | File icon | Màu token |
|---|---|---|
| Thông tin | `info-circle.svg` | `--xds-info` |
| Cảnh báo | `alert-triangle.svg` hoặc `alert-circle.svg` | `--xds-warning` |
| Thành công | `circle-check.svg` | `--xds-success` |
| Lỗi | `circle-x.svg` | `--xds-danger` |
| Trợ giúp | `help.svg` | `--xds-icon-neutral` |
| Thông báo (chuông) | `bell.svg` | `--xds-icon-neutral` |
| Tính năng mới (loa thông báo, đầu cụm tiện ích header) | `speakerphone.svg` | `--xds-icon-neutral` (trắng trên header brand) |

## Nghiệp vụ & đối tượng

| Ý nghĩa | File icon |
|---|---|
| Người dùng / Nhóm người dùng | `user.svg` / `users.svg` |
| Ngày tháng / Giờ | `calendar.svg` / `clock.svg` |
| Xem / Ẩn (mật khẩu, cột) | `eye.svg` / `eye-off.svg` |
| Email / Điện thoại | `mail.svg` / `phone.svg` |
| Thư mục / Tệp / Văn bản | `folder.svg` / `file.svg` / `file-text.svg` |
| Đính kèm | `paperclip.svg` |
| Khóa / Mở khóa | `lock.svg` / `lock-open.svg` |
| Đăng nhập / Đăng xuất | `login.svg` / `logout.svg` |
| Cài đặt / Thiết lập | `settings.svg` |
| Yêu thích / Đánh dấu | `star.svg` / `bookmark.svg` |
| Nhãn (tag) | `tag.svg` |
| Tin nhắn / Bình luận | `message.svg` |
| More trong vòng tròn header | `dots.svg` trong button tròn có border `--xds-border` |
| Ảnh / Chụp ảnh | `photo.svg` / `camera.svg` |
| Vị trí | `map-pin.svg` |
| Cơ quan, tòa nhà / Công việc | `building.svg` / `briefcase.svg` |
| Ví / Tiền mặt / Thẻ / Hóa đơn | `wallet.svg` / `cash.svg` / `credit-card.svg` / `receipt.svg` |
| Báo cáo cột / tròn | `chart-bar.svg` / `chart-pie.svg` |
| Dữ liệu / Đồng bộ lên / xuống | `database.svg` / `cloud-upload.svg` / `cloud-download.svg` |

## Ví dụ dùng trong code

```html
<!-- XIcon dùng registry sinh từ assets/icons, màu theo currentColor -->
<button class="btn-secondary">
  <XIcon name="plus" :size="16" />
  Thêm mới
</button>
```

```css
.xds-icon { color: var(--xds-icon-neutral); }
.btn-primary .xds-icon { color: #fff; }
.icon-danger { color: var(--xds-danger); }
```

> Phân loại đầy đủ 43 nhóm icon của XDS: xem [icons-library.md](icons-library.md).

## Khi thư viện chưa có icon

1. Tra `assets/icons/`, bảng này và Figma Icons trước.
2. Nếu có trong Figma, bổ sung đúng SVG chính thức vào bundle.
3. Nếu thật sự chưa có trong Figma, dùng Tabler outline gần nhất hoặc thiết kế mới theo XDS; bổ sung vào Design System trước khi app dùng.
4. Chạy generator + validator; không cập nhật map path riêng vì mọi component dùng chung `XIcon`.
