# Popup / Form (XDS)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa

Popup là **cửa sổ nổi bật giữa màn hình, có lớp phủ (overlay)**, chỉ cho phép người dùng nhập dữ liệu vào popup; **phải lưu hoặc đóng thì mới tiếp tục được các thao tác khác** trên nền phía sau.

## 1. Dạng popup giới hạn kích thước

- Popup này hiển thị **giới hạn kích thước chiều rộng và chiều cao theo các trường dữ liệu bên trong nó** (kích thước co theo nội dung form).

### Tỉ lệ hiển thị

- Tỉ lệ tối ưu thông thường của popup nên tuân theo **tỉ lệ 4:3 hoặc 6:4** để mắt nhìn dễ chịu nhất.
- Nếu popup dài **vượt quá 80% chiều cao màn hình**: nên **giới hạn chiều cao**, nội dung bên trong **cuộn**.

### Các biến thể layout form trong popup

- Popup dạng thông tin **đơn giản 1 cột**.
- Popup dạng thông tin có **nhiều cột**.
- Popup **label trên - dưới** (label đặt phía trên ô nhập).
- Popup **label trên - dưới dạng nhiều cột**.

## 2. Dạng popup full màn hình

- Dùng cho các form nhập liệu cần nhập **cùng lúc nhiều thông tin**, cần hiển thị **full màn hình để tối ưu diện tích**.
- Để đồng nhất quy tắc UX **nhập liệu từ trên xuống dưới rồi mới bấm Lưu**, thứ tự hiển thị các thông tin tương tự popup loại nhỏ:
  1. **Header** (tiêu đề popup)
  2. **Các thông tin cần nhập** (body)
  3. **Footer** chứa các nút **Hủy, Lưu...** nằm **ghim ở cuối cùng**.
- **Chiều cao của popup responsive theo chiều cao màn hình**; nội dung dài thì có **thanh cuộn bên phải**.
- **Luôn ghim (fix) Header và Footer của popup** — chỉ phần body cuộn.

## 3. Popup xem chi tiết 1 bản ghi

- Có dạng popup riêng dùng để xem chi tiết 1 bản ghi (chế độ xem, không phải nhập liệu).

## 4. Quy tắc nút trong form — KHÔNG dùng nút Disable

- **Tránh dùng nút Submit dạng disable** vì gây mơ hồ cho người dùng.
- **Luôn để nút enable**; khi bấm, nếu còn lỗi thì:
  - **Focus vào ô lỗi đầu tiên**, và
  - **Hiển thị tooltip thông báo lỗi** để người dùng biết cách nhập đúng.

### Trạng thái đang xử lý

- Khi hệ thống đang xử lý việc cập nhật dữ liệu thì **disable nút và hiển thị kèm icon loading** để tránh lỗi **lưu trùng dữ liệu** (double submit).

### Bấm Sửa nhưng chưa thay đổi gì rồi bấm Lưu

- Nút Lưu **vẫn hành xử như khi có thay đổi**; tuy nhiên DEV có thể kiểm tra thay đổi và **không gọi cập nhật dữ liệu** để tối ưu hệ thống.

## 5. Spec form chứng từ full màn hình (từ bộ demo chuẩn — mẫu "Phiếu thu")

Form chứng từ kế toán mở **full màn hình thay thế vùng nội dung** (header + sidebar app vẫn giữ nguyên). Cấu trúc dọc: `Form bar → Form body (cuộn) → Form footer (ghim)`.

### Form bar (thay cho sub-nav, cao 48px)

- **Trái**: hộp icon 28px nền brand-light bo 6px chứa icon nghiệp vụ màu brand → tiêu đề "Phiếu thu **PT00020**" 13px (số chứng từ đậm) → vạch dọc 1×20px → combobox loại chứng từ (200px, có nút + thêm nhanh) → ô tìm kiếm chứng từ nguồn (flex, max 360px).
- **Phải**: nút "Hướng dẫn sử dụng" (outline neutral, icon help màu success, chevron-down) → icon settings outline → **nút X đóng form** (icon outline).

### Vùng field thông tin chung

- Label 13px medium đặt **trên** input, cách 4px; các hàng field dàn flex gap 16px với **bề rộng cột cố định thống nhất giữa các hàng** (vd 200px / flex / 220px / 175px) để các ô thẳng cột.
- Input dùng khung `ibox`: icon hành động bên trong ô (dấu **+** = thêm nhanh danh mục, **chevron-down** = mở combobox, **calendar** = date picker, icon **bảng** = chọn mẫu diễn giải).
- Ô ghép ("Kèm theo [số] | chứng từ gốc"): input số + vạch ngăn dọc + label tĩnh secondary trong cùng một ibox.
- **Tổng tiền hiển thị lớn ở góc phải trên**: label 12px secondary + giá trị **28px bold** căn phải, cập nhật realtime theo bảng hạch toán.

### Section bảng hạch toán (inline edit)

- Tiêu đề section H3 "Hạch toán"; bên phải: select "Loại tiền" (VND/USD/EUR).
- Bảng viền ngoài 1px bo 8px; header + footer nền `--bg-neutral-light`, chữ header 12px medium secondary; row body cao 36px, hover nền brand-light.
- Ô nhập trong cell cao 28px: viền trong suốt khi nghỉ → hover viền neutral nền trắng → focus viền brand + ring nhạt; cột số căn phải `tnum`. Cột cuối là nút xóa dòng (trash đỏ).
- Dưới bảng: trái = nút "Thêm dòng" + "Xóa hết dòng" (outline neutral); phải = "Tổng số: N bản ghi" + phân trang.

### Đính kèm

- Icon paperclip + label "Đính kèm" + chú thích "Dung lượng tối đa 5MB" secondary.
- Dropzone ~280×60px viền **dashed 1.5px** bo 8px, chữ "Kéo/thả tệp vào đây hoặc bấm vào đây" secondary; hover → viền brand + nền brand-light.

### Form footer — thanh tối ghim đáy (điểm nhận diện của form chứng từ)

- Cao 52px, **nền tối `--neutral-800` `#484E59`**, ghim cuối form (không trôi).
- **Trái**: gợi ý phím tắt "F3 - Tìm nhanh, F9 - Thêm nhanh" 12px trắng 50%.
- **Giữa/phải theo thứ tự**: nút **Hủy** (ghost viền trắng 25%, chữ trắng) → toggle "Hiển thị tài khoản" (switch 36×20px, bật = nền success) → nút **Cất** (ghost viền trắng) → **split button primary "Cất và Thêm"** ở ngoài cùng bên phải (đúng quy tắc Primary ngoài cùng phải).

### Biến thể form có aside phải (mẫu "Bán hàng")

- Form header 56px: icon 32px brand-light + tiêu đề H3 + mã chứng từ dạng badge nền neutral bo 4px.
- Dưới header có **options strip** (padding 8×16px): các radio/checkbox/select nhỏ 28px cấu hình chứng từ, ngăn nhóm bằng vạch dọc.
- Body chia 2 cột: nội dung chính (tab + field grid 2 cột gap 12×24px + bảng chi tiết) và **aside phải 300px** (border-left) chứa các card tóm tắt viền 1px bo 8px: trạng thái (badge), thông tin key-value, khối tổng tiền (giá trị chính 18px bold).
- Footer của biến thể này nền trắng 56px, border-top.

---

*Ghi chú: Mục 1–4 từ tài liệu quy chuẩn gốc (mô tả bằng lời); mục 5 đo trực tiếp từ bộ demo chuẩn của giám đốc thiết kế.*
