# Xoăn Design System Skill

Bộ quy chuẩn giúp AI coding agent (Claude Code, Codex, Cursor, VS Code Copilot, Antigravity, Kiro, Xcode...) xây dựng UI **đúng quy chuẩn thiết kế Xoăn (XDS)** khi phát triển ứng dụng trong hệ sinh thái Xoăn.

Khi được cài, AI sẽ tự động áp dụng:
- 4 nguyên tắc thiết kế chung của Xoăn (dễ học, dễ nhập liệu, kiểm soát thao tác, kiểm soát lỗi)
- Bố cục chuẩn cho 4 loại màn hình: Tổng quan, Danh sách (6 biến thể), Thêm/Sửa, Chi tiết
- Quy tắc component theo bộ XDS Web Components, kèm **spec chi tiết từng component** (Input, Tab, Tree, Date time picker, Icon...)
- Header Xoăn tối giản (logo + tên app + tìm kiếm + Thiết lập + avatar)
- Checklist kiểm tra UI trước khi bàn giao

## Cấu trúc

```
xoan-design-system/
├── SKILL.md                          # Chuẩn Agent Skills — Claude Code / Codex
├── AGENTS.md                         # Chuẩn AGENTS.md — Cursor, Antigravity, Copilot, Zed...
├── install.sh                        # Script cài tự động cho từng agent
├── assets/
│   ├── tokens.css                    # Token nhanh (thang Brand Blue, trạng thái, size)
│   ├── tokens/                       # Token CSS sinh từ Figma variables:
│   │   ├── themes/                   #   10 theme màu app (blue, indigo, teal...)
│   │   ├── base-colors.css           #   Info/Warning/Danger/Success/Neutral 50→950
│   │   ├── space-*.css               #   3 chế độ mật độ spacing từng component
│   │   ├── chart-*.css               #   Bảng màu biểu đồ (palette/divergent/single-hue)
│   │   ├── number.css · font.css     #   Spacing/radius scale, font
│   ├── figma-tokens/                 # JSON gốc export từ Figma (nguồn để build lại)
│   ├── theme-preview.html            # Trang chọn tone màu — mở cho user chọn 1/10 theme
│   └── icons/                        # Icon SVG chuẩn stroke 1.5px (không search mạng)
├── scripts/build-tokens.py           # Sinh lại assets/tokens/ khi có export Figma mới
└── references/
    ├── general-design-rules.md       # 4 nguyên tắc thiết kế chung
    ├── usability-requirements.md     # Yêu cầu tiện dụng (Tab order, SelectAll, tooltip...)
    ├── layout-patterns.md            # Bố cục các loại màn hình
    ├── styles.md                     # Hệ màu 2 cấp, Text Styles (Inter), quy tắc icon
    ├── communication.md              # Thông báo, dialog, loading, empty state, error page, biểu đồ
    ├── conventions.md                # Phím tắt, chính tả, định dạng số VN, icon dùng chung...
    ├── components.md                 # Quy tắc chung khi dùng component XDS
    ├── patterns/                     # Data table (chọn dòng/phân trang/lọc/sắp xếp),
    │                                 # Header bar, Sidebar, Popup/Form
    └── components/                   # Spec từng component: button, text-field, dropdown,
        │                             # combobox, checkbox, radio, date-time-picker,
        │                             # context-menu, input, tab, tree, icon...
        └── icons-map.md              # Bảng tra: hành động → file icon + token màu
```

## Cài đặt

Clone / copy repo về máy một lần, rồi chạy script cài cho agent bạn dùng:

```bash
cd ~/Xoan-design-system
```

| Agent | Lệnh cài | Cơ chế |
|---|---|---|
| **Claude Code** | `./install.sh claude` | Skill tại `~/.claude/skills/xoan-design-system` (toàn máy) |
| **Codex** | `./install.sh codex` | Skill tại `~/.codex/skills/xoan-design-system` (toàn máy) |
| **Cursor** | `./install.sh cursor /đường/dẫn/project` | Rule tại `.cursor/rules/` + docs trong project |
| **VS Code (Copilot)** | `./install.sh vscode /đường/dẫn/project` | Instructions tại `.github/instructions/` |
| **Kiro** | `./install.sh kiro /đường/dẫn/project` | Steering tại `.kiro/steering/` |
| **Antigravity / Zed / khác** | `./install.sh antigravity /đường/dẫn/project` | Tạo/nối vào `AGENTS.md` của project |

Với Cursor/VS Code/Kiro/Antigravity, script đồng thời copy toàn bộ quy chuẩn vào `docs/xoan-design-system/` của project để agent đọc chi tiết khi cần — nhớ commit các file này vào git của project để cả team dùng chung.

### Xcode (Coding Intelligence)

Xcode chưa có cơ chế rules file tự động. Cách dùng:
1. Chạy `./install.sh antigravity /đường/dẫn/project` để có `docs/xoan-design-system/` trong project.
2. Khi chat với Coding Intelligence, đính kèm hoặc yêu cầu: *"Đọc docs/xoan-design-system/xoan-design-rules.md và tuân theo khi làm UI"*. Nếu dùng Claude qua Xcode, nội dung project có `AGENTS.md` cũng sẽ được tham chiếu.

### Cài thủ công (không dùng script)

- **Claude Code:** copy toàn bộ repo vào `~/.claude/skills/xoan-design-system`.
- **Agent đọc AGENTS.md:** copy `AGENTS.md` + thư mục `references/` vào project.

## Đóng góp

Khi quy chuẩn thiết kế Xoăn thay đổi: cập nhật file trong `references/`, đồng bộ quy tắc cốt lõi ở cả `SKILL.md` lẫn `AGENTS.md`. Có thêm component mới từ Figma? Export và trích xuất thành file mới trong `references/components/`.

---
Tài liệu quy chuẩn thiết kế nội bộ Xoăn.
