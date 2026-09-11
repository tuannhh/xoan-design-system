# Tree (Cây phân cấp)

> Nguồn: Tree.pdf — export từ Figma XDS Web Components

## 1. Mô tả & mục đích sử dụng

Tree là component hiển thị dữ liệu dạng cây phân cấp (hierarchical list), cho phép người dùng duyệt và thao tác trên các nút (node) lồng nhau nhiều cấp — ví dụ điển hình trong PDF là cây thư mục kiểu File Explorer: `This PC → Pictures → Camera Roll → Saved Pictures`.

Dùng Tree khi:
- Cần thể hiện quan hệ cha–con nhiều cấp (thư mục, đơn vị/phòng ban, danh mục…).
- Người dùng cần mở rộng/thu gọn (expand/collapse) từng nhánh để khám phá dần dữ liệu.
- Có thể kết hợp checkbox để chọn nhiều node cùng lúc.

## 2. Anatomy / Cấu trúc

Mỗi dòng của Tree (Tree Item) gồm các phần tử sau, xếp ngang từ trái sang phải:

| # | Phần tử | Bắt buộc | Ghi chú |
|---|---------|----------|---------|
| 1 | **Expand/Collapse icon** (chevron) | Không | Chevron phải `>` khi node đang thu gọn (collapsed), chevron xuống `v` khi node đang mở rộng (expanded). Node lá (không có con) **không hiển thị chevron** nhưng vẫn giữ khoảng thụt lề tương ứng (xem ví dụ "Saved Pictures" trong PDF). |
| 2 | **Checkbox** | Không | Tùy chọn, đặt giữa chevron và nhãn; dùng cho trường hợp chọn nhiều node (trang 4 của PDF). |
| 3 | **Text / Title** (nhãn chính) | Có | Nhãn của node. |
| 4 | **Subtext / Subtitle** (nhãn phụ) | Không | Dòng mô tả phụ nằm ngay dưới nhãn chính, màu xám nhạt hơn (biến thể 2 dòng). |

Cấu trúc nội dung nhãn (trang 3 của PDF) có 2 dạng:
- **Title** — 1 dòng, chỉ có nhãn chính (đậm/đen).
- **Title + Subtitle** — 2 dòng: nhãn chính phía trên, nhãn phụ (Subtitle) màu xám phía dưới.

## 3. Biến thể (Variants)

PDF thể hiện ma trận biến thể theo 2 trục:

### 3.1. Theo màu nhãn
| Biến thể | Mô tả |
|----------|-------|
| **Default (text tối)** | Nhãn màu đen/tối — dạng chuẩn cho node thường. |
| **Accent (text xanh dương)** | Nhãn màu xanh dương (brand/link-style) — dùng để nhấn mạnh node (cột bên phải ở trang 1–2 của PDF). |

### 3.2. Theo số dòng nội dung
| Biến thể | Mô tả |
|----------|-------|
| **1 dòng (Text)** | Chỉ có nhãn chính. |
| **2 dòng (Text + Subtext)** | Nhãn chính + nhãn phụ màu xám nằm dưới. |

### 3.3. Theo thành phần kèm theo
| Biến thể | Mô tả |
|----------|-------|
| **Không checkbox** | Chevron + nhãn (trang 1, 2, 5). |
| **Có checkbox** | Chevron + checkbox + nhãn (trang 4). |

> Lưu ý: PDF không ghi rõ giá trị px cho chiều cao dòng, kích thước icon, font size — không suy đoán các giá trị này; khi triển khai hãy dùng token kích thước/typography mặc định của XDS.

## 4. Trạng thái (States)

Ma trận trạng thái (trang 2 của PDF) áp dụng cho cả biến thể text tối và text xanh, cả dạng 1 dòng và 2 dòng:

| Trạng thái | Nền (background) | Viền (border) | Nhãn |
|------------|------------------|---------------|------|
| **Default** | Trong suốt (không nền) | Không | Đen/tối (hoặc xanh dương với biến thể accent) |
| **Hover** | Xanh dương rất nhạt (light tint) | Không | Giữ nguyên màu nhãn |
| **Selected** | Xanh dương nhạt đậm hơn hover (solid light blue) | Không | Giữ nguyên màu nhãn |
| **Focused** | Nền như default | Viền xanh dương đậm, nét liền, bo quanh toàn bộ item (focus ring) | Giữ nguyên màu nhãn |
| **Disabled** | Trong suốt | Không | Nhãn và chevron chuyển xám nhạt/mờ (biến thể accent: xanh nhạt mờ); không nhận tương tác |
| **Expanded** | — | — | Chevron xoay xuống (`v`); các node con hiển thị bên dưới với thụt lề tăng 1 cấp |
| **Collapsed** | — | — | Chevron chỉ sang phải (`>`); node con bị ẩn |

Ở trạng thái 2 dòng, nền hover/selected và viền focus bao trọn cả 2 dòng (Text + Subtext); Subtext luôn giữ màu xám ở mọi trạng thái (trừ disabled thì mờ đi cùng nhãn chính).

> PDF là bản export hình ảnh, không kèm chú thích mã màu — **không có mã hex nào đọc được trực tiếp**. Khi triển khai, ánh xạ các trạng thái trên vào token màu chuẩn của XDS (nền hover nhạt, nền selected xanh nhạt, focus ring xanh brand, text disabled xám).

## 5. Thụt lề & căn chỉnh (Indentation & Alignment)

Trang 5 của PDF dùng các đường gióng đỏ/xanh lá để minh họa quy tắc căn chỉnh thụt lề:

- Mỗi cấp con thụt vào thêm **một bước thụt lề cố định** so với cấp cha.
- **Đúng (đường xanh lá):** nhãn của node con căn thẳng hàng theo mốc thụt lề của cấp tương ứng — node lá không có chevron vẫn phải chừa chỗ chevron để nhãn thẳng cột với các node cùng cấp (ví dụ "Saved Pictures", "Item 9").
- **Sai (đường đỏ):** nhãn node con căn lệch mốc — bắt đầu ở cột không đúng với cấp của nó (ví dụ minh họa "Camera Roll", "Item 8" gióng vào đường đỏ).
- Chevron của node con nằm thẳng cột với vị trí bắt đầu nhãn của node cha (chevron cấp n+1 gióng theo mốc text cấp n).

> PDF không ghi số px cụ thể cho bước thụt lề — dùng token spacing chuẩn của XDS.

## 6. Quy tắc sử dụng / Do & Don't

**Do:**
- Luôn hiển thị chevron cho node có con; đổi hướng chevron đúng theo trạng thái expanded/collapsed.
- Giữ thụt lề nhất quán theo cấp; node lá vẫn giữ khoảng trống thay cho chevron để các nhãn cùng cấp thẳng hàng.
- Dùng biến thể có checkbox khi cần chọn nhiều node.
- Dùng Subtext khi cần thông tin phụ ngắn gọn cho node (mô tả, số lượng…).
- Thể hiện đầy đủ các trạng thái hover / selected / focused / disabled như ma trận ở mục 4.

**Don't:**
- Không căn nhãn node con lệch khỏi mốc thụt lề của cấp (lỗi minh họa bằng đường đỏ ở trang 5).
- Không hiển thị chevron cho node lá.
- Không tự chế màu trạng thái ngoài token của XDS.
- Không cho phép tương tác (hover/click) trên item ở trạng thái disabled.
