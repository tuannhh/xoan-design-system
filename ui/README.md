# XDS UI — Bộ control Vue 3 + Tailwind chuẩn Xoăn

Bộ component mới xây từ đầu theo quy chuẩn XDS, phân phối kiểu **copy-in**: chép file `.vue` cần dùng vào project, không cần cài package riêng. Mục tiêu: PD mô tả màn hình bằng lời → AI lắp từ các control này → ra FE chuẩn chuyển thẳng cho dev.

## Cách dùng trong project Vue 3

1. Project cần có: Vue 3 + Tailwind CSS (v3/v4 đều được) + font Inter.
2. Copy thư mục `ui/components/` vào project (khuyến nghị `src/components/mds/`).
3. Import tokens vào CSS gốc của project:
   ```css
   @import "<đường-dẫn>/assets/tokens.css";
   @import "<đường-dẫn>/assets/tokens/base-colors.css";
   @import "<đường-dẫn>/assets/tokens/themes/blue.css"; /* + theme khác nếu cho đổi */
   ```
4. Đặt theme trên `<html data-xds-theme="blue">` (blue là mặc định).
5. Đặt `<XToast />` một lần ở App.vue nếu dùng toast.

## Danh sách control (31)

| Control | File | Ghi chú nhanh |
|---|---|---|
| Icon | `XIcon.vue` + `iconRegistry.generated.js` | registry sinh từ bundle SVG đã xác minh · size 12–48 · filled chỉ khi có asset chính thức |
| Button | `XButton.vue` | variant: primary/secondary/danger/link/icon · `loading` tự disable chặn double-submit |
| Tag | `XTag.vue` | 6 màu soft · `closable` |
| Spinner | `XSpinner.vue` | stroke currentColor, dùng trong button được |
| Progress | `XProgress.vue` | thanh 6px, cho tác vụ >5s |
| Input | `XInput.vue` | select-all khi focus · `clearable` · password eye · slot prefix/suffix · `error` |
| Textarea | `XTextarea.vue` | đếm ký tự realtime khi có `maxlength` |
| Checkbox | `XCheckbox.vue` | `indeterminate` cho checkbox đầu danh sách |
| Radio group | `XRadioGroup.vue` | `options` + `direction` |
| Select | `XSelect.vue` | dropdown 4–8 lựa chọn · bàn phím đầy đủ · teleport popover |
| Combobox | `XCombobox.vue` | >8 lựa chọn · gõ tìm bỏ dấu TV · `multiple` (2 tag + "+N") · `allowCreate` thêm nhanh · emit `search` cho load-on-demand |
| Dialog | `XDialog.vue` | Primary ngoài cùng phải · Esc đóng · cấm chồng dialog |
| Toast | `XToast.vue` + `toast.js` | `useToast()` · tự đóng 5s · max 3 · rộng ≤400px |
| Tabs | `XTabs.vue` | underline/pill · bàn phím ←→ |
| Empty state | `XEmptyState.vue` | `type`: initial/no-result · slot actions |
| Data table | `XDataTable.vue` | tick dòng → bulk action bar · phân trang prev/next không đánh số · sort server-side · row actions hover · sticky header · slot `cell-<key>` |
| Date picker | `XDatePicker.vue` | lịch T2–CN tiếng Việt · gõ tay dd/MM/yyyy · drill-down tháng/năm · nút Hôm nay |
| Date range | `XDateRangePicker.vue` | 8 preset VN (Hôm nay→Năm nay) · 2 lịch liền kề · Hủy/Áp dụng |
| Drawer | `XDrawer.vue` | trượt phải/trái · overlay hoặc đẩy nội dung · footer Primary phải |
| Context menu | `XContextMenu.vue` | `ref.open(event, payload)` · submenu · item danger · icon từ assets/icons |
| Tooltip | `XTooltip.vue` | hover/focus · `shortcut` hiện kbd phím tắt · 4 hướng tự lật |
| Dropdown menu | `XDropdownMenu.vue` | nút More ⋯ chuẩn XDS · item danger/divider · bàn phím đầy đủ |
| Header bar | `XHeaderBar.vue` | cao 48px `brand` (mặc định)/`light` · logo + tên app · ô tìm kiếm secondary trước focus · cụm phải chỉ Thiết lập + avatar (không app switcher / trợ lý AI / tin nhắn / thông báo) |
| Sidebar | `XSidebar.vue` | trắng · expanded 200px / collapsed 64px hover popover · active rounded brand-50 trong gutter |
| Chart | `XChart.vue` | ECharts wrapper (cần `npm i echarts`) · palette chart tokens · số VN · auto-resize |
| Image viewer | `XImageViewer.vue` | fullscreen slideshow · Esc/←/→ · counter · thumbnail strip · responsive mobile |
| Collapse/Expand panel | `XCollapseExpandPanel.vue` | tab 40×16/16×40px · `side` top/bottom/left/right · icon chevron đảo chiều · dùng thu/mở KPI row |
| Switch | `XSwitch.vue` | toggle 36×20px · bật = nền success |
| Tree | `XTree.vue` | cây phân cấp làm phẳng (flatten) · single-select · checkbox cascade cha/con + indeterminate · node lá không chevron nhưng vẫn thẳng cột |
| Upload | `XUpload.vue` | dropzone kéo-thả + click · validate dung lượng (`maxSizeMB`) · KHÔNG tự upload — emit `select-files` cho cha xử lý |
| Settings dialog | `XSettingsDialog.vue` | dialog "Thiết lập màu sắc và hiển thị" mở từ nút Thiết lập header · 3 tab: màu sắc/hiển thị/hình nền · draft state, chỉ áp dụng khi Lưu |

