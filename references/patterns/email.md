# Mẫu Email — XDS

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn), mục "Mẫu email".

## 1. Khung tổng thể

- **Chiều rộng khung email tối đa 600px** — mọi email (thông báo hệ thống, xác nhận, báo cáo...) đều dựng trong khung này, không rộng hơn.
- **Nền ngoài cùng** (phần bao quanh khung 600px, hiển thị khi mở email trên màn hình rộng): màu xám theo token `Bg/Page` (`--xds-bg-page`) của XDS — không dùng nền trắng hay màu khác cho phần ngoài khung.
- **Phần Header và Nội dung đặt trong 1 box nền trắng** bo góc, nổi trên nền xám ngoài.

## 2. 3 vùng bắt buộc

1. **Header**: chỉ chứa logo, tuỳ loại email mà logo khác nhau (xem mục 3).
2. **Nội dung**: layout tự do theo từng loại email (thông báo, xác nhận, báo cáo...), miễn responsive tốt trên mobile. **Bắt buộc phải có dòng**: *"Đây là email tự động từ hệ thống, Quý khách vui lòng không phản hồi"* cố định ở cuối vùng nội dung (trước khi sang Footer).
3. **Footer**: cố định cho mọi loại email, chứa thông tin công ty Xoăn — tên công ty, địa chỉ, website, email liên hệ. Không tuỳ biến theo từng email.

## 3. Logo header theo loại email — 3 trường hợp

- **Email chung của Xoăn** (không gắn với nền tảng/app cụ thể): chỉ có **logo Xoăn**.
- **Email từ một nền tảng** (vd nền tảng Xoăn): dùng **logo nền tảng**.
- **Email từ một app cụ thể trong nền tảng** (vd app Kế toán, app Nhân sự...): dùng **logo nền tảng + logo app** (2 logo cạnh nhau).

Không tự suy ra loại logo nếu chưa rõ email gửi từ đâu — hỏi lại Product/PM loại email trước khi chọn logo.

## 4. Bảng trong nội dung email (responsive)

- Nếu nội dung có bảng dữ liệu (vd bảng chi tiết đơn hàng, bảng chấm công...), **phải thiết kế responsive cho màn hình nhỏ** — không giữ nguyên bảng nhiều cột trên mobile.
- Cách xử lý: **chuyển đổi từ dạng bảng sang dạng phù hợp hơn** khi màn hình nhỏ (vd mỗi dòng bảng thành 1 card dọc liệt kê nhãn/giá trị), tương tự cách XDataTable/pattern data-table.md xử lý responsive cho danh sách trên mobile — không có 1 khuôn cố định, chọn dạng phù hợp nội dung.

## 5. Không có trong bộ XDS UI (`ui/`)

Kho email này **chưa có template `.vue` hay HTML mẫu sẵn** trong `ui/` — vì email HTML cần viết bằng bảng/CSS inline riêng cho tương thích client mail (Outlook, Gmail...), không dùng chung được với Tailwind/Vue của bộ UI. Khi cần dựng email thật, đọc đúng 4 mục trên rồi viết HTML email theo kỹ thuật email riêng (table-based layout, CSS inline), giữ đúng khung 600px + 3 vùng + logo + footer + câu tự động + bảng responsive.
