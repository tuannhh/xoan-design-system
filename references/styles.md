# Styles — Màu sắc, Kiểu chữ, Icons

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Màu sắc

Hệ màu XDS tổ chức 2 cấp:

### Nhóm Base — màu cấp 1 (khai báo giá trị trực tiếp)

| Bộ màu | Mục đích |
|---|---|
| Brand | Màu chính của app |
| Accent | Màu nhấn mạnh (ít sử dụng) |
| Info | Thông tin mang tính hướng dẫn |
| Warning | Thông báo cảnh báo |
| Danger | Hành động nguy hiểm: Xóa, hủy dữ liệu... |
| Success | Thông báo thành công |
| Neutral | Màu trung tính: text, border, background (thang số 50→950) |
| Alpha White | Trắng có opacity — đặt trên nền màu đậm |
| Alpha Black | Đen có opacity — đặt trên nền trắng |

- Base còn có: Black `#000000`, White `#FFFFFF`.
- **Các ứng dụng có thể tùy chỉnh màu nhóm Base theo app của mình** (thang màu sinh theo công cụ uicolors.app từ mã màu chính).

### 10 theme Brand chính thức (từ bộ Figma variables export)

Brand không phải 1 màu cố định mà là **theme chọn được** — 10 theme, mỗi theme có thang 50→900 + bộ Text/Icon/Stroke/Bg tương ứng, nằm sẵn ở `assets/tokens/themes/*.css`:

| Theme | Brand/600 (default) | Brand light (bg nhạt) |
|---|---|---|
| **Blue (mặc định)** | `#245FDF` | `#F0F6FE` |
| Indigo | `#4155F5` | `#ECF4FF` |
| Cyan | `#00A2CF` | `#F0FBFF` |
| Teal | `#0E9384` | `#F0FDFA` |
| Green | `#0E9A62` | `#E6F5EF` |
| Orange | `#EA580C` | `#FFF7ED` |
| Red | `#C34266` | `#FBF4F7` |
| Pink | `#C64691` | `#FCF3F9` |
| Purple | `#744EC7` | `#F7F5FD` |
| Blue gray | `#4E5BA6` | `#FCFCFD` |

Ngoài 10 theme màu, dialog Thiết lập màu sắc có thêm lựa chọn thứ 11: **Gradient** — dùng bộ token của theme Green nhưng header (chế độ màu) tô `linear-gradient(90deg, #245FDF 0%, #0FBF79 100%)`. Gradient chỉ áp cho nền header, không áp cho button/tag/link.

Ngoài Brand, mỗi bộ màu Base (Info/Warning/Danger/Success/Neutral) có thang 50→950 cố định — đầy đủ trong `assets/tokens/base-colors.css`. Trạng thái tương tác lấy theo bậc: Default 600, Hover 700, Pressed 800, Disabled 300-400, nền nhạt selected/hover 50-200.

### Nhóm cấp 2: Text / Icon / Stroke / Bg (chỉ tham chiếu, KHÔNG khai báo hex mới)

Nhóm này link tới biến nhóm Base — khi đổi màu Base, toàn bộ cấp 2 tự ăn theo. **Dự án không chỉnh màu trực tiếp ở cấp 2.**

Mapping nhóm Text (mẫu chuẩn):

| Biến Text | Tham chiếu |
|---|---|
| Primary Neutral | Base/Neutral/950 |
| Secondary Neutral | Base/Neutral/600 |
| Hint Neutral | Base/Neutral/400 |
| Disabled Neutral | Base/Neutral/400 |
| Brand / Link | Base/Brand/Default |
| Brand Disabled / Link Disabled | Base/Brand/Disabled |
| White | Base/White |
| White Disabled | Base/Alpha White/700 |
| Info | Base/Info/Default |

Mapping nhóm **Stroke** (viền/đường kẻ) — xác nhận từ giám đốc thiết kế: **stroke dùng chính thang màu Neutral phía trên**, không tạo hex riêng.

