<script setup>
/**
 * DashboardPage — template màn hình Tổng quan (Dashboard) chuẩn XDS, ứng dụng
 * "app Nhân sự" (đồng bộ với ListPage/FormPage/DetailPage cùng bộ demo).
 * Dựng theo cấu trúc bộ demo chuẩn của giám đốc thiết kế (đối chiếu 2026-07):
 * header 48px + sub-nav 48px, sidebar 200/64px hover-overlay, card dùng
 * .xds-card (shadow-card thay border), dialog Thiết lập màu sắc/hiển thị,
 * bảng mini trong card, biểu đồ ECharts theo spec communication.md.
 */
import { computed, ref, watch } from 'vue'
import XHeaderBar from '../components/XHeaderBar.vue'
import XSidebar from '../components/XSidebar.vue'
import XSettingsDialog from '../components/XSettingsDialog.vue'
import XDropdownMenu from '../components/XDropdownMenu.vue'
import XChart from '../components/XChart.vue'
import XIcon from '../components/XIcon.vue'
import XTabs from '../components/XTabs.vue'
import XToast from '../components/XToast.vue'
import { useToast } from '../components/toast.js'
import { currentHeaderMode, sidebarCollapsed } from '../components/theme-state.js'

const toast = useToast()

/* ── Menu người dùng ở cụm phải header: dựng ở tầng template bằng XDropdownMenu
   (đã có sẵn keyboard ↑↓/Enter/Esc + outside click) qua slot "user" — không
   hard-code nghiệp vụ vào XHeaderBar. ── */
const userMenuItems = [
  { key: 'profile', label: 'Thông tin tài khoản', icon: 'user' },
  { key: 'security', label: 'Đổi mật khẩu', icon: 'lock' },
  { divider: true },
  { key: 'logout', label: 'Đăng xuất', icon: 'logout', danger: true },
]
function onUserMenuSelect(key) { toast.info(key === 'logout' ? 'Đã đăng xuất (demo)' : `Tài khoản: ${key}`) }

/* ── Điều hướng — cùng cấu trúc sidebar với ListPage để 2 trang nhất quán ── */

const sidebarItems = [
  { key: 'dashboard', label: 'Tổng quan', icon: 'home' },
  {
    key: 'nhan-vien',
    label: 'Nhân viên',
    icon: 'users',
    children: [
      { key: 'ds-nhan-vien', label: 'Danh sách' },
      { key: 'hop-dong', label: 'Hợp đồng' },
    ],
  },
  { key: 'cham-cong', label: 'Chấm công', icon: 'calendar' },
  { key: 'bao-cao', label: 'Báo cáo', icon: 'chart-bar' },
  { key: 'thiet-lap', label: 'Thiết lập', icon: 'settings' },
]
const activeMenu = ref('dashboard')

// Các mục còn lại có dữ liệu demo ở màn hình Danh sách (ListPage) → điều hướng sang đó
watch(activeMenu, (val) => {
  if (val !== 'dashboard') location.hash = 'list'
})

const subTabs = [
  { key: 'tong-quan', label: 'Tổng quan' },
  { key: 'tinh-nang-moi', label: 'Tính năng mới' },
]
const activeSubTab = ref('tong-quan')

/* ── Dialog Thiết lập ───────────────────────────────────────── */
const showSettings = ref(false)

/* ── Màu biểu đồ — computed để tự đổi theo theme (Settings dialog) ── */
function cssVar(name) {
  if (typeof window === 'undefined') return ''
  return getComputedStyle(document.documentElement).getPropertyValue(name).trim()
}
// currentHeaderMode chỉ đổi mode header; đọc lại token khi component mount là đủ
// vì props XHeaderBar/XSettingsDialog tự re-render theo theme đang áp dụng.
const brand600 = computed(() => cssVar('--xds-brand-600'))
const success = computed(() => cssVar('--xds-success'))
const warning = computed(() => cssVar('--xds-warning'))
const info = computed(() => cssVar('--xds-info'))
const danger = computed(() => cssVar('--xds-danger'))
const textMuted = computed(() => cssVar('--xds-text-muted'))
const border = computed(() => cssVar('--xds-border'))

