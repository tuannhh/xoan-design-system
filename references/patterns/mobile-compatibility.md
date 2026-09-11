# Mobile compatibility và kiểm tra va chạm - XDS

File này là checklist bắt buộc đi kèm `mobile-native-app.md`. Mục tiêu là mini-app Xoăn dùng được trên điện thoại Android/iOS đời cũ và mới, tablet, xoay màn hình, split view và cỡ chữ lớn mà **text, chart, icon, badge, button hoặc shape không đè/chạm nhau**.

Đây là baseline kỹ thuật bảo thủ, không thay thế tuyên bố chính thức của Xoăn về phiên bản hệ điều hành tối thiểu. Khi native host công bố support floor, vẫn phải giữ các test kích thước compact bên dưới.

## 1. Support tiers bắt buộc

| Tier | Viewport kiểm tra | Đại diện |
|---|---|---|
| Legacy compact | 320x568, 360x640 | iPhone SE đời đầu, Android màn nhỏ/đời cũ |
| Legacy phổ biến | 375x667, 360x800 | iPhone 6/7/8/SE 2, Android 16:9/20:9 |
| Current | 375x812, 390x844, 393x873, 412x915, 430x932 | iPhone tai thỏ/Dynamic Island, Android hiện hành |
| Tablet | 600x960, 768x1024, 1024x768 | split view, iPad/Android tablet dọc và ngang |

Kiểm tra cả portrait và landscape khi màn hình có chart, bảng, form dài, media viewer hoặc sticky action. Không suy luận layout bằng user-agent; đổi bố cục theo chiều rộng container và capability host.

## 2. Definition of done: không va chạm

Một màn chỉ đạt khi tất cả điều kiện sau đúng ở mọi viewport trong Tier liên quan:

- Root `.xds-mobile-app` có `scrollWidth <= clientWidth + 1px`. Chỉ carousel, tab list hoặc thumbnail rail có chủ đích mới được cuộn ngang và phải tự chứa overflow.
- Không có text bị cắt theo chiều dọc. Button/tab/nav giữ một dòng; tiêu đề được phép ellipsis khi có bản đầy đủ ở detail, `aria-label`, tooltip hoặc sheet.
- Hai touch target độc lập cách nhau tối thiểu 8px khi có thể; icon và text trong cùng control cách tối thiểu 4px.
- Badge/tag không đè tiêu đề. Khi thiếu chỗ, đặt tag sang metadata row, rút gọn nhãn hoặc chuyển action phụ thành icon XDS.
- Shape/media/canvas có `max-width: 100%`, parent `min-width: 0` và vùng clip riêng. Không dùng absolute positioning cho nội dung chính; badge/FAB được phép absolute hoặc nhô ra khi parent đã chừa đúng khoảng trống.
- Sticky top/bottom bar không che nội dung cuối, field đang focus hoặc validation message; padding cuối phải gồm safe area/keyboard inset do host cung cấp.
- Không có card/row thay đổi chiều rộng hoặc chiều cao khi hover, loading, badge count, nhãn dài hay giá trị động xuất hiện.

Khoảng cách tối thiểu để duyệt trực quan:

| Cặp thành phần | Khoảng cách |
|---|---:|
| Text/body với border hoặc shape độc lập | 8px |
| Tiêu đề section với action bên phải | 12px |
| Chart title/filter với canvas | 8px |
| Legend với plot area | 12px |
| Hai touch target | 8px nếu không cùng segmented control |

## 3. Text và cỡ chữ lớn

- Duyệt ở 100%, 115%, 130% và 200% text/zoom. 200% có thể chuyển grid thành một cột hoặc tăng chiều cao row, nhưng không được mất nội dung nghiệp vụ thiết yếu.
- Body, helper, validation và value dài phải wrap tự nhiên; dùng `.xds-mobile-readable` cho URL/mã/chuỗi không có khoảng trắng.
- Dùng `.xds-mobile-single-line`, `min-width: 0` và ellipsis cho title/action label được phép rút gọn. Không đặt fixed height cho khối text nhiều dòng.
- Không tắt pinch zoom, không đặt `user-scalable=no`, không dùng font nhỏ hơn 12px cho nội dung và 11px cho bottom-nav label.
- Input dùng font 16px và touch target 48px để tránh iOS tự zoom khi focus.