| Biến Stroke | Tham chiếu | Hex (theme mặc định) | Dùng cho |
|---|---|---|---|
| Stroke Neutral | Base/Neutral/400 | `#CED1D6` | Viền mặc định: input, button neutral, viền cột bảng |
| Stroke Neutral Light | Base/Neutral/300 | `#E9EAEB` | **Phân tách rất nhẹ** (border-bottom header/sub-nav, kẻ trong card, vạch ngăn) |
| Stroke Divider | Base/Neutral/300 | `#E9EAEB` | Đường divider ngang/dọc |
| Stroke Neutral Disable | Base/Neutral/200 | `#ECEDEF` | Viền phần tử disabled |
| Stroke Brand | Base/Brand/600 | `#245FDF` | Viền brand (input focus, button outline) |
| Stroke Brand Light | Base/Brand/300 | — | Viền nhạt brand (tag/badge brand) |
| Stroke {Info/Warning/Danger/Success} | Base/{…}/600 | — | Viền semantic |
| Stroke {…} Light | Base/{…}/300 | — | Viền nhạt semantic (tag/badge trạng thái) |
| Stroke {…} Disabled | Base/{…}/400 | — | Viền semantic disabled |

Quy tắc chọn: viền/đường kẻ mặc định dùng **Stroke Neutral (Neutral/400)**; khi cần phân tách **rất nhẹ** (trong card, dưới header, giữa các dòng) dùng biến **Light (Neutral/300)**. Không dùng Neutral/400 đậm cho các đường kẻ nội bộ tinh tế.

**Cách áp dụng khi code:** khai báo thang Base thành CSS variables (xem `assets/tokens.css`), các màu ngữ nghĩa (text, icon, border, bg) luôn trỏ về biến Base — không hard-code hex rải rác trong component.

> Lưu ý: `#245FDF` xuất hiện trong các spec component (input.md, icon.md) chính là **Brand/600 của theme Blue mặc định** — nhất quán với bộ variables. (Bảng minh họa trên trang tài liệu có ví dụ `#2563EB` nhưng bộ variables chính thức dùng thang Blue `#245FDF`.) Khi làm app mới: dùng theme Blue trừ khi người dùng chọn theme khác — xem quy trình chọn theme trong SKILL.md.

## Kiểu chữ

- **Font duy nhất: Inter** cho tất cả ứng dụng Xoăn (sans-serif tối ưu cho màn hình). Bản chuẩn hiện tại là **Inter Variable v4 self-hosted** (tên font-family `InterVariable`, giữ alias `'Inter var'` để tương thích ngược): `font-family: InterVariable, 'Inter var', sans-serif`, weight 100–900 trong 1 file woff2.
- Bật font features cho số liệu: `font-feature-settings: 'liga' 1, 'calt' 1, 'tnum' 1, 'lnum' 1` ở body (tabular numbers giúp cột số thẳng hàng); riêng ô số trong bảng dùng thêm `'tnum'`.
- **Kích thước tiêu chuẩn: 13px** — nếu không có lý do đặc biệt, toàn bộ text dùng size này.

### Text Styles (size/line-height, px)

| Style | Size/LH | Dùng cho |
|---|---|---|
| H1 — Banner Title | 24/36 | Tiêu đề lớn trên banner |
| H2 — App, Page Title | 20/28 | Tiêu đề app, tiêu đề page |
| H3 — Form, Card, Section, Group Title | 16/22 | Tiêu đề form, popup, dialog, section, group |
| Body Regular | 13/18–20 | **Mặc định cho mọi text** (token mới `--text-body-lh: 20px`; body element hiện dùng 18px) |
| Body Medium | 14/20 | Text nhấn nhẹ hơn body (tiêu đề card tính năng, tên bản ghi) |
| Body Large | 16/20 | Đoạn văn bản lớn, rich text, nội dung bài viết |
| Small | 12/16 | Chú thích, subtext, caption, ngày tháng phụ |

