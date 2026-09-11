#!/usr/bin/env bash
# Cài quy chuẩn Xoăn Design System (XDS) cho coding agent.
#
# Cách dùng:
#   ./install.sh <agent> [thư-mục-project]
#
#   <agent>: claude | codex | cursor | vscode | kiro | antigravity | agents
#   [thư-mục-project]: bắt buộc với cursor/vscode/kiro/antigravity/agents
#                      (mặc định: thư mục hiện tại)
#
# Ví dụ:
#   ./install.sh claude                    # cài toàn máy cho Claude Code
#   ./install.sh cursor ~/projects/my-app  # cài cho Cursor trong project my-app

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENT="${1:-}"
PROJECT="${2:-$(pwd)}"

if [ -z "$AGENT" ]; then
  grep '^#' "$0" | sed 's/^# \{0,1\}//' | head -14
  exit 1
fi

# Copy toàn bộ quy chuẩn vào project (docs/xoan-design-system) để agent đọc references
copy_docs() {
  local dest="$PROJECT/docs/xoan-design-system"
  mkdir -p "$dest/ui" "$dest/scripts"
  cp "$SKILL_DIR/AGENTS.md" "$dest/xoan-design-rules.md"
  cp "$SKILL_DIR/MEMORY.md" "$dest/"
  cp -R "$SKILL_DIR/references" "$SKILL_DIR/assets" "$dest/"
  cp "$SKILL_DIR/scripts/build-icon-registry.py" "$SKILL_DIR/scripts/build-tokens.py" "$dest/scripts/"
  cp -R "$SKILL_DIR/ui/components" "$SKILL_DIR/ui/templates" "$SKILL_DIR/ui/README.md" "$SKILL_DIR/ui/CONVENTIONS.md" "$dest/ui/"
  echo "→ Đã copy quy chuẩn + bộ control vào $dest"
}

