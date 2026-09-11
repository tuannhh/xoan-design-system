# Quy chuẩn UI Xoăn Design System (XDS)

> File này dành cho các coding agent đọc chuẩn AGENTS.md (Cursor, Antigravity, Codex, GitHub Copilot, Zed...).
> Người dùng Claude Code dùng bản SKILL.md cùng thư mục (nội dung tương đương).

Mọi giao diện (UI) tạo ra cho ứng dụng Xoăn **bắt buộc** tuân theo quy chuẩn dưới đây. Mục tiêu: người dùng mở bất kỳ app nào cũng thấy quen thuộc — cùng bố cục, cùng vị trí nút, cùng hành vi.

> **Trước khi làm bất kỳ việc gì trong repo này**, đọc [MEMORY.md](MEMORY.md) — bối cảnh dự án, quyết định đã chốt, bẫy đã gặp. Có quyết định lớn mới thì cập nhật lại MEMORY.md.

## Quy trình khi làm UI

1. Xác định loại màn hình: **Tổng quan (dashboard) / Danh sách / Thêm-Sửa / Chi tiết**.
2. Đọc file quy chuẩn tương ứng trong thư mục `references/` (cùng thư mục với file này):
   - `references/layout-patterns.md` — bố cục 4 loại màn hình, chọn biến thể. **Luôn đọc khi dựng màn hình mới.**
   - `references/styles.md` — hệ màu 2 cấp, thang Brand, Text Styles (Inter 13px), icon stroke 1.5px.
   - `references/patterns/` — data-table.md (chọn dòng, phân trang, lọc, sắp xếp), header-bar.md, sidebar.md, popup-form.md.
   - `references/patterns/mobile-native-app.md` — cho app mobile nhúng trong native host / super-app; `mobile-pwa.md` cho web mobile độc lập.
   - `references/general-design-rules.md` + `references/usability-requirements.md` — nguyên tắc nền tảng, yêu cầu tiện dụng (Tab order, SelectAll khi focus...).
   - `references/communication.md` — thông báo/toast, dialog, loading, empty state, error page, biểu đồ.
   - `references/components.md` → spec chi tiết trong `references/components/` (button, text-field, dropdown, combobox, checkbox, radio-button, date-time-picker, context-menu, tab, tree, input, icon...).
   - `references/conventions.md` — phím tắt, chính tả, định dạng số VN, tiêu đề trình duyệt, icon dùng chung, bản quyền.
3. Trước khi bàn giao, đối chiếu **Checklist** cuối file này.

## Quy tắc cốt lõi (áp dụng cho MỌI màn hình)

- **Nút Primary luôn ở ngoài cùng bên phải** của toolbar/form. Nút phụ nằm bên trái nút Primary. Nút "More" (⋯) nằm ngay bên phải nút Primary — cụm `[nút phụ] [Primary] [More]` luôn căn phải.
- **Màn hình Thêm/Sửa: nút Lưu và Hủy luôn ghim (sticky) ở cuối trang/form.**
- **Màn hình Chi tiết: các nút thao tác với bản ghi ghim ở góc trên bên phải.**
- **Màn hình Danh sách: nền xám**, bảng cách lề xung quanh; tiêu đề bảng bên trái toolbar, chức năng thao tác bên phải; click dòng mở chi tiết.
- **Mọi thao tác phải có phản hồi**: disable button hoặc busy indicator sau khi click; xử lý > 5 giây phải có progress bar.
- **Lỗi nhập liệu**: cảnh báo tiếng Việt dễ hiểu, tự động focus trường lỗi đầu tiên.
- **Icon và phím tắt của cùng chức năng phải đồng nhất** toàn ứng dụng; phím tắt có tooltip.
- **Icon: dùng Tabler Icons stroke 1.5px** qua wrapper `XIcon.vue`, không inline SVG/map path riêng, không trộn nhiều thư viện.
- **Màu sắc, font, kích thước: dùng token trong `assets/tokens.css`** — không hard-code mã hex.
- **Header Xoăn tối giản**: chỉ **logo + tên app + ô tìm kiếm + nút Thiết lập + avatar người dùng**. Cụm bên phải CHỈ có Thiết lập và Avatar — không có nút 9 chấm chuyển app, không trợ lý AI, không tin nhắn/thông báo/trợ giúp/khác, không badge năm dữ liệu hay nút chọn công ty. Xem `references/patterns/header-bar.md`.
- Trường nhập liệu: có giá trị mặc định hợp lý, thứ tự theo thói quen tác nghiệp, tự động điền khi có thể.
- **Mobile nhúng trong native host**: không dựng lại status bar, launcher, bottom nav hệ sinh thái, avatar/thông báo của host; dùng app top bar Back 56px, touch/input 48px, app-level bottom nav 3–5 mục và giữ mọi button/tab/nav label một dòng.

