# Tab — Xoăn Design System (XDS)

> Nguồn: Tab.pdf — export từ Figma XDS Web Components

> **Lưu ý về nguồn:** File PDF là bản export dạng hình ảnh (visual spec), **không kèm chú thích số đo (px) hay mã màu (hex)**. Tài liệu này mô tả đầy đủ những gì nhìn thấy được: cấu trúc, biến thể, trạng thái và màu sắc ở mức định tính. Khi triển khai, PHẢI lấy giá trị token chính xác (màu, spacing, radius, typography) từ design tokens của XDS hoặc từ file Figma gốc — **không được tự bịa giá trị px/hex**.

## 1. Mô tả & mục đích sử dụng

Tab là component điều hướng dạng thanh ngang (hoặc danh sách dọc) cho phép người dùng chuyển đổi giữa các vùng nội dung ngang hàng trong cùng một ngữ cảnh/màn hình mà không rời trang. Tại một thời điểm chỉ có **một tab được chọn (selected)**; nội dung tương ứng với tab đó được hiển thị.

Dùng Tab khi:
- Cần phân nhóm nội dung cùng cấp trong một trang (ví dụ các phân hệ, các chế độ xem của cùng một đối tượng).
- Người dùng cần chuyển qua lại nhanh giữa các nhóm nội dung.

Không dùng Tab để:
- Điều hướng sang trang/ngữ cảnh khác hoàn toàn (dùng menu/navigation).
- Thể hiện các bước tuần tự (dùng Stepper/Wizard).

## 2. Anatomy / Cấu trúc

Một Tab group gồm:

| # | Phần tử | Mô tả |
|---|---------|-------|
| 1 | **Tab container (Tab bar)** | Vùng chứa các tab item, xếp ngang (horizontal) hoặc dọc (vertical). Có biến thể nền nhạt + đường kẻ dưới (track line) chạy suốt chiều rộng, hoặc biến thể "trần" chỉ gồm text. |
| 2 | **Tab item** | Đơn vị bấm được. Gồm: label + (tùy biến thể) nền, đường gạch chỉ báo, hoặc icon radio. |
| 3 | **Label** | Nhãn text của tab. Tab đang chọn: chữ xanh dương, đậm (semibold/bold). Tab không chọn: chữ đen/xám đậm, weight thường. |
| 4 | **Selected indicator** | Đường gạch ngang màu xanh dương đậm nằm sát cạnh dưới tab đang chọn (biến thể underline). Với biến thể vertical-list: thanh dọc màu xanh ở cạnh trái item đang chọn. |
| 5 | **Track line / divider** | Đường kẻ xám mảnh chạy dọc cạnh dưới toàn bộ tab bar (các tab không chọn nằm trên đường này); ở dạng vertical là đường kẻ dọc bên trái danh sách. |
| 6 | **Radio icon** (biến thể radio-tab) | Vòng tròn kiểu radio button đặt phía trên (hoặc bên trái) label; đổi màu theo trạng thái. |
| 7 | **Title** (heading đi kèm) | Text tiêu đề khu vực tab: trạng thái không active màu xám, trạng thái active màu đen gần như thuần và in đậm (trang 7 của PDF). |

## 3. Biến thể (Variants)

PDF thể hiện các biến thể sau (mỗi biến thể có đủ bộ trạng thái ở mục 4):

