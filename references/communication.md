# XDS — Giao tiếp với người dùng (Nội dung, Thông báo, Dialog, Loading, Empty state, Error Page)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## 1. Nội dung (Content Guidelines)

### Nguyên tắc chính
**Ngắn gọn, đơn giản, rõ ràng, liên quan trực tiếp.**

Nội dung trên giao diện phải được viết sao cho người dùng có thể **"đọc lướt nhanh nội dung là có thể xác định được mình sẽ làm gì và chuyện gì sẽ xảy ra."**

- ✅ Nên: "Cố gắng viết ít chữ nhất mà vẫn truyền tải được đúng nội dung để người dùng hiểu được."
- ❌ Không nên: Nội dung giải thích dài dòng khiến người dùng khó đọc.

### Xưng hô
Hệ thống Xoăn Platform quy định:
- Ngôi thứ nhất: **"tôi, của tôi"**
- Ngôi thứ hai: **"bạn, của bạn"**

Quy tắc:
- ✅ Nhấn mạnh phần nội dung người dùng sở hữu → dùng **ngôi thứ nhất**.
- ✅ Nội dung truyền đạt trực tiếp với người dùng → dùng **ngôi thứ hai**.
- ❌ Tránh kết hợp cả 2 ngôi trong cùng một thông báo.

### Từ ngữ thông dụng
- ✅ Sử dụng từ ngữ quen thuộc giúp người dùng dễ hiểu.
- ❌ Tránh từ ngữ mang tính kỹ thuật khó hiểu.

### Ký tự số thay vì chữ số
Dùng ký tự số (1, 2, 3…) thay vì viết chữ số (một, hai, ba…). Phần này minh họa bằng hình ảnh — giá trị chi tiết: hỏi đội thiết kế Xoăn.

---

## 2. Thông báo (Announcement)

### 2.1 Thông báo kêu gọi hành động
- Các thông báo hiển thị dạng **dialog** trực tiếp trên màn hình của người dùng, **yêu cầu người dùng phải đưa ra lựa chọn trước khi tiếp tục hành động**.
- Quy cách chi tiết: theo chuẩn Dialog (xem mục 3).

### 2.2 Thông báo dạng Toast
4 loại: **Success, Error, Warning, Information**.

Ngữ cảnh sử dụng:
- "Thông báo nhanh trạng thái thao tác, hiển thị cho mọi người dùng, không cần tương tác xử lý."

Quy cách:
- Thời gian hiển thị: **5 giây, tự động đóng**.
- "Luôn hiển thị tối đa **3 thông báo** gần nhất, nhiều hơn 3 thông báo liên tục tự động ẩn các thông báo trước đó."
- **Max-width: 400px**.
- Vị trí hiển thị: phía trên/dưới thanh header.
- Thứ tự hiển thị: "Thông báo mới nhất sẽ hiển thị trên cùng, cũ hơn đẩy xuống phía dưới."

Do:
- ✅ Rộng tối đa 400px; text nên xuống dòng tối đa 2 dòng để dễ đọc.
- ✅ Khi nội dung ngắn hơn mức tối đa, hiển thị chiều rộng toast theo độ rộng của text.

Don't:
- ❌ Không mở rộng toast quá 400px.
- ❌ Không fix cứng chiều rộng không cần thiết gây che khuất nội dung bên dưới.

### 2.3 Thông báo dạng Notification
4 loại tương tự: Success, Error, Warning, Information.

Ngữ cảnh sử dụng:
- "Thông báo các sự kiện quan trọng, cần được xem lại sau (ví dụ: tin nhắn mới, nhắc việc, cảnh báo hệ thống,...)."
- "Các thông báo này thường do hệ thống tự động bắn lên, không phải do hành động của người dùng."

Quy cách:
- **Không tự động đóng**; người dùng phải bấm X để đóng.
- **Max-width: 400px**.
- Vị trí: **góc trên bên phải** của ứng dụng.
- Thứ tự hiển thị: "Thông báo mới nhất sẽ hiển thị trên cùng."

