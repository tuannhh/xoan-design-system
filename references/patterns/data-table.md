# Data Table (Bảng dữ liệu) — XDS

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## 1. Cấu trúc bảng dữ liệu

Một bảng dữ liệu thông thường bao gồm:

- **Ô tìm kiếm dữ liệu trong bảng** (Bắt buộc) — đặt phía bên trái vùng trên bảng.
- **Bộ lọc nhanh** (Tùy chọn có hoặc không).
- **Các action của toàn bảng**: Icon reload, xuất khẩu, thiết lập, lọc — ở phía trên bên phải bảng.
- **Vùng giữa**: Header (tiêu đề cột), các dòng dữ liệu, Footer.
- **Paging** dùng phân trang dữ liệu.

## 2. Các dạng bảng dữ liệu

1. **Bảng đơn giản**: dùng cho nhiều loại danh sách thông thường. Ví dụ: Danh mục, danh sách nhân viên, danh sách khách hàng.
2. **Bảng phức tạp** (có gộp các nhóm trên cột): dùng khi cần gộp nhiều thông tin cha, con. Ví dụ: Bảng lương.

## 3. Căn lề cột dữ liệu

Quy tắc căn lề:

1. Dạng **văn bản** căn **bên trái** (vd: Tên).
2. **Số không thay đổi số lượng ký tự** căn **bên trái** (vd: Ngày, Số điện thoại, STT...).
3. **Số tiền, các số liệu cần so sánh** căn **bên phải** (vd: Số tiền, Đơn giá, Chiết khấu...).

Với bảng gộp cột: tiêu đề của bảng luôn **căn giữa**, các cột có đường ngăn cách rõ ràng với nhau, dữ liệu trong bảng vẫn căn theo quy tắc trên.

## 4. Hover dòng và thao tác trên dòng

- Khi **hover chuột lên dòng** thì hiển thị action của dòng.
- Hiển thị **tối đa 3 icon**; nếu có nhiều hơn 3 sẽ hiển thị **icon more (…)** ở cuối để xổ ra các chức năng khác.

## 5. Tooltip

- Tất cả các tiêu đề viết tắt, các icon khi hover chuột lên **đều phải hiện tooltip**.

## 6. Chọn dòng bằng checkbox & thao tác hàng loạt

### 6.1. Khi check chọn bản ghi

- Khi có **≥ 1 bản ghi** trên dòng của bảng được check chọn thì **show đè phần action hàng loạt** vào vùng lọc nhanh và các icon action của bảng ở phía trên.
- **Vẫn giữ lại ô tìm kiếm phía bên trái** để có thể tìm kiếm các giá trị từ trang khác để chọn thêm.

### 6.2. Giới hạn số nút chức năng hàng loạt

- Khi có **nhiều hơn 5 chức năng hàng loạt**, các chức năng từ **thứ 6 trở đi gom vào nút 3 chấm** ở cuối cùng; **không hiển thị thành 2 dòng nút**.

### 6.3. Chọn tất cả các bản ghi ở tất cả các trang

- Một số chức năng người dùng có nhu cầu chọn **toàn bộ các bản ghi ở tất cả các trang** để thực hiện một số chức năng nào đó.
- Khi đã chọn xong toàn bộ các bản ghi thì hiển thị giao diện để người dùng nhìn thấy **đã chọn số bản ghi là bao nhiêu** và text thể hiện **đang chọn tất cả**.
- **Lưu ý hiệu năng**: Đây là một chức năng gây ảnh hưởng hiệu năng của phần mềm khi có số bản ghi lớn. **Chỉ hiển thị chức năng này khi có yêu cầu từ nghiệp vụ.**

## 7. Bộ lọc (Filter)

### 7.1. Bộ lọc cơ bản (lọc nhanh)

- Cho phép người dùng áp dụng các tham số thiết lập trước cho tập dữ liệu.

### 7.2. Tìm kiếm thông minh

- Các danh sách nhiều cột dữ liệu, hoặc dữ liệu phức tạp nên hỗ trợ tìm kiếm thông minh: khi tìm kiếm gõ **ngôn ngữ tự nhiên**, hệ thống sẽ dùng **AI phân tích** thành điều kiện lọc.

