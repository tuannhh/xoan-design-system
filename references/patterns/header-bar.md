# Header bar (Thanh điều hướng trên cùng) — XDS

## Định nghĩa

Header bar là **thanh điều hướng nằm ở phía trên cùng** của giao diện web/ứng dụng Xoăn. Nó chứa: **logo + tên sản phẩm, ô tìm kiếm, nút Thiết lập, và avatar người dùng**.

Header Xoăn **cố tình tối giản**: cụm bên phải chỉ còn **Thiết lập** và **Avatar người dùng**. Không có nút chuyển ứng dụng 9 chấm, không có trợ lý AI, không có tin nhắn/thông báo/trợ giúp/khác, không có badge năm dữ liệu hay nút chọn công ty. Component triển khai: [`ui/components/XHeaderBar.vue`](../../ui/components/XHeaderBar.vue).

## 1. Biến thể

- **Mặc định là header CÓ MÀU (`brand`)** — tô theo màu chính (Brand/600) của ứng dụng; chữ và icon màu trắng. Người dùng cuối đổi được màu này theo sở thích trong dialog Thiết lập. Theme Gradient tô header bằng `linear-gradient(90deg, #245FDF, #0FBF79)` qua class hook `xds-header--brand`.
- **`light`**: header nền trắng; chữ và icon dùng màu neutral, có `border-bottom` 1px `--xds-border`.
- Biến thể do người dùng chọn trong dialog "Thiết lập màu sắc và hiển thị" (mục Giao diện: **Màu sắc** = brand / **Sáng** = light), lưu `localStorage`.
- Ô tìm kiếm ở trạng thái chưa focus có cảm giác secondary: nền trung tính (`--xds-bg-disabled`) trên `light`, `rgba(255,255,255,0.2)` trên `brand`. Khi focus chỉ tăng nhẹ độ tương phản (`rgba(255,255,255,0.28)` trên brand) — không đổi thành input trắng đặc.

### Kích thước chuẩn (redline)

- Header cao **48px**, **padding trái 16px, padding phải 16px**.
- **Logo app: 32×32px**, cách tên app **12px**. Tên app **20px semibold** màu trắng (trên brand) / text-primary (trên light).
- Ô tìm kiếm: cao 32px, bo 8px, rộng co giãn theo không gian còn lại (max 500px), có icon search 16px ở đầu.
- **Icon button trên header (Thiết lập): 32×32px**, icon 20px, bo 8px, **khoảng cách giữa các phần tử cụm phải 8px**; hover `rgba(255,255,255,0.15)` (brand) / `--xds-bg-hover-soft` (light).
- **Avatar người dùng: 32×32px** tròn, cách mép phải header **16px**.

## 2. Tooltip

- Khi **hover vào nút Thiết lập và avatar** đều phải hiển thị **tooltip** mô tả chức năng ("Thiết lập", tên người dùng).

## 3. Các thành phần trên Header bar (trái → phải)

- **Bên trái ngoài cùng**: Logo + tên sản phẩm/ứng dụng (bấm vào điều hướng về màn hình chính — emit `logo-click`). KHÔNG có nút app switcher 9 chấm.
- **Ở giữa**: Ô **tìm kiếm** (có thể ẩn bằng prop `showSearch=false`). Phím tắt `Ctrl/Cmd + K` focus vào ô tìm kiếm; focus tự select toàn bộ text; Enter emit `search`.
- **Bên phải (cụm cố định)**: **Thiết lập** (bánh răng, emit `settings`) → **Avatar người dùng** (emit `user-click`). Đây là toàn bộ cụm phải — không thêm icon nào khác vào giữa cụm.

### API component `XHeaderBar`