### 2.4 Thông báo dạng Inline
Ngữ cảnh sử dụng:
- "Hiển thị trực tiếp bên trong nội dung chính (gần khu vực thao tác/ngữ cảnh liên quan)."
- "Inline notification thích hợp cho các thông báo liên quan trực tiếp đến từng khu vực."
- Có thể có icon đóng X tùy ngữ cảnh.

### 2.5 Thông báo dạng Global Inline
Ngữ cảnh sử dụng:
- "Thích hợp cho các thông báo hết thời hạn sử dụng, thông báo cảnh báo hệ thống sắp bảo trì."
- Vị trí: **trên cùng của ứng dụng, phía trên thanh header**.
- Icon đóng X: tùy chọn (optional).

---

## 3. Dialog

### Định nghĩa
"Là một thành phần giao diện người dùng, được sử dụng khi cần thông báo cho người dùng các thông tin quan trọng."

### Tiêu đề (Title)
- "Tiêu đề nên là cụm từ hoặc một câu hỏi ngắn gọn, rõ ràng thể hiện hành động mà người dùng đang cần phải xác nhận."

### Mô tả (Description)
- "Mô tả là nội dung để người dùng có thêm thông tin, hiểu ngữ cảnh trước khi thực hiện xác nhận hành động."
- Nghiên cứu hành vi đọc:
  - Dưới **8 từ**: tỷ lệ hiểu **100%**
  - **14 từ**: tỷ lệ hiểu **90%**
  - **43 từ**: tỷ lệ hiểu **10%**
- "Hãy lựa chọn từ ngữ phù hợp để viết các mô tả ngắn gọn, súc tích, có ngữ cảnh và ý nghĩa."
- ❌ "Hạn chế lặp lại từ với tiêu đề hoặc đặt lại các câu hỏi như 'Bạn có chắc bạn muốn…'"

### Button
- Số lượng: tối thiểu **1**, tối đa **3** button.
- Sắp xếp: "các button nên được sắp xếp trên 1 hàng theo **thứ tự ưu tiên từ phải sang trái**."
- Các loại button:
  - **Primary**: cụm từ hành động, hoặc "Đóng" đối với dialog thông báo.
  - **Secondary**: hành động ưu tiên thấp hơn (ẩn khi không dùng).
  - **Cancel (Hủy)**: đóng dialog mà không thực hiện hành động nào.

### Quy tắc sử dụng
- Nội dung dài: "tiêu đề và mô tả tự động xuống dòng, với tiêu đề chỉ hiển thị **tối đa 2 dòng**."
- ✅ Giữ tiêu đề và mô tả nhất quán với nhau.
- ✅ Nêu rõ hệ quả của hành động trong phần mô tả.
- ❌ Tránh lặp từ giữa tiêu đề và mô tả.
- ❌ **Không chồng (stack) nhiều dialog**; với luồng nhiều bước hãy dùng Popup.

---

## 4. Dữ liệu trực quan (Data Visualization / Biểu đồ)

### Tổng quan
- "Dữ liệu trực quan mô tả thông tin dưới dạng đồ họa, nó có thể là các dạng biểu đồ trên báo cáo, các widget."
- Nên hiển thị số liệu **trực tiếp trên biểu đồ** để người dùng không cần hover mới xem được dữ liệu.

### Quy tắc chung
- Thư viện biểu đồ: dựa trên **Apache ECharts**.
- Bo góc: "Sử dụng bo góc chung cho Pie, column, bar là: **4px**" — tạo cảm giác mềm mại, hiện đại.

### Spec render chuẩn (đo từ bộ demo chuẩn của giám đốc thiết kế)

