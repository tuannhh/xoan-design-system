# Icons Library — Xoăn Design System (XDS)

> Nguồn: Icons.pdf — export từ Figma XDS Web Components

> **Lưu ý về nguồn:** File PDF (44 trang) là bản export dạng **hình ảnh glyph, KHÔNG kèm tên icon riêng lẻ** — chỉ có tiêu đề danh mục trên mỗi trang. Vì vậy tài liệu này mô tả cách tổ chức bộ icon, hệ modifier (biến thể), và mô tả hình dạng các icon tiêu biểu cho từng hành động phổ biến — **không liệt kê tên icon** (tên không hiển thị trong PDF, không được tự bịa). Khi cần tên chính xác, tra trực tiếp file Figma XDS gốc.

> **Quan sát quan trọng:** Danh mục (43 nhóm) và phong cách glyph của bộ icon này **trùng khớp với bộ Tabler Icons** (outline, nét đều, bo tròn, hệ hậu tố modifier). Nếu cần tra tên icon để dùng trong code, có thể đối chiếu với Tabler Icons (tabler.io/icons) — nhưng phải xác nhận icon đó thực sự tồn tại trong thư viện XDS/Figma trước khi dùng.

## 1. Phong cách & quy tắc chung

- **Kiểu:** Outline (nét viền) là mặc định cho toàn bộ thư viện; có riêng một danh mục **Filled** chứa các biến thể tô đặc (dùng cho trạng thái active/selected hoặc cần nhấn mạnh).
- **Nét (stroke):** độ dày đồng đều trên toàn bộ icon, đầu nét và góc bo tròn (round cap/join).
- **Màu:** đơn sắc (1 màu duy nhất) — icon nhận màu theo ngữ cảnh (nên render bằng `currentColor` để kế thừa màu chữ/token của component chứa nó). PDF không quy định mã màu cụ thể.
- **Lưới dựng (keyline):** trang 1 của PDF là template lưới dựng icon: khung vuông chia ô pixel, có **vùng padding an toàn quanh mép** (icon không chạm sát biên) và các keyline shape (hình tròn, hình vuông, chữ nhật đứng/ngang bo góc) để mọi icon có trọng lượng thị giác đồng đều. Template hiển thị ở 2 cỡ (lớn và nhỏ) — tức bộ icon được thiết kế để dùng ở nhiều kích thước theo bội số của lưới.
- **Giá trị px/stroke cụ thể không được chú thích trong PDF** — khi triển khai phải lấy từ design tokens XDS hoặc file Figma gốc, không tự bịa số.

## 2. Cách tổ chức: 43 danh mục

Mỗi trang PDF là một danh mục (theo thứ tự trang trong PDF):

| Trang | Danh mục | Dùng cho |
|---|---|---|
| 2 | Animals | Động vật |
| 3 | Database | CSDL, bảng dữ liệu, import/export dữ liệu |
| 4 | Photography | Máy ảnh, chụp/chỉnh ảnh |
| 5 | Arrows | Mũi tên đủ mọi hướng: điều hướng, sort, expand/collapse, refresh, chuyển trang, autofit, back/forward, share/forward |
| 6 | Design | Công cụ thiết kế: bút, thước, màu, layout, căn lề |
| 7 | Filled | Biến thể tô đặc của các icon phổ biến (sao, tim, chuông, cảnh báo…) |
| 8 | Map | Bản đồ, định vị, pin địa điểm |
| 9 | Math | Toán: cộng, trừ, bằng, phần trăm, hàm số |
| 10 | Shapes | Hình khối cơ bản (tròn, vuông, đa giác…) |
| 11 | Sport | Thể thao |
| 12 | Badges | Huy hiệu, nhãn, chứng nhận |
| 13 | Development | Lập trình: code, terminal, bug, API |
| 14 | Food | Đồ ăn, thức uống |
| 15 | Symbols | Ký hiệu chung |
| 16 | Brand | Logo thương hiệu bên thứ ba (mạng xã hội, dịch vụ) |
| 17 | Devices | Thiết bị: điện thoại, máy tính, TV, máy in… |
| 18 | Games | Trò chơi |
| 19 | Media | Phát media: play, pause, âm lượng, nhạc, video |
| 20 | Gender | Giới tính |
| 21 | Mood | Cảm xúc (mặt cười/buồn…) — dùng cho rating, feedback |
| 22 | Gestures | Cử chỉ tay |
| 23 | Nature | Thiên nhiên |
| 24 | Buildings | Tòa nhà: nhà, văn phòng, ngân hàng, kho |
| 25 | Document | Tài liệu: file, folder, clipboard, sách, hóa đơn/biên lai, chữ ký, con dấu, báo cáo |
| 26 | Health | Y tế, sức khỏe |
| 27 | Laundry | Ký hiệu giặt là |
| 28 | Numbers | Chữ số 0–9 |
| 29 | System | **Nhóm quan trọng nhất cho app nghiệp vụ**: settings, thông báo, lịch, đồng hồ, khóa/bảo mật, user, tìm kiếm, lọc, cảnh báo, thùng rác, bật/tắt… |
| 30 | Charts | Biểu đồ: cột, tròn, đường — dashboard/báo cáo |
| 31 | Communication | Liên lạc: email, tin nhắn/chat, gửi (máy bay giấy) |
| 32 | E-commerce | Thương mại: tiền, thẻ, giỏ hàng, tag giá, giảm giá %, giao hàng |
| 33 | Letters | Chữ cái A–Z |
| 34 | Electrical | Điện |
| 35 | Logic | Cổng logic |
| 36 | Computers | Phần cứng máy tính |
| 37 | Extensions | Định dạng file/phần mở rộng |
| 38 | Other | Khác (chưa phân loại) |
| 39 | Text | Soạn thảo văn bản: bold, italic, heading, danh sách, căn chỉnh |
| 40 | Vehicles | Phương tiện giao thông |
| 41 | Version control | Git: branch, commit, merge, PR |
| 42 | Currencies | Ký hiệu tiền tệ các nước |
| 43 | Weather | Thời tiết |
| 44 | Zodiac | Cung hoàng đạo |