### 7.3. Lọc dữ liệu trên cột

- Hỗ trợ **Filter trên từng cột dữ liệu**; khi **hover vào cột nào thì mới hiển thị icon lọc** của cột đó.
- Sau khi áp dụng lọc thì icon **luôn luôn hiển thị màu Brand**.
- Khi bấm icon lọc, xổ ra **popover** đồng thời **tự động focus vào ô nhập giá trị**, điều kiện lọc mặc định là **"Chứa"**.
- Người dùng chỉ cần **gõ giá trị và bấm Enter** là áp dụng.
- Khi focus vào bộ lọc mà **chưa lọc**: icon lọc hiển thị dạng **outline** (chỉ có border, rỗng giữa) màu brand.
- Khi **có cột đang lọc**: icon lọc chuyển về dạng **filled** (đặc) để làm dấu hiệu nhận biết bảng đang có cột lọc.

### 7.4. Bộ lọc nâng cao

- Khi **chưa nhập điều kiện lọc** thì nút sẽ là **"Áp dụng"**.
- Khi đã có điều kiện và đã áp dụng xong thì nút "Áp dụng" **đổi thành nút "Lưu"**.
- Các bộ lọc hay sử dụng **có thể lưu lại** và hiển thị trong panel lọc.
- Khi **chọn bộ lọc đã lưu** thì **điền sẵn giá trị lọc** vào các trường tương ứng.
- Khi bấm nút **Lưu** thì bật popup cho phép **điền tên bộ lọc** và lưu lại.
- Sau khi lưu sẽ hiển thị **danh sách bộ lọc đã lưu** ở ngay dưới tiêu đề "Bộ lọc".
- Khi đang dùng bộ lọc đã lưu mà sửa điều kiện: nút Lưu có **2 lựa chọn** — bấm "Lưu" để **cập nhật vào chính bộ lọc hiện tại**, hoặc xổ ra và bấm **"Lưu thành bộ lọc mới"**.

## 8. Các chức năng trên tiêu đề cột (sort, ghim, ẩn/hiện, resize)

Bấm vào **tiêu đề cột** sẽ show **Dropdown Menu** các chức năng:

- Sắp xếp: **Không / Tăng dần / Giảm dần**
- **Ghim cột / Bỏ ghim cột**
- **Đặt làm cột đầu tiên**
- **Thêm cột bên trái / Thêm cột bên phải**
- **Ẩn cột**
- **Hiển thị nhiều dòng / Hiển thị 1 dòng**

Quy tắc:

- Cột nào được **ghim** thì hiển thị **icon Pin ở đầu tiêu đề** cột.
- Hỗ trợ Filter trên từng cột; icon lọc chỉ hiện khi hover vào cột đó (xem mục 7.3).
- **Resize cột**: cho phép tùy chỉnh độ rộng từng cột khi **di chuột vào phân cách giữa 2 cột** rồi kéo.
- **Lưu ý**: Một số tính năng nâng cao như "Thêm cột bên trái", "Thêm cột bên phải"... thì tùy nhu cầu của từng dự án.

## 9. Phân trang (Paging)

Có **2 loại** paging:

1. **Infinite Scroll**: dạng cuộn đến đâu load nội dung đến đó. Áp dụng cho các dạng giao diện **không phải bảng dữ liệu**, không có nhu cầu xem chính xác một page nào (ví dụ: mạng xã hội, blog list, lịch sử chat).
2. **Pagination kinh điển** (bấm next/prev chuyển qua lại giữa các trang): sử dụng **duy nhất** trong các **bảng danh sách thông thường**. Paging đặt ở **footer** của bảng.

Lý do **không dùng pagination theo dãy số trang**:

- Trên sản phẩm SaaS có rất nhiều dòng dữ liệu; khi người dùng lướt 1–2 trang đầu không thấy dòng cần tìm, họ sẽ có nhu cầu **tìm kiếm hoặc lọc** chứ không bấm next qua nhiều trang.
- Build bộ lọc đơn giản sẽ **tiết kiệm hiệu năng** tính toán ra các số trang với dữ liệu lớn.
- Pagination theo số chỉ phù hợp với các trang website tin tức (phục vụ SEO và chia sẻ nội dung).

