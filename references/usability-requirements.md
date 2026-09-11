# Yêu cầu tiện dụng chung (XDS)

> Nguồn: tài liệu quy chuẩn nội bộ Xoăn (đội thiết kế Xoăn)

## Quy tắc về chính tả

Tuân thủ quy tắc chính tả chung của hệ thống (xem chi tiết tại tài liệu "Quy tắc chính tả" trong `conventions.md`).

## Tab order, focus nhập liệu

- Khi mở form nhập liệu phải focus vào ô nhập số liệu đầu tiên.
- Thiết lập TabOrder giữa các control; phải đặt chế độ SelectAll khi focus vào ô nhập liệu.
- Sử dụng phím **Tab** để di chuyển giữa các control.
- Sử dụng tổ hợp phím **Shift+Tab** để di chuyển ngược trở về control trước.

## TabIndex

- Thứ tự TabIndex: từ **trái → phải**, tiếp đến từ **trên → dưới**.
- Ví dụ thứ tự đánh số trong form: 1, 2, 3, 5, 7, 9, 10, 11, 12, 8, 6, 4 (minh họa trường hợp bố cục nhiều cột).
- Một số trường hợp gom nhóm thông tin thì các thông tin trong cùng 1 nhóm sẽ được chuyển tab bên trong nhóm trước, sau đó mới chuyển sang nhóm khác.

## Phím tắt

- Tất cả các hoạt động trên sản phẩm đều có thể sử dụng phím tắt.
- Phải show cho người dùng thấy được phải dùng phím tắt gì; có thể show bằng tooltip hoặc status.

## Tooltip

- Tất cả các từ viết tắt phải có tooltip.
- Tooltip phải diễn giải đầy đủ một chức năng, một thông tin mà tên của nó không thể hiện được đầy đủ.

## HotTrack

- Khi di chuyển chuột qua thì đối tượng được đổi màu để người dùng dễ quan sát.
- Các đối tượng cần sử dụng HotTrack: Tab, Sidebar, Toolbar, Button, Combo...
- Các action mà người dùng có thể bấm được: icon chuột phải là hình bàn tay (cursor: pointer).

## Label

- Tất cả các Label chỉ được viết tắt khi có từ 4 từ trở lên; khi viết tắt bắt buộc phải có tooltip.
