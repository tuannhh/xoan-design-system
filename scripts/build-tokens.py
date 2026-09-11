#!/usr/bin/env python3
"""Sinh CSS tokens từ bộ export Figma variables (W3C design tokens JSON).

Cách dùng: đặt các file .tokens.json vào assets/figma-tokens/<collection>/,
rồi chạy:  python3 scripts/build-tokens.py
Kết quả ghi vào assets/tokens/ — chạy lại mỗi khi đội Product Design cập nhật variables.
"""
import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "assets" / "figma-tokens"
OUT = ROOT / "assets" / "tokens"
OUT.mkdir(parents=True, exist_ok=True)
CHECK = False


def walk(obj, prefix=""):
    items = []
    if isinstance(obj, dict):
        if "$value" in obj:
            items.append((prefix, obj["$value"], obj.get("$type")))
        else:
            for k, v in obj.items():
                items.extend(walk(v, f"{prefix}/{k}" if prefix else k))
    return items


def slug(path):
    s = path.lower().replace("/", "-").replace(" ", "-")
    s = re.sub(r"[^a-z0-9-]", "", s)
    return re.sub(r"-+", "-", s).strip("-")


def value_str(v, t, var_prefix):
    if isinstance(v, str):
        alias = re.fullmatch(r"\{([^{}]+)\}", v.strip())
        if alias:
            alias_path = alias.group(1).replace(".", "/")
            return f"var(--{var_prefix}-{slug(alias_path)})"
    if isinstance(v, dict) and "hex" in v:
        hexv = v["hex"].upper()
        if v.get("alpha", 1) != 1:
            a = v["alpha"]
            r, g, b = (round(c * 255) for c in v["components"])
            return f"rgba({r}, {g}, {b}, {a:g})"
        return hexv
    if t == "number":
        return f"{v}px"
    return str(v)


def emit(json_path, css_path, var_prefix, selector=":root", header=""):
    tokens = walk(json.loads(json_path.read_text()))
    lines = [f"/* {header} — sinh tự động bởi scripts/build-tokens.py, không sửa tay */", selector + " {"]
    for path, v, t in tokens:
        lines.append(f"  --{var_prefix}-{slug(path)}: {value_str(v, t, var_prefix)};")
    lines.append("}\n")
    output = "\n".join(lines)
    unresolved = re.findall(r"\{[^{}\n;]+(?:\.[^{}\n;]+)+\}", output)
    if unresolved:
        raise ValueError(f"Unresolved token aliases in {css_path}: {unresolved}")
    if CHECK:
        if not css_path.exists() or css_path.read_text() != output:
            raise ValueError(f"Stale token output: {css_path}; run scripts/build-tokens.py")
    else:
        css_path.write_text(output)
    return len(tokens)


def main():
    global CHECK
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--check",
        action="store_true",
        help="fail when generated CSS is stale or contains unresolved aliases",
    )
    CHECK = parser.parse_args().check
    total = 0
    # Base Colors → base-colors.css
    f = SRC / "base-colors" / "Mode 1.tokens.json"
    if f.exists():
        total += emit(f, OUT / "base-colors.css", "xds-base", ":root", "XDS Base Colors (Info/Warning/Danger/Success/Neutral/Alpha)")

    # Themes → themes/<name>.css ; mỗi theme dùng attribute selector để chuyển theme runtime
    tdir = SRC / "themes"
    if tdir.exists():
        (OUT / "themes").mkdir(exist_ok=True)
        for f in sorted(tdir.glob("*.tokens.json")):
            name = slug(f.stem.replace(".tokens", ""))
            sel = f':root, [data-xds-theme="{name}"]' if name == "blue" else f'[data-xds-theme="{name}"]'
            total += emit(f, OUT / "themes" / f"{name}.css", "xds", sel, f"XDS Theme: {f.stem} (Brand 50-900 + Text/Icon/Stroke/Bg)")

    # Number → number.css (spacing, radius...)
    f = SRC / "number" / "Mode 1.tokens.json"
    if f.exists():
        total += emit(f, OUT / "number.css", "xds", ":root", "XDS Number tokens (spacing/padding, radius, size)")

    # Space (mật độ giao diện) → space-<mode>.css
    sdir = SRC / "space"
    if sdir.exists():
        for f in sorted(sdir.glob("*.tokens.json")):
            name = slug(f.stem.replace(".tokens", ""))
            sel = f':root, [data-xds-space="{name}"]' if name == "standard" else f'[data-xds-space="{name}"]'
            total += emit(f, OUT / f"space-{name}.css", "xds-space", sel, f"XDS Space mode: {f.stem} (spacing chi tiết từng component)")

    # Chart Colors → chart-<mode>.css
    cdir = SRC / "chart-colors"
    if cdir.exists():
        for f in sorted(cdir.glob("*.tokens.json")):
            name = slug(f.stem.replace(".tokens", ""))
            total += emit(f, OUT / f"chart-{name}.css", "xds-chart", ":root", f"XDS Chart Colors: {f.stem}")

    # Font Family → font.css
    f = SRC / "font-family" / "Inter.tokens.json"
    if f.exists():
        total += emit(f, OUT / "font.css", "xds", ":root", "XDS Font Family/Weight")

    mode = "checked" if CHECK else "generated"
    print(f"OK: {mode} {total} tokens → {OUT}")


if __name__ == "__main__":
    main()