| Biến thể | Mô tả nhận dạng trong PDF |
|----------|---------------------------|
| **Underline tab (có container)** | Tab bar nền xám-xanh rất nhạt, tab item hình chữ nhật, tab đang chọn có gạch chân dày màu xanh dương đậm; các tab còn lại nằm trên track line xám mảnh. (Trang 1, 5) |
| **Text-only tab (không container)** | Chỉ gồm label xếp ngang, không nền, không track line; tab chọn = chữ xanh đậm. (Trang 1, 5) |
| **Square tab item** | Item góc vuông (hoặc radius rất nhỏ), có thể kèm underline indicator. (Trang 2, cột trái) |
| **Rounded / Pill tab item** | Item bo góc rõ rệt, không underline; trạng thái selected thể hiện bằng nền (nền xanh đậm chữ trắng, hoặc nền xanh nhạt chữ xanh). (Trang 2–3) |
| **Neutral (gray) tab item** | Bộ trạng thái dùng thang xám cho nền hover/pressed thay vì thang xanh. (Trang 3, 4) |
| **Full-width / block tab item** | Item chiếm trọn chiều rộng (dạng hàng trong danh sách), label căn trái. (Trang 4) |
| **Radio tab** | Icon vòng tròn radio + label bên dưới; có phiên bản trần và phiên bản có nền (xám nhạt / xanh nhạt / xanh đậm). (Trang 4, 6) |
| **Vertical tab list** | Danh sách tab xếp dọc; item đang chọn có nền trắng + thanh chỉ báo dọc màu xanh ở cạnh trái; các item khác nền nhạt, phân tách bằng đường kẻ mảnh; đường kẻ dọc xám chạy bên trái toàn danh sách. Có biến thể text-only dọc và radio-tab dọc. (Trang 6) |

### Kích thước (Sizes)

PDF thể hiện **2 cỡ** cho tab bar ngang (trang 1 = cỡ nhỏ hơn, trang 5 = cỡ lớn hơn — cùng cấu trúc, label và chiều cao item lớn hơn). Giá trị px cụ thể không được ghi trong bản export; lấy từ Figma/token khi triển khai. Tạm gọi:

| Size | Nhận dạng |
|------|-----------|
| Medium (mặc định) | Trang 1 |
| Large | Trang 5 — chữ và chiều cao item lớn hơn rõ rệt |

## 4. Trạng thái (States)

Mã hex không có trong bản export — mô tả màu ở mức định tính, map sang token XDS khi code.

### 4.1 Tab item thường (square / rounded)

| Trạng thái | Nền | Chữ | Ghi chú |
|------------|-----|-----|---------|
| Default (unselected) | Trắng / trong suốt | Đen/xám đậm | Có track line xám mảnh ở cạnh dưới (biến thể underline) |
| Hover | Xanh dương rất nhạt (biến thể blue) hoặc xám nhạt (biến thể neutral) | Đen/xám đậm | |
| Pressed / Active | Xanh dương nhạt đậm hơn hover (blue) hoặc xám đậm hơn (neutral) | Đen/xám đậm | |
| Focus | Nền trắng, **viền outline màu xanh dương đậm** bao quanh item | Đen/xám đậm | Viền focus rõ, bo theo góc item |
| Disabled | Trắng / trong suốt | Xám nhạt | Không tương tác |

### 4.2 Trạng thái Selected (tab đang chọn)

| Kiểu selected | Nền | Chữ | Indicator |
|---------------|-----|-----|-----------|
| Selected (underline) | Trắng / nền nhạt | Xanh dương đậm, đậm (semibold) | Gạch dưới dày màu xanh dương đậm |
| Selected disabled / dimmed (underline) | Trắng / nền nhạt | Xanh dương nhạt | Gạch dưới màu xanh nhạt |
| Selected + nền nhạt | Xanh dương rất nhạt | Xanh dương đậm | Có/không gạch dưới tùy biến thể |
| Selected filled | Xanh dương đậm | Trắng | Không gạch dưới |
| Selected filled disabled | Xanh dương trung bình/nhạt (muted) | Trắng/xanh rất nhạt | Không gạch dưới |
| Selected (vertical list) | Trắng | Xanh dương đậm | Thanh dọc xanh đậm ở cạnh trái item |
| Selected (text-only) | Không nền | Xanh dương đậm, đậm | Không |

### 4.3 Radio tab