## 10. Chỉnh sửa dữ liệu trong bảng (inline edit)

### 10.1. Sửa tất cả dữ liệu trên bảng

- Người dùng có thể chỉnh sửa **tất cả dữ liệu trên bảng** (ngoại trừ những trường không được phép sửa).
- **Không mở sẵn toàn bộ các cell ở chế độ edit** để không bị rối mắt.
- Khi hover chuột lên từng dòng, nếu sửa được thì **các cell sẽ sáng viền các control lên**.
- **Nút lưu là lưu của cả form.**

### 10.2. Sửa dữ liệu từng dòng

- Dùng khi việc chỉnh sửa dữ liệu **không phải tác vụ chính**; chỉ cho phép chỉnh sửa tất cả dữ liệu trên từng dòng.
- **Nút lưu là lưu của từng dòng.**

### 10.3. Sửa dữ liệu từng cell

- Chỉnh sửa trên từng cell mất nhiều thao tác hơn nhưng **tránh gây nhầm lẫn** cho người dùng.
- Phù hợp khi chỉ chỉnh sửa **1 vài cell trên 1 dòng**.
- **Hover vào từng cell** sẽ có **icon sửa ở cuối mỗi cell** để bấm vào chỉnh sửa.
- Khi bấm sửa của cell, cho phép nhập sửa giá trị của cell, sau đó **lưu dữ liệu ngay tại cell đó**.

### 10.4. Thông báo lỗi và ngoại lệ khi nhập trong bảng

- Thông báo lỗi trên ô nhập liệu **tương tự style của ô input** ở các form nhập liệu.
- Trường hợp chữ quá dài: khi **focus** vào ô nhập liệu, hiển thị ô nhập liệu **tràn ra khỏi cell** để nhìn đủ nội dung.
- Khi ở trạng thái xem bình thường, chữ dài sẽ hiển thị **cắt bớt với dấu "..."** (ellipsis).

## 11. Thiết lập bảng (tùy chỉnh cột hiển thị)

- Cho phép người dùng chọn **cột dữ liệu nào được hiển thị** trên bảng của họ.
- Người dùng có thể **kéo thả để sắp xếp thứ tự** của các cột hiển thị, hoặc chọn **"Lấy lại mặc định"**.

### 11.1. Thiết lập bảng tiêu chuẩn

- Hầu hết các bảng dữ liệu bình thường dùng dạng tiêu chuẩn.
- Hiển thị dạng **Drawer full chiều cao màn hình** để tận dụng tối đa diện tích.

### 11.2. Thiết lập bảng nâng cao

Dành cho các bảng dữ liệu phức tạp như: Bảng lương.

- **Thiết lập dòng**: cho phép cấu hình hiển thị của dòng, có gom thành nhóm hay không, gom thành 1 hay 2 cấp hiển thị dạng cây trên danh sách.
- **Thiết lập cột**: cho phép cấu hình hiển thị của cột giống như thiết lập ở chế độ tiêu chuẩn; một số bảng có gom nhóm các cột với nhau thì có thể có thêm chức năng **Gộp cột**.

## 12. Scroll trong bảng

- Khi cuộn chuột thì **cuộn cả page** cho đến khi **header của bảng chạm vào header bar** thì **ghim lại header của bảng**, sau đó chỉ scroll trong vùng nội dung của bảng.
- **Lưu ý**: Một số dạng bảng phức tạp có thêm panel bên phải có thể cân nhắc giữ nguyên vùng tiêu đề trang, tổng quan, header bảng và footer — **chỉ cuộn nội dung bên trong bảng**.

## 13. Spec chuẩn từ bộ demo của giám đốc thiết kế (07/2026)

Giá trị đo trực tiếp từ bộ demo chuẩn — dùng làm mặc định khi dựng bảng mới.

### Khối bảng trong màn hình Danh sách