### Weight trong Body (khi nào dùng gì)

| Weight | Dùng cho |
|---|---|
| Regular | Label, dữ liệu trên bảng, mô tả — mọi dữ liệu thông thường |
| Medium | Chữ trong Button, Tag, Header của bảng, Navigation text |
| Semi Bold | Nội dung cần phân cấp mạnh hơn Medium (vd: Tên người) |
| Bold | Data number cần nhấn mạnh |

## Bo góc (Radius)

Thang radius chuẩn (từ bộ demo chuẩn của giám đốc thiết kế):

| Token | Giá trị | Dùng cho |
|---|---|---|
| `--radius-sm` | 4px | Chi tiết nhỏ: ô mini, tag nhỏ, focus ring trong cell |
| `--radius-inner` | 6px | Phần tử lồng trong card/control (logo box, thumbnail nhỏ) |
| `--radius-default` | 8px | **Mặc định**: button, input, card, dropdown item, badge trạng thái |
| `--radius-dialog` | 12px | Dialog, popover, menu ngữ cảnh, card lớn kiểu marketing |
| `--radius-pill` | 9999px | Badge tròn, pill, toggle |

## Đổ bóng (Shadow)

### ⭐ Box trắng trên nền xám — QUY TẮC BẮT BUỘC (cả team thống nhất)

Mọi **box/card trắng đặt trên nền xám** (`--bg-page #ECEDEF`) — dashboard card, KPI box, panel bảng, card tính năng... — PHẢI dùng đúng đoạn sau, KHÔNG dùng border thay thế:

```css
border-radius: 8px;
background: #FFF;
/* Drop Shadow/Neutral/All 2 */
box-shadow: 0 0 2px 0 var(--Alpha-Black-100, rgba(0, 0, 0, 0.10));
```

Đây là token `--shadow-card` (tên Figma: **Drop Shadow/Neutral/All 2**, màu = **Alpha-Black-100** `rgba(0,0,0,0.10)`): bóng mờ đều 4 phía, blur 2px, không offset, không spread — tạo cảm giác tách nền tinh tế mà không "nổi". Đây là chuẩn đã thống nhất toàn team, thay cho việc kẻ border 1px quanh box.

### Thang shadow đầy đủ

| Token | Giá trị | Dùng cho |
|---|---|---|
| `--shadow-card` | `0 0 2px 0 rgba(0,0,0,0.10)` | **Bắt buộc cho mọi box trắng trên nền xám** (card, KPI, panel bảng) |
| `--shadow-sm` | `0 1px 2px rgba(16,24,40,0.05)` | Nhấn rất nhẹ |
| `--shadow-md` | `0 4px 8px -2px rgba(16,24,40,0.10), 0 2px 4px -2px rgba(16,24,40,0.06)` | Hover card, preview |
| `--shadow-lg` | `0 12px 16px -4px rgba(16,24,40,0.08), 0 4px 6px -2px rgba(16,24,40,0.03)` | Overlay lớn |
| `--shadow-dialog` | `0 8px 24px rgba(16,24,40,0.15)` | Dialog/drawer |

Quy tắc: box trắng trên nền xám dùng `--shadow-card` (KHÔNG dùng md/lg, KHÔNG thay bằng border 1px). Shadow nổi (md/lg/dialog) chỉ dành cho lớp overlay (popup, dropdown, tooltip, toast, dialog, sidebar hover-expand). Border 1px `--stroke-neutral-light` chỉ dùng cho **phân tách nội bộ** (kẻ dòng, dưới header) — không dùng để "đóng khung" box trắng.

## Bảng màu biểu đồ (Chart palette)

Thứ tự series chuẩn trên biểu đồ ECharts:

