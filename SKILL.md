---
name: xoan-design-system
description: >-
  Quy chuẩn thiết kế giao diện của Xoăn Design System (XDS) cho mọi ứng dụng web trong hệ sinh thái Xoăn.
  BẮT BUỘC dùng skill này mỗi khi tạo, sửa, hoặc review giao diện (UI) cho bất kỳ ứng dụng, màn hình, form,
  danh sách, popup, dashboard nào của Xoăn — kể cả khi người dùng không nhắc đến "design system".
  Trigger khi thấy: Xoăn, XDS, làm app/web Xoăn, tạo màn hình danh sách/chi tiết/thêm sửa,
  thiết kế UI, review UI, chuẩn hóa giao diện. Skill đảm bảo layout, component, button, form, màu sắc
  đúng quy chuẩn thiết kế Xoăn.
---

# Xoăn Design System (XDS)

Skill này giúp AI xây dựng UI đúng quy chuẩn thiết kế Xoăn khi phát triển ứng dụng trong hệ sinh thái Xoăn. Mục tiêu: người dùng mở bất kỳ app nào cũng thấy quen thuộc — cùng bố cục, cùng vị trí nút, cùng hành vi.

> **Trước khi làm bất kỳ việc gì trong repo này** (sửa component, thêm control, đổi kiến trúc...), đọc [MEMORY.md](MEMORY.md) — bối cảnh dự án, quyết định đã chốt, bẫy đã gặp. Có quyết định lớn mới thì cập nhật lại MEMORY.md.