## 4. Chart và báo cáo

- Dùng `XChart`; parent phải có chiều cao ổn định, `min-width: 0` và `overflow: hidden`.
- Cartesian chart bắt buộc `grid.containLabel: true`, `axisLabel.hideOverlap: true`; series label dùng `labelLayout.hideOverlap: true`.
- Dưới 340px: giảm `barMaxWidth`, rút gọn đơn vị/trục và tắt data label không thiết yếu. Không thu font theo viewport; giữ font tối thiểu và giảm mật độ thông tin.
- Legend nhiều mục dùng scroll/selector hoặc chuyển xuống dưới chart; không ép legend và title lên cùng hàng khi tổng chiều rộng không đủ.
- Tooltip phải `confine: true`; số quan trọng vẫn đọc được bằng label/summary, không phụ thuộc hover.
- Chart resize theo container. Nếu WebView thiếu `ResizeObserver`, phải có fallback `resize`/`orientationchange` như `XChart.vue`.
- Với donut/pie, label ngoài phải có đường dẫn đủ dài và `hideOverlap`; nếu compact vẫn va chạm, dùng legend/list số liệu bên dưới thay vì ép label quanh hình.

## 5. Baseline CSS/WebView đời cũ

- Không phụ thuộc duy nhất vào `flex-gap`; vùng trọng yếu dùng các class `xds-mobile-row-gap-*`/`xds-mobile-column-gap-*` có sibling-margin fallback.
- Không phụ thuộc duy nhất vào `color-mix()`; dùng token solid `--xds-*-soft` làm nền trạng thái.
- Khai báo fallback trước enhancement mới: `min-height: 100%` trước `100dvh`; `overflow-x: hidden` trước `overflow: clip`; event resize trước `ResizeObserver` nếu cần.
- Safe area luôn qua `--xds-mobile-safe-*`; không hard-code notch, Dynamic Island, home indicator hoặc Android navigation bar.
- Không dùng UA sniff để phân nhánh iOS/Android. Chỉ phân nhánh khi capability host hoặc hành vi platform thật sự khác.
- Không khóa orientation. Mọi thay đổi orientation/split view phải cập nhật mà không reload và không làm mất dữ liệu form.

## 6. Khác biệt Android và iOS

- **iOS:** kiểm tra swipe-back, keyboard che footer, input zoom, safe area bốn cạnh và viewer xung đột gesture. Back trong top bar vẫn bắt buộc.
- **Android:** kiểm tra hardware/gesture Back, navigation mode 3 nút/gesture, bàn phím nhiều hãng và WebView có thể cập nhật độc lập OS.
- Back của cả hai platform đi qua host adapter. Form bẩn phải confirm; viewer active phải báo host khóa/mở gesture phù hợp.
- Permission/camera/file/share/download dùng capability host; không giả định API browser có sẵn trên mọi phiên bản.

## 7. Quy trình QA trước bàn giao

1. Mở từng màn trong playground và lần lượt chọn profile 320, 360, 390, 430, 768px.
2. Ở mỗi profile, đi qua trạng thái mặc định, dữ liệu dài, empty, loading, error, selected và keyboard/focus nếu có.
3. Kiểm tra `document.querySelector('.xds-mobile-app').scrollWidth` không lớn hơn `clientWidth + 1`.
4. Dùng screenshot toàn màn và phóng 200% để rà border, baseline, chart label, badge/FAB, sticky bar và dòng cuối.
5. Xoay landscape; mở/đóng keyboard; quay lại portrait. Form data, scroll position hợp lý và chart phải resize.
6. Chạy build. Không bàn giao nếu còn warning overflow, text hai dòng trong button/tab/nav, chart label chạm nhau hoặc action bị che.

Playground có sẵn 5 profile: `320 · SE`, `360 · Android cũ`, `390 · iPhone`, `430 · Máy lớn`, `768 · Tablet`. Profile chỉ mô phỏng viewport; test thiết bị thật/native host vẫn cần trước release production.