const axisLabel = computed(() => ({ color: textMuted.value, fontSize: 11, fontFamily: 'Inter' }))
const splitLine = computed(() => ({ lineStyle: { color: cssVar('--xds-bg-disabled') } }))
// Legend chuẩn dashboard: dưới chart, chữ nhỏ uppercase, chấm màu — theo communication.md
const legendBelow = computed(() => ({
  bottom: 0, left: 'center', icon: 'circle', itemWidth: 8, itemHeight: 8, itemGap: 16,
  textStyle: { color: textMuted.value, fontSize: 11, fontFamily: 'Inter' },
}))

/* ── Chi nhánh (bộ lọc trên cùng) ───────────────────────────── */
const branchName = ref('Chi nhánh Hà Nội')

/* ── Row 1: Tình hình nhân sự + 2 card đơn chờ duyệt ─────────── */
const periodTch = ref('Tháng này')
const nsLeft = [
  { label: 'Đang làm việc', value: '1.192' },
  { label: 'Thử việc', value: '68' },
  { label: 'Nghỉ phép', value: '14' },
  { label: 'Đã nghỉ việc', value: '10' },
]
const nsRight = [
  { label: 'Tuyển mới tháng', value: '36' },
  { label: 'Nghỉ việc tháng', value: '12' },
  { label: 'Tỷ lệ nghỉ', value: '0,9%' },
  { label: 'Số phòng ban', value: '6' },
]
const tongNhanSu = '1.284'

const periodNghiPhep = ref('Tháng này')
const donNghiPhep = { total: '18', overdue: '3', current: '15' }
const donNghiPhepPct = 16.7 // % quá hạn xử lý/tổng, chỉ để vẽ thanh tiến trình minh họa

const donTangCa = { total: '0', overdue: '0', current: '0' }

/* ── Row 2: Tuyển mới/Nghỉ việc/Chênh lệch + Nhân sự theo phòng ban ── */
const periodBar = ref('Năm nay')
const MONTHS = ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12']

const newHireData = [18, 22, 31, 26, 24, 28, 33, 29, 35, 30, 27, 36]
const leaveData = [8, 6, 10, 7, 9, 12, 8, 11, 9, 13, 10, 12]
const netData = newHireData.map((v, i) => v - leaveData[i])

const barLineOption = computed(() => ({
  legend: legendBelow.value,
  grid: { left: 8, right: 8, top: 16, bottom: 32, containLabel: true },
  tooltip: { trigger: 'axis' },
  xAxis: { type: 'category', data: MONTHS, axisLabel: axisLabel.value, axisTick: { show: false }, axisLine: { lineStyle: { color: border.value } } },
  yAxis: { type: 'value', axisLabel: axisLabel.value, splitLine: splitLine.value },
  series: [
    { name: 'TUYỂN MỚI', type: 'bar', data: newHireData, barMaxWidth: 14, itemStyle: { color: brand600.value, borderRadius: [4, 4, 0, 0] } },
    { name: 'NGHỈ VIỆC', type: 'bar', data: leaveData, barMaxWidth: 14, itemStyle: { color: '#98A2B3', borderRadius: [4, 4, 0, 0] } },
    { name: 'CHÊNH LỆCH RÒNG', type: 'line', data: netData, smooth: true, symbolSize: 6, lineStyle: { color: warning.value, width: 2 }, itemStyle: { color: warning.value } },
  ],
}))

