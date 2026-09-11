# Date time picker (XDS)

> Nguồn: Date time picker.pdf — export từ Figma XDS Web Components

## 1. Mô tả & mục đích

Bộ component chọn ngày/giờ của Xoăn Design System, gồm nhiều biến thể picker (ngày, tuần, quý, 6 tháng, năm, thập kỷ) và chế độ chọn khoảng ngày (date range) có sidebar preset. Tất cả picker hiển thị dưới dạng popup (panel nổi) với cùng một khung: nền trắng, bo góc 4px, đổ bóng, header điều hướng ở trên, lưới giá trị ở giữa, và nút tắt "nhảy nhanh" (Hôm nay / Tuần này / Quý này / Năm nay...) ở dưới, ngăn cách bằng divider.

## 2. Các biến thể picker

| Biến thể | Lưới nội dung | Nút tắt dưới cùng | Header hiển thị |
|---|---|---|---|
| **Date Picker** | Lưới 7 cột (T2→CN) × 6 hàng ngày | `Hôm nay` | Tháng + Năm (Month: true, Year: true) |
| **Week Picker** | Lưới ngày như Date Picker, chọn theo cả hàng tuần | `Tuần này` | Tháng + Năm |
| **Quarter Picker** | 4 ô: Quý 1, Quý 2, Quý 3, Quý 4 | `Quý này` | Chỉ Năm (Month: false, Year: true) |
| **6 Months Picker** | 2 ô: `6 Thg đầu năm`, `6 Thg cuối năm` | — | Chỉ Năm |
| **Year Picker** | Lưới 4×3 năm (VD: 2019–2030), header hiện dải `2020 - 2029` | `Năm nay` | Chỉ Năm |
| **Decade Picker** | Lưới 4×3 thập kỷ (VD: `1990–1999` … `2100–2109`) | — | Chỉ Năm (dải thập kỷ) |
| **Date Range Picker** | 2 panel tháng liền kề cạnh nhau (VD: Thg 6 2024 + Thg 7 2024), mỗi panel có header riêng | Nút `Đồng ý` (primary, góc phải dưới) | Tháng + Năm mỗi panel |

### Date Range Picker — sidebar preset

Bản đầy đủ có cột preset bên trái (ngăn với calendar bằng divider dọc), gồm các mục:

`7 ngày qua` · `30 ngày qua` · `Tuần này` · `Tuần trước` · `Tháng này` · `Tháng trước` · `Năm nay` · `Năm trước`

Chọn range xác nhận bằng nút **Đồng ý** (Button màu Brand) ở footer.

## 3. Anatomy (cấu trúc chung)

Cấu trúc các picker giống nhau (đánh số theo tài liệu Figma):

1. **Container (Date Picker / Week Picker / ...)** — khung popup
   - Background: `#FFFFFF`
   - Border radius: `4`
   - Drop shadow: token `Drop Shadow/Neutral/Bottom 8` = `0px 8px 16px 4px #000000` (kèm alpha của token)
2. **_Header Date Time** — header điều hướng tháng/năm
3. **Menu List Divider** — đường kẻ ngăn header với lưới
4. **_Date Name Item** — hàng tên thứ trong tuần (`T2 T3 T4 T5 T6 T7 CN`) — chỉ ở Date/Week Picker
5. **_Date / _Quarter / _6 Months / _Year / _Decade** — lưới ô giá trị (component `_Date Time Items`)
6. **Menu List Divider** — đường kẻ ngăn lưới với footer
7. **Button** (nút tắt "Hôm nay"/"Tuần này"/...) — dùng component Button: Size `Small`, Color `Brand`, Style `Text`, State `Default`, không icon

### 3.1 _Header Date Time

Thanh header gồm 7 phần tử, trái → phải:

| # | Phần tử | Component | Thuộc tính |
|---|---|---|---|
| 2 | `«` lùi năm | Button Icon | Size Small, Shape Square, Color Neutral, Style Icon |
| 3 | `‹` lùi tháng | Button Icon | như trên |
| 4 | Nhãn tháng (`Thg 6`) | Button | Size Small, Color Neutral, Style Text, không icon |
| 5 | Nhãn năm (`2024`) | Button | như trên |
| 6 | `›` tiến tháng | Button Icon | như trên |
| 7 | `»` tiến năm | Button Icon | như trên |