## 3. Hệ modifier (quy luật đặt biến thể) — chìa khóa để chọn đúng icon

Đây là quy luật nhất quán nhất của bộ icon, thấy rõ trên mọi trang: **mỗi icon gốc (base) có một "gia đình" biến thể** tạo bằng cách gắn thêm một ký hiệu nhỏ (badge) ở góc dưới-phải, hoặc gạch chéo toàn icon. Các badge quan sát được (lặp lại ở email, message, calendar, clock, lock, shield, folder, file, user, bell, filter, gear, cursor…):

| Badge/biến thể | Ý nghĩa | Ví dụ dùng |
|---|---|---|
| `+` | thêm mới | user+ = thêm người dùng; folder+ = tạo thư mục |
| `x` | xóa/hủy | calendar-x = hủy lịch |
| `✓` | đã xác nhận/hoàn thành | mail-check = mail đã xác nhận |
| `−` | loại bỏ/thu nhỏ | user− = bỏ người dùng |
| Gạch chéo (slash) | tắt/vô hiệu (off) | bell gạch chéo = tắt thông báo; eye gạch chéo = ẩn |
| Kính lúp | tìm trong đối tượng đó | file + kính lúp = tìm trong tài liệu |
| `$` | liên quan tiền | file-$ = chứng từ tiền |
| `⚡` (tia sét) | nhanh/tự động | |
| Bánh răng nhỏ | cài đặt của đối tượng | user + bánh răng = thiết lập người dùng |
| `↑` / `↓` | tải lên / tải xuống, tăng/giảm | file-↓ = tải tài liệu |
| `!` | cảnh báo trên đối tượng | shield-! = bảo mật có vấn đề |
| `?` | trợ giúp/không rõ | |
| `♥` | yêu thích | |
| `★` | đánh dấu sao | |
| `⏸` (hai vạch) | tạm dừng | clock-pause |
| Pin định vị | gắn vị trí | calendar + pin = lịch có địa điểm |
| `< >` (code) | liên quan code | |
| Bút chì | chỉnh sửa đối tượng | user + bút chì = sửa hồ sơ |

**Quy tắc chọn:** khi cần icon "hành động X trên đối tượng Y", tìm icon base của Y trong đúng danh mục rồi chọn biến thể có badge tương ứng với X — không ghép 2 icon rời.

## 4. Icon tiêu biểu cho các hành động phổ biến (mô tả glyph + trang)

Vì PDF không in tên icon, bảng dưới mô tả **hình dạng glyph nhìn thấy được** và trang chứa nó, để agent chọn đúng icon chuẩn trong Figma/thư viện:

