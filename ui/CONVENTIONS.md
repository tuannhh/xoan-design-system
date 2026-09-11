# Quy ước code bộ XDS UI (Vue 3 + Tailwind CSS)

Bộ control mới chuẩn XDS, phân phối kiểu **copy-in**: mỗi component là 1 file `.vue` tự chứa trong `ui/components/`, AI/dev copy thẳng vào project (`src/components/mds/`). Không có build step riêng, không phụ thuộc package ngoài Vue.

## Nguyên tắc chung

1. **Vue 3 `<script setup>`**, JavaScript thuần (không TypeScript) để chạy được trong mọi project Vue 3 + Vite.
2. **Styling bằng Tailwind utility classes**, mọi màu/kích thước lấy qua CSS variables của XDS bằng arbitrary value: `bg-[var(--xds-brand-600)]`, `text-[var(--xds-text)]`, `border-[var(--xds-border)]`... — KHÔNG hard-code hex. Project chỉ cần import `assets/tokens.css` + `assets/tokens/themes/<theme>.css` (+ `base-colors.css`) là component tự ăn theme.
3. Tên component tiền tố `M`: `XButton.vue`, `XInput.vue`... Props/emits đặt tên tiếng Anh chuẩn Vue.
4. Component dùng chung `XIcon.vue` + `iconRegistry.generated.js`; không inline SVG hoặc duy trì `ICON_PATHS` riêng. Khi copy component có icon, copy kèm hai file này.
   Ngoại lệ inline SVG được kiểm soát bởi validator: glyph trạng thái Checkbox, illustration EmptyState, biểu tượng 9 chấm Platform, Spinner và chính renderer XIcon.

## Kích thước & hình khối chuẩn (từ spec XDS)

- Chiều cao control (button, input, select): **32px** (`h-8`). Font **13px/18px** (`text-[13px] leading-[18px]`), font-family kế thừa (project set Inter toàn cục).
- Corner radius control: **8px** (`rounded-lg`). Popup/menu/calendar: **4px** (`rounded`).
- Card/box nội dung dashboard: **border 1px**, nền trắng, bo góc 8px; **không shadow**. Chỉ overlay nổi (popup, dropdown, toast, dialog/drawer) mới dùng shadow.
- Sidebar trắng: item active/hover là rounded tab nằm trong gutter hai bên, không tô nền full-width và không dùng vạch active mép trái.
- Button: min-width 80px, padding ngang 14px, chữ font-medium.
- Padding ngang input: 12px.

## Trạng thái (bắt buộc đủ)

- **Hover**: brand-700 (nút primary) / nền `--xds-bg-hover-soft` hoặc neutral nhạt (item danh sách).
- **Pressed/Active**: brand-800.
- **Focus**: `focus-visible:outline outline-2 outline-offset-2 outline-[var(--xds-brand-600)]` (ring 2px, offset 2px theo spec Button).
- **Disabled**: `disabled:opacity-*` KHÔNG dùng — dùng màu thật: nền `--xds-bg-disabled`, chữ `--xds-text-placeholder`, `cursor-not-allowed`, `pointer-events-none` khi cần.
- **Error** (control nhập liệu): border `--xds-danger`, message đỏ 12px hiển thị dưới control.
- **Loading** (button): prop `loading` → hiện spinner inline + tự disable (chặn double-submit theo XDS).

## API conventions

- `v-model` qua `modelValue`/`update:modelValue`.
- Kích thước: prop `size` với `'md'` (32px, mặc định) và `'lg'` (40px) nếu spec có.
- Mọi control nhập liệu nhận props: `disabled`, `readonly` (nếu áp dụng), `error` (string — có giá trị thì hiện trạng thái lỗi + message).
- Label/required do form đảm nhiệm, không nhét vào control (trừ checkbox/radio có label đi kèm).
- Emit sự kiện chuẩn: `change`, `focus`, `blur` khi có ý nghĩa.

## Hành vi XDS bắt buộc (không được bỏ)

- Input focus: **tự SelectAll nội dung** (spec tiện dụng chung).
- Combobox: gõ để lọc (AutoComplete), điều khiển hoàn toàn bằng bàn phím (↑↓ chọn, Enter xác nhận, Esc đóng), hỗ trợ slot "thêm nhanh" khi không tìm thấy.
- Dropdown/Select: popover rộng tối thiểu bằng control, mở rộng theo nội dung dài; ↑↓ + Enter.
- Toast: tự đóng sau 5s, rộng tối đa 400px, tối đa 3 cái, mới nhất trên cùng.
- Dialog: 1–3 nút, ưu tiên phải→trái (Primary ngoài cùng phải), không chồng dialog.
- Mọi thao tác có phản hồi thị giác (hover/click đổi màu).

## Cấu trúc file component

```vue
<script setup>
// props, emits, logic — có comment tiếng Việt ngắn cho phần hành vi XDS
</script>

<template>
  <!-- Tailwind classes, token qua var(--xds-*) -->
</template>
```

Không dùng `<style>` trừ khi bất khả kháng (animation keyframes).