# Tạo file rule trỏ tới bộ quy chuẩn, kèm quy tắc cốt lõi inline
rule_body() {
  cat <<'EOF'
Mọi UI cho ứng dụng Xoăn phải tuân theo quy chuẩn Xoăn Design System (XDS).

TRƯỚC KHI tạo/sửa bất kỳ giao diện nào, đọc: docs/xoan-design-system/xoan-design-rules.md
và các file trong docs/xoan-design-system/references/ (layout-patterns.md cho bố cục màn hình,
components.md + components/*.md cho spec từng component).

Quy tắc cốt lõi không được vi phạm:
- Nút Primary luôn ngoài cùng bên phải toolbar/form; nút More (⋯) ngay bên phải Primary.
- Màn Thêm/Sửa: nút Lưu/Hủy ghim (sticky) cuối trang. Màn Chi tiết: nút thao tác ghim góc trên phải.
- Màn Danh sách: nền xám, bảng cách lề; tiêu đề trái — thao tác phải; click dòng mở chi tiết.
- Mọi click có phản hồi (disable/busy indicator); xử lý > 5s có progress bar.
- Lỗi nhập liệu: thông báo tiếng Việt dễ hiểu, focus trường lỗi đầu tiên.
- 2–3 lựa chọn dùng radio/checkbox; 4–8 dùng dropdown; >8 dùng combo box (AutoComplete + LoadOnDemand).
- Icon/phím tắt đồng nhất toàn app, có tooltip. Icon dùng Tabler stroke 1.5px qua XIcon, không inline SVG.
- Header Xoăn tối giản: chỉ logo + tên app + ô tìm kiếm + nút Thiết lập + avatar người dùng.
  KHÔNG có nút 9 chấm chuyển app, trợ lý AI, tin nhắn/thông báo/trợ giúp/khác, badge năm dữ liệu, chọn công ty.
- Mobile nhúng trong native host: đọc references/patterns/mobile-native-app.md;
  không dựng lại status bar/launcher/nav hệ sinh thái; touch/input 48px; button/tab/nav label một dòng.
- Màu sắc/kích thước: dùng token trong docs/xoan-design-system/assets/tokens.css, không hard-code hex.
EOF
}

# cp trên macOS có thể in lỗi từng file nhưng vẫn trả mã thành công khi copy nhiều nguồn.
# Xác minh lại để không báo cài đặt thành công khi skill toàn máy đang cũ hoặc thiếu file.
verify_global_install() {
  local dest="$1"
  local source target
  for source in SKILL.md MEMORY.md references assets; do
    target="$dest/$source"
    if ! diff -qr "$SKILL_DIR/$source" "$target" >/dev/null; then
      echo "✗ Cài đặt chưa hoàn tất: $target không khớp với bản nguồn"
      return 1
    fi
  done
  for source in components templates README.md CONVENTIONS.md; do
    target="$dest/ui/$source"
    if ! diff -qr "$SKILL_DIR/ui/$source" "$target" >/dev/null; then
      echo "✗ Cài đặt chưa hoàn tất: $target không khớp với bản nguồn"
      return 1
    fi
  done
  for source in build-icon-registry.py build-tokens.py; do
    if ! diff -q "$SKILL_DIR/scripts/$source" "$dest/scripts/$source" >/dev/null; then
      echo "✗ Cài đặt chưa hoàn tất: $dest/scripts/$source không khớp với bản nguồn"
      return 1
    fi
  done
}

case "$AGENT" in
  claude)
    DEST="$HOME/.claude/skills/xoan-design-system"
    mkdir -p "$DEST/ui" "$DEST/scripts"
    cp -R "$SKILL_DIR/SKILL.md" "$SKILL_DIR/MEMORY.md" "$SKILL_DIR/references" "$SKILL_DIR/assets" "$DEST/"
    cp "$SKILL_DIR/scripts/build-icon-registry.py" "$SKILL_DIR/scripts/build-tokens.py" "$DEST/scripts/"
    cp -R "$SKILL_DIR/ui/components" "$SKILL_DIR/ui/templates" "$SKILL_DIR/ui/README.md" "$SKILL_DIR/ui/CONVENTIONS.md" "$DEST/ui/"
    verify_global_install "$DEST"
    echo "✓ Claude Code: đã cài skill vào $DEST"
    ;;
  codex)
    DEST="$HOME/.codex/skills/xoan-design-system"
    mkdir -p "$DEST/ui" "$DEST/scripts"
    cp -R "$SKILL_DIR/SKILL.md" "$SKILL_DIR/MEMORY.md" "$SKILL_DIR/references" "$SKILL_DIR/assets" "$DEST/"
    cp "$SKILL_DIR/scripts/build-icon-registry.py" "$SKILL_DIR/scripts/build-tokens.py" "$DEST/scripts/"
    cp -R "$SKILL_DIR/ui/components" "$SKILL_DIR/ui/templates" "$SKILL_DIR/ui/README.md" "$SKILL_DIR/ui/CONVENTIONS.md" "$DEST/ui/"
    verify_global_install "$DEST"
    echo "✓ Codex: đã cài skill vào $DEST"
    ;;
  cursor)
    copy_docs
    mkdir -p "$PROJECT/.cursor/rules"
    {
      echo "---"
      echo "description: Quy chuẩn UI Xoăn Design System (XDS) — áp dụng khi tạo/sửa giao diện"
      echo "alwaysApply: true"
      echo "---"
      rule_body
    } > "$PROJECT/.cursor/rules/xoan-design-system.mdc"
    echo "✓ Cursor: đã tạo .cursor/rules/xoan-design-system.mdc"
    ;;
  vscode)
    copy_docs
    mkdir -p "$PROJECT/.github/instructions"
    {
      echo "---"
      echo "applyTo: \"**\""
      echo "---"
      rule_body
    } > "$PROJECT/.github/instructions/xoan-design-system.instructions.md"
    echo "✓ VS Code (Copilot): đã tạo .github/instructions/xoan-design-system.instructions.md"
    ;;
  kiro)
    copy_docs
    mkdir -p "$PROJECT/.kiro/steering"
    rule_body > "$PROJECT/.kiro/steering/xoan-design-system.md"
    echo "✓ Kiro: đã tạo .kiro/steering/xoan-design-system.md"
    ;;
  antigravity|agents)
    copy_docs
    if [ -f "$PROJECT/AGENTS.md" ]; then
      if ! grep -q "Xoăn Design System" "$PROJECT/AGENTS.md"; then
        { echo ""; echo "## Quy chuẩn UI Xoăn Design System (XDS)"; echo ""; rule_body; } >> "$PROJECT/AGENTS.md"
        echo "✓ Đã nối quy chuẩn vào AGENTS.md có sẵn"
      else
        echo "✓ AGENTS.md đã có quy chuẩn Xoăn — bỏ qua"
      fi
    else
      { echo "# AGENTS.md"; echo ""; echo "## Quy chuẩn UI Xoăn Design System (XDS)"; echo ""; rule_body; } > "$PROJECT/AGENTS.md"
      echo "✓ Đã tạo AGENTS.md (Antigravity/Codex/Zed... đọc file này)"
    fi
    ;;
  *)
    echo "Agent không hỗ trợ: $AGENT (dùng: claude | codex | cursor | vscode | kiro | antigravity | agents)"
    exit 1
    ;;
esac
