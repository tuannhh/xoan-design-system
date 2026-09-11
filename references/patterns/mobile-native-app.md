# Mobile mini-app trong native host / super-app - XDS

Đọc file này trước khi tạo hoặc sửa UI chạy trên điện thoại/tablet trong một native host / super-app. Kênh production mặc định là **mini-app chạy bên trong native host**, không phải bản desktop co lại và không phải PWA độc lập.

Mô hình tham chiếu: các super-app phổ biến nhúng nhiều mini-app trong một host chung (host sở hữu launcher, điều hướng cấp hệ sinh thái, tài khoản; mini-app sở hữu nội dung nghiệp vụ).

## 1. Mô hình sở hữu giao diện

| Lớp | Native host / OS sở hữu | Mini-app sở hữu |
|---|---|---|
| Hệ thống | status bar, navigation/gesture bar, quyền hệ điều hành | chừa safe area, phản hồi khi host báo thay đổi inset |
| Hệ sinh thái | launcher ứng dụng, điều hướng cấp hệ sinh thái (feed, danh bạ, chat, trợ lý...), tài khoản và phiên đăng nhập | không dựng lại các thành phần này |
| App con | mở/đóng WebView hoặc native container, Back về host | top bar của app, nội dung nghiệp vụ, điều hướng cấp một của app, bottom sheet/dialog/form |

Quy tắc bắt buộc:

- Không dùng `XHeaderBar`, `XSidebar`, logo desktop, ô tìm kiếm toàn cục hay cụm tiện ích desktop trong mini-app.
- Không dựng giả status bar, thanh điều hướng Android, Dynamic Island hoặc bottom navigation của native host bên trong app con.
- Màn gốc của app vẫn có Back để thoát về host/launcher; hành vi Back phải gọi adapter của host thay vì đoán URL.
- Cloud Run hoặc URL web chỉ là kênh test. Bản test vẫn phải giữ cùng cấu trúc mini-app để kết quả duyệt phản ánh đúng production.

## 2. App shell của mini-app

### Top bar

- Tổng cao phần nội dung: **56px**, cộng safe area phía trên do host/OS cung cấp.
- Back có vùng chạm **48x48px**. Tiêu đề 20/28, semibold, một dòng và truncate.
- Bên phải chỉ giữ tối đa 2 action liên quan trực tiếp đến màn hình. Action phụ vào More.
- Không đặt app switcher 9 chấm, Thông báo hệ sinh thái hoặc avatar tài khoản vào top bar app con.
- Nút chữ trong top bar dùng động từ ngắn, tối đa khoảng 12 ký tự tiếng Việt. Khi không đủ chỗ, action phụ chuyển thành icon XDS có `aria-label`/tooltip.

### Vùng nội dung

- Compact dùng gutter 16px; danh sách dài có thể chạm mép và dùng padding nội bộ 16px.
- Ưu tiên mặt phẳng trắng/xám nhạt và list row. Card chỉ dùng cho nhóm tổng hợp, KPI, nội dung nổi bật hoặc công cụ có ranh giới thật.
- Không đặt toàn bộ màn hình trong một card và không lồng card trong card.
- Một màn hình chỉ có một vùng cuộn dọc chính. Header/footer sticky nằm ngoài vùng cuộn đó.

### Điều hướng cấp một của app

- App có 3-5 điểm đến ổn định: dùng `XMobileBottomNav` với icon XDS và nhãn ngắn một dòng.
- Có thể dùng một FAB ở giữa cho thao tác tạo/tải lên thường xuyên. FAB vẫn phải có nhãn trong bottom nav.
- App có hơn 5 điểm đến: giữ 3-4 mục chính, mục cuối là `Thêm`; không thêm hàng điều hướng thứ hai.
- Điều hướng cấp hệ sinh thái bên ngoài host không được sao chép vào mini-app.

## 3. Adaptive theo container native

Responsive vẫn cần cho xoay màn hình, split view và tablet, nhưng không được biến thành desktop shell.

| Lớp | Độ rộng container | Bố cục |
|---|---:|---|
| Compact | `< 600px` | một pane, bottom nav, top bar 56px, gutter 16px |
| Tablet | `600-1023px` | một hoặc hai pane; bottom nav hoặc rail 72px; form tối đa hai cột cho field ngắn |
| Wide tablet | `>= 1024px` | list-detail hoặc lưới 2-3 cột; vẫn dùng app top bar/rail, không chuyển sang header + sidebar desktop |

- Tablet dọc ưu tiên một pane; tablet ngang có thể dùng list-detail.
- Layout cập nhật khi xoay máy/chia đôi màn hình mà không reload.
- Nội dung chính nên có `max-width` hợp lý và căn giữa trên tablet nếu không có lý do dùng full width.
- Baseline 320px, WebView đời cũ, cỡ chữ lớn và quy tắc chống va chạm bắt buộc đọc thêm `mobile-compatibility.md`.

## 4. Text và action không xuống dòng

- Button, segmented control, chip, tab và nhãn bottom nav phải `white-space: nowrap`.
- Primary action giữ chữ; secondary action chuyển sang icon-only trước khi làm primary bị co hoặc xuống dòng.
- Nhãn dài phải rút gọn theo nghiệp vụ: `Thêm phim mới` -> `Thêm phim`, `Gửi yêu cầu phê duyệt` -> `Gửi duyệt`, `Tải phim lên hệ thống` -> `Tải lên`.
- Nút trong cùng một hàng không dùng câu mô tả. Mô tả đặt dưới tiêu đề/field hoặc trong helper text.
- Bottom nav label dài hơn vùng chứa dùng ellipsis; không cho phép hai dòng. Chọn nhãn ngắn trước khi dựa vào ellipsis.
- Tiêu đề/list metadata dùng `min-width: 0` + truncate; nội dung cần đọc đủ được mở ở detail, tooltip hoặc sheet.