Thông số header:
- Width: `240px` (cố định — Horizontal resizing: Fixed)
- Background: `#FFFFFF`
- Layout: Horizontal, Alignment Middle center, Vertical resizing Hug
- Padding trái/phải: `8px`
- Cấu hình theo biến thể: `Month: true/false`, `Year: true` (picker quý/năm/thập kỷ ẩn nút tháng)

### 3.2 _Date Time Items (ô ngày/giá trị)

- Kích thước ô: **32 × 32 px** (Height 32, Width 32)
- Text align: Center

## 4. Trạng thái / kiểu ô (`_Date Time Items`)

### Property `Type`

| Type | Ý nghĩa | Style |
|---|---|---|
| **Current** (hôm nay) | Ngày hiện tại, chưa chọn | Border `1px #4262F0`, border radius `4`, text `#4262F0`, font `Body Medium/Medium` |
| **Another** | Ngày thường trong tháng | Text `#1F2229`, font `Body Medium/Regular`, không nền |
| **Another Parrent** | Ngày thuộc tháng trước/sau (ngoài tháng đang xem) | Text `#99A1B2`, font `Body Medium/Regular` |
| **Range** | Ngày nằm giữa khoảng đã chọn | Background `#E7EBFD`, border radius `0`, text `#1F2229`, font `Body Medium/Regular` |
| **Selected** | Ngày được chọn | Background `#4262F0`, text `#FFFFFF` |
| **Selected Range** | Ngày đầu/cuối của khoảng chọn | Background `#4262F0`, border radius `0` (phía tiếp giáp range), text `#FFFFFF` |

### Property `State`

| State | Style |
|---|---|
| **Default** | như Type tương ứng |
| **Hover** | Background `#E7EBFD` |

### Property `Position`

Ô trong range có biến thể Position (Default + các vị trí đầu/giữa/cuối hàng): ô đầu range bo góc trái, ô cuối range bo góc phải, ô giữa vuông (radius 0) — thể hiện qua bộ variant bo góc từng phía trong Figma.

### Ghi chú màu khác (đọc từ mockup)

- Tên thứ `CN` (Chủ nhật) hiển thị màu đỏ, các thứ còn lại màu chữ thường.
- Ngày ngoài tháng (Another Parrent) luôn xám `#99A1B2` kể cả khi nằm trong dải range.

## 5. Layout & spacing container

### Date Picker (container)

- Direction: Vertical, Alignment: Top center
- Vertical resizing: Hug, Horizontal resizing: Hug
- Padding top: `8px`, Padding bottom: `8px`
- Khoảng cách hiển thị giữa các khối (header/lưới/footer theo hình chú thích spacing): `8px`

### Khối "Today" (footer nút tắt)

- Direction: Vertical, Alignment: Middle center
- Vertical resizing: Hug, Horizontal resizing: **Fill**
- Padding left: `8px`, Padding right: `8px`
- Property Figma: `Today` là Boolean, mặc định `true`; layer liên quan: Menu List Divider + Button (tắt property này sẽ ẩn cả divider và nút)

## 6. Typography

| Vị trí | Text style |
|---|---|
| Ô ngày thường / range / ngoài tháng | `Body Medium/Regular` |
| Ô ngày hiện tại (Current) | `Body Medium/Medium` |
| Nút footer, nhãn tháng/năm ở header | Component Button size Small (style Text) |

## 7. Định dạng ngày giờ tiếng Việt

Quy ước hiển thị trong toàn bộ picker (theo mockup):

| Thành phần | Định dạng | Ví dụ |
|---|---|---|
| Nhãn tháng | `Thg <số tháng>` | `Thg 6`, `Thg 7` |
| Nhãn năm | 4 chữ số | `2024` |
| Tên thứ | `T2 T3 T4 T5 T6 T7 CN` (tuần bắt đầu **Thứ 2**, `CN` màu đỏ) | |
| Quý | `Quý 1` … `Quý 4` | |
| Nửa năm | `6 Thg đầu năm`, `6 Thg cuối năm` | |
| Dải năm/thập kỷ | `2020 - 2029` | |
| Nút tắt | `Hôm nay`, `Tuần này`, `Quý này`, `Năm nay` | |
| Preset range | `7 ngày qua`, `30 ngày qua`, `Tuần này`, `Tuần trước`, `Tháng này`, `Tháng trước`, `Năm nay`, `Năm trước` | |
| Nút xác nhận range | `Đồng ý` | |

## 8. Quy tắc sử dụng / hành vi