> ⚠️ **Nếu project đang làm KHÔNG phải Vue 3 sạch** (vanilla JS, React, Angular, app "lai" có sẵn kiến trúc riêng...), đọc ngay mục **["BẮT BUỘC TUÂN THỦ — Khi project KHÔNG dùng Vue 3..."](#️-bắt-buộc-tuân-thủ--khi-project-không-dùng-vue-3-hoặc-đã-có-kiến-trúcui-riêng-từ-trước)** bên dưới TRƯỚC khi viết bất kỳ control nào — đây là quy tắc bắt buộc, không phải tham khảo thêm.

## Quy trình làm việc (làm theo thứ tự)

1. **Xác định loại màn hình** đang cần xây dựng: Tổng quan (dashboard), Danh sách, Thêm/Sửa, hay Chi tiết.
2. **Đọc reference tương ứng** trước khi viết code UI:

   | Đang làm gì | Đọc file |
   |---|---|
   | Dựng màn hình mới (bất kỳ) | [references/layout-patterns.md](references/layout-patterns.md) — bố cục 4 loại màn hình, chọn biến thể (Master-Detail, tab, card, drawer...) |
   | Màu sắc, font chữ, icon style | [references/styles.md](references/styles.md) — hệ màu 2 cấp, thang Brand, Text Styles, quy tắc icon stroke 1.5px |
   | Bảng dữ liệu (tick dòng, phân trang, lọc, sắp xếp) | [references/patterns/data-table.md](references/patterns/data-table.md) |
   | Header bar, Sidebar, Popup/Form | [references/patterns/](references/patterns/) — header-bar.md, sidebar.md, popup-form.md |
   | Mẫu email (thông báo hệ thống, xác nhận, báo cáo...) | [references/patterns/email.md](references/patterns/email.md) — khung 600px, 3 vùng Header/Nội dung/Footer, bảng responsive |
   | Xem ảnh/slideshow | [references/patterns/image-viewer.md](references/patterns/image-viewer.md) |
   | Mobile nhúng trong native host / super-app | [references/patterns/mobile-native-app.md](references/patterns/mobile-native-app.md) — mini-app trong native host, không co desktop/PWA |
   | URL mobile/PWA (web độc lập) | [references/patterns/mobile-pwa.md](references/patterns/mobile-pwa.md) |
   | Form nhập liệu, luồng thao tác | [references/general-design-rules.md](references/general-design-rules.md) + [references/usability-requirements.md](references/usability-requirements.md) |
   | Thông báo, dialog, toast, loading, empty state, error page, biểu đồ | [references/communication.md](references/communication.md) |
   | Chọn/dùng component | [references/components.md](references/components.md) rồi đọc spec chi tiết trong `references/components/` (button, text-field, dropdown, combobox, checkbox, radio-button, date-time-picker, context-menu, tab, tree, input, icon...) |
   | Phím tắt, chính tả, định dạng số, tiêu đề trình duyệt, icon dùng chung, bản quyền | [references/conventions.md](references/conventions.md) |

3. **Áp dụng checklist** ở cuối file này trước khi bàn giao.

## Các quy tắc cốt lõi (áp dụng cho MỌI màn hình)

Đây là những quy tắc bất biến, vi phạm là sai quy chuẩn Xoăn:

- **Nút Primary luôn ở ngoài cùng bên phải** của toolbar/form. Nút phụ (secondary) nằm bên trái nút Primary. Nút "More" (⋯) nằm ngay bên phải nút Primary — và cặp Primary + More luôn ở ngoài cùng bên phải.
- **Màn hình Thêm/Sửa: nút Lưu và Hủy luôn ghim (sticky) ở cuối trang/form**, không trôi theo nội dung.
- **Màn hình Chi tiết: các nút thao tác với bản ghi luôn ghim ở góc trên bên phải.**
- **Màn hình Danh sách: nền xám**, bảng có khoảng cách với lề xung quanh; tiêu đề bảng bên trái toolbar, chức năng thao tác bên phải.
- **Mọi thao tác của người dùng phải có phản hồi**: disable button hoặc hiện busy indicator sau khi click; xử lý > 5 giây phải có thanh tiến trình (progress bar).
- **Lỗi nhập liệu**: cảnh báo dễ hiểu bằng tiếng Việt, tự động focus vào trường lỗi đầu tiên.
- **Icon và phím tắt của cùng một chức năng phải đồng nhất** trên toàn bộ ứng dụng; phím tắt phải có tooltip.
- **Icon: dùng Tabler Icons với `stroke-width: 1.5`** làm thư viện triển khai (dùng qua wrapper `.ti`/`XIcon.vue`, icon kích thước `1em` theo font-size). Dùng qua component wrapper, **không inline SVG/map path riêng**, không trộn nhiều thư viện (FontAwesome, Material, Lucide, emoji).
- **Màu sắc, font, kích thước: dùng token trong [assets/tokens.css](assets/tokens.css)** — không hard-code mã hex.
- **Header Xoăn tối giản**: gồm **logo + tên app + ô tìm kiếm + nút Thiết lập + avatar người dùng**. Cụm bên phải CHỈ có Thiết lập và Avatar — **không** có nút chuyển ứng dụng 9 chấm, **không** trợ lý AI, **không** icon tin nhắn/thông báo/trợ giúp/khác, **không** badge năm dữ liệu hay nút chọn công ty. Chi tiết + API component ở [header-bar.md](references/patterns/header-bar.md).
- **Header chọn đúng biến thể**: `brand` (nền theo màu chính của app — **mặc định**, người dùng cuối đổi màu được) hoặc `light` (nền trắng) — đổi trong dialog Thiết lập (Giao diện: Màu sắc/Sáng). Ô tìm kiếm ở trạng thái chưa focus là nền trung tính/white-alpha mờ; không dùng input trắng đặc trên header brand.
- **Sidebar trắng kiểu mới dùng item bo góc trong gutter**, kể cả trạng thái thu gọn; không tô active tràn sát mép và không dùng vạch active 3px mép trái. Kích thước chuẩn: mở rộng 200px / thu gọn 64px, hover khi thu gọn thì mở đè lên app (không đẩy layout).
- **Mọi box trắng trên nền xám (dashboard card, KPI, panel bảng...) BẮT BUỘC dùng `box-shadow: 0 0 2px 0 rgba(0,0,0,0.10)` (token `--xds-shadow-card`, "Drop Shadow/Neutral/All 2") + `border-radius: 8px`** — chuẩn thống nhất toàn team, KHÔNG dùng border 1px để đóng khung, KHÔNG dùng drop shadow nổi. Shadow nổi (md/lg/dialog) chỉ dùng cho overlay (popup/dropdown/toast/dialog/drawer).
- **Màu viền (stroke) dùng chính thang Neutral**: viền mặc định = Stroke Neutral (Neutral/400 `#CED1D6`); phân tách rất nhẹ (dưới header, kẻ trong card, giữa dòng) = Stroke Neutral Light (Neutral/300 `#E9EAEB`). Không tạo hex viền riêng.
- **Khung app theo kích thước chuẩn**: Global Header 48px, Sub-nav tab 48px, Page header 56px, nền content xám `#ECEDEF`, padding/gap card 16px — xem mục "Khung ứng dụng chuẩn" trong [references/layout-patterns.md](references/layout-patterns.md).
- **Chiều cao control theo mật độ hiển thị (density)**: mặc định Trung bình (button 32px, input 36px, row bảng 36px); người dùng đổi được sang Compact/Rộng trong dialog Thiết lập — dùng token, không hard-code chiều cao.
- **Mobile nhúng trong host là mini-app**: root dùng `.xds-mobile-app`, top bar Back 56px, touch/input 48px, app-level bottom nav 3–5 mục; không dựng lại status bar, app launcher, bottom nav hệ sinh thái, avatar hay thông báo của host. Nút/tab/nhãn điều hướng luôn một dòng — bắt buộc đọc cả `mobile-native-app.md` và `mobile-compatibility.md`.

## Chọn tone màu (theme) cho ứng dụng

XDS có **10 theme màu chính thức**: blue (mặc định, Brand/600 `#245FDF`), indigo, cyan, teal, green, orange, red, pink, purple, blue-gray — mỗi theme là 1 file trong [assets/tokens/themes/](assets/tokens/themes/) chứa đủ thang Brand 50→900 + màu Text/Icon/Stroke/Bg tương ứng. Trong dialog Thiết lập của app còn có lựa chọn thứ 11 **Gradient** (token theme Green + header gradient `#245FDF→#0FBF79` — xem `references/styles.md`).

**Theme/giao diện là thiết lập của người dùng cuối, không chỉ của dev**: app chuẩn có dialog "Thiết lập màu sắc và hiển thị" mở từ nút Thiết lập trên header — gồm 3 tab: màu sắc (theme + chế độ header Màu sắc/Sáng), mật độ hiển thị (Compact/Trung bình/Rộng), hình nền (wallpaper + hiệu ứng kính). Spec chi tiết trong [references/patterns/header-bar.md](references/patterns/header-bar.md).

**Khi người dùng muốn chọn/đổi tone màu app:**
1. Mở [assets/theme-preview.html](assets/theme-preview.html) trong trình duyệt (hoặc render các thẻ swatch tương tự) để người dùng xem 10 theme với thang màu + nút/tag minh họa và chọn.
2. Áp dụng theme đã chọn: import `assets/tokens/themes/<tên-theme>.css` vào project (kèm `base-colors.css`, `number.css`, `font.css`, `space-standard.css` nếu chưa có). Đổi theme runtime bằng thuộc tính `data-xds-theme="<tên>"` trên `<html>`.
3. **Không tự pha màu ngoài 10 theme.** App cần màu thương hiệu riêng ngoài bộ này → liên hệ đội thiết kế Xoăn.

Bộ token đầy đủ (sinh từ Figma variables) nằm ở `assets/tokens/`; file nguồn JSON ở `assets/figma-tokens/` — cập nhật bằng `python3 scripts/build-tokens.py` khi có export mới.

## Sinh FE trực tiếp bằng bộ XDS UI (design-in-code)

Repo này kèm **bộ control Vue 3 + Tailwind viết sẵn** tại [ui/components/](ui/components/) (**31 control**: XIcon, XButton, XInput, XTextarea, XCheckbox, XRadioGroup, XSelect, XCombobox, XTag, XSpinner, XProgress, XDialog, XToast, XTabs, XEmptyState, XDataTable, XDatePicker, XDateRangePicker, XDrawer, XContextMenu, XTooltip, XDropdownMenu, XHeaderBar, XSidebar, XChart, XImageViewer, XCollapseExpandPanel, XSwitch, XTree, XUpload, XSettingsDialog — xem đủ trong [ui/README.md](ui/README.md)/[assets/component-map.json](assets/component-map.json)) và **5 màn hình mẫu desktop** tại [ui/templates/](ui/templates/) (ListPage, FormPage, DetailPage, DashboardPage, DocumentFormPage) + **4 màn hình mobile** tại `ui/templates/mobile/`. Khi người dùng (PD/PM) yêu cầu dựng màn hình cho app Xoăn:

1. **Bắt đầu từ màn hình mẫu**: xác định loại màn hình → clone file trong `ui/templates/` làm khung rồi sửa theo nghiệp vụ, KHÔNG dựng layout từ đầu (root template dùng `h-full` — mount trong container cao 100vh).
2. **Bắt buộc dùng control có sẵn** — tra nhanh props/emits/quy tắc trong [assets/component-map.json](assets/component-map.json), chi tiết đọc file `.vue` (có comment tiếng Việt). **CẤM viết HTML thô** (button, input, select...) cho control đã có trong bộ.
3. Project chưa có bộ control → copy các file `.vue` cần dùng vào `src/components/xds/` + import tokens theo hướng dẫn [ui/README.md](ui/README.md). Dùng XChart thì `npm i echarts`.
4. Đổ **mock data tiếng Việt giống thật** (tên người, phòng ban, mã chứng từ...), đủ các trạng thái (loading, empty, error).
5. Mở dev server/preview cho người dùng xem và chỉnh bằng ngôn ngữ tự nhiên — sản phẩm chốt chính là FE chuyển cho dev gắn API.
6. Control chưa có trong bộ: dựng inline theo spec trong `references/`, dùng token `var(--xds-*)`, và ghi chú TODO đề xuất bổ sung vào bộ chung.

Xem/duyệt toàn bộ control: `cd ui/playground && npm install && npm run dev` (có nút đổi 10 theme).

## ⚠️ BẮT BUỘC TUÂN THỦ — Khi project KHÔNG dùng Vue 3, hoặc đã có kiến trúc/UI riêng từ trước

**Đây là quy tắc BẮT BUỘC, KHÔNG phải gợi ý.** Áp dụng cho mọi project Xoăn không phải Vue 3 sạch từ đầu — app vanilla JS/jQuery cũ, React, Angular, hoặc "lai" (1 khung Vue nhỏ bọc ngoài + phần thân trang render bằng chuỗi HTML/DOM thuần, template server-side...). Vi phạm bất kỳ mục nào dưới đây = **vi phạm quy chuẩn thiết kế Xoăn**, không được coi là "xong việc", dù giao diện nhìn "tạm ổn" ở cái nhìn đầu tiên.

Rút ra từ một ca thực tế: AI đã tự viết lại `<select>` gốc trình duyệt + class `.btn` tự chế "cho giống" XDS thay vì dùng đúng component/token — kết quả lệch hẳn bản demo, chỉ phát hiện được khi người dùng tự so sánh bằng mắt và hỏi lại. Để KHÔNG lặp lại:

1. **KHÔNG được tự chế lại token.** Dù không dùng được file `.vue` thật, vẫn PHẢI import nguyên vẹn `assets/tokens.css` (+ theme cần dùng trong `assets/tokens/themes/`) vào project, dùng đúng biến `var(--xds-*)`. **Tuyệt đối cấm tự khai báo lại một bộ biến số song song** (ví dụ tự viết `:root{--layout-sidebar-w: 240px}` bên cạnh `--xds-layout-sidebar-w: 200px` đã import) — hai bộ token lệch nhau là dấu hiệu chắc chắn đã làm sai, rất khó phát hiện bằng mắt vì cả hai đều "nhìn giống nhau". Trước khi coi là xong, tự grep lại toàn bộ CSS của project tìm khai báo `--xds-` hoặc token trùng tên bị định nghĩa lại ở nơi khác ngoài `assets/tokens.css`.
2. **CẤM dùng phần tử HTML thô cho control đã có trong bộ**, kể cả khi framework không phải Vue: `<select>` gốc, `<button>` tự set style tay, checkbox/radio mặc định trình duyệt đều SAI quy chuẩn (không có chevron riêng, không đúng radius/state hover-focus-disabled, checkbox không bo góc 4px/tô brand khi check...). Thứ tự ưu tiên BẮT BUỘC tuân theo khi không thể mount thẳng file `.vue` (không được nhảy thẳng xuống ưu tiên thấp hơn để đỡ việc):
   - **Ưu tiên 1 (mặc định, phải thử trước)**: viết lại phần UI đó thành đảo Vue nhỏ (mount 1 component Vue cụ thể vào 1 vùng DOM), dùng đúng file `.vue` trong `ui/components/` — áp dụng được cả trong app không phải Vue-SPA nếu có Vite/bundler.
   - **Ưu tiên 2** (framework khác hẳn Vue, hoặc không thể refactor lớn): viết lại đúng hành vi + markup + class CSS của component XDS bằng ngôn ngữ/framework của project (ví dụ dropdown popover tự dựng bằng React/vanilla JS y hệt cấu trúc trigger+popover của `XSelect.vue`), đọc kỹ file `.vue` gốc để chép đúng class Tailwind/token, KHÔNG chỉ nhìn ảnh chụp rồi áng chừng.
   - **Ưu tiên 3 (chỉ khi rewrite toàn phần rủi ro quá lớn cho app cũ đang chạy production thật** — vd sửa hàng chục nơi dùng native `<select>` trong 1 file JS khổng lồ có thể gãy logic `onchange` khắp nơi): CHO PHÉP giữ nguyên phần tử HTML gốc + chỉ ép CSS để đạt tối đa sự giống nhau về mặt nhìn (native `<select>` thêm `appearance:none` + `background-image` chevron đúng SVG/màu XDS; checkbox/radio thêm `appearance:none` + vẽ lại đúng 16px/radius 4px/màu brand khi check) — nhưng **BẮT BUỘC phải nói rõ với người dùng** đây là "parity một phần" (hành vi/markup panel dropdown vẫn là mặc định trình duyệt, không có bàn phím nav/animation như XSelect thật). **CẤM báo cáo là "đã dùng đúng component" khi thực chất chỉ làm ưu tiên 3** — đây là hành vi báo cáo sai kết quả, không được phép.
3. **BẮT BUỘC tự thao tác thật trên trình duyệt trước khi báo "xong"** — không được chỉ đọc code hoặc xem 1 tấm ảnh chụp trạng thái mặc định rồi kết luận. Nhiều bug (nút thu gọn sidebar không phản hồi khi bấm, icon rơi về `help-circle`) chỉ lộ ra khi bấm/hover thật và soi CSS đang thắng ở trạng thái nào. Tối thiểu phải tự: click, hover, đổi theme/density trên trình duyệt thật (Playwright/Browser tool/thủ công) trước khi coi việc đã hoàn thành.
4. **BẮT BUỘC build+test local trước khi kết luận** nếu có bản build/deploy tách biệt với source đang sửa (Cloud Run, Railway, Netlify...) — đối chiếu commit đang chạy production có khớp source hiện tại không. Một bug "code đúng nhưng vẫn lỗi trên production" nhiều khả năng là do bản deploy đang chạy cũ hơn source, không phải do logic sai — KHÔNG được kết luận "đã sửa xong" chỉ dựa trên đọc code mà chưa build/deploy/verify lại bản chạy thật.

## Chọn control nhập liệu theo số lượng lựa chọn

| Số lựa chọn | Control |
|---|---|
| 2–3 | Radio button / Checkbox |
| 4–8 | Dropdown |
| > 8 | Combo box (có AutoComplete, LoadOnDemand) |

## Nguồn quy chuẩn gốc

Toàn bộ quy chuẩn cần thiết đã nằm trong skill này (`references/`). Cần spec chưa có trong skill thì liên hệ đội thiết kế Xoăn, không tự suy đoán giá trị.

## Checklist trước khi bàn giao UI

Kiểm tra từng mục, sửa ngay nếu chưa đạt:

- [ ] Loại màn hình dùng đúng bố cục trong `layout-patterns.md` (đúng biến thể Master-Detail/tab/card phù hợp nghiệp vụ)
- [ ] Nút Primary ở ngoài cùng bên phải; More ở bên phải Primary; mỗi màn hình chỉ 1 nút Primary
- [ ] Form Thêm/Sửa có Lưu/Hủy ghim cuối trang; màn Chi tiết có nút thao tác ghim góc trên phải
- [ ] Bảng dữ liệu: hành vi chọn dòng/chọn tất cả, phân trang, lọc, sắp xếp đúng `patterns/data-table.md`
- [ ] Control nhập liệu chọn đúng theo số lựa chọn (radio/dropdown/combo)
- [ ] Có giá trị mặc định hợp lý cho các trường nhập liệu; thứ tự trường theo thói quen tác nghiệp; Tab/Shift+Tab đi đúng thứ tự trái→phải, trên→dưới
- [ ] Mọi button có trạng thái loading/disabled sau khi click; xử lý > 1s có loading, > 5s có progress
- [ ] Thông báo lỗi tiếng Việt dễ hiểu, focus vào trường lỗi đầu tiên; toast tự đóng sau 5s
- [ ] Font Inter, chữ mặc định 13px; màu/size dùng token, không hard-code hex
- [ ] Icon dùng `XIcon` (stroke 1.5px), đúng bảng icon dùng chung; phím tắt có tooltip
- [ ] Header Xoăn: chỉ logo + tên app + tìm kiếm + Thiết lập + avatar; dùng đúng biến thể `light`/`brand`; icon 32×32, avatar cách mép phải 16px; KHÔNG có 9 chấm / trợ lý AI / tin nhắn / thông báo / badge năm dữ liệu
- [ ] Sidebar collapsed/expanded: item bo góc trong gutter, active không tràn mép
- [ ] Mọi box trắng trên nền xám dùng đúng `box-shadow: 0 0 2px 0 rgba(0,0,0,0.10)` + radius 8px (không border đóng khung, không shadow nổi); stroke dùng thang Neutral (400 mặc định / 300 phân tách nhẹ); header 48px, sub-nav 48px, sidebar 200/64px đúng khung chuẩn
- [ ] Chiều cao control dùng token density (desktop: button 32/input 36 ở mật độ Trung bình; mini-app mobile: touch/input 48px qua `.xds-mobile-app`), không hard-code
- [ ] Mini-app mobile đã duyệt 320/360/390/430/768px, portrait + landscape cần thiết, cỡ chữ/zoom 100/115/130/200%; root không overflow ngang ngoài vùng cuộn có chủ đích
- [ ] Text, chart, icon, badge và shape không đè/chạm nhau; chart có containLabel/hideOverlap, label phụ tự giảm mật độ dưới 340px, sticky bar không che nội dung/keyboard
- [ ] Mobile không phụ thuộc duy nhất vào flex-gap, color-mix hay ResizeObserver; có safe-area/resize fallback theo `mobile-compatibility.md`
- [ ] Slideshow dùng `XImageViewer`, có Esc, mũi tên, counter, thumbnail và alt text
- [ ] Mobile đã kiểm tra theo `mobile-native-app.md`: đúng lớp host/app, không lặp launcher/status bar/nav hệ sinh thái, touch target >= 48px, button/tab/nav label một dòng, safe area/bàn phím không che nội dung; PWA chỉ dùng khi scope yêu cầu rõ
- [ ] Số định dạng kiểu Việt Nam: chấm ngăn nghìn, phẩy thập phân (1.234.567,89)
- [ ] Có empty state đúng chuẩn (initial state ≠ no data state); có cảnh báo thoát trang khi form đang nhập dở
- [ ] Chức năng phức tạp có hướng dẫn ngay trên form
- [ ] **Nếu project không dùng Vue 3 / không mount được file `.vue` thật**: đã import nguyên `assets/tokens.css` (không tự khai báo token song song), control select/checkbox/radio/button đã được style lại đúng chuẩn (không phải mặc định trình duyệt) — đã tự bấm/hover/thao tác thật trên trình duyệt để xác nhận, không chỉ xem ảnh chụp tĩnh
