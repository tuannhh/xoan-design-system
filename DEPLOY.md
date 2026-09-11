# Deploy XDS UI Playground — Hướng dẫn

Playground giúp PD/PM xem bộ control mới trực tiếp trên web, đóng feedback tập trung. Sau đây là hướng dẫn triển khai trên **Vercel** (khuyến nghị) hoặc **Netlify** — cả hai đều free, tự động deploy khi push GitHub.

## Lựa chọn platform

| Platform | Giá | Khởi động | Tích hợp GitHub |
|---|---|---|---|
| **Vercel** (khuyến nghị) | Free (≤100 GB bandwidth/tháng) | 2 phút | Auto — push là deploy |
| Netlify | Free (≤100 GB bandwidth/tháng) | 2 phút | Auto |
| Railway | Miễn phí (limited giờ/tháng) rồi tính tiền | 3 phút | Thủ công |
| Google Cloud Run | Free (2M request/tháng) | 5 phút | Thủ công |

## 1️⃣ Deploy trên Vercel (nhanh nhất — khuyến nghị)

### Bước 1: Push playground vào GitHub (nếu chưa)
```bash
cd ~/Xoan-design-system
git add -A && git commit -m "ui/playground: sẵn sàng deploy"
git push origin main
```

### Bước 2: Connect Vercel vào repo
1. Truy cập https://vercel.com (đăng nhập bằng GitHub)
2. Chọn **Add New** → **Project**
3. Import repo `xoan-design-system` từ GitHub
4. Cấu hình:
   - **Framework Preset**: Vue
   - **Root Directory**: `ui/playground`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Nhấn **Deploy** — xong trong ~30s, Vercel tự cấp URL

### Bước 3: Mỗi lần cập nhật
```bash
# Sửa code, commit, push
git commit -am "ui/components: sửa XButton hover state"
git push origin main
# Vercel tự deploy (~30s)
```

## 2️⃣ Deploy trên Netlify (thay thế nếu Vercel ko dùng được)

### Bước 1: Push như trên

### Bước 2: Connect Netlify
1. Truy cập https://netlify.com (đăng nhập bằng GitHub)
2. Chọn **Add new site** → **Import an existing project**
3. Chọn repo `xoan-design-system`
4. Cấu hình:
   - **Base directory**: `ui/playground`
   - **Build command**: `npm run build`
   - **Publish directory**: `dist`
5. Nhấn **Deploy** — xong trong ~1 phút

## 3️⃣ Local build để test trước deploy

```bash
cd ui/playground
npm run build
npm run preview    # mở http://localhost:4173 để test production build
```

## Feedback từ PD

**Cách 1 — GitHub Issues (khuyến nghị)**
- Tạo issue template: `.github/ISSUE_TEMPLATE/xds-ui-feedback.md`
- PD vào repo → Issues → mô tả cảm nhận/đề xuất

**Cách 2 — Form bên trong playground**
- Thêm modal "📝 Góp ý" ở app — submit tự gửi email hoặc webhook

**Cách 3 — Slack channel riêng**
- `#xds-ui-feedback` — PD post screenshot + comment

## URL công cộng

Sau deploy, share link này cho PD:
- **Vercel**: `https://xoan-design-system.vercel.app` (hoặc tên khác Vercel gán)
- **Netlify**: `https://xoan-design-system-ui.netlify.app`

## Cách thay đổi URL (tùy chọn)

Cả Vercel và Netlify cho phép thay đổi tên miền. Ví dụ:
- Vercel: Project → Settings → Domains → Add → `xds-ui.vercel.app` (miễn phí)
- Netlify: Site settings → General → Site details → Change site name

Hoặc mua domain riêng (ví dụ `design-ui.example.com`) — hướng dẫn chi tiết ở trang Vercel/Netlify.

---

**Khuyến nghị cuối cùng**: Deploy Vercel ngay bây giờ, share link cho PD xem + feedback 1 tuần, rồi tiếp tục Đợt 2 (DataTable, DatePicker...) dựa trên ý kiến họ.