- **Màu series**: series chính = màu brand của theme hiện tại (đổi theme → chart đổi màu theo, lắng nghe sự kiện đổi theme để vẽ lại); series phụ theo chart palette trong `styles.md` (`#12B76A` thu/success, `#F79009` chi/warning, `#0BA5EC` tồn/info, `#98A2B3` neutral so sánh, `#7A5AF8` accent).
- **Cột (bar)**: `barMaxWidth: 12`, bo đỉnh `borderRadius: [4,4,0,0]`.
- **Đường (line)**: width 2, `smooth: true`, điểm `symbol: 'circle'` size 4; area dùng gradient dọc từ màu series ~27% alpha → trong suốt.
- **Donut**: `radius: ['50%','80%']`, `padAngle: 2`, `borderRadius: 4`, không hiện label trên lát (`label.show: false`) — tên hiển thị ở legend/bảng kèm theo.
- **Trục & lưới**: nhãn trục 11px màu `#717680`; đường trục `#E9EAEB`; chỉ kẻ lưới ngang màu `#F0F2F4`; giá trị lớn rút gọn (`399k`); nhãn trục X tự xoay 30° khi vùng vẽ hẹp (<640px).
- **Chú thích (legend)**: đặt DƯỚI biểu đồ, căn giữa, chữ **11px UPPERCASE màu secondary**, gap 16px giữa các mục; ký hiệu màu 8×8px — **tròn cho line/donut, vuông cho bar**. Bar/line chỉ 1 series thì KHÔNG hiện legend (tiêu đề card đã đủ nghĩa).
- **Tooltip**: `trigger: 'axis'` cho bar/line (so sánh nhiều series tại 1 mốc), `trigger: 'item'` cho donut; chữ 12px.
- **Hàng số tổng trên biểu đồ**: có thể đặt 2–3 chỉ số tổng ngay trên vùng vẽ — số 18px bold + nhãn 11px UPPERCASE secondary (vd DOANH THU / CHI PHÍ / LỢI NHUẬN).
- **Dòng đơn vị**: "Đvt: Triệu đồng" 11px secondary căn phải dưới tiêu đề card; **chân card**: "Số liệu tính đến: {giờ}" + link "Tải lại" màu brand, 11px, border-top 1px.

### Tham số/chức năng trên biểu đồ
- Trạng thái bình thường: **ẩn các chức năng** trên card để tránh giao diện rối.
- Khi hover, hiển thị chức năng theo quy tắc:
  - Icon reload hiển thị đầu tiên.
  - Các chức năng khác hiển thị tiếp theo.
  - Quá nhiều chức năng → gom vào menu 3 chấm.
  - Nếu có combo chọn thời gian: các icon chức năng hiển thị **bên trái** combo đó.
  - Nếu không có combo chọn thời gian: icon hiển thị góc **trên bên phải**.

### Score Card (thẻ chỉ số KPI)
- Thành phần bắt buộc: **Label (trên)**, **giá trị số liệu (dưới)**.
- Thành phần tùy chọn: đơn vị (bên phải giá trị), icon minh họa (bên phải, ưu tiên hiển thị số liệu), % tăng giảm (dưới số liệu), biểu đồ xu hướng (bên phải).
- ✅ "Label, số liệu, % tăng giảm ưu tiên hiển thị đầu. Icon minh họa và biểu đồ minh họa nằm phía phải."
- ❌ Tránh đặt icon trước text.

### Biểu đồ Pie & Donut
- Mặc định: dùng **Donut chart** cho đồng bộ, hiện đại (trừ khi có lý do đặc biệt).
- Quy tắc 1 — Giới hạn thành phần: "Bạn nên sử dụng **tối đa là 6 thành phần**" để tránh các phần nhỏ khó nhận biết; phần dư gom vào nhóm "Khác/Other".
- Quy tắc 2 — Tỷ lệ tương đồng: không dùng pie chart khi các thành phần có tỷ lệ gần bằng nhau → dùng **Bar chart**.
- Quy tắc 3 — Sắp xếp: sắp xếp theo giá trị; phần trăm lớn nhất bắt đầu từ góc phần tư đầu tiên, giảm dần sau đó.