| Hành động | Glyph chuẩn trong bộ | Danh mục (trang) |
|---|---|---|
| Thêm mới | Dấu cộng (trần hoặc trong hình tròn/vuông) | Math (9), System (29) |
| Sửa / chỉnh sửa | Bút chì; bút chì đè lên tài liệu/đối tượng | Design (6), Document (25) |
| Xóa | Thùng rác (có biến thể thùng rác-x, thùng rác gạch chéo) | System (29) |
| Tìm kiếm | Kính lúp (có biến thể kính lúp +/− cho zoom) | System (29) |
| Lọc | Phễu (funnel) — đủ biến thể +, x, ✓, $, ⚙, gạch chéo (bỏ lọc) | System (29) |
| Cài đặt | Bánh răng (gear) — rất nhiều biến thể badge | System (29) |
| Thông báo | Chuông (bell); chuông gạch chéo = tắt thông báo | System (29) |
| Cảnh báo / lỗi | Tam giác-!, tròn-!, lục giác-!, bát giác-! | System (29) |
| Thông tin | Chữ i trong hình tròn/vuông/lục giác | System (29) |
| Trợ giúp | Dấu ? trong hình tròn/vuông/lục giác | System (29) |
| Xác nhận / hoàn thành | Dấu tích đơn, tích trong ô vuông, tích đôi | System (29) |
| Người dùng | Hình người (đầu + vai); nhóm người cho users; đủ biến thể +, x, ✓, ⚙, bút chì, kính lúp… | System (29) |
| Khóa / bảo mật | Ổ khóa đóng/mở; khiên (shield) và các biến thể | System (29) |
| Ẩn / hiện | Con mắt / con mắt gạch chéo | System (29) |
| Ngày tháng / lịch | Tờ lịch — biến thể +, x, ✓, pin, kim đồng hồ… | System (29) |
| Thời gian | Đồng hồ tròn — biến thể pause, play, +, x… | System (29) |
| Tải lên / tải xuống | Đám mây mũi tên lên/xuống; mũi tên xuống vạch ngang | System (29), Arrows (5) |
| Xuất / chia sẻ | Mũi tên đi ra khỏi hộp; mũi tên cong forward | Arrows (5) |
| Làm mới (refresh) | Mũi tên vòng tròn (xoay) | Arrows (5) |
| Sắp xếp (sort) | Cặp mũi tên lên-xuống; mũi tên kèm vạch | Arrows (5) |
| Mở rộng / thu gọn | Chevron lên/xuống/trái/phải (trần, trong tròn, trong vuông); mũi tên 4 hướng maximize/minimize | Arrows (5) |
| Chuyển trang (pagination) | Chevron đơn/kép, chevron chạm vạch (first/last) | Arrows (5) |
| Gửi (send) | Máy bay giấy (có biến thể gạch chéo) | Communication (31) |
| Email | Phong bì — đủ hệ biến thể badge; phong bì mở | Communication (31) |
| Chat / bình luận | Bong bóng thoại (vuông bo góc và tròn) — đủ hệ biến thể | Communication (31) |
| Tiền / thanh toán | Đồng xu ký hiệu tệ, chồng xu, tờ tiền, thẻ tín dụng | E-commerce (32), Currencies (42) |
| Giỏ hàng | Xe đẩy (cart) — biến thể +, x; túi mua hàng | E-commerce (32) |
| Giảm giá | % trong tròn/tem răng cưa; tag giá | E-commerce (32) |
| Giao hàng | Xe tải, xe đẩy hàng | E-commerce (32) |
| Tài liệu / file | Tờ giấy gập góc — hệ biến thể rất lớn (badge đủ loại) | Document (25) |
| Thư mục | Folder — hệ biến thể đầy đủ | Document (25) |
| Sao chép (copy) | Hai tờ giấy chồng nhau | Document (25) |
| Báo cáo / hóa đơn | Tờ giấy răng cưa đáy (receipt) — biến thể $, %, ⚡ | Document (25) |
| Con dấu / phê duyệt | Con dấu (stamp); clipboard-✓ | Document (25) |
| In / thiết bị | Xem danh mục Devices | Devices (17) |
| Biểu đồ / dashboard | Cột, tròn, đường | Charts (30) |
| Yêu thích / đánh giá | Sao, tim, like/dislike (ngón cái) | System (29), Filled (7) |
| Bật / tắt | Toggle (con nhộng có chấm trái/phải) | System (29) |
| Đang tải (loading) | Vòng cung hở, tia xoay (spinner) | System (29) |
| Soạn thảo văn bản | B/I/U, heading, list, căn lề | Text (39) |

## 5. Hướng dẫn cho AI agent khi chọn icon

1. **Xác định đối tượng trước, hành động sau**: tìm danh mục chứa đối tượng (mục 2) → tìm icon base → chọn biến thể badge theo hành động (mục 3).
2. **Ưu tiên outline**; chỉ dùng bản Filled cho trạng thái active/selected hoặc điểm nhấn.
3. **Không ghép/chế icon mới** — bộ đã có sẵn hầu hết tổ hợp đối tượng × hành động.
4. **Không bịa tên icon**: PDF không in tên; lấy tên chính xác từ file Figma XDS. Có thể đối chiếu Tabler Icons để tra tên nhanh (do trùng khớp về danh mục và glyph) nhưng phải xác nhận tồn tại trong XDS.
5. **Kích thước/màu/stroke**: dùng token XDS; render icon bằng `currentColor`, giữ icon trên bội số lưới chuẩn, không tự scale lệch tỉ lệ hay đổi độ dày nét.
