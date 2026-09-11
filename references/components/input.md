# Input (Ô nhập liệu) — Xoăn Design System 2.0

> Nguồn: Input.pdf — export từ Figma XDS Web Components

Tài liệu này mô tả toàn bộ họ component Input của XDS để AI coding agent triển khai đúng thiết kế. Mọi giá trị px và mã màu hex bên dưới được đo trực tiếp từ dữ liệu vector trong file Figma export (không suy đoán). PDF không chứa chú thích đo đạc dạng chữ; những thông số không đọc được đã được lược bỏ thay vì phỏng đoán.

> **Cập nhật theo bộ demo chuẩn (07/2026):** chiều cao control giờ theo **mật độ hiển thị** (xem `styles.md` mục Density): input **36px** ở mật độ Trung bình (mặc định), 28px Compact, 40px Rộng — dùng token `--xds-input-height`, KHÔNG hard-code 32px. Các giá trị "32px" trong tài liệu này là bản Figma cũ, giữ nguyên để tham khảo tỷ lệ các phần tử con; button vẫn 32px ở mật độ Trung bình.

## 1. Mô tả & phạm vi

Input là nhóm ô nhập liệu dùng trong form và bảng dữ liệu. PDF định nghĩa các loại sau (cùng chung nền tảng khung ô nhập):

| Loại | Placeholder mẫu trong thiết kế | Đặc điểm riêng |
|---|---|---|
| Textbox | "Textbox" | Ô nhập text 1 dòng |
| Textarea | "Textare" | Nhiều dòng, có tay kéo resize ở góc phải-dưới |
| Number | "0" | Nhập số |
| Number stepper | "1" | Nút −/+ tăng giảm, hoặc mũi tên lên/xuống |
| Date picker | "DD/MM/YYYY" | Icon lịch bên phải |
| Time picker | "HH:MM" | Icon đồng hồ bên phải |
| DateTime picker | "DD/MM/YYYY HH:MM" | Icon lịch+đồng hồ bên phải |
| Combobox Single | "Combobox Single" | Chevron xuống bên phải, chọn 1 giá trị |
| Combobox Single Split | "Combobox Single Split" | Phần nhập + nút chevron tách riêng có vách ngăn |
| Combobox Multiple | "Combobox Multiple" | Chọn nhiều, hiển thị counter + tags |
| Combobox Multiple Split | "Combobox Multiple Split" | Như trên nhưng nút chevron tách riêng |
| Search | "Tìm kiếm" | Icon kính lúp bên trái, nút × xóa khi có nội dung |
| AI Search | "Tìm kiếm thông minh" | Viền gradient, icon kính lúp AI, badge "AI" bên phải |
| Rich text editor (toolbar) | — | Thanh công cụ định dạng văn bản (xem mục 9) |

## 2. Anatomy (giải phẫu)

Một ô nhập đầy đủ gồm:

1. **Label (nhãn)** — chữ màu `#10141B`, đặt phía trên hoặc bên trái ô nhập.
2. **Container (khung ô nhập)** — nền + viền 1px, bo góc.
3. **Placeholder** — chữ màu `#9DA2AC`.
4. **Value (giá trị đã nhập)** — chữ màu `#10141B`.
5. **Icon trái** (chỉ Search/AI Search) — kính lúp 14×14px, màu `#6B707A`.
6. **Icon phải** — tùy loại: chevron xuống (combobox, ~10×6px), lịch (date, ~12–14px), đồng hồ (time), nút xóa × (~10×10px khi có nội dung); màu `#6B707A`, khi disabled chuyển `#CED1D6`.
7. **Counter + Tags** (combobox multiple) — chip đếm số + các tag giá trị đã chọn (xem mục 7).
8. **Helper text** — dòng mô tả phụ dưới ô nhập, màu `#9DA2AC`, thẳng lề với text trong ô.
9. **Tooltip lỗi** — bong bóng đỏ hiển thị dưới ô khi có lỗi (xem mục 8).
10. **Caret (con trỏ nhập)** — vạch 1×16px màu `#245FDF` khi đang gõ.