### Biểu đồ Column & Bar
- Quy tắc 1: "Giá trị trục Y **luôn luôn bắt đầu từ số 0**."
- Quy tắc 2: nhãn cột quá dài → chuyển sang **Bar chart** (ngang).
- Quy tắc 3: hiển thị cột theo thứ tự có trật tự, trừ khi dữ liệu theo trình tự thời gian.
- Quy tắc 4 (Stacked chart): màu sắc phải có **độ tương phản đủ** để dễ đọc.
- Các loại: Single column, Clustered column, Stacked column.

### Line Chart
- Quy tắc 1: "Tránh sử dụng quá **7 đường** trên một biểu đồ" — các đường chồng chéo sẽ khó đọc.
- Quy tắc 2: "Màu sắc cần được quy định rõ ràng", không dùng ngẫu nhiên; đảm bảo nhất quán và tương phản đủ.
- Quy tắc 3: chỉ dùng cho so sánh dữ liệu **theo chuỗi thời gian**; so sánh danh mục đơn thuần → dùng Bar chart.
- Chức năng: thể hiện sự thay đổi dữ liệu theo thời gian, xu hướng tổng thể và tính liên tục của tập dữ liệu.

### Area Chart
- Các loại:
  - **Overlapping**: so sánh giá trị giữa các nhóm.
  - **Stacked**: theo dõi giá trị tổng thể và phân tích theo danh mục.
- Quy tắc 1: "Khi sử dụng overlapping area chart hãy đảm bảo **màu trong suốt** để thông tin không bị che lấp."
- Quy tắc 2: tránh dùng overlapping area chart với **hơn 4 loại thông tin** → dùng line chart.
- Chức năng: tương tự line chart nhưng có phần tô màu giữa đường và trục để thể hiện khối lượng giá trị.

---

## 5. Cảnh báo thoát trang (Leave Page Warning)

### Mục đích
"Cảnh báo cho người dùng khi đang nhập liệu mà thoát hoặc bấm nhầm tắt trình duyệt, tắt tab, F5 trình duyệt hay chuyển sang phân hệ khác."

### Nguyên tắc then chốt — khi nào hiển thị
"**Chỉ show những cảnh báo này khi có thao tác nhập liệu của người dùng trên form.** Nếu chỉ bấm thêm hoặc sửa mà không nhập liệu gì sau đó tắt đi thì **không cần cảnh báo**."

### Trường hợp 1: Thao tác trình duyệt (F5, tắt tab, tắt trình duyệt)
- Bắt buộc: "Các dự án **bắt buộc phải áp dụng** phòng trường hợp người dùng đang nhập liệu lỡ tay bấm nhầm đóng tab."
- Cách làm: "Sử dụng **form cảnh báo của trình duyệt** (native browser dialog) để tránh trường hợp tắt tab hay tắt trình duyệt vẫn có thể cảnh báo được."
- Cấm: "**Không sử dụng form cảnh báo dự án tự vẽ**" — vì khi F5 nhiều lần hoặc đóng tab/trình duyệt, cảnh báo custom không hiệu quả.

### Trường hợp 2: Thao tác trong ứng dụng (đóng popup, bấm Hủy, chuyển phân hệ)
- Cách làm: "Sử dụng **confirm dự án tự vẽ**" (dialog custom theo chuẩn Dialog).
- Triết lý nội dung: **chỉ cảnh báo về việc thoát mà chưa lưu**; **không hỏi người dùng có muốn lưu không**.

### Lý do thiết kế
Ứng dụng SaaS nên mặc định rằng người dùng chủ động bấm Hủy/X là chọn không lưu, vì "phần mềm SaaS trên form luôn có nút **Lưu** và có màu primary nổi bật."

Ví dụ tham chiếu thực tiễn: Shopify, QuickBooks, Zoho Books.

---

## 6. Loading

### Nguyên tắc cốt lõi
"Trạng thái loading giúp trấn an người dùng rằng hệ thống vẫn đang làm việc, tránh người dùng hiểu nhầm hệ thống bị treo."

### Quy tắc theo thời gian chờ
| Thời gian chờ | Yêu cầu |
|---|---|
| > 1 giây | **Bắt buộc** có trạng thái loading |
| < 1 giây | Cân nhắc dùng loading indicator |
| > 4 giây | Dùng **Progress bar** |
| > 10 giây | Hiển thị tiến trình ở góc màn hình (xem mục "Thao tác chạy lâu") |