| Token | Màu | Ý nghĩa |
|---|---|---|
| `--chart-c1` | `#245FDF` (hoặc brand của theme hiện tại) | Series chính |
| `--chart-c2` | `#12B76A` | Success/thu |
| `--chart-c3` | `#F79009` | Warning/chi |
| `--chart-c4` | `#F04438` | Danger |
| `--chart-c5` | `#0BA5EC` | Info/tồn |
| `--chart-c6` | `#7A5AF8` | Accent |

Series chính của biểu đồ nên lấy theo màu brand của theme đang chọn (đổi theme → biểu đồ đổi màu theo).

## Mật độ hiển thị (Density)

Người dùng chọn mật độ trong dialog "Thiết lập màu sắc và hiển thị" (tab Thiết lập hiển thị) — 3 mức, điều khiển bằng `data-density` trên `<html>`:

| Mức | Button height | Input height | Row 1 dòng của DataTable |
|---|---|---|---|
| Compact (`data-density="compact"`) | 28px | 28px | 32px |
| **Trung bình (mặc định)** | 32px | 36px | 36px |
| Rộng (`data-density="comfortable"`) | 36px | 40px | 40px |

Lưu ý: chỉ row **1 dòng** của bảng đổi theo density; row 2 dòng (56px) và 3 dòng (72px) **cố định**. Lựa chọn lưu vào `localStorage` (`xds-density`).

## Màu AI (tính năng AI)

- Text/stroke AI: `--text-ai` / `--stroke-ai` = `#1482FF`; nền nhạt `--bg-ai-light` = `rgba(20,130,255,0.06)`.
- **Button AI** dùng gradient riêng `linear-gradient(110deg, #1482FF 0%, #CF11FF 100%)` — 3 biến thể: solid (nền gradient, chữ trắng), outline (viền `#1482FF`, chữ gradient qua background-clip), text (chữ gradient, không viền). Chỉ dùng cho hành động gọi AI, không dùng thay nút Primary thường.

## Icons

- **Dạng stroke, nét 1.5px** (KHÔNG dùng nét 2px) — cho cả đường nét trong và ngoài; đầu nét tròn (rounded) hoặc phẳng (butt-cap). Nét 1.5px giúp giao diện thoáng, hợp với web app/dashboard nhiều dữ liệu.
- **Bộ demo chuẩn của giám đốc thiết kế dùng Tabler Icons (`@tabler/icons-vue`) với `stroke-width: 1.5`** làm nguồn icon, bọc trong component wrapper (span `.ti`, icon SVG kích thước `1em` theo font-size). Tên icon theo Tabler: `search`, `settings`, `bell`, `help-circle`, `dots-circle-horizontal`, `refresh`, `file-export`, `filter`, `chevron-*-pipe` (phân trang đầu/cuối)...
- Nguồn chuẩn về tên/hình dạng/variant là trang Icons trong Figma XDS; `assets/icons/` là gói lõi để code, không phải toàn bộ thư viện. Xem [components/icon.md](components/icon.md) và [components/icons-map.md](components/icons-map.md).
- **Kích thước Icon Swap:** 12 / 16 / 20 / 24 / 28 / 32 / 36 / 40 / 44 / 48px. Trong UI nghiệp vụ thường dùng 16/20/24/32px; kích thước icon nên khớp line-height của text đi kèm.
- **Vùng chạm:** icon tương tác đứng riêng lẻ cần vùng chạm tối thiểu **40px** trên Web desktop; với màn hình touch/coarse pointer dùng tối thiểu **48px** theo [patterns/mobile-pwa.md](patterns/mobile-pwa.md).
- **Radius:** viền ngoài bo 3px (icon chi tiết phức tạp: 2px).
- **Filled icon** chỉ dùng 2 trường hợp: (1) cặp filled/outline thể hiện trạng thái active/inactive; (2) icon đứng một mình trên nền phức tạp cần tương phản (vd: pin vị trí trên bản đồ).
- Màu icon theo ngữ cảnh và theme — dùng token, không tô màu tùy tiện.