## 3. Kích thước & spacing

Thiết kế thể hiện một chiều cao chuẩn duy nhất cho ô nhập 1 dòng:

| Thuộc tính | Giá trị |
|---|---|
| Chiều cao ô nhập (1 dòng) | **32px** |
| Chiều rộng mẫu trong spec | 240px (co giãn theo layout; bản full-width 400px) |
| Border | 1px |
| Corner radius | **8px** |
| Padding ngang (mép ô → text) | **12px** |
| Icon phải cách mép phải | ~10px |
| Search: icon trái cách mép trái ~9px, cách placeholder ~9px | icon 14×14px |
| Caret khi focus | 1×16px, `#245FDF` |
| Textarea mặc định | 240×76px (bản thấp 240×32px); tay kéo resize là 2 vạch chéo màu `#CED1D6` ở góc phải-dưới |
| Combobox Split: phần nhập | 208×32px |
| Combobox Split: nút chevron | 32×32px, tách bằng vách ngăn viền |
| Number stepper liền khối | nút − 32×32px, ô giá trị 40×32px, nút + 32×32px |

### Bố cục label

| Bố cục | Thông số |
|---|---|
| Label trên (dọc) | Khoảng cách label → ô nhập: **12px**; ô nhập chiếm full chiều rộng |
| Label trái (ngang) | Cột label rộng **208px** (từ mép trái label đến mép trái ô nhập); label căn giữa theo chiều cao ô |
| Helper text | Nằm dưới ô nhập, thẳng lề trái với text trong ô (lệch 12px so với mép ô) |

## 4. Typography

| Vai trò | Font | Cỡ | Màu |
|---|---|---|---|
| Label | Inter | 13px | `#10141B` |
| Value (text đã nhập) | Inter | 13px | `#10141B` |
| Placeholder | Inter | 13px | `#9DA2AC` |
| Helper text | Inter | 13px | `#9DA2AC` |
| Tag, counter, tooltip lỗi, badge "AI" | Inter | 12px | theo thành phần |

(Font Inter xác nhận từ dropdown font hiển thị trong toolbar rich text editor của chính file thiết kế.)

## 5. Trạng thái (states)

Lưới trạng thái trong PDF gồm 4 hàng cho mỗi biến thể: mặc định → hover/focus → đang nhập → disabled; cột placeholder và cột đã có giá trị.

| Trạng thái | Nền | Viền | Text | Ghi chú |
|---|---|---|---|---|
| Default | `#FFFFFF` | `#CED1D6` 1px | placeholder `#9DA2AC` / value `#10141B` | |
| Hover / Focus | `#FFFFFF` | `#245FDF` 1px | như trên | |
| Đang nhập (typing) | `#FFFFFF` | `#245FDF` 1px | value `#10141B` | Có caret 1×16px `#245FDF` |
| Disabled | `#F2F2F4` | `#CED1D6` 1px | `#9DA2AC` (value giữ `#10141B`) | Icon chuyển `#CED1D6` |
| Error | `#FFFFFF` | `#F04438` 1px | như default | Kèm tooltip đỏ (mục 8) |
| Readonly / View mode | trong suốt, không khung | chỉ đường gạch chân 2px `#E9EAEB` dưới text | value `#10141B` | Dạng hiển thị trong PDF: text + underline, không có viền bao |

### Biến thể nền xám (ghost / không viền)

Song song biến thể có viền, PDF thể hiện biến thể không viền nền xám nhạt (dùng trên nền trắng như thanh công cụ, bảng):

| Trạng thái | Nền |
|---|---|
| Default | `#FDFDFD` |
| Hover | `#FAFAFA` |
| Focus / đang nhập | `#FFFFFF` + viền `#245FDF` 1px |
| Disabled | `#F2F2F4` |

(Trang Search còn xuất hiện nền `#ECEDEF` cho mức nhấn đậm hơn của biến thể xám.)

### Biến thể trên nền đậm (on-dark)

Trang Search có nhóm mẫu dùng trên nền màu: icon, placeholder, caret và viền focus đều màu `#FFFFFF`.

## 6. Chi tiết theo từng loại