| Trạng thái | Icon vòng tròn | Label | Nền |
|------------|----------------|-------|-----|
| Default | Viền xám | Đen | Không |
| Hover | Viền xám | Đen | Xám/xanh rất nhạt |
| Pressed | Viền xám | Đen | Xám đậm hơn |
| Focus | Viền xám | Đen | Trắng + outline xanh đậm |
| Disabled | Viền xám nhạt | Xám nhạt | Không |
| Selected | Viền xanh dương | Xanh dương | Không hoặc xanh rất nhạt |
| Selected filled | Viền trắng | Trắng | Xanh dương đậm |
| Selected filled dimmed | Viền trắng/nhạt | Trắng/nhạt | Xanh dương nhạt |

### 4.4 Title đi kèm tab (trang 7)

| Trạng thái | Màu chữ | Weight |
|------------|---------|--------|
| Inactive | Xám trung tính | Đậm vừa |
| Active | Đen gần thuần | Đậm (bold) |

## 5. Spacing, radius, typography

Bản export không in giá trị số; các đặc điểm quan sát được:

- **Corner radius:** biến thể square gần như vuông (radius rất nhỏ); biến thể rounded/pill bo góc rõ; biến thể filled selected bo góc đồng nhất với rounded. Focus ring bo theo radius của item.
- **Underline indicator:** dày hơn track line rõ rệt (track line ~1px mảnh, indicator dày hơn nhiều lần), chiều rộng bằng đúng chiều rộng tab item.
- **Typography:** cùng một font sans-serif của XDS; label tab selected dùng weight đậm hơn label thường; size Large dùng cỡ chữ lớn hơn Medium.
- **Layout ngang:** các tab item cao bằng nhau, label căn giữa item; chiều rộng item theo nội dung + padding ngang (trang 1) hoặc giãn đều (trang 1, hàng 3 — item rộng hơn, khoảng cách đều nhau).
- **Layout dọc:** item full-width, label căn trái, các item cao bằng nhau, phân tách bằng divider mảnh.

⚠️ Khi triển khai: đọc giá trị px/hex chính xác từ Figma (Dev Mode) hoặc file token XDS. Không hard-code màu ước lượng từ ảnh.

## 6. Quy tắc sử dụng / Do & Don't

**Do**
- Luôn có đúng một tab ở trạng thái selected khi tab group hiển thị.
- Giữ label ngắn gọn (1–2 từ), cùng cấp ngữ nghĩa giữa các tab.
- Dùng biến thể underline cho điều hướng nội dung chính; biến thể filled/pill cho bộ lọc hoặc segmented control thứ cấp.
- Dùng vertical tab list khi số lượng tab nhiều (PDF minh họa danh sách ~10 item) hoặc không gian ngang hạn chế.
- Giữ nguyên một size (Medium hoặc Large) trong cùng một tab group.

**Don't**
- Không trộn nhiều biến thể (underline + filled + radio) trong cùng một tab bar.
- Không dùng tab cho hành động (dùng Button) hoặc điều hướng rời trang (dùng Nav/Menu).
- Không tự chế màu trạng thái — dùng đúng thang xanh dương (primary) và thang xám (neutral) như các trạng thái ở mục 4.
- Không bỏ trạng thái focus (outline xanh) — bắt buộc cho khả năng truy cập bàn phím.
- Không disable tab đang selected trừ trường hợp toàn bộ group bị disable.

## 7. Gợi ý API khi hiện thực hóa (tham khảo)

- `variant`: `underline` | `text` | `pill` (filled) | `radio` — theo mục 3.
- `orientation`: `horizontal` | `vertical`.
- `size`: `medium` | `large`.
- `tone`: `primary` (blue) | `neutral` (gray) cho các trạng thái hover/pressed.
- Mỗi item: `selected`, `disabled`; hỗ trợ keyboard (Arrow trái/phải hoặc lên/xuống, Home/End) và ARIA (`role="tablist"`, `role="tab"`, `aria-selected`, `role="tabpanel"`).
