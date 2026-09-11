# Bố cục màn hình — Xoăn Platform

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (liên hệ đội thiết kế Xoăn)

Ứng dụng trong Xoăn Platform có 4 loại màn hình chính. Xác định loại màn hình trước, rồi chọn biến thể phù hợp với nghiệp vụ theo hướng dẫn "Phù hợp khi" của từng biến thể.

## 0. Khung ứng dụng chuẩn (App Shell)

Mọi màn hình đều nằm trong khung sau (kích thước đo từ bộ demo chuẩn của giám đốc thiết kế):

```
┌──────────────────────────────────────────────┐
│ Global Header — 48px (nền brand hoặc trắng)  │
├────────┬─────────────────────────────────────┤
│Sidebar │ Sub-nav tabs — 48px (nền trắng)     │
│200px   ├─────────────────────────────────────┤
│(mở)    │ Page header — 56px (màn List/Detail)│
│64px    ├─────────────────────────────────────┤
│(thu    │ Content — nền xám #ECEDEF,          │
│ gọn)   │ padding 16px, gap giữa card 16px    │
└────────┴─────────────────────────────────────┘
```

- Shell dùng `100vw × 100vh`, `overflow: hidden`; chỉ vùng content cuộn (`overflow-y: auto`).
- **Global Header 48px** (`--layout-header-h`), **Sidebar mở rộng 200px / thu gọn 64px** (`--layout-sidebar-w` / `--layout-sidebar-sm-w`), **Page header 56px** (`--layout-page-header-h`).
- **Sub-nav tabs** (hàng tab ngay dưới header, vd "Tổng quan / Tính năng mới"): cao 48px, nền trắng, border-bottom 1px; tab active có gạch chân 2px màu brand + chữ brand semibold; tab có thể kèm icon 15px và badge "mới". Góc phải sub-nav có thể đặt hành động phụ (vd nút ghost "Bắt đầu sử dụng").
- Nền trang (vùng content) là `--bg-page: #ECEDEF`.

## 1. Màn hình Tổng quan (Dashboard)

- Cho phép tạo **nhiều giao diện** chứa các loại biểu đồ khác nhau.
- Hỗ trợ **kéo thả vị trí và điều chỉnh độ rộng** của từng widget/biểu đồ.
- Nút **Lưu/Hủy thống nhất ở cuối trang** khi ở chế độ tùy chỉnh.
- **Card/box trên dashboard (và MỌI box trắng trên nền xám): BẮT BUỘC dùng đúng đoạn sau** (chuẩn thống nhất toàn team — KHÔNG dùng border 1px để đóng khung):

  ```css
  border-radius: 8px;
  background: #FFF;
  /* Drop Shadow/Neutral/All 2 */
  box-shadow: 0 0 2px 0 var(--Alpha-Black-100, rgba(0, 0, 0, 0.10));
  ```

  Đây là token `--shadow-card`: bóng mờ đều 4 phía, không offset, tạo cảm giác tách nền tinh tế. KHÔNG dùng drop shadow nổi (md/lg) cho card thường; shadow nổi chỉ dành cho overlay (popup, dropdown, tooltip, toast, dialog/drawer). Border 1px `--stroke-neutral-light` chỉ dùng cho phân tách nội bộ (kẻ dòng, dưới header), không dùng để viền quanh box.
- Padding card 16px; khoảng cách giữa các card 16px, đều nhau. Hàng card dùng grid (`repeat(2..4, 1fr)` hoặc tỷ lệ tùy chỉnh như `1.7fr 1fr 1fr`).

### Cấu trúc card dashboard chuẩn

- **Tiêu đề card**: H3 16px semibold, dàn ngang — trái là tiêu đề, phải là cụm thao tác.
- **Cụm thao tác góc phải card**: icon button nhỏ (refresh, settings) **ẩn mặc định, chỉ hiện khi hover vào card**; kèm **select kỳ báo cáo không viền** ("Tháng này/Quý này/Năm nay") chữ 12px màu secondary.
- **Dòng đơn vị tính**: "Đvt: Triệu đồng" 11px secondary, căn phải, ngay dưới tiêu đề.
- **Số liệu KPI**: số chính 22–28px bold + đơn vị 14px semibold màu secondary đặt cạnh (baseline); nhãn phân loại 11px UPPERCASE màu secondary ("TỔNG", "DOANH THU"...).
- **Bảng mini trong card** (top mặt hàng...): row 32px, chữ 12px, header 12px semibold secondary, kẻ ngang 1px `--stroke-neutral-light`, chấm màu 8px trước tên, cột số căn phải semibold; dưới bảng có link "Xem thêm".
- **Chân card**: "Số liệu tính đến: {giờ} {ngày}" 11px secondary + link "Tải lại" màu brand, ngăn với thân card bằng border-top 1px.
- Trên cùng vùng content có thể có **thanh lọc chi nhánh** (label "Chi nhánh" + nút chọn text kèm chevron), không phải dropdown viền.

### Quy ước biểu đồ trong card (ECharts)

- Series chính lấy màu brand theme hiện tại; series phụ theo bảng chart palette trong `styles.md`.
- Bar: `barMaxWidth: 12`, bo đỉnh `borderRadius: [4,4,0,0]`. Line: width 2, `smooth: true`, symbol circle 4. Area: gradient từ brand 27% alpha → trong suốt.
- Trục: nhãn 11px màu `#717680`, đường lưới ngang `#F0F2F4`, trục `#E9EAEB`; giá trị lớn rút gọn dạng `399k`.
- Chú giải (legend) đặt dưới biểu đồ, chữ 11px UPPERCASE secondary, chấm màu 8px (tròn cho line/donut, vuông cho bar).
- Trên biểu đồ cột/đường có thể đặt **hàng 3 số tổng** (18px bold + nhãn 11px uppercase) ngay trên vùng vẽ.
- Nhãn trục X tự xoay 30° khi card hẹp (<640px).