### Textbox / Number / Date / Time / DateTime
- Khung chuẩn mục 3–5. Number placeholder "0", giá trị căn trái.
- Date/Time/DateTime có icon tương ứng ở mép phải, màu `#6B707A`; disabled icon `#CED1D6`.

### Combobox Single
- Chevron xuống ~10×6px `#6B707A` ở mép phải; disabled chevron `#CED1D6`.

### Combobox Single/Multiple Split
- Phần nhập 208×32px + nút chevron 32×32px tách rời bằng vách ngăn (chung khối, viền liên tục).
- Khi focus, viền `#245FDF` bao cả hai phần.
- Có trạng thái hover riêng trên nút chevron (nền nút chuyển `#FAFAFA`).

### Combobox Multiple (thường và Split)
- Khi đã chọn nhiều giá trị, hiển thị: **counter chip** (số lượng, ví dụ "3") + các **tag**.
- Counter chip: 24×24px, nền `#F2F2F4`, viền 1px `#CED1D6`, chữ 12px `#10141B`; phía sau có hiệu ứng chồng lớp (vạch 8×24px màu `#E9EAEB`) gợi ý còn nhiều mục.
- Tag: cao 24px (rộng theo nội dung, mẫu 38px), nền `#F2F2F4`, viền 1px `#CED1D6`, chữ 12px `#10141B`, kèm icon × để xóa từng tag.
- Biến thể nhiều dòng: khung cao (mẫu ~80px trở lên), tags xếp từ góc trên-trái, chevron giữ ở góc trên-phải.

### Search (Tìm kiếm)
- Icon kính lúp 14×14px bên trái.
- Khi có nội dung: hiện nút × (10×10px, `#6B707A`) bên phải để xóa nhanh.
- Có đủ biến thể: viền, nền xám không viền, và on-dark (trắng).

### AI Search (Tìm kiếm thông minh)
- Kích thước khung như Search (cao 32px, radius 8px).
- **Viền gradient** chuyển sắc từ xanh dương sang tím/hồng (magenta) — theo hình; mã màu gradient không đọc được từ export nên không liệt kê, cần lấy token gradient AI từ thư viện XDS.
- Placeholder "Tìm kiếm thông minh" cũng đổ màu gradient xanh–tím; khi đã nhập, text thường `#10141B`.
- Icon kính lúp AI (kính lúp + tia sáng) bên trái, đổ gradient.
- Badge "AI" 16×16px ở mép phải (chữ "AI" 12px trên nền gradient nhạt).
- Khi có nội dung: badge AI thay bằng nút × và icon kết quả.
- Disabled: nền `#F2F2F4`, toàn bộ icon/chữ nhạt đi.

### Number stepper
- **Liền khối**: [−] 32×32px | ô giá trị 40×32px | [+] 32×32px, chung viền `#CED1D6`, vách ngăn giữa các phần; icon −/+ ~11px màu `#6B707A`; giá trị `#10141B` căn giữa.
- **Tách rời**: 3 khối riêng (−, giá trị, +) mỗi khối bo góc riêng, có khoảng cách.
- **Dạng dọc (compact)**: cặp mũi tên lên/xuống xếp chồng (2 nút chồng nhau hoặc 1 nút chứa 2 mũi tên) gắn cạnh ô nhập, rộng 32px.
- Hover/focus từng nút: viền nút chuyển `#245FDF`.
- Icon phụ trợ trong bộ: chevron phải/xuống (expand), ô +/− vuông nhỏ (tree expand/collapse), màu `#6B707A`.

## 7. Màu tổng hợp (đo từ file)