## Chọn tone màu (theme) cho ứng dụng

XDS có **10 theme chính thức** trong `assets/tokens/themes/` (blue — mặc định `#245FDF`, indigo, cyan, teal, green, orange, red, pink, purple, blue-gray). Khi người dùng muốn chọn/đổi tone màu: mở `assets/theme-preview.html` cho họ xem và chọn, rồi import file theme tương ứng (kèm `base-colors.css`, `number.css`, `font.css`, `space-standard.css`). Đổi theme runtime bằng `data-xds-theme="<tên>"`. KHÔNG tự pha màu ngoài 10 theme này.

## Sinh FE trực tiếp bằng bộ XDS UI

Repo kèm bộ control Vue 3 + Tailwind viết sẵn ở `ui/components/` (**31 control**, prefix `X`) và **5 màn hình mẫu desktop + 4 màn hình native mobile** ở `ui/templates/`. Khi dựng màn hình: **clone template tương ứng làm khung** (root dùng `h-full`, mount trong container 100vh), **bắt buộc dùng control có sẵn, cấm viết HTML thô thay thế** — tra `assets/component-map.json`; copy file `.vue` cần dùng vào project + import tokens (xem `ui/README.md`, XChart cần `npm i echarts`); đổ mock data tiếng Việt giống thật; control chưa có thì dựng theo spec `references/` bằng token và ghi TODO. Với mobile, phải đọc `mobile-native-app.md` + `mobile-compatibility.md`, duyệt đủ profile 320/360/390/430/768px và không bàn giao khi text/chart/shape còn va chạm.

## Chọn control nhập liệu theo số lượng lựa chọn

| Số lựa chọn | Control |
|---|---|
| 2–3 | Radio button / Checkbox |
| 4–8 | Dropdown |
| > 8 | Combo box (AutoComplete + LoadOnDemand, thao tác được hoàn toàn bằng bàn phím, cho thêm nhanh danh mục) |

## Checklist trước khi bàn giao UI

- [ ] Đúng bố cục loại màn hình theo `references/layout-patterns.md` (đúng biến thể phù hợp nghiệp vụ)
- [ ] Nút Primary ngoài cùng bên phải; More bên phải Primary
- [ ] Form Thêm/Sửa: Lưu/Hủy ghim cuối trang; màn Chi tiết: nút thao tác ghim góc trên phải
- [ ] Control nhập liệu đúng theo số lựa chọn (radio/dropdown/combo)
- [ ] Trường nhập có giá trị mặc định hợp lý; thứ tự theo tác nghiệp
- [ ] Button có loading/disabled sau click; tác vụ > 5s có progress
- [ ] Lỗi tiếng Việt dễ hiểu, focus trường lỗi đầu tiên
- [ ] Icon/phím tắt đồng nhất, có tooltip; chức năng phức tạp có hướng dẫn trên form
- [ ] Header Xoăn: chỉ logo + tên app + tìm kiếm + Thiết lập + avatar (không 9 chấm/trợ lý AI/tin nhắn/thông báo/năm dữ liệu)
- [ ] Component dùng đúng spec trong `references/components/` (nếu có file spec tương ứng)
- [ ] Mini-app mobile đúng `mobile-native-app.md`: host/app không chồng chức năng, touch target 48px, text action một dòng, Back/safe area/keyboard đúng hợp đồng host

## Nguồn quy chuẩn gốc

Toàn bộ quy chuẩn cần thiết đã nằm trong thư mục `references/`. Cần spec chưa có thì liên hệ đội thiết kế Xoăn, không tự suy đoán giá trị.