## 5. Touch, input và bàn phím

- Touch target tối thiểu **48x48px**; glyph vẫn dùng thang XDS 16/20/24px.
- Input trong mini-app cao 48px; text nhập tối thiểu 16px để iOS không tự zoom.
- Khoảng cách giữa hai touch target tối thiểu 8px khi có thể.
- Khi bàn phím mở, field focus và lỗi phải còn trong viewport; footer không che field cuối.
- Dùng `inputmode`, `autocomplete`, `enterkeyhint` và kiểu input đúng dữ liệu.
- Hỗ trợ Back của Android và swipe-back iOS qua adapter host; form bẩn phải hỏi xác nhận trước khi thoát.

## 6. Pattern theo màn hình

### Danh sách

- Dùng search 48px, filter icon 48px và chip lọc cuộn ngang một dòng.
- Item độc lập hiển thị dạng list row, không bắt buộc bọc từng item bằng card.
- Row có vùng bấm tối thiểu 64px; tên một dòng, metadata tối đa hai dòng có truncate.
- Chọn nhiều hiển thị action bar sticky và số mục đã chọn; action nguy hiểm không nằm sát Back.

### Form

- Compact luôn một cột, label trên field, section phân tách bằng divider hoặc heading.
- Footer sticky: Hủy bên trái, Primary bên phải; cả hai cao 48px và không xuống dòng.
- Form dài dùng full-screen page; form ngắn/filter dùng bottom sheet.

### Chi tiết

- Top bar: Back + tiêu đề truncate + More.
- Tab/chip cuộn ngang, không wrap. Primary action dài đặt ở sticky bottom bar.
- Metadata ưu tiên label/value dạng row; không biến mọi section thành card.

### Dashboard/báo cáo

- KPI tối đa hai cột trên compact nếu giá trị dài nhất không tràn; nếu tràn thì một cột hoặc horizontal scroller có chủ đích.
- Chart có chiều cao cố định và nhãn số quan trọng; không phụ thuộc hover.
- Bộ lọc thời gian dùng segmented control ngắn hoặc bottom sheet.

### Slideshow/xem ảnh, video

- `XImageViewer`/media viewer mở full container, chừa safe area cho Close và thanh thumbnail.
- Hỗ trợ swipe, pinch/double-tap zoom cho ảnh; vẫn có Previous/Next cho accessibility.
- Playback/zoom gesture không được kích hoạt swipe-back của host ngoài ý muốn; adapter host cần khóa/mở gesture khi viewer active.

## 7. Hợp đồng với native host

App không gọi trực tiếp API giả định. Tạo một adapter duy nhất để nhận/cấp các capability sau; tên API thật do team native host xác nhận:

- `closeApp`/Back về host và xử lý hardware Back.
- safe-area insets, thay đổi orientation và kích thước container.
- trạng thái keyboard/visual viewport khi cần đặt composer hoặc sticky footer.
- theme, ngôn ngữ, user/session context đã đăng nhập.
- mở camera, file picker, share, download, notification permission và deep link qua capability host.
- báo viewer/gesture state để tránh xung đột swipe-back.

Trong browser test, adapter có fallback không gây lỗi và chỉ mô phỏng kết quả cục bộ; không thay thế hành vi production.

## 8. Token và building block

- Root mini-app phải có class `.xds-mobile-app`; class này áp touch/input 48px và font input 16px.
- Dùng `XMobileTopBar.vue` và `XMobileBottomNav.vue` trong `ui/templates/mobile/`.
- Safe area lấy từ `--xds-mobile-safe-top/right/bottom/left`; host có thể override, mặc định dùng `env(safe-area-inset-*)`.
- Icon bắt buộc qua `XIcon`. Thiếu icon: đối chiếu Figma XDS trước, sau đó mới bổ sung icon Tabler cùng stroke 1.5 vào registry.

## 9. Ma trận kiểm thử bắt buộc

- Legacy compact: 320x568, 360x640 và 375x667; không dựa duy nhất vào flex-gap, color-mix hoặc ResizeObserver.
- iOS: 375x812, 390x844, 430x932; notch, swipe-back, keyboard và Dynamic Type ở mức mặc định/lớn.
- Android: 360x800, 393x873, 412x915; hardware Back/gesture Back, bàn phím và navigation mode 3 nút/gesture.
- Tablet: 768x1024 portrait, 1024x768 landscape và split view khoảng 600-720px.
- Cỡ chữ/zoom: 100%, 115%, 130% và 200%; grid được phép đổi cột nhưng nội dung thiết yếu không được mất.
- Kiểm tra mọi button/tab/bottom-nav label không xuống dòng; không có overflow ngang ngoài carousel/tab/thumbnail được thiết kế.
- Kiểm tra top bar/bottom bar không trùng vùng host, footer không bị keyboard che và Back luôn về đúng lớp.
- Definition of done chi tiết cho text/chart/shape nằm trong `mobile-compatibility.md`; thiếu bất kỳ bước nào thì chưa được bàn giao.