| Token gợi ý | Hex | Dùng cho |
|---|---|---|
| Border default | `#CED1D6` | Viền ô nhập, viền tag/counter, icon disabled |
| Border focus / primary | `#245FDF` | Viền hover/focus, caret, text link trạng thái active |
| Primary nhạt | `#68A6F2` | Trạng thái nhạt của text action (thấy ở trang text states) |
| Border/underline nhạt | `#E9EAEB` | Gạch chân readonly, lớp chồng counter |
| Error | `#F04438` | Viền lỗi, nền tooltip lỗi |
| Text chính | `#10141B` | Value, label |
| Text phụ / placeholder | `#9DA2AC` | Placeholder, helper, text disabled |
| Icon | `#6B707A` | Kính lúp, chevron, lịch, đồng hồ, −/+ |
| Nền disabled | `#F2F2F4` | Ô nhập disabled, nền tag |
| Nền ghost default | `#FDFDFD` | Biến thể không viền |
| Nền ghost hover | `#FAFAFA` | Biến thể không viền |
| Nền ghost nhấn đậm | `#ECEDEF` | Biến thể không viền (mức đậm) |
| Trắng | `#FFFFFF` | Nền ô nhập, chữ tooltip, biến thể on-dark |

## 8. Validate & hiển thị lỗi

- Ô lỗi: viền đổi sang `#F04438` 1px, nền giữ trắng, text giữ nguyên màu.
- **Tooltip lỗi**: bong bóng nền `#F04438`, bo góc, chữ trắng 12px, mũi tên tam giác (~16×7px) chỉ lên ô nhập; đặt **bên dưới ô nhập, lệch về phía cuối (bên phải)** của ô.
- Tooltip xuất hiện ở cả bố cục label-trái và label-trên; áp dụng cho mọi kích thước/chiều rộng ô.
- Label không đổi màu khi ô lỗi (vẫn `#10141B`).
- PDF không thể hiện dấu * bắt buộc (required) và không có trang Do/Don't — không quy định trong tài liệu này; tham chiếu guideline chung của XDS nếu cần.

## 9. Rich text editor toolbar (trang cuối PDF)

Thanh công cụ soạn thảo đi kèm nhóm Input, nền trắng, viền `#CED1D6`, bo góc, các nhóm nút phân tách bằng vách ngăn dọc. Các cấu hình từ đầy đủ đến rút gọn:

1. **Đầy đủ 2 hàng**: undo/redo | B, I, U, màu chữ | font (Inter) | cỡ chữ (− 12 +) | căn lề | danh sách số/bullet | indent/outdent | đính kèm, link, ảnh; hàng 2: chèn bảng, xóa bảng, thêm hàng, thêm/xóa hàng trên-dưới, thêm/xóa cột, gộp/tách ô, thuộc tính bảng.
2. **1 hàng rút gọn**: undo/redo | B, I, U, màu chữ | căn lề | danh sách | indent | link, ảnh.
3. **1 hàng có font + cỡ chữ**: như (1) nhưng không có hàng công cụ bảng.
4. **Dạng đầy đủ kiểu văn bản**: undo/redo | kiểu đoạn ("Đoạn văn") | font (Inter) | cỡ (8) | màu chữ, màu nền chữ | B, I, U, S | bút highlight | căn lề | giãn dòng | danh sách | indent | link, ảnh, bảng.
5. **Rút gọn có overflow**: undo/redo | kiểu đoạn | font | cỡ | màu | B, I, U, S | bút | nút ⋮ (menu tràn).

Nút đang bật (active) có nền xám nhạt bo góc (ví dụ nút B trong thiết kế).

## 10. Quy tắc triển khai nhanh (checklist cho agent)

- [ ] Chiều cao ô 1 dòng luôn 32px, radius 8px, viền 1px, padding ngang 12px, font Inter 13px.
- [ ] Placeholder `#9DA2AC`, value `#10141B`, viền `#CED1D6` → hover/focus `#245FDF`, disabled nền `#F2F2F4`.
- [ ] Label trên cách ô 12px; label trái dùng cột 208px.
- [ ] Lỗi: viền `#F04438` + tooltip đỏ chữ trắng dưới ô, mũi tên chỉ lên.
- [ ] Combobox multiple: counter chip 24×24 + tags cao 24px, mỗi tag có nút ×.
- [ ] Search có icon trái 14px và nút × khi có nội dung; AI Search dùng viền + chữ gradient (lấy token gradient từ thư viện, không hard-code).
- [ ] Readonly hiển thị dạng text + gạch chân `#E9EAEB`, không khung.