- **Lưới ngày luôn đủ 6 hàng × 7 cột**; các ngày thuộc tháng trước/sau được hiển thị mờ (`#99A1B2`) để lấp đầy lưới, vẫn click được để nhảy tháng.
- **Ngày hôm nay** luôn được đánh dấu bằng viền `#4262F0` (không tô nền) — phân biệt với ngày **được chọn** (nền `#4262F0`, chữ trắng).
- **Week Picker**: hover/chọn áp dụng cho cả hàng tuần (highlight nguyên hàng), không chọn ngày lẻ.
- **Date Range**: ngày đầu và cuối dùng style Selected (nền `#4262F0`), các ngày giữa dùng nền `#E7EBFD`; các ô giữa range không bo góc để tạo dải liền; đầu/cuối dải bo góc phía ngoài.
- **Range Picker hiển thị 2 tháng liền kề**, mỗi panel có header điều hướng riêng; chọn xong bấm `Đồng ý` mới áp dụng.
- Nút tắt footer (`Hôm nay`...) là Button Text màu Brand — chọn nhanh giá trị hiện tại; có thể ẩn qua property `Today = false`.
- Header dùng đúng component `Button` / `Button Icon` của hệ thống (Size Small, Color Neutral) — không tự vẽ nút riêng; click nhãn tháng/năm để chuyển sang picker cấp cao hơn (tháng → năm → thập kỷ).
- Drill-down giữa các cấp: Date ↔ Year ↔ Decade dùng chung khung container và `_Header Date Time`, chỉ thay lưới nội dung.

## 9. Token màu tổng hợp

| Token/giá trị | Dùng cho |
|---|---|
| `#FFFFFF` | Nền popup, nền header, chữ trên ô selected |
| `#4262F0` | Brand/primary: viền + chữ ngày hôm nay, nền ngày được chọn, nút Đồng ý |
| `#E7EBFD` | Nền hover và nền dải range |
| `#1F2229` | Chữ ngày thường |
| `#99A1B2` | Chữ ngày ngoài tháng đang xem |
| `Drop Shadow/Neutral/Bottom 8` (`0px 8px 16px 4px`, gốc `#000000`) | Bóng đổ popup |

## Quy tắc sử dụng (từ trang quy chuẩn chung)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

### Mục đích

DateTime Picker giúp người dùng nhập hoặc chọn ngày, giờ một cách trực quan, chính xác, giảm nhầm lẫn định dạng và tăng hiệu quả nhập liệu.

Chi tiết component gồm 2 phần: **ô input nhập liệu** và **popover xổ ra**.

### Quy tắc chung khi sử dụng

- Bấm vào các link **Hôm nay**, **Bây giờ** trên popover sẽ chuyển về ngày và giờ hiện tại tương ứng.
- Các popover có nút **Đồng ý** thì sau khi chọn xong phải bấm Đồng ý mới submit thông tin và đóng popover; các loại **không có** nút Đồng ý thì khi chọn giá trị sẽ tự động submit và đóng popover luôn.

### Các loại control

#### Control chọn Date

- Sử dụng để chọn hoặc nhập ngày tháng theo định dạng thông thường **Ngày/Tháng/Năm**. Ví dụ ngày tháng năm sinh: `20/01/2000`.
- Có trạng thái riêng khi **focus** vào ô nhập liệu.

#### Control chọn Date và Time

- Sử dụng khi cần chọn cả ngày và giờ. Ví dụ: đặt lịch họp cần chính xác cả ngày lẫn giờ.

#### Control chọn Date Range

- **Dạng đơn giản**: dùng khi ít có nhu cầu chọn khoảng cố định.
- **Dạng nâng cao**: có tiện ích chọn các khoảng cố định (preset), phù hợp cho các báo cáo.

#### Chọn Date Range có cả ngày và giờ

Quy trình chọn: chọn xong ngày và giờ **bắt đầu** → bấm **Đồng ý** → nhảy sang chọn ngày giờ **kết thúc** → bấm **Đồng ý** lần nữa → submit thông tin xuống.

1. Chọn ngày bắt đầu
2. Chọn ngày kết thúc

#### Control chỉ chọn giờ

- Phù hợp khi chỉ cần nhập/thay đổi giờ trong một ngày — không cần quan tâm tới ngày cụ thể, hoặc ngày đã được xác định từ trước.
- Các biến thể:
  - Chọn đầy đủ **giờ, phút, giây**
  - Chọn chỉ **giờ và phút**

#### Control chỉ chọn tháng và năm

- Dùng khi chỉ cần xác định thời điểm theo **kỳ tháng** (không quan tâm đến ngày cụ thể).