**Helper không phải control**: `useFormValidation.js` — composable validate form dùng chung (`rules.required/email/phoneVN/minLength/maxLength/min/max` + `validate()` tự focus vào ô lỗi đầu tiên, khớp quy tắc "không disable nút Submit" của XDS). Field cần tự focus phải bọc `data-field="tênTrường"`. Xem ví dụ thật trong `ui/templates/FormPage.vue`.

## 5 màn hình mẫu desktop (`ui/templates/`) + 4 màn hình mobile (`ui/templates/mobile/`)

Khi dựng màn hình mới, **clone template tương ứng làm khung** rồi sửa theo nghiệp vụ — không dựng layout từ đầu. Root template dùng `h-full`, mount trong container cao 100vh.

| Màn hình | File | Nội dung |
|---|---|---|
| Danh sách | `ListPage.vue` | HeaderBar + Sidebar + toolbar chuẩn + DataTable + Drawer thêm nhanh |
| Thêm/Sửa | `FormPage.vue` | form 2 cột + footer sticky Lưu/Hủy |
| Chi tiết | `DetailPage.vue` | nút thao tác ghim góc phải + Tabs |
| Tổng quan | `DashboardPage.vue` | 4 KPI card + 3 Chart + bảng mini · có ví dụ panel thật (XDropdownMenu) cho Thông báo/Trợ giúp/Khác/Avatar |
| Chứng từ | `DocumentFormPage.vue` | form full màn hình nhiều section + bảng dòng chi tiết + footer sticky |

4 màn hình native mobile tương ứng (`ListPageMobile.vue`, `FormPageMobile.vue`, `DetailPageMobile.vue`, `DashboardPageMobile.vue`) nằm ở `ui/templates/mobile/`, minh họa bằng app **Kho phim** và dùng chung 2 building block nội bộ `XMobileTopBar.vue` + `XMobileBottomNav.vue`. Đây là mini-app trong native host, không chứa Header Platform/launcher/bottom nav hệ sinh thái — đọc `references/patterns/mobile-native-app.md` và `references/patterns/mobile-compatibility.md` trước khi sửa. Playground có selector 320/360/390/430/768px để rà máy cũ, máy mới và tablet.

Chi tiết props/emits: đọc trực tiếp file component (có comment tiếng Việt) hoặc `assets/component-map.json`.

## Quy tắc khi AI sinh màn hình

- Control đã có trong bảng trên → **bắt buộc dùng, cấm viết HTML thô thay thế**.
- Control chưa có (HeaderBar, Sidebar, Chart... — Đợt 3) → dựng theo spec trong `references/`, dùng token, và đánh dấu TODO để bổ sung vào bộ.
- Mọi màu/kích thước qua `var(--xds-*)` — không hard-code.
- Icon luôn render qua `XIcon`; bundle thiếu thì đối chiếu Figma trước, bổ sung SVG chính thức vào XDS và chạy generator trước khi ứng dụng sử dụng.
- Với mobile production, đọc `references/patterns/mobile-native-app.md` + `mobile-compatibility.md`, đặt class `.xds-mobile-app` ở root, touch/input 48px và giữ button/tab/nav label một dòng. Duyệt đủ profile playground, zoom đến 200%, không để text/chart/shape va chạm. Chỉ đọc thêm `mobile-pwa.md` khi scope có URL test hoặc PWA riêng.

## Xem & duyệt bộ control (playground)

```bash
cd ui/playground && npm install && npm run dev
# mở http://localhost:5199 — có nút đổi 10 theme ngay trên trang
```

## Lộ trình

- ~~Đợt 1: 14 control lõi~~ ✅
- ~~Đợt 2: DataTable, DatePicker/Range, Drawer, ContextMenu, Tooltip, DropdownMenu~~ ✅
- ~~Đợt 3: HeaderBar, Sidebar, XChart (ECharts), 4 màn hình mẫu~~ ✅
- ~~Đợt 3.5: Tree, Upload, form validation helper (`useFormValidation.js`)~~ ✅
- Tiếp theo (khi có feedback PD): tinh chỉnh thẩm mỹ theo phản hồi PD