| Loại | Tên | Ghi chú |
|---|---|---|
| Prop | `variant` | `'light'` \| `'brand'` (mặc định `'brand'`) |
| Prop | `appName` | Tên app hiển thị cạnh logo |
| Prop | `searchPlaceholder` | Mặc định `'Tìm kiếm'` |
| Prop | `user` | Object `{ name, avatarUrl }` cho avatar |
| Prop | `showSearch` | Mặc định `true` |
| Prop | `showSettings` | Mặc định `true` |
| Emit | `search` | Payload là chuỗi tìm kiếm (khi nhấn Enter) |
| Emit | `settings` | Mở dialog Thiết lập ([`XSettingsDialog`](../../ui/components/XSettingsDialog.vue)) |
| Emit | `user-click` | Bấm avatar (app tự gắn menu tài khoản) |
| Emit | `logo-click` | Bấm logo/tên app |
| Slot | `logo` | Thay logo mặc định (mặc định là ô vuông chữ cái đầu tên app) |
| Slot | `actions` | Nút riêng của app, đặt **TRƯỚC** cụm Thiết lập/Avatar |
| Slot | `user` | Thay hẳn nút avatar bằng identity phức tạp hơn (dropdown menu kèm tên/vai trò), vẫn giữ vị trí ngoài cùng bên phải |

> **Gắn menu tài khoản**: dùng slot `user` bọc quanh avatar, gắn [`XDropdownMenu`](../../ui/components/XDropdownMenu.vue) (đã có keyboard ↑↓/Enter/Esc + outside click) làm panel tài khoản (họ tên, email, đổi mật khẩu, đăng xuất...). Nút riêng của app (vd nút "Đăng nhập" khi chưa login) đặt ở slot `actions`, KHÔNG chèn vào giữa cụm Thiết lập/Avatar.

## 3b. Dialog "Thiết lập màu sắc và hiển thị" (nút Thiết lập trên header)

Nút Thiết lập (icon bánh răng) mở dialog cá nhân hóa toàn app — component [`XSettingsDialog`](../../ui/components/XSettingsDialog.vue), dạng dialog full-width trượt từ mép trên (bo góc 12px chỉ 2 góc trên, max-width 1440px), có 3 tab:

1. **Thiết lập màu sắc**: radio Giao diện (**Màu sắc** = header nền brand / **Sáng** = header trắng) + dãy swatch **10 theme màu + Gradient**; bên dưới có **preview thu nhỏ toàn app** (header, sub-nav, sidebar, dashboard) đổi màu theo lựa chọn trước khi Lưu.
2. **Thiết lập hiển thị**: chọn mật độ dữ liệu — Trung bình (mặc định) / Compact / Rộng, mỗi lựa chọn có preview 3 hàng bảng đúng chiều cao thật (xem bảng density trong [`styles.md`](../styles.md)).
3. **Hình nền**: chọn wallpaper cho app (lưới thumbnail + lựa chọn "Không có"). Khi bật wallpaper, giao diện chuyển sang **hiệu ứng kính (glass)**: card/table nền `rgba(255,255,255,0.72–0.80)` + `backdrop-filter: blur(14–16px)` + viền `rgba(255,255,255,0.6)`; header trắng, sidebar, dialog vẫn **solid** để đảm bảo độ đọc; dropdown gần solid (`0.95`).

Footer dialog: Hủy (outline) + Lưu (primary) — chỉ áp dụng thay đổi khi bấm Lưu. Mọi lựa chọn lưu `localStorage` (`xds-theme`, `xds-header-mode`, `xds-density`, `xds-wallpaper`). Đổi theme runtime bằng thuộc tính `data-xds-theme="<tên>"` trên `<html>`.

## 3c. Màu thành phần trên header theo chế độ

| Thành phần | Header màu (brand) | Header sáng (light) |
|---|---|---|
| Icon Thiết lập | trắng | `--xds-icon-neutral` `#6B707A` |
| Tên app | trắng | `--xds-text` |
| Ô tìm kiếm | nền `white/20`, chữ/icon trắng mờ | nền `--xds-bg-disabled`, icon neutral |
| Avatar người dùng | nền trắng, chữ màu brand | giữ nguyên |

---

*Ghi chú: Các con số px ở mục "Kích thước chuẩn" là redline chính thức của XDS. Phần nào cần bổ sung spec, liên hệ đội thiết kế Xoăn.*