### 6.1 Spinner
- Kỹ thuật: GIF hoặc SVG động, hiệu ứng vòng tròn xoay.
- Thiết kế: vòng tròn khuyết một góc, xoay đều.
- Màu sắc: tùy chỉnh theo màu của từng ứng dụng.

Ngữ cảnh sử dụng:
- Popup màn hình chi tiết cần load dữ liệu.
- Control cần load dữ liệu trước khi hiển thị.
- Control cần tính toán trước khi thực hiện hành động.

Quy cách:
- Kích thước tiêu chuẩn: **border 3px**.
- Kích thước nhỏ (trong control): **border 2px**.

### 6.2 Loading Skeleton
- Mục đích: cho người dùng hình dung trước bố cục cuối cùng trước khi dữ liệu tải xong; trực quan hơn spinner.

Ngữ cảnh sử dụng:
- Màn hình tổng quan load nhiều dữ liệu cùng lúc.
- Dashboard dạng báo cáo (hình skeleton mô phỏng trước dạng biểu đồ).
- Màn hình danh sách: dữ liệu tĩnh hiển thị ngay; skeleton cho phần dữ liệu load từ database.

Lưu ý: "Những thành phần nào đã có sẵn dữ liệu thì hiển thị luôn mà không cần thể hiện trạng thái loading."

Thiết kế: không có kích thước cố định; skeleton phải phản ánh đúng bố cục nội dung thật.

### 6.3 Thao tác chạy lâu (Long-duration operations)
- Với thao tác **> 10 giây**: hiển thị chỉ báo tiến trình ở **góc màn hình**, cho biết trạng thái đang chạy của thao tác.
- Nút đóng (X) ở trên cùng: bấm sẽ hiện xác nhận hủy.
- Nút X ở từng dòng: hủy riêng thao tác đó.

---

## 7. Empty State (Trạng thái trống dữ liệu)

### Định nghĩa & mục đích
- "Quy định các tiêu chuẩn cụ thể cho việc thiết kế 'Empty State' (Trạng thái trống dữ liệu), bao gồm hình ảnh minh họa (illustration), văn bản và CTA."
- "Sử dụng illustration (hình minh họa, ví dụ plane, fog shape, icon…) kèm title, subtitle và button nếu phù hợp. Hiển thị khi khởi đầu section, chưa từng có bản ghi nào, nhằm mục đích gây thú vị cho người dùng."

### Hình họa & quy định màu sắc
- Độ dày nét: "Sử dụng phong cách **line art** với độ dày nét cố định là **2px** cho tất cả các thành phần chính."
- "Kết hợp hài hòa giữa đường nét và các mảng màu đặc để tạo điểm nhấn và chiều sâu."

### Các yếu tố cấu thành hình họa

| Yếu tố | Mô tả & cách dùng | Màu (token) |
|---|---|---|
| **Fog Shape** | "Mảng sương, sử dụng làm lớp dưới cùng, để tất cả các hình hoạ bên trên." | Neutral/200 |
| **Icon chính** | "Icon đại diện cho nội dung sẽ xuất hiện trên màn hình khi có dữ liệu (ví dụ: icon tờ giấy cho chứng từ, icon người cho thông tin khách hàng). Luôn là thành phần lớn nhất và nổi bật nhất, thu hút sự chú ý của người dùng đầu tiên." | Neutral/800 |
| **Ground line** | "Đường cơ sở, đặt ở bên dưới tạo không gian cho illustration." | Neutral/800 |
| **Icon phụ** | "Icon phụ thể hiện các hành động hoặc trạng thái của dữ liệu." | Icon/Brand |
| **Cloud Shape** | "Line art vẽ mây, dùng làm yếu tố phụ phía sau." | Neutral/400 |
| **Pattern** | "Pattern ngôi sao, sử dụng trang trí xung quanh yếu tố chính." | Neutral/400, Neutral/800, Icon/Brand |
| **Plane** | "Hình hoạ máy bay, sử dụng trang trí xung quanh yếu tố chính. Bao gồm hình máy bay và đường bay đằng sau." | Icon/Brand, Neutral/800 |
| **Flight path** | "Hình hoạ đường bay, sử dụng trang trí xung quanh yếu tố máy bay." | Neutral/400 |

