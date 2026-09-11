# Image viewer / Slideshow — XDS

Dùng `XImageViewer` khi người dùng cần xem ảnh lớn, duyệt nhiều ảnh, ảnh đính kèm hoặc ảnh trong danh sách. Không mở ảnh bằng tab mới hay tạo dialog HTML riêng.

## Cấu trúc và hành vi

- Viewer phủ toàn viewport trên overlay tối; ảnh nằm giữa, giữ tỷ lệ, không bị crop.
- Header có tên ảnh (nếu có), counter `3 / 12`, tải xuống (khi được phép) và nút đóng.
- Có nút mũi tên trái/phải khi có từ 2 ảnh; `Esc` đóng, `ArrowLeft`/`ArrowRight` chuyển ảnh. Nút disabled ở đầu/cuối, không vòng lặp tự động.
- Thanh thumbnail ở đáy khi có từ 2 ảnh; thumbnail đang chọn có stroke `--xds-brand-600`.
- Cung cấp `alt` cho mọi ảnh; ảnh lỗi phải có trạng thái thay thế, không để vùng trống.

## Mobile trong native host

- Viewer luôn full container mini-app và chừa `--xds-mobile-safe-*`; host/OS vẫn sở hữu system bar.
- Nút điều hướng và đóng có vùng chạm tối thiểu 48px trên màn hình touch; thumbnail được cuộn ngang, không ép nhiều cột.
- Không dùng hover là cách duy nhất để thấy controls.
- Khi zoom/swipe, báo trạng thái viewer qua native adapter để tránh xung đột swipe-back của host. Web/PWA test giữ cùng hành vi và dùng `env(safe-area-inset-*)` làm fallback.

## Dùng component

```vue
<XImageViewer v-model="showImages" :images="attachments" :initial-index="selectedImage" />
```

`images` dùng dạng `{ src, alt?, name? }`. Chỉ bật `downloadable` khi nghiệp vụ cho phép tải tệp.