const departmentTotal = '1.284'
const departmentRows = [
  { name: 'Kinh doanh', qty: '412', value: '32,1%', color: '#F59E0B' },
  { name: 'Phát triển sản phẩm', qty: '296', value: '23,1%', color: '#3B82F6' },
  { name: 'Chăm sóc khách hàng', qty: '188', value: '14,6%', color: '#8B5CF6' },
  { name: 'Marketing', qty: '152', value: '11,8%', color: '#6B7280' },
  { name: 'Kế toán', qty: '132', value: '10,3%', color: '#EF4444' },
]

/* ── Row 3: Tổng nhân sự qua các tháng + Phòng ban tuyển nhiều nhất ── */
const periodRev = ref('Năm nay')
const headcountTotal = '1.284'
const headcountTrend = [1180, 1188, 1201, 1214, 1222, 1219, 1231, 1244, 1252, 1265, 1271, 1284]
const headcountOnly = computed(() => ({
  grid: { left: 8, right: 8, top: 16, bottom: 8, containLabel: true },
  tooltip: { trigger: 'axis' },
  legend: { show: false },
  xAxis: { type: 'category', boundaryGap: false, data: MONTHS, axisLabel: axisLabel.value, axisTick: { show: false }, axisLine: { lineStyle: { color: border.value } } },
  yAxis: { type: 'value', axisLabel: axisLabel.value, splitLine: splitLine.value },
  series: [{
    type: 'line', data: headcountTrend, smooth: true, symbolSize: 6,
    lineStyle: { color: brand600.value, width: 2 }, itemStyle: { color: brand600.value },
    areaStyle: { color: { type: 'linear', x: 0, y: 0, x2: 0, y2: 1, colorStops: [{ offset: 0, color: brand600.value + '33' }, { offset: 1, color: brand600.value + '00' }] } },
  }],
}))

const periodSell = ref('Năm nay')
const hiringTotal = '36'
const hiringRows = [
  { name: 'Kinh doanh', qty: '14', revenue: '38,9%', color: '#3B82F6' },
  { name: 'Phát triển sản phẩm', qty: '8', revenue: '22,2%', color: '#8B5CF6' },
  { name: 'Chăm sóc khách hàng', qty: '6', revenue: '16,7%', color: '#F59E0B' },
  { name: 'Marketing', qty: '5', revenue: '13,9%', color: '#6B7280' },
  { name: 'Kế toán', qty: '3', revenue: '8,3%', color: '#F97316' },
]

/* ── Row 4: Chấm công + Cơ cấu quỹ lương ──────────────────────── */
const periodCash = ref('Năm nay')
const onTimeData = [1020, 1040, 1062, 1078, 1090, 1085, 1102, 1118, 1130, 1145, 1158, 1170]
const lateData = [64, 58, 70, 62, 66, 72, 68, 74, 70, 78, 74, 80]
const leaveOffData = onTimeData.map((v, i) => Math.max(0, tongNhanSuInt() - v - lateData[i]))
function tongNhanSuInt() { return 1284 }

const attendanceOption = computed(() => ({
  legend: legendBelow.value,
  grid: { left: 8, right: 8, top: 16, bottom: 32, containLabel: true },
  tooltip: { trigger: 'axis' },
  xAxis: { type: 'category', data: MONTHS, axisLabel: axisLabel.value, axisTick: { show: false }, axisLine: { lineStyle: { color: border.value } } },
  yAxis: { type: 'value', axisLabel: axisLabel.value, splitLine: splitLine.value },
  series: [
    { name: 'ĐÚNG GIỜ', type: 'line', data: onTimeData, smooth: true, symbolSize: 6, lineStyle: { color: success.value, width: 2 }, itemStyle: { color: success.value } },
    { name: 'ĐI MUỘN', type: 'line', data: lateData, smooth: true, symbolSize: 6, lineStyle: { color: warning.value, width: 2 }, itemStyle: { color: warning.value } },
    { name: 'NGHỈ PHÉP', type: 'line', data: leaveOffData, smooth: true, symbolSize: 6, lineStyle: { color: info.value, width: 2 }, itemStyle: { color: info.value } },
  ],
}))

