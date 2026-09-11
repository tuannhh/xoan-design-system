# Memory bank — Xoăn Design System (XDS) skill

File này lưu **bối cảnh và quyết định** không thể hiện được trong code/spec — để bất kỳ agent nào (Claude Code, Codex, Cursor, Antigravity...) mở repo lên là nắm được ngay, không phải đọc lại toàn bộ lịch sử commit. Cập nhật khi có thay đổi lớn về hướng đi; đừng chép lại thứ đã có trong SKILL.md/CONVENTIONS.md/component-map.json.

## 1. Mục tiêu dự án

Repo là hạ tầng để **Product Designer/PM prompt trực tiếp trên Claude Code/Codex ra FE chuẩn Xoăn**, bỏ qua bước dựng Figma rồi dev map lại. Gồm 3 phần: quy chuẩn thiết kế (XDS) trong `references/` + bộ control code sẵn (Vue 3 + Tailwind) trong `ui/` + skill (`SKILL.md`/`AGENTS.md`) để AI tuân thủ. Dev chỉ cần gắn API vào FE đã sinh.

## 2. Kiến trúc & lý do

- **Phân phối kiểu copy-in** (không phải npm package): chép trực tiếp file `.vue` vào project. Lý do: khỏi maintain version/publish; người dùng không cần biết npm.
- **Vue 3 `<script setup>` + Tailwind, JS thuần (không TypeScript)** — giảm rào cản khi AI sinh code nhanh.
- **Token qua CSS variables `var(--xds-*)`**, không hard-code hex — cho phép đổi cả 10 theme màu runtime bằng `data-xds-theme`. Prefix token là `--xds-`, component prefix là `X` (XButton, XHeaderBar...), alias Vite là `@xds`.
- **Icon**: registry tập trung `XIcon.vue` + `iconRegistry.generated.js`, sinh từ `scripts/build-icon-registry.py` (đối chiếu bundle icon trong `assets/icons/`, Tabler stroke 1.5). **Không tự thêm icon bằng cách tự vẽ path** — thêm SVG chuẩn vào `assets/icons/` rồi chạy generator. `python3 scripts/build-icon-registry.py --check` phải pass sạch (dùng để canh regression).

## 2b. Nguồn gốc: chuyển thể & rebrand

Repo này được **chuyển thể từ một design system tiền thân** và **rebrand toàn bộ sang Xoăn**. Các thay đổi lớn đã áp:
- Đổi prefix token `--xds-`, `data-xds-*`, class `xds-*`, localStorage `xds-*`; component prefix `X`; alias `@xds`.
- **Rút gọn Header bar**: header Xoăn chỉ còn **logo + tên app + ô tìm kiếm + nút Thiết lập + avatar người dùng**. Đã **bỏ hẳn**: nút app switcher 9 chấm, trợ lý AI, icon tin nhắn/chat, thông báo, trợ giúp, khác, badge "năm dữ liệu", nút chọn công ty. Đã xóa 2 component icon riêng của trợ lý AI/chat. Xem `references/patterns/header-bar.md` + `ui/components/XHeaderBar.vue` cho API mới (props: `variant`, `appName`, `searchPlaceholder`, `user`, `showSearch`, `showSettings`; emits: `search`, `settings`, `user-click`, `logo-click`; slots: `logo`, `actions`, `user`).

## 3. Trạng thái hiện tại

- **31 control** trong `ui/components/` + **5 màn hình mẫu desktop** trong `ui/templates/` + **4 màn hình native mobile** trong `ui/templates/mobile/`.
- Playground Vite (`ui/playground`) hiển thị bộ control + các template desktop/mobile; có nút đổi 10 theme. `PhoneFrame.vue` chỉ mô phỏng vùng host/OS ngoài slot app, không phải component để copy vào sản phẩm.
- **State dùng chung toàn app**: `ui/components/theme-state.js` (singleton module-scope) — theme màu (11 gồm Gradient), header mode ('brand'/'light'), density (compact/medium/comfortable), sidebar collapsed — tất cả tự lưu `localStorage`, set thuộc tính `data-xds-theme`/`data-density` trên `<html>`. Dialog `XSettingsDialog.vue` (mở từ nút Thiết lập trên `XHeaderBar`) là UI đổi các giá trị này (3 tab: màu sắc, hiển thị, hình nền).
- **Multi-agent/multi-phiên trên cùng repo**: có thể nhiều phiên chạy song song → **`git fetch` + xem diff trước khi sửa, và fetch lại ngay trước khi push**. Khi merge, ưu tiên bản dùng token CSS var thay vì hardcode nếu 2 bên khác nhau ở cùng chỗ.

## 4. Quyết định đã chốt (đừng làm lại/đảo ngược mà không hỏi)

