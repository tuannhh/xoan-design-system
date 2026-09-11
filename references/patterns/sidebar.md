# Side bar (Thanh điều hướng) — XDS

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Định nghĩa

Sidebar là **thanh điều hướng nằm bên trái (hoặc phải)** giao diện website/app, thường chứa **menu, danh mục, liên kết nhanh** hoặc các tính năng phụ trợ giúp người dùng truy cập các phần chính của hệ thống dễ dàng hơn.

## 1. Style chuẩn & 2 chế độ hiển thị

- Dùng **style sidebar trắng** để giao diện trông **sạch và hiện đại** hơn.
- Sidebar chuẩn có **2 chế độ**: **Mở rộng (expanded)** và **Thu gọn (collapsed)**.
- Item menu nằm trong gutter hai bên của sidebar, không tô nền tràn sát mép. Trạng thái hover/active dùng nền bo góc dạng pill/rounded tab.
- **Không dùng vạch active 3px ở mép trái** cho sidebar trắng kiểu mới; active được nhận biết bằng nền brand nhạt + chữ/icon brand.

### Kích thước chuẩn (từ bộ demo chuẩn)

- Rộng **200px** khi mở rộng, **64px** khi thu gọn; nền trắng, border-right 1px `--stroke-neutral-light`.
- Trên cùng là **nút "Thêm nhanh"** (icon plus + label): full-width, cao bằng `--btn-height`, viền 1px, bo 8px; khi thu gọn chỉ còn icon căn giữa.
- Item menu: cao `--btn-height + 4px` (36px ở mật độ trung bình), bo góc 8px, gap 4px giữa các item, icon 20px màu `--icon-neutral`, chữ 13px medium; padding gutter 12–16px hai bên.
- Hover: nền xám nhạt `--bg-neutral-hover`. Active: nền brand nhạt + chữ/icon brand + semibold.
- **Nút thu gọn/mở rộng (icon co/cụp) ở đáy sidebar**: nền `--neutral-50`, border-top + border-left 1px `--stroke-neutral-light`, hover `--bg-neutral-hover`, icon 20px.
  - Khi **mở rộng**: nút vuông **40×40px ở góc phải-dưới**, bo góc **trên-trái 8px** (`8px 0 0 0`); icon là mũi tên "thu gọn" (2 vạch phải + mũi tên chỉ sang trái).
  - Khi **thu gọn (và không hover)**: nút **kéo dài full-width** đáy rail (bỏ bo góc, đổi border-left → border-right); icon là mũi tên "mở rộng" (2 vạch trái + mũi tên chỉ sang phải).
  - Icon đảo chiều theo trạng thái để chỉ rõ hành động kế tiếp; tooltip "Thu gọn" / "Ghim mở rộng".
- Trạng thái mở/thu lưu `localStorage` (`xds-sidebar-expanded`) để mọi trang dùng chung một mặc định.
- **Nút co/cụp panel khác trong app (CollapseExpandPanel)** — dùng cho hàng KPI trên bảng, panel Detail: là tab nhỏ **40×16px** (ngang) hoặc **16×40px** (dọc), nền xám hoặc trắng, viền 1px `--stroke-neutral-light`, bo 4px ở 2 góc phía "gắn vào" đường kẻ, icon chevron 13px đảo chiều theo trạng thái (Top/Bottom/Left/Right × Collapse/Expand).

### Hành vi thu gọn / mở rộng

- Ở chế độ **thu gọn**, sidebar là một rail hẹp màu trắng: mỗi item chỉ còn icon 20px căn giữa trong vùng click bo góc; không hiển thị label trong rail.
- Item active khi thu gọn vẫn dùng nền brand nhạt bo góc quanh icon, không kéo nền full-width.
- Khi **hover chuột lên menu đang ở chế độ thu gọn**, sidebar **mở rộng tạm thời đè lên giao diện app** (position absolute trong host giữ chỗ 64px — layout không bị đẩy) kèm shadow `4px 0 20px rgba(16,24,40,0.12)`, transition width ~0.22s; label hiện sau icon với delay ~0.1s.
- **Di chuột ra ngoài vùng của menu** sẽ **tự động ẩn menu**, quay về chế độ thu gọn.
- Chỉ khi người dùng **chủ động bấm vào nút "Mở rộng"** thì mới hiển thị giao diện ở chế độ mở rộng **nằm dính dưới trang và đẩy giao diện ứng dụng sang phải** (mở cố định, chiếm layout).

## 2. Một số dạng sidebar khác (phân cấp menu)

1. **Sidebar có 1 cấp con**: thường sử dụng cho các **phân hệ cha bên trong có một vài phân hệ con** (xổ xuống dọc).
2. **Sidebar xổ cấp con sang ngang (flyout)**: áp dụng cho các loại danh mục có **rất nhiều danh mục con** — nếu dùng dạng xổ xuống thì phải cuộn chuột rất nhiều gây khó chịu. Ở dạng xổ ngang, các item **có thể có icon hoặc không**.
3. **Sidebar nhiều cấp con**: áp dụng cho các **menu động**, người dùng có thể tạo nhiều cấp menu tùy nhu cầu sử dụng. Ví dụ: Phòng ban cha → Phòng ban con → Phòng ban...n → Dự án.

## 3. Trạng thái của các item trên sidebar

- **Hover**: hiển thị **nền xám nhạt**.
- **Active**: hiển thị **nền màu brand nhạt**, đồng thời **đổi màu text và màu icon sang màu brand**.
- **Quy tắc active cha/con**:
  - Khi **item con đang active** thì **item cha không cần thể hiện trạng thái** active (ở chế độ mở rộng).
  - Nhưng khi sidebar ở trạng thái **Thu gọn** (các item con bị ẩn) thì **item cha cần có trạng thái active** để người dùng nhận biết đang active vào phân hệ nào.

---

*Ghi chú: Tài liệu gốc mô tả quy tắc bằng lời kèm hình minh họa; các giá trị px/hex cụ thể nằm trong hình ảnh nên không liệt kê tại đây để tránh sai lệch.*