### Bố cục (thứ tự từ trên xuống)
1. **Hình họa**: miêu tả nội dung của dữ liệu sẽ có trong section này.
2. **Title & Subtitle**: "Cung cấp thông điệp về trạng thái hiện tại của màn hình và hướng dẫn người dùng."
3. **Button (CTA)**: "Đưa ra lời kêu gọi hành động (Call to Action), giúp người dùng biết cần làm gì tiếp theo để tạo ra dữ liệu."

### Kích thước & căn chỉnh
- Layout: "Sử dụng Auto Layout loại **Top Alignment**."
- Top Padding: khoảng cách từ đỉnh component đến đỉnh frame illustration là **120px**.

Khoảng cách giữa các thành phần:

| Cặp yếu tố | Khoảng cách |
|---|---|
| Illustration ↔ Title | **16px** |
| Title ↔ Subtitle | **4px** |
| Subtitle ↔ Button | **24px** |

### Hai trạng thái Empty State

**1. Initial State — chưa từng phát sinh dữ liệu**
- "Đây là trạng thái khi một tính năng hoặc module chưa từng có bất kỳ dữ liệu nào được tạo, tức là người dùng chưa thực hiện thêm, ghi nhận, hay phát sinh bản ghi nào từ trước đến nay."
- "Khi đã 1 lần được thêm dữ liệu thì sẽ không còn trạng thái này nữa mà chuyển xuống trạng thái bên dưới."
- "Khi ở trạng thái này chỉ hiển thị màn hình trống có các chức năng: **Thêm mới, nhập khẩu**... **Không chứa** bất kỳ chức năng nào liên quan tới bản ghi như: Tìm kiếm, lọc, giao diện Data table..."

**2. No Data State — đã từng có dữ liệu nhưng bị xóa hoặc lọc không có kết quả**
- "Đây là trạng thái khi hệ thống hoặc bảng dữ liệu đã từng có bản ghi, nhưng hiện tại không hiển thị dữ liệu vì đã xóa hết hoặc lọc không ra kết quả phù hợp."
- "Khi ở trạng thái này luôn hiển thị 1 hình minh họa đơn giản báo không tìm thấy dữ liệu, áp dụng cho cả trường hợp đã xóa không còn bản ghi nào hoặc tìm kiếm hay lọc không có kết quả nào."

---

## 8. Error Page (Trang báo lỗi)

### Cấu trúc
"Hiển thị trang báo lỗi có **hình hoạ và title** cho mỗi lỗi tương ứng." (Chi tiết component: hỏi đội thiết kế Xoăn.)

### Các loại trang lỗi và nội dung chuẩn

| Loại lỗi | Nội dung mô tả chuẩn |
|---|---|
| **403** | "Lỗi 403 xảy ra khi người dùng không có quyền truy cập vào tài nguyên hoặc chức năng mà họ đang cố gắng truy cập." |
| **404** | "Lỗi 404 xảy ra khi trang hoặc tài nguyên bạn yêu cầu không tồn tại trên máy chủ." |
| **Bị chặn truy cập (Access Blocked)** | "Lỗi bị chặn truy cập do chính sách bảo mật của công ty. Nhằm đảm bảo an toàn hệ thống, quyền truy cập của bạn tới trang này hoặc tài nguyên này đã bị hạn chế." |
| **Lỗi chung (General Error)** | "Đã xảy ra lỗi hệ thống hoặc lỗi không xác định. Bạn không thể tiếp tục thao tác trên trang này." |
| **Chức năng đang phát triển** | "Chức năng này chưa hoàn thiện hoặc đang được phát triển, hiện chưa thể sử dụng trên hệ thống." |