- Stack: **Vue 3 + Tailwind CSS**, không xét lại React trừ khi có yêu cầu.
- Copy-in, không npm publish.
- 10 theme màu chính thức cố định (blue mặc định `#245FDF`) — không tự pha thêm theme ngoài bộ này. Có thêm lựa chọn **Gradient** thứ 11 (token Green + header gradient).
- Dashboard card / box trắng trên nền xám dùng **`shadow-card` (`0 0 2px rgba(0,0,0,0.10)`) + radius 8px, không drop shadow nổi**; shadow nổi chỉ dùng cho overlay (popup/dropdown/toast/dialog/drawer).
- Sidebar active state là rounded tab trong gutter, không tô nền full-width, không vạch mép trái. Kích thước 200px/64px.
- Icon bắt buộc qua `XIcon` + registry, cấm inline SVG riêng (trừ ngoại lệ trong `ui/CONVENTIONS.md`).
- **Header Xoăn tối giản** (mục 2b) — không thêm lại app switcher/trợ lý AI/tin nhắn/thông báo/năm dữ liệu vào header nếu chưa có quyết định chính thức đổi hướng.
- **Mobile production** là mini-app nhúng trong native host / super-app, không phải desktop responsive hay PWA. Host sở hữu status bar/launcher/nav hệ sinh thái/user session; app con sở hữu top bar/nội dung/nav nghiệp vụ.

## 5. Bài học quan trọng / bẫy đã gặp (đọc trước khi lặp lại việc tương tự)

1. **Nếu đã có source gốc chính xác trong tay, luôn dùng lại nguyên văn — đừng suy luận thư viện "chắc đã có sẵn".** Từng có icon bị làm sai nhiều lần vì tự vẽ tay/đoán tên icon có sẵn thay vì dùng đúng SVG capture.
2. **`<XChart>` tự có `class="w-full"` hardcode trên root** — truyền `class="w-[160px]"` trực tiếp vào component KHÔNG có tác dụng (2 class Tailwind cùng set width xung đột). Luôn bọc `<div class="w-[...]">` bên ngoài rồi đặt `<XChart>` bên trong.
3. **Legend/flex item tự dựng cần `min-w-0`** nếu nằm trong container hẹp — flex item mặc định không co lại dưới content width, dễ tràn.
4. **`.gitignore` có rule `dist/`** — nếu commit `ui/playground/dist/` thì phải `git add -f`, và `git rm --cached` asset hash cũ mỗi lần rebuild (Vite đổi hash). Đối chiếu `git ls-files ui/playground/dist/` khớp `ls ui/playground/dist/assets/` trước khi commit.
5. **Vue SFC compiler lỗi "Invalid end tag" → trang trắng** (thường do sót tag thừa cuối file khi ghi nội dung): khi thấy trang trắng bất thường, kiểm tra network filter `failed` (fetch file .vue lỗi 500), đừng chỉ nhìn console.
6. **Bài học "không dùng Vue 3 sạch"**: khi project không phải Vue-SPA sạch (khung Vue nhỏ bọc phần thân vanilla JS/chuỗi HTML), tuyệt đối không tự viết `<select>` gốc + `.btn` tự chế "nhìn giống" XDS, không tự khai báo token song song với `--xds-*` đã import, không để `XIcon` thiếu icon rơi về fallback sai. Thứ tự ưu tiên xử lý control: đảo Vue nhỏ → viết lại đúng markup/behavior bằng framework của project → chỉ CSS-only cho native element kèm cảnh báo rõ "parity một phần". BẮT BUỘC tự bấm/hover thật trên trình duyệt trước khi báo xong (không chỉ xem ảnh chụp tĩnh). Đã ghi thành mục riêng trong `SKILL.md`.
7. **Nested preview/native container không luôn trùng browser viewport**: `@media (max-width)` đủ cho WebView production full container nhưng không kích hoạt khi playground đặt app 320px trong cửa sổ desktop. Mobile rule quan trọng phải có cả media fallback (WebView cũ) và `@container` enhancement (split view/nested host); đừng chỉ nhìn screenshot ở viewport desktop rồi kết luận breakpoint đã chạy.
8. **`rounded-xl` (Tailwind v4) = 12px = `--xds-radius-popup`** — không phải hardcode sai, đừng tốn công sửa lại.

## 6. Cách dùng file này

- Agent mới vào repo: đọc file này trước, rồi mới đọc SKILL.md/AGENTS.md để biết quy trình làm UI.
- Khi có quyết định lớn mới (đổi stack, đổi kiến trúc phân phối, đổi hướng header/theme...) → cập nhật mục tương ứng, đừng để MEMORY.md lạc hậu.
- Đừng chép nội dung đã có sẵn trong SKILL.md/CONVENTIONS.md/component-map.json vào đây — chỉ ghi phần "tại sao" và "bối cảnh".
