# Web test và PWA fallback cho mobile Xoăn

Kênh mobile production mặc định của ứng dụng Xoăn là **mini-app trong một super-app/native host**. Trước tiên phải đọc và tuân thủ [mobile-native-app.md](mobile-native-app.md).

File này chỉ áp dụng khi yêu cầu ghi rõ một trong các trường hợp sau:

- deploy URL lên Cloud Run/hosting để test và duyệt;
- cần mở tạm bằng trình duyệt mobile;
- một sản phẩm được phê duyệt phát hành PWA/standalone ngoài native host.

## Nguyên tắc fallback

- Giữ nguyên app top bar, content và điều hướng nghiệp vụ của mini-app; không phục hồi header/sidebar desktop.
- Tạo adapter fallback cho Back, share, file picker và safe area; không giả rằng browser API tương đương native bridge.
- Dùng `<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">` và `100dvh`.
- Safe area vẫn đi qua `--xds-mobile-safe-*`; mặc định các token này đọc `env(safe-area-inset-*)`.
- Nếu browser có thanh địa chỉ, sticky footer phải theo visual viewport và không che field đang focus.

## Khi thật sự phát hành PWA

- Chỉ thêm manifest, service worker, install prompt, offline/sync và push notification khi đây là scope sản phẩm đã được duyệt.
- Không cache dữ liệu nghiệp vụ nhạy cảm chỉ để đạt điểm Lighthouse; cache shell/static asset có chiến lược version rõ ràng.
- Offline phải có inline notification và action `Thử lại`; không chỉ dùng toast.
- Phiên hết hạn phải giữ bản nháp an toàn và quay lại đúng tác vụ sau đăng nhập khi có thể.
- Xin quyền notification/camera/microphone sau hành động có chủ đích của người dùng.

## Kiểm thử web fallback

- Chạy cùng ma trận kích thước trong `mobile-native-app.md`.
- Test iOS Safari, Android Chrome, bàn phím, xoay màn hình và split view tablet.
- So sánh ảnh test với bản mini-app: khác biệt chỉ đến từ chrome của browser/host, không phải do hai bộ UI khác nhau.