- Bảng nằm trong panel trắng bo góc 8px trên nền xám; cấu trúc dọc: `[KPI row (tùy chọn)] → [Table toolbar] → [Header bảng] → [Body cuộn] → [Footer Tổng] → [Thanh phân trang]`. Footer và phân trang nằm NGOÀI vùng cuộn.
- **Hàng KPI trên bảng** (tùy chọn): 3 card ngang gap 12px — icon 36px bo 8px nền màu nhạt theo ngữ nghĩa (success/warning/brand) + label 12px medium + giá trị 18px semibold cùng màu + chip giờ cập nhật (icon clock + "15:59") 11px secondary; nút refresh ẩn, hiện khi hover card. Cả hàng KPI thu gọn được bằng nút **CollapseExpandPanel** (tab 40×16px nền trắng viền 1px, bo 4px 2 góc dưới, icon chevron 13px) căn giữa.

### Table toolbar (TableHeader)

- Cao tối thiểu 56px, padding 12×16px, nền trắng.
- **Trái**: ô tìm kiếm (ibox) 240–280px + các filter phụ (vd select "Trường: Tất cả").
- **Phải**: cụm 4 icon button outline cố định theo thứ tự **Làm mới → Xuất file → Thiết lập cột → Bộ lọc** | vạch dọc 1×20px | cụm nút chính.
- Nút chính thường là **split button**: nút hành động chính primary ("Thêm thu tiền" + mũi tên chevron-down chọn biến thể), nút hành động phụ split neutral, cuối cùng là nút More (⋯) icon outline mở DropdownMenu tiện ích (Nhập/Xuất Excel, In danh sách, Tùy chỉnh cột...).
- **Chế độ bulk action**: khi tick ≥ 1 dòng, phần phải toolbar đổi thành `Đã chọn **N**` + link "Bỏ chọn" màu brand + tối đa 3 nút hàng loạt (outline neutral) + nút More; ô tìm kiếm giữ nguyên vị trí bên trái.

### Kích thước bảng

- Cột checkbox đầu tiên 44px; checkbox 16×16px bo 3px viền 1.5px, hover có vòng tròn 20px nền brand-light quanh box; checked nền brand + check trắng; header dùng trạng thái indeterminate (gạch ngang) khi chọn một phần.
- Header: nền `--neutral-200`, border trên/dưới 1px `--stroke-neutral`, chữ 13px semibold, sticky khi cuộn; cell header ngăn nhau bằng vạch liền 1px.
- Body row: cao theo density (36px mặc định), border-bottom 1px; **các cell trong row ngăn nhau bằng vạch chấm (dotted) 1px** — khác header (liền). Hover row: nền `--bg-brand-light`; row đang chọn/active cũng nền brand-light.
- Số tiền: căn phải, semibold, `font-feature-settings: 'tnum'`. Số chứng từ là link (`dt-action-link` màu link, hover gạch chân).
- Footer "Tổng": nền `--neutral-150`, chữ semibold, border-top 1px.
- **Resize cột**: hotspot 8px mép phải cell header, hover hiện vạch 2px brand + đường chỉ dọc full-height mờ; kéo để đổi width, min 60px.
- **Cột thao tác dòng**: sticky mép phải, rộng ~140px, chỉ hiện khi hover/chọn dòng, nền gradient trong suốt → brand-light; gồm icon button outline nhỏ: Xem (eye), Sửa (pencil), Xóa (trash, đỏ), More (dots).

### Thanh phân trang (TablePaging)

- Cao 48px, border-top 1px, nền trắng.
- **Trái**: `Tổng số: **N**` (label secondary, số semibold). **Phải**: "Số dòng/trang" + select 72px (20/50/100) + range `1 - 20` semibold + 4 nút icon: về đầu (chevron-left-pipe), trước, sau, về cuối (chevron-right-pipe).

### Master trên – Detail dưới (spec)

- Click dòng → mở panel Detail bên dưới (cao mặc định ~280px), có: nút CollapseExpandPanel thu/mở ở đỉnh, tab "Chi tiết" (36px), bảng con + phân trang riêng.
- Giữa 2 panel có **thanh kéo resize** cao 8px (hover hiện thanh ngang 32×3px bo tròn màu `--stroke-neutral`), kéo dọc đổi chiều cao Detail (min 80px).

---

*Ghi chú: Tài liệu gốc mô tả hành vi và quy tắc bằng lời kèm hình minh họa; các giá trị px/hex cụ thể lấy từ bộ demo chuẩn của giám đốc thiết kế (mục 13).*