## 2. Màn hình Danh sách (List)

### Đặc điểm chung — áp dụng cho mọi biến thể

- **Nền xám**, có khoảng cách giữa bảng và lề xung quanh (bảng không dính sát mép màn hình) — padding 16px, panel bảng nền trắng bo góc 8px.
- **Bấm vào dòng** để chuyển sang trang chi tiết hoặc mở popup chi tiết (hoặc mở panel Detail dưới với biến thể Master trên–Detail dưới).
- Trên panel bảng có thể có **hàng KPI** (3 thẻ chỉ số thu/chi/tồn quỹ...) thu gọn được — spec chi tiết toolbar, KPI, phân trang, resize cột... xem `patterns/data-table.md` mục 13.

### Quy tắc sắp xếp Toolbar (bắt buộc)

- **Bên trái:** tiêu đề bảng.
- **Bên phải:** các chức năng thao tác.
- **Nút chính (Primary): luôn đặt ở vị trí ngoài cùng bên phải.**
- Nút phụ: bên trái nút chính.
- Nút "More" (⋯): **ngay bên phải nút chính**.

### 6 biến thể danh sách — cách chọn

**1. Danh sách có tab**
Mỗi tab là một danh sách khác nhau với nội dung riêng biệt.
*Phù hợp khi:* dữ liệu chia thành các nhóm/trạng thái rõ rệt cùng cấu trúc thao tác.

**2. Master-Detail (Master rộng, Detail nhỏ)**
Master hiển thị bảng nhiều trường; Detail là panel nhỏ hiển thị tóm tắt/preview.
*Phù hợp khi:* quản lý khối lượng lớn bản ghi, thao tác liên tục trên nhiều mục.

**3. Master-Detail (Master nhỏ, Detail rộng)**
Master chỉ hiện thông tin tóm tắt (tên, mã, tiêu đề, trạng thái); Detail rộng chứa nội dung chi tiết phong phú, có thể gồm nhiều trường và bảng phụ.
*Phù hợp khi:* người dùng chọn nhanh một mục rồi làm việc sâu trên từng bản ghi (kiểu email client, chat, hồ sơ).

**4. Master trên, Detail dưới**
Master phía trên dạng bảng/danh sách lớn; Detail phía dưới với tab hoặc vùng mở rộng theo dòng đang chọn.
*Phù hợp khi:* làm việc trên desktop màn rộng, cần so sánh/cập nhật liên tục, dashboard nghiệp vụ, quy trình phức tạp.

**5. Master trái, Detail Drawer phải**
Detail trượt ra dạng drawer **che đè lên** danh sách; có thể co kéo độ rộng; vẫn bấm được dòng bên trái khi drawer đang mở.
*Phù hợp khi:* độ rộng phần chi tiết cần linh hoạt, người dùng muốn xem nhanh nội dung từng mục mà không rời danh sách.

**6. Danh sách Card**
Sắp xếp hiện đại, bố cục trực quan; mỗi card hiển thị linh hoạt: mô tả, tag, trạng thái, hình ảnh, nút thao tác.
*Phù hợp khi:* cần làm nổi bật từng mục (task, ticket, sản phẩm), thao tác trực tiếp nhanh trên từng mục, hoặc tối ưu cho mobile.

## 3. Màn hình Thêm/Sửa (Add/Edit)

**Nguyên tắc chung: nút Lưu và Hủy luôn ghim (sticky) ở vị trí cuối cùng của trang** — không trôi mất khi cuộn.

Ba biến thể theo lượng thông tin:

| Biến thể | Dùng khi |
|---|---|
| **Dạng Page** (trang riêng) | Thêm dữ liệu không quá nhiều trường |
| **Popup nhỏ** | Danh mục, thông tin ít và đơn giản |
| **Popup full màn hình** | Rất nhiều thông tin, cần tối ưu không gian |

## 4. Màn hình Chi tiết (Detail)

### Tách riêng mode xem (view mode ≠ edit mode)

Dùng cho giao diện phức tạp:

- Form Thêm/Sửa thường chỉ cập nhật thông tin cơ bản; màn Chi tiết có thể cập nhật nhiều thông tin khác.
- **Luôn ghim các nút thao tác với bản ghi ở góc trên, bên phải.**
- **Hover vào từng trường cho phép chỉnh sửa riêng lẻ** (inline edit) đối với các trường hỗ trợ.

Biến thể:
- **Dạng Page:** nhiều tab chia nhóm thông tin khác nhau.
- **Dạng Popup** (ít hoặc nhiều thông tin): tùy nhu cầu.

### Không tách mode xem

Xem và sửa đồng thời trên cùng giao diện — chỉ dùng cho **form đơn giản, rủi ro thấp**.

## Quy tắc hiển thị nút (áp dụng toàn hệ thống)

> "Nút More luôn nằm phía bên phải của nút Primary, và 2 nút này luôn nằm phía ngoài cùng bên phải của form."

Thứ tự từ trái sang phải trên toolbar/form: `[các nút phụ] [nút Primary] [nút More ⋯]` — cụm này căn phải.