const periodCost = ref('Năm nay')
const payrollItems = [
  { name: 'Lương cơ bản', color: '#F43F5E', value: 58 },
  { name: 'Thưởng KPI', color: '#3B82F6', value: 20 },
  { name: 'BHXH / BHYT', color: '#A78BFA', value: 14 },
  { name: 'Phụ cấp khác', color: '#1E293B', value: 8 },
]
const payrollTotal = '32.480'
const payrollOption = computed(() => ({
  tooltip: { trigger: 'item' },
  legend: { show: false },
  series: [{
    type: 'pie', radius: ['55%', '80%'], center: ['50%', '50%'], padAngle: 2,
    itemStyle: { borderRadius: 4 }, label: { show: false },
    data: payrollItems.map((d) => ({ name: d.name, value: d.value, itemStyle: { color: d.color } })),
  }],
}))
</script>

<template>
  <div
    class="flex h-full flex-col overflow-hidden bg-[var(--xds-bg-page)] text-[13px] leading-[18px] text-[var(--xds-text)]"
    :style="{ fontFamily: 'var(--xds-font-family)' }"
  >
    <!-- Header: mode do người dùng chọn trong dialog Thiết lập, dùng chung mọi trang -->
    <XHeaderBar
      :variant="currentHeaderMode"
      app-name="app Nhân sự"
      search-placeholder="Tìm kiếm trong app Nhân sự"
      @search="toast.info('Mở tìm kiếm toàn hệ thống')"
      @settings="showSettings = true"
    >
      <template #user>
        <XDropdownMenu :items="userMenuItems" placement="bottom-end" @select="onUserMenuSelect">
          <template #activator>
            <button type="button" class="h-8 w-8 shrink-0 overflow-hidden rounded-full bg-[var(--xds-brand-100)] text-[12px] font-semibold text-[var(--xds-brand-700)] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]" title="Nguyễn Văn An" aria-label="Nguyễn Văn An">
              <span aria-hidden="true" class="flex h-full w-full items-center justify-center">NV</span>
            </button>
          </template>
        </XDropdownMenu>
      </template>
    </XHeaderBar>

    <!-- Sub-nav 48px -->
    <div class="flex h-12 shrink-0 items-center justify-between border-b border-[var(--xds-border-light,var(--xds-border))] bg-[var(--xds-bg)] px-4">
      <XTabs v-model="activeSubTab" :tabs="subTabs" class="[&_[role=tablist]]:border-b-0" />
      <button type="button" class="flex items-center gap-1.5 text-[13px] font-medium text-[var(--xds-success)] hover:underline">
        <XIcon name="check" :size="12" />
        Bắt đầu sử dụng
      </button>
    </div>

    <div class="flex min-h-0 flex-1">
      <XSidebar v-model="activeMenu" v-model:collapsed="sidebarCollapsed" :items="sidebarItems" />

      <!-- Main nền xám, cuộn dọc -->
      <main class="min-h-0 min-w-0 flex-1 overflow-y-auto p-4">
        <!-- Chi nhánh filter -->
        <div class="mb-3 flex items-center gap-2 text-[13px] text-[var(--xds-text-secondary,var(--xds-text-muted))]">
          <span class="shrink-0">Chi nhánh</span>
          <button type="button" class="flex items-center gap-1 text-[13px] font-medium text-[var(--xds-text)] hover:text-[var(--xds-brand-600)]">
            {{ branchName }}
            <XIcon name="chevron-down" :size="12" />
          </button>
        </div>

        <!-- ── Row 1: Tình hình nhân sự + 2 card đơn chờ duyệt ── -->
        <div class="grid grid-cols-1 gap-4 xl:grid-cols-[1.7fr_1fr_1fr]">
          <!-- Tình hình nhân sự -->
          <section class="group xds-card p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Tình hình nhân sự</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodTch" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Tháng này</option>
                  <option>Quý này</option>
                  <option>Năm nay</option>
                </select>
              </div>
            </div>
            <p class="mb-2 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <div class="flex gap-0">
              <div class="flex-1">
                <div class="flex items-center justify-between border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5">
                  <span class="text-[12px] font-semibold uppercase text-[var(--xds-text-secondary,var(--xds-text-muted))]">Tổng nhân sự</span>
                  <span class="text-[13px] font-semibold">{{ tongNhanSu }}</span>
                </div>
                <div v-for="r in nsLeft" :key="r.label" class="flex items-center justify-between border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 pl-2 last:border-b-0">
                  <span class="text-[13px] text-[var(--xds-text-secondary,var(--xds-text-muted))]">{{ r.label }}</span>
                  <span class="text-[13px] font-semibold text-[var(--xds-brand-600)]">{{ r.value }}</span>
                </div>
              </div>
              <div class="mx-4 w-px shrink-0 bg-[var(--xds-border-light,var(--xds-border))]" />
              <div class="flex-1">
                <div v-for="r in nsRight" :key="r.label" class="flex items-center justify-between border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 last:border-b-0">
                  <span class="text-[13px] text-[var(--xds-text-secondary,var(--xds-text-muted))]">{{ r.label }}</span>
                  <span class="text-[13px] font-semibold text-[var(--xds-brand-600)]">{{ r.value }}</span>
                </div>
              </div>
            </div>
            <div class="mt-2 border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 15h47
              <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>

          <!-- Đơn nghỉ phép chờ duyệt -->
          <section class="group xds-card flex flex-col p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Đơn nghỉ phép chờ duyệt</h3>
              <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
              </button>
            </div>
            <div class="mt-2 flex items-baseline gap-1.5">
              <span class="text-[28px] font-bold leading-none">{{ donNghiPhep.total }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Đơn</span>
            </div>
            <p class="mb-2.5 mt-1.5 text-[11px] uppercase text-[var(--xds-text-muted)]">Tổng</p>
            <div class="mb-2.5 flex justify-between">
              <div>
                <div class="text-[14px] font-semibold text-[var(--xds-warning)]">{{ donNghiPhep.overdue }} <span class="text-[11px] font-normal text-[var(--xds-text-muted)]">Đơn</span></div>
                <div class="mt-0.5 text-[11px] uppercase text-[var(--xds-warning)]">Quá hạn xử lý</div>
              </div>
              <div class="text-right">
                <div class="text-[14px] font-semibold">{{ donNghiPhep.current }} <span class="text-[11px] font-normal text-[var(--xds-text-muted)]">Đơn</span></div>
                <div class="mt-0.5 text-[11px] uppercase text-[var(--xds-text-muted)]">Trong hạn</div>
              </div>
            </div>
            <div class="h-1.5 overflow-hidden rounded-full bg-[var(--xds-border-light,var(--xds-border))]">
              <div class="h-full rounded-full bg-[var(--xds-warning)]" :style="{ width: donNghiPhepPct + '%' }" />
            </div>
            <div class="mt-auto border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 14h58 <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>

          <!-- Đơn tăng ca chờ duyệt -->
          <section class="group xds-card flex flex-col p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Đơn tăng ca chờ duyệt</h3>
              <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
              </button>
            </div>
            <div class="mt-2 flex items-baseline gap-1.5">
              <span class="text-[28px] font-bold leading-none">{{ donTangCa.total }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Đơn</span>
            </div>
            <p class="mb-2.5 mt-1.5 text-[11px] uppercase text-[var(--xds-text-muted)]">Tổng</p>
            <div class="mb-2.5 flex justify-between">
              <div>
                <div class="text-[14px] font-semibold text-[var(--xds-warning)]">{{ donTangCa.overdue }} <span class="text-[11px] font-normal text-[var(--xds-text-muted)]">Đơn</span></div>
                <div class="mt-0.5 text-[11px] uppercase text-[var(--xds-warning)]">Quá hạn xử lý</div>
              </div>
              <div class="text-right">
                <div class="text-[14px] font-semibold">{{ donTangCa.current }} <span class="text-[11px] font-normal text-[var(--xds-text-muted)]">Đơn</span></div>
                <div class="mt-0.5 text-[11px] uppercase text-[var(--xds-text-muted)]">Trong hạn</div>
              </div>
            </div>
            <div class="h-1.5 overflow-hidden rounded-full bg-[var(--xds-border-light,var(--xds-border))]">
              <div class="h-full w-full rounded-full bg-[var(--xds-warning)] opacity-40" />
            </div>
            <div class="mt-auto border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 14h58 <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>
        </div>

        <!-- ── Row 2: Tuyển mới/Nghỉ việc/Chênh lệch + Nhân sự theo phòng ban ── -->
        <div class="mt-4 grid grid-cols-1 gap-4 xl:grid-cols-[1.3fr_1fr]">
          <section class="group xds-card p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Tuyển mới, nghỉ việc, chênh lệch</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodBar" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Năm nay</option>
                  <option>Tháng này</option>
                  <option>Quý này</option>
                </select>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <XChart :option="barLineOption" :height="280" />
          </section>

          <section class="group xds-card flex flex-col p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Nhân sự theo phòng ban</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="settings" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <div class="flex items-baseline gap-1.5">
              <span class="text-[22px] font-bold leading-none">{{ departmentTotal }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Người</span>
            </div>
            <p class="mb-2 mt-1 text-[12px] text-[var(--xds-text-muted)]">Tổng nhân sự</p>
            <table class="w-full border-collapse text-[12px]">
              <thead>
                <tr>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-left font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Phòng ban</th>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Số lượng</th>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Tỷ trọng</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="r in departmentRows" :key="r.name" class="hover:bg-[var(--xds-bg-hover-soft)]">
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5">
                    <span class="mr-1.5 inline-block h-2 w-2 rounded-full align-middle" :style="{ background: r.color }" />{{ r.name }}
                  </td>
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right">{{ r.qty }}</td>
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold">{{ r.value }}</td>
                </tr>
              </tbody>
            </table>
            <button type="button" class="mt-1.5 self-start text-[11px] font-medium text-[var(--xds-brand-600)] hover:underline">Xem thêm</button>
            <div class="mt-auto border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 14h58 <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>
        </div>

        <!-- ── Row 3: Tổng nhân sự qua các tháng + Phòng ban tuyển nhiều nhất ── -->
        <div class="mt-4 grid grid-cols-1 gap-4 xl:grid-cols-[1.3fr_1fr]">
          <section class="group xds-card p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Tổng nhân sự qua các tháng</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodRev" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Năm nay</option>
                  <option>Tháng này</option>
                  <option>Quý này</option>
                </select>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <div class="mb-1 flex items-baseline gap-1.5">
              <span class="text-[22px] font-bold leading-none">{{ headcountTotal }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Người</span>
            </div>
            <p class="mb-1 text-[12px] text-[var(--xds-text-muted)]">Tổng nhân sự hiện tại</p>
            <XChart :option="headcountOnly" :height="220" />
          </section>

          <section class="group xds-card flex flex-col p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Phòng ban tuyển nhiều nhất</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="settings" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodSell" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Năm nay</option>
                  <option>Tháng này</option>
                  <option>Quý này</option>
                </select>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <div class="flex items-baseline gap-1.5">
              <span class="text-[22px] font-bold leading-none">{{ hiringTotal }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Người</span>
            </div>
            <p class="mb-2 mt-1 text-[12px] text-[var(--xds-text-muted)]">Tổng tuyển mới tháng này</p>
            <table class="w-full border-collapse text-[12px]">
              <thead>
                <tr>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-left font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Phòng ban</th>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Số lượng</th>
                  <th class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Tỷ trọng</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="r in hiringRows" :key="r.name" class="hover:bg-[var(--xds-bg-hover-soft)]">
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5">
                    <span class="mr-1.5 inline-block h-2 w-2 rounded-full align-middle" :style="{ background: r.color }" />{{ r.name }}
                  </td>
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right">{{ r.qty }}</td>
                  <td class="border-b border-[var(--xds-border-light,var(--xds-border))] py-1.5 text-right font-semibold">{{ r.revenue }}</td>
                </tr>
              </tbody>
            </table>
            <button type="button" class="mt-1.5 self-start text-[11px] font-medium text-[var(--xds-brand-600)] hover:underline">Xem thêm</button>
            <div class="mt-auto border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 15h47 <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>
        </div>

        <!-- ── Row 4: Chấm công + Cơ cấu quỹ lương ── -->
        <div class="mt-4 grid grid-cols-1 gap-4 xl:grid-cols-[1.3fr_1fr]">
          <section class="group xds-card p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Chấm công</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodCash" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Năm nay</option>
                  <option>Tháng này</option>
                  <option>Quý này</option>
                </select>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Người</p>
            <XChart :option="attendanceOption" :height="260" />
          </section>

          <section class="group xds-card flex flex-col p-4">
            <div class="flex items-center justify-between">
              <h3 class="text-[16px] font-semibold leading-[22px]">Cơ cấu quỹ lương</h3>
              <div class="flex items-center gap-1.5">
                <button type="button" class="flex h-6 w-6 items-center justify-center rounded opacity-0 transition-opacity hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100">
                  <XIcon name="refresh" :size="12" class="text-[var(--xds-icon-neutral)]" />
                </button>
                <select v-model="periodCost" class="cursor-pointer bg-transparent text-[11px] text-[var(--xds-text-secondary,var(--xds-text-muted))] outline-none">
                  <option>Năm nay</option>
                  <option>Tháng này</option>
                  <option>Quý này</option>
                </select>
              </div>
            </div>
            <p class="mb-1 mt-0.5 text-right text-[11px] text-[var(--xds-text-muted)]">Đơn vị: Triệu đồng</p>
            <div class="mb-1 flex items-baseline gap-1.5">
              <span class="text-[22px] font-bold leading-none">{{ payrollTotal }}</span>
              <span class="text-[14px] font-semibold text-[var(--xds-text-secondary,var(--xds-text-muted))]">Triệu đồng</span>
            </div>
            <p class="mb-1 text-[12px] text-[var(--xds-text-muted)]">Tổng quỹ lương tháng</p>
            <div class="flex min-w-0 items-center gap-3">
              <!-- Bọc trong div có width cố định — XChart tự có class w-full nội bộ,
                   truyền class="w-[...]" trực tiếp vào XChart sẽ bị w-full đè mất -->
              <div class="w-[160px] shrink-0">
                <XChart :option="payrollOption" :height="160" />
              </div>
              <div class="flex min-w-0 flex-1 flex-col gap-2">
                <div v-for="c in payrollItems" :key="c.name" class="flex min-w-0 items-center gap-2 text-[12px] text-[var(--xds-text-secondary,var(--xds-text-muted))]">
                  <span class="inline-block h-2 w-2 shrink-0 rounded-full" :style="{ background: c.color }" />
                  <span class="truncate">{{ c.name }}</span>
                </div>
              </div>
            </div>
            <div class="mt-auto border-t border-[var(--xds-border-light,var(--xds-border))] pt-2 text-[11px] text-[var(--xds-text-muted)]">
              Số liệu tính đến 15h47 <button type="button" class="ml-1 font-medium text-[var(--xds-brand-600)] hover:underline">Tải lại</button>
            </div>
          </section>
        </div>
      </main>
    </div>

    <XSettingsDialog v-model="showSettings" />
    <XToast />
  </div>
</template>
