# Icon

> Nguồn chuẩn: [XDS Web Components](https://www.figma.com/design/1DP5RJM3MsZJ8SnUWgTavS/XDS-Web-Components---v2.0?node-id=15074-40229) — trang Icons, đối chiếu trực tiếp ngày 10/07/2026.

Trạng thái component: **Đã phát hành** (Xoăn Design System — Tài liệu nội bộ Xoăn).

## 1. Mô tả & nguyên tắc

- Icon trong XDS là icon dạng vector, nguồn gốc từ bộ **Tabler Icons** (https://tabler.io/icons) hoặc tự vẽ theo quy tắc của XDS.
- Component hỗ trợ 2 style: **Outline** (mặc định, nét viền) và **Filled** (tô đặc). Chỉ bật Filled khi icon cụ thể có biến thể Filled chính thức trong Figma; không tự tô `fill` cho SVG outline.
- Icon được flatten thành 1 vector duy nhất trong Frame đúng kích thước, tên Frame = tên icon trên Tabler (ví dụ `a-b-2`).
- Figma là nguồn chuẩn về **tên, hình dạng và biến thể**. Thư mục `assets/icons/` là gói lõi đã xác minh để dùng trong code, không phải toàn bộ thư viện Figma.

## 2. Hai component sử dụng

Sử dụng 1 trong 2 component sau:

| Component | Hành vi | Kích thước hỗ trợ |
|---|---|---|
| **Icon Swap Resize** | Icon tự động resize theo mode Space; kích thước hiển thị có thể không chuẩn xác tuyệt đối theo Size đã chọn | 4 kích thước: **12, 16, 20, 24px** |
| **Icon Swap** | Icon hiển thị đúng chính xác kích thước đã chọn | Đầy đủ các kích thước từ **12 đến 48px** |

### Variants (props của component)

| Prop | Ý nghĩa |
|---|---|
| `Size` | Kích thước icon |
| `Color` | Màu ngữ nghĩa: Neutral, White, AI, Brand, Accent, Link, Info, Success, Warning, Danger |
| `Filled` | `No` = Outline, `Yes` = Filled |
| `Icon` | Lựa chọn icon cụ thể |

Instance `Icon Swap` đang thấy trong Figma có: `Size=16`, `Color=Brand`, `Filled=No`, `Icon=Icon Placeholder Desktop`; mode `Themes=Auto (Blue)`, `Space=Auto (Standard)`.

> Không dùng prop `Hierarchy`: prop này có trong bản PDF cũ nhưng không xuất hiện trên component hiện tại đã kiểm tra (node `6019:66853`).

## 3. Kích thước chuẩn (px)

Thang kích thước icon thể hiện trong bảng size của file (mỗi màu có đủ 2 style Outline/Filled ở từng size):

| Nhóm | Kích thước frame icon (px) |
|---|---|
| Icon Swap Resize | 12, 16, 20, 24 |
| Icon Swap (đầy đủ) | 12, 16, 20, 24, 28, 32, 36, 40, 44, 48 |

Ghi chú: glyph bên trong (ví dụ icon hình tròn) chiếm ~75% frame (glyph 18px trong frame 24px) — đúng theo lưới của Tabler Icons.

## 4. Màu sắc icon

Bảng dưới là giá trị màu quan sát được trong tài liệu cũ để đối chiếu. Khi code, luôn dùng token ngữ nghĩa/theme, không hard-code hex:

| Màu (tên gợi ý theo ngữ cảnh) | Hex | Ghi chú |
|---|---|---|
| Neutral (xám — mặc định/secondary) | `#6B707A` | Xám trung tính, dùng cho icon thường |
| Xám nhạt | `#8F949D` | Sắc độ xám nhạt hơn, xuất hiện trong bảng màu filled |
| Xanh dương chính (Primary/Brand) | `#245FDF` | Màu xanh chủ đạo |
| Xanh dương đậm | `#2753CE` | Biến thể đậm của xanh chính |
| Xanh dương sáng (Info) | `#2E90FA` | |
| Tím (Purple) | `#9E77ED` | |
| Cam (Warning) | `#F79009` | |
| Đỏ (Danger/Error) | `#F04438` | |
| Xanh lá (Success) | `#12B76A` | |
| Trắng | `#FFFFFF` | Dùng trên nền đậm/nền màu |
| Gradient tím–xanh | — | Biến thể gradient (AI), không đọc được mã màu chính xác từ file |

Enum `Color` hiện tại trong Figma là nguồn chuẩn; tên gợi ý trong bảng chỉ giúp đối chiếu mã màu của bản tài liệu cũ.

## 5. Phạm vi gói icon trong skill

- Trang Icons của Figma có hơn 40 nhóm cấp cao; tài liệu `icons-library.md` đang mô tả 43 nhóm.
- Riêng nhóm `System` có **375 icon** khi kiểm tra trực tiếp layer tree.
- `assets/icons/` hiện là **gói lõi 81 icon outline**, đã kiểm tra XML, `viewBox="0 0 24 24"`, `stroke=currentColor`, nét 1.5 và linecap/linejoin round.
- Gói lõi hiện chưa chứa file `*-filled.svg`. Vì vậy không dùng Filled trong code cho đến khi biến thể chính thức được xuất từ Figma và đưa vào bundle.
- Dùng `XIcon.vue` để render icon. Registry sinh từ SVG bằng `python3 scripts/build-icon-registry.py`; không chép path SVG vào từng component.

## 6. Icon trong container (nút icon / icon badge)

Trang cuối thể hiện icon đặt trong container vuông bo góc **32×32px**, glyph icon nhỏ bên trong (~14px), 3 kiểu:

### 6.1. Solid — nền đậm, icon trắng (`#FFFFFF`)

| Màu | Nền container |
|---|---|
| Xanh chính | `#245FDF` |
| Tím | `#9E77ED` |
| Xanh dương | `#1570EF` |
| Cam | `#F79009` |
| Đỏ | `#F04438` |
| Xanh lá | `#12B76A` |
| Xám | `#717680` |

### 6.2. Soft — nền nhạt, icon giữ màu chính

| Màu icon | Nền container | Icon |
|---|---|---|
| Xanh chính | `#DDEAFC` | `#245FDF` |
| Tím | `#EDE9FE` | `#9E77ED` |
| Xanh dương sáng | `#EFF8FF` | `#2E90FA` |
| Cam | `#FFFAEB` | `#F79009` |
| Đỏ | `#FEF3F2` | `#F04438` |
| Xanh lá | `#ECFDF3` | `#12B76A` |
| Xám | `#FAFAFA` | `#6B707A` |

### 6.3. Outline — nền trắng, viền màu nhạt, icon màu chính (container ~34px kể cả viền)

| Màu icon | Viền container | Icon |
|---|---|---|
| Xanh chính | `#68A6F2` | `#245FDF` |
| Tím | `#C4B5FD` | `#9E77ED` |
| Xanh dương sáng | `#53B1FD` | `#2E90FA` |
| Cam | `#FDBA74` | `#F79009` |
| Đỏ | `#F97066` | `#F04438` |
| Xanh lá | `#32D583` | `#12B76A` |
| Xám | `#CED1D6` | `#6B707A` |

## 7. Quy trình bổ sung icon

### Cho coding agent/developer

1. Tra `assets/icons/`, `icons-map.md` và tên chính xác trên trang Icons của Figma.
2. Nếu icon có trong Figma nhưng chưa có trong bundle, xuất/copy đúng vector từ Figma vào `assets/icons/<tên>.svg`; không thay bằng icon gần giống từ thư viện khác.
3. Chạy `python3 scripts/build-icon-registry.py`, cập nhật `icons-map.md`, rồi chạy lại với `--check`.
4. Nếu Figma thật sự không có icon cho chức năng mới, mới chọn Tabler outline gần nhất hoặc tự vẽ theo quy tắc XDS; phải được bổ sung vào Design System trước khi app dùng.
5. Không copy path vào `ICON_PATHS` cục bộ và không inline SVG trong component nghiệp vụ.

### Cho designer

Trường hợp chưa có icon trong DS thì có thể tự thêm icon mới:

1. Tìm icon trên https://tabler.io/icons hoặc tự vẽ theo quy tắc của XDS.
2. **Copy SVG** và paste vào Figma; copy tên icon trên web (nhấn vào tên) để đổi tên Frame theo đúng tên đó (ví dụ `a-b-2`).
3. Xóa layer khung bao bọc hình vuông (thường là layer cuối cùng), chọn tất cả layer trong Frame và **Flatten (Ctrl + E)** — lưu ý **không đổi tên layer**.
4. Bấm **Ctrl + Alt + K** để tạo thành Component (frame chuẩn 24×24).

## 8. Fix lỗi icon

- Một số icon bị lỗi **reset stroke và color về mặc định** do quá trình chuyển file.
- Cách khắc phục: **bật rồi tắt lại prop Filled** trong panel component — icon sẽ trở về trạng thái chuẩn.

## 9. Do / Don't (rút từ tài liệu)

| Do | Don't |
|---|---|
| Dùng `Icon Swap` khi cần kích thước hiển thị chính xác tuyệt đối | Không dùng `Icon Swap Resize` cho ngữ cảnh yêu cầu size chuẩn xác (nó resize theo Space, có thể lệch size) |
| Khi bật Filled, chọn icon có biến thể `*-filled` | Không bật Filled với icon chỉ có bản outline |
| Đặt tên Frame/Component đúng tên icon trên Tabler | Không đổi tên layer vector sau khi Flatten |
| Xóa layer khung vuông bao ngoài trước khi Flatten | Không giữ layer khung nền khi tạo component icon |
| Dùng `XIcon` và registry sinh từ SVG | Không duy trì map path riêng trong từng component |
