<script setup>
/**
 * ListPage — template màn hình Danh sách chuẩn XDS
 * Bố cục: XHeaderBar (trên) + XSidebar (trái) + main nền xám:
 * toolbar (tiêu đề trái — cụm thao tác phải, Primary ngoài cùng phải + More)
 * và XDataTable có chọn nhiều dòng, bulk actions, row actions, drawer thêm mới.
 */
import { ref, computed, reactive, watch } from 'vue'
import XHeaderBar from '../components/XHeaderBar.vue'
import XSidebar from '../components/XSidebar.vue'
import XButton from '../components/XButton.vue'
import XInput from '../components/XInput.vue'
import XSelect from '../components/XSelect.vue'
import XDatePicker from '../components/XDatePicker.vue'
import XDateRangePicker from '../components/XDateRangePicker.vue'
import XTextarea from '../components/XTextarea.vue'
import XDataTable from '../components/XDataTable.vue'
import XDrawer from '../components/XDrawer.vue'
import XDropdownMenu from '../components/XDropdownMenu.vue'
import XTag from '../components/XTag.vue'
import XIcon from '../components/XIcon.vue'
import XToast from '../components/XToast.vue'
import XSettingsDialog from '../components/XSettingsDialog.vue'
import { useToast } from '../components/toast.js'
import { currentHeaderMode, sidebarCollapsed } from '../components/theme-state.js'

const toast = useToast()

/* ── Điều hướng: sidebar + header ───────────────────────────── */

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

const activeMenu = ref('ds-nhan-vien')
const showSettings = ref(false)

// "Tổng quan" là màn hình mẫu khác (DashboardPage) → điều hướng sang đó qua hash
// của playground; các mục còn lại đều có dữ liệu demo ngay trong trang này.
watch(activeMenu, (val) => {
  if (val === 'dashboard') location.hash = 'dashboard'
})

/* ── Bộ lọc toolbar ─────────────────────────────────────────── */

const search = ref('')
const dateRange = ref({ start: null, end: null })

/* ── Dữ liệu bảng (mock) ────────────────────────────────────── */

const columns = [
  { key: 'code', label: 'Mã nhân viên', width: 120, sortable: true },
  { key: 'name', label: 'Họ và tên', width: 180, sortable: true },
  { key: 'department', label: 'Phòng ban', width: 160 },
  { key: 'title', label: 'Chức danh', width: 180 },
  // Số tiền căn PHẢI theo chuẩn XDS
  { key: 'salary', label: 'Lương cơ bản', width: 130, align: 'right', sortable: true },
  { key: 'status', label: 'Trạng thái', width: 140 },
]

const employees = ref([
  { id: 1, code: 'NV-0001', name: 'Nguyễn Văn An', department: 'Kinh doanh', title: 'Trưởng phòng kinh doanh', salary: 25000000, status: 'Đang làm việc' },
  { id: 2, code: 'NV-0002', name: 'Trần Thị Bích', department: 'Kế toán', title: 'Kế toán trưởng', salary: 22000000, status: 'Đang làm việc' },
  { id: 3, code: 'NV-0003', name: 'Lê Hoàng Cường', department: 'Phát triển sản phẩm', title: 'Lập trình viên', salary: 18500000, status: 'Đang làm việc' },
  { id: 4, code: 'NV-0004', name: 'Phạm Thu Dung', department: 'Nhân sự', title: 'Chuyên viên tuyển dụng', salary: 13500000, status: 'Đang làm việc' },
  { id: 5, code: 'NV-0005', name: 'Hoàng Minh Đức', department: 'Kinh doanh', title: 'Nhân viên kinh doanh', salary: 12000000, status: 'Thử việc' },
  { id: 6, code: 'NV-0006', name: 'Vũ Thị Hà', department: 'Marketing', title: 'Chuyên viên nội dung', salary: 14000000, status: 'Đang làm việc' },
  { id: 7, code: 'NV-0007', name: 'Đặng Quốc Huy', department: 'Phát triển sản phẩm', title: 'Kỹ sư kiểm thử', salary: 16500000, status: 'Đang làm việc' },
  { id: 8, code: 'NV-0008', name: 'Bùi Thanh Lam', department: 'Chăm sóc khách hàng', title: 'Nhân viên hỗ trợ', salary: 11000000, status: 'Thử việc' },
  { id: 9, code: 'NV-0009', name: 'Ngô Văn Minh', department: 'Kế toán', title: 'Kế toán viên', salary: 13500000, status: 'Đã nghỉ việc' },
  { id: 10, code: 'NV-0010', name: 'Đỗ Thị Ngọc', department: 'Marketing', title: 'Thiết kế đồ họa', salary: 15000000, status: 'Đang làm việc' },
])

// Lọc client-side theo ô tìm kiếm (thực tế gọi API server-side)
const filteredRows = computed(() => {
  const q = search.value.trim().toLowerCase()
  if (!q) return employees.value
  return employees.value.filter((r) =>
    [r.code, r.name, r.department, r.title].some((v) => v.toLowerCase().includes(q))
  )
})

const selected = ref([])
const page = ref(1)
const pageSize = ref(20)
const kpiCollapsed = ref(false)

// Hàng KPI trên bảng Nhân viên (spec data-table.md mục 13)
const employeeKpis = [
  { label: 'Đang làm việc', value: '1.192', icon: 'users', color: 'var(--xds-success)' },
  { label: 'Thử việc', value: '68', icon: 'user', color: 'var(--xds-warning)' },
  { label: 'Tổng quỹ lương', value: '18,4 tỷ', icon: 'cash', color: 'var(--xds-brand-600)' },
]

// Số tiền định dạng VN: 13.500.000
const formatMoney = (v) => Number(v || 0).toLocaleString('vi-VN')

// Màu XTag theo trạng thái nhân viên
const statusColor = (s) =>
  s === 'Đang làm việc' ? 'success' : s === 'Thử việc' ? 'warning' : 'neutral'

/* ── Thao tác toolbar ───────────────────────────────────────── */

const moreItems = [
  { key: 'export', label: 'Xuất khẩu', icon: 'file-export' },
  { key: 'print', label: 'In danh sách', icon: 'printer' },
  { divider: true },
  { key: 'columns', label: 'Tùy chỉnh cột', icon: 'settings' },
]

function onMore(item) {
  const key = item && item.key ? item.key : item
  if (key === 'export') toast.success('Đang xuất khẩu danh sách nhân viên')
  else if (key === 'print') toast.info('Đang chuẩn bị bản in')
  else toast.info('Mở tùy chỉnh cột')
}

function onImport() {
  toast.info('Mở màn hình nhập khẩu nhân viên từ Excel')
}

/* ── Bulk actions ───────────────────────────────────────────── */

function bulkExport() {
  toast.success(`Đã xuất khẩu ${selected.value.length} nhân viên`)
}

function bulkDelete() {
  employees.value = employees.value.filter((r) => !selected.value.includes(r.id))
  toast.success(`Đã xóa ${selected.value.length} nhân viên`)
  selected.value = []
}

/* ── Row actions ────────────────────────────────────────────── */

const rowMenuItems = [
  { key: 'edit', label: 'Sửa', icon: 'pencil' },
  { key: 'duplicate', label: 'Nhân bản', icon: 'copy' },
  { divider: true },
  { key: 'delete', label: 'Xóa', icon: 'trash', danger: true },
]

function onRowAction(item, row) {
  const key = item && item.key ? item.key : item
  if (key === 'edit') {
    toast.info(`Mở màn hình sửa nhân viên ${row.name}`)
  } else if (key === 'duplicate') {
    const nextId = Math.max(...employees.value.map((r) => r.id)) + 1
    employees.value = [
      ...employees.value,
      { ...row, id: nextId, code: `NV-${String(nextId).padStart(4, '0')}` },
    ]
    toast.success(`Đã nhân bản nhân viên ${row.name}`)
  } else if (key === 'delete') {
    employees.value = employees.value.filter((r) => r.id !== row.id)
    toast.success(`Đã xóa nhân viên ${row.name}`)
  }
}

// Bấm vào dòng để chuyển sang trang chi tiết (spec màn Danh sách)
function openDetail(row) {
  toast.info(`Mở chi tiết nhân viên ${row.name}`)
}

/* ── Nhân viên > Hợp đồng (mock) ─────────────────────────────── */

const contractColumns = [
  { key: 'code', label: 'Số hợp đồng', width: 140 },
  { key: 'employee', label: 'Nhân viên', width: 180 },
  { key: 'type', label: 'Loại hợp đồng', width: 200 },
  { key: 'signDate', label: 'Ngày ký', width: 110 },
  { key: 'effectiveDate', label: 'Ngày hiệu lực', width: 120 },
  { key: 'status', label: 'Trạng thái', width: 130 },
]

const contracts = ref([
  { id: 1, code: 'HĐLĐ-2023-0125', employee: 'Nguyễn Văn An', type: 'Không xác định thời hạn', signDate: '01/03/2023', effectiveDate: '01/03/2023', status: 'Đang hiệu lực' },
  { id: 2, code: 'HĐLĐ-2022-0098', employee: 'Trần Thị Bích', type: 'Không xác định thời hạn', signDate: '15/06/2022', effectiveDate: '15/06/2022', status: 'Đang hiệu lực' },
  { id: 3, code: 'HĐLĐ-2021-0064', employee: 'Lê Hoàng Cường', type: 'Xác định thời hạn 36 tháng', signDate: '01/09/2021', effectiveDate: '01/09/2021', status: 'Đang hiệu lực' },
  { id: 4, code: 'HĐTV-2026-0031', employee: 'Phạm Thu Dung', type: 'Thử việc', signDate: '02/06/2026', effectiveDate: '02/06/2026', status: 'Đang hiệu lực' },
  { id: 5, code: 'HĐTV-2026-0030', employee: 'Hoàng Minh Đức', type: 'Thử việc', signDate: '10/06/2026', effectiveDate: '10/06/2026', status: 'Đang hiệu lực' },
  { id: 6, code: 'HĐLĐ-2024-0112', employee: 'Vũ Thị Hà', type: 'Xác định thời hạn 12 tháng', signDate: '01/01/2024', effectiveDate: '01/01/2024', status: 'Đang hiệu lực' },
  { id: 7, code: 'HĐLĐ-2020-0089', employee: 'Ngô Văn Minh', type: 'Xác định thời hạn 36 tháng', signDate: '01/03/2020', effectiveDate: '01/03/2020', status: 'Hết hiệu lực' },
])

function openContractDetail(row) {
  toast.info(`Mở chi tiết hợp đồng ${row.code}`)
}

/* ── Chấm công (mock, hôm nay) ────────────────────────────────── */

const attendanceColumns = [
  { key: 'code', label: 'Mã nhân viên', width: 110 },
  { key: 'name', label: 'Họ và tên', width: 170 },
  { key: 'checkIn', label: 'Giờ vào', width: 100 },
  { key: 'checkOut', label: 'Giờ ra', width: 100 },
  { key: 'hours', label: 'Số giờ công', width: 110, align: 'right' },
  { key: 'status', label: 'Trạng thái', width: 130 },
]

const attendanceToday = ref([
  { id: 1, code: 'NV-0001', name: 'Nguyễn Văn An', checkIn: '08:02', checkOut: '17:35', hours: 8, status: 'Đúng giờ' },
  { id: 2, code: 'NV-0002', name: 'Trần Thị Bích', checkIn: '07:58', checkOut: '17:30', hours: 8, status: 'Đúng giờ' },
  { id: 3, code: 'NV-0003', name: 'Lê Hoàng Cường', checkIn: '08:21', checkOut: '17:40', hours: 7.5, status: 'Đi muộn' },
  { id: 4, code: 'NV-0004', name: 'Phạm Thu Dung', checkIn: '08:00', checkOut: '—', hours: 0, status: 'Đang làm việc' },
  { id: 5, code: 'NV-0005', name: 'Hoàng Minh Đức', checkIn: '—', checkOut: '—', hours: 0, status: 'Nghỉ phép' },
  { id: 6, code: 'NV-0006', name: 'Vũ Thị Hà', checkIn: '08:05', checkOut: '17:32', hours: 8, status: 'Đúng giờ' },
])

const attendanceStatusColor = (s) =>
  s === 'Đúng giờ' ? 'success' : s === 'Đi muộn' ? 'warning' : s === 'Nghỉ phép' ? 'neutral' : 'info'

/* ── Báo cáo (mock) ───────────────────────────────────────────── */

const reports = [
  { key: 'phong-ban', title: 'Báo cáo nhân sự theo phòng ban', description: 'Số lượng, biến động nhân sự theo từng phòng ban trong kỳ', icon: 'chart-bar', updated: 'Cập nhật 13/07/2026' },
  { key: 'bien-dong', title: 'Báo cáo biến động nhân sự', description: 'Tuyển mới, nghỉ việc, chuyển phòng ban theo tháng/quý/năm', icon: 'chart-pie', updated: 'Cập nhật 13/07/2026' },
  { key: 'luong', title: 'Báo cáo quỹ lương', description: 'Tổng hợp lương cơ bản, phụ cấp theo phòng ban và chức danh', icon: 'cash', updated: 'Cập nhật 12/07/2026' },
  { key: 'cham-cong', title: 'Báo cáo chấm công', description: 'Tổng hợp giờ công, đi muộn, nghỉ phép toàn công ty', icon: 'clock', updated: 'Cập nhật 13/07/2026' },
]

function openReport(report) {
  toast.info(`Mở ${report.title.charAt(0).toLowerCase()}${report.title.slice(1)}`)
}

/* ── Thiết lập (mock) ─────────────────────────────────────────── */

const settingSections = [
  { key: 'cong-ty', title: 'Thông tin công ty', description: 'Tên công ty, mã số thuế, địa chỉ, logo hiển thị trên hồ sơ', icon: 'building' },
  { key: 'phan-quyen', title: 'Phân quyền người dùng', description: 'Vai trò, nhóm quyền truy cập từng phân hệ nhân sự', icon: 'users' },
  { key: 'quy-trinh', title: 'Quy trình phê duyệt', description: 'Luồng duyệt hồ sơ, nghỉ phép, tăng lương theo cấp quản lý', icon: 'file-text' },
  { key: 'thong-bao', title: 'Thông báo', description: 'Kênh nhận thông báo: trong ứng dụng, email, di động', icon: 'bell' },
]

function openSetting(section) {
  toast.info(`Mở thiết lập: ${section.title}`)
}

/* ── Drawer Thêm nhân viên ──────────────────────────────────── */

const departmentOptions = [
  { label: 'Kinh doanh', value: 'kinh-doanh' },
  { label: 'Kế toán', value: 'ke-toan' },
  { label: 'Nhân sự', value: 'nhan-su' },
  { label: 'Marketing', value: 'marketing' },
  { label: 'Phát triển sản phẩm', value: 'phat-trien-san-pham' },
  { label: 'Chăm sóc khách hàng', value: 'cskh' },
]

const drawerOpen = ref(false)
const saving = ref(false)

const form = reactive({ name: '', department: null, startDate: null, note: '' })
const formErrors = reactive({ name: '' })

function resetForm() {
  form.name = ''
  form.department = null
  form.startDate = null
  form.note = ''
  formErrors.name = ''
}

function openDrawer() {
  resetForm()
  drawerOpen.value = true
}

function saveEmployee() {
  // Validate bắt buộc: message đỏ 12px hiển thị dưới control (qua prop error)
  formErrors.name = form.name.trim() ? '' : 'Họ tên không được để trống'
  if (formErrors.name) return

  saving.value = true
  const nextId = Math.max(...employees.value.map((r) => r.id), 0) + 1
  const dep = departmentOptions.find((o) => o.value === form.department)
  employees.value = [
    {
      id: nextId,
      code: `NV-${String(nextId).padStart(4, '0')}`,
      name: form.name.trim(),
      department: dep ? dep.label : '',
      title: '',
      salary: 0,
      status: 'Thử việc',
    },
    ...employees.value,
  ]
  saving.value = false
  drawerOpen.value = false
  toast.success(`Đã thêm nhân viên ${form.name.trim()}`)
}
</script>

<template>
  <div
    class="flex h-full flex-col overflow-hidden bg-[var(--xds-bg-disabled)] text-[13px] leading-[18px] text-[var(--xds-text)]"
    :style="{ fontFamily: 'var(--xds-font-family)' }"
  >
    <!-- Header: mode do người dùng chọn trong dialog Thiết lập, dùng chung mọi trang -->
    <XHeaderBar
      :variant="currentHeaderMode"
      app-name="app Nhân sự"
      search-placeholder="Tìm kiếm trong app Nhân sự"
      :user="{ name: 'Nguyễn Văn An' }"
      @search="toast.info('Mở tìm kiếm toàn hệ thống')"
      @settings="showSettings = true"
      @user-click="toast.info('Mở menu tài khoản')"
    />

    <div class="flex min-h-0 flex-1">
      <!-- Sidebar nền trắng -->
      <XSidebar v-model="activeMenu" v-model:collapsed="sidebarCollapsed" :items="sidebarItems" />

      <!-- Main NỀN XÁM — bảng có khoảng cách với lề, không dính sát mép -->
      <main class="flex min-w-0 flex-1 flex-col overflow-hidden px-4 pb-4 pt-3">
        <!-- Nhân viên > Danh sách -->
        <template v-if="activeMenu === 'ds-nhan-vien'">
          <div class="mb-3 flex shrink-0 items-center justify-between gap-3">
            <h2 class="text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Nhân viên</h2>
          </div>

          <!-- Bảng danh sách: KPI row + toolbar chuẩn (search trái, 4 icon cố định +
               nút chính phải), chọn nhiều dòng, bulk actions, cột thao tác sticky
               (spec data-table.md mục 13) -->
          <XDataTable
            v-model:selected="selected"
            v-model:page="page"
            v-model:page-size="pageSize"
            v-model:kpi-collapsed="kpiCollapsed"
            :columns="columns"
            :rows="filteredRows"
            :total="filteredRows.length"
            row-key="id"
            selectable
            :has-next="false"
            class="min-h-0 flex-1"
            @row-click="openDetail"
            @refresh="toast.info('Đang tải lại danh sách')"
            @export="onMore('export')"
            @column-settings="onMore('columns')"
            @filter-click="toast.info('Mở bộ lọc nâng cao')"
          >
            <!-- Hàng KPI: 3 card icon+label+giá trị+chip giờ cập nhật -->
            <template #kpi>
              <div class="flex flex-wrap gap-3 pb-3">
                <div
                  v-for="kpi in employeeKpis"
                  :key="kpi.label"
                  class="group flex flex-1 min-w-[200px] items-center gap-3 rounded-lg border border-[var(--xds-border-light,var(--xds-border))] p-3"
                >
                  <span
                    class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg"
                    :style="{ background: `color-mix(in srgb, ${kpi.color} 12%, white)`, color: kpi.color }"
                  >
                    <XIcon :name="kpi.icon" :size="20" />
                  </span>
                  <div class="flex min-w-0 flex-1 flex-col">
                    <span class="truncate text-[12px] font-medium text-[var(--xds-text-secondary)]">{{ kpi.label }}</span>
                    <span class="text-[18px] font-semibold" :style="{ color: kpi.color }">{{ kpi.value }}</span>
                  </div>
                  <span class="hidden shrink-0 items-center gap-1 text-[11px] text-[var(--xds-text-secondary)] sm:flex">
                    <XIcon name="clock" :size="12" />
                    15:59
                    <XIcon
                      name="refresh"
                      :size="12"
                      class="ml-1 opacity-0 transition-opacity group-hover:opacity-100"
                    />
                  </span>
                </div>
              </div>
            </template>

            <!-- Toolbar trái: ô tìm kiếm + filter phụ -->
            <template #toolbar-search>
              <div class="w-[240px]">
                <XInput v-model="search" placeholder="Tìm kiếm mã, tên nhân viên" clearable />
              </div>
              <div class="w-[236px]">
                <XDateRangePicker v-model="dateRange" />
              </div>
            </template>

            <!-- Toolbar phải (sau vạch dọc + 4 icon cố định): cụm nút chính -->
            <template #toolbar-actions>
              <XButton variant="secondary" @click="onImport">
                <template #icon>
                  <XIcon name="upload" :size="16" />
                </template>
                Nhập khẩu
              </XButton>
              <XButton variant="primary" @click="openDrawer">
                <template #icon>
                  <XIcon name="plus" :size="16" />
                </template>
                Thêm nhân viên
              </XButton>
              <XDropdownMenu :items="moreItems" @select="onMore" />
            </template>

            <!-- Lương: định dạng số VN 13.500.000, căn phải theo cột -->
            <template #cell-salary="{ value }">
              {{ formatMoney(value) }}
            </template>

            <!-- Trạng thái: XTag màu theo trạng thái -->
            <template #cell-status="{ row }">
              <XTag :color="statusColor(row.status)" size="sm">{{ row.status }}</XTag>
            </template>

            <!-- Bulk actions khi chọn ≥1 dòng -->
            <template #bulk-actions>
              <XButton variant="secondary" @click="bulkExport">Xuất khẩu</XButton>
              <XButton variant="danger" @click="bulkDelete">Xóa</XButton>
            </template>

            <!-- Row actions: cột sticky riêng, hiện khi hover dòng -->
            <template #row-actions="{ row }">
              <button
                type="button"
                title="Xem"
                class="flex h-7 w-7 items-center justify-center rounded-md border border-[var(--xds-border)] bg-[var(--xds-bg)] text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)]"
                @click="openDetail(row)"
              >
                <XIcon name="eye" :size="16" />
              </button>
              <button
                type="button"
                title="Sửa"
                class="flex h-7 w-7 items-center justify-center rounded-md border border-[var(--xds-border)] bg-[var(--xds-bg)] text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)]"
                @click="openDrawer()"
              >
                <XIcon name="pencil" :size="16" />
              </button>
              <button
                type="button"
                title="Xóa"
                class="flex h-7 w-7 items-center justify-center rounded-md border border-[var(--xds-border)] bg-[var(--xds-bg)] text-[var(--xds-danger)] hover:bg-[var(--xds-bg-hover-soft)]"
                @click="toast.info(`Xóa ${row.name}`)"
              >
                <XIcon name="trash" :size="16" />
              </button>
              <XDropdownMenu :items="rowMenuItems" @select="onRowAction($event, row)" />
            </template>
          </XDataTable>
        </template>

        <!-- Nhân viên > Hợp đồng -->
        <template v-else-if="activeMenu === 'hop-dong'">
          <div class="mb-3 flex shrink-0 items-center justify-between gap-3">
            <h2 class="text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Hợp đồng</h2>
            <XButton variant="primary">
              <template #icon><XIcon name="plus" :size="16" /></template>
              Thêm hợp đồng
            </XButton>
          </div>
          <XDataTable :columns="contractColumns" :rows="contracts" row-key="id" class="min-h-0 flex-1" @row-click="openContractDetail">
            <template #cell-status="{ row }">
              <XTag :color="row.status === 'Đang hiệu lực' ? 'success' : 'neutral'" size="sm">{{ row.status }}</XTag>
            </template>
            <template #footer-info>Tổng số hợp đồng: {{ contracts.length }}</template>
          </XDataTable>
        </template>

        <!-- Chấm công -->
        <template v-else-if="activeMenu === 'cham-cong'">
          <div class="mb-3 flex shrink-0 items-center justify-between gap-3">
            <h2 class="text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Chấm công hôm nay</h2>
            <XButton variant="secondary">
              <template #icon><XIcon name="file-export" :size="16" /></template>
              Xuất bảng công
            </XButton>
          </div>
          <XDataTable :columns="attendanceColumns" :rows="attendanceToday" row-key="id" class="min-h-0 flex-1">
            <template #cell-status="{ row }">
              <XTag :color="attendanceStatusColor(row.status)" size="sm">{{ row.status }}</XTag>
            </template>
            <template #footer-info>Tổng số nhân viên: {{ attendanceToday.length }}</template>
          </XDataTable>
        </template>

        <!-- Báo cáo -->
        <template v-else-if="activeMenu === 'bao-cao'">
          <h2 class="mb-3 shrink-0 text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Báo cáo</h2>
          <div class="min-h-0 flex-1 overflow-y-auto">
            <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
              <button
                v-for="report in reports"
                :key="report.key"
                type="button"
                class="flex items-start gap-3 rounded-lg bg-[var(--xds-bg)] p-4 text-left shadow-[var(--xds-shadow-card)] ring-1 ring-transparent transition-shadow hover:ring-[var(--xds-brand-600)]"
                @click="openReport(report)"
              >
                <span class="grid h-9 w-9 shrink-0 place-items-center rounded-lg bg-[var(--xds-brand-50)] text-[var(--xds-brand-600)]">
                  <XIcon :name="report.icon" :size="20" />
                </span>
                <span class="min-w-0">
                  <span class="block text-[14px] font-semibold leading-[20px] text-[var(--xds-text)]">{{ report.title }}</span>
                  <span class="mt-0.5 block text-[12px] leading-[16px] text-[var(--xds-text-muted)]">{{ report.description }}</span>
                  <span class="mt-2 block text-[11px] leading-[14px] text-[var(--xds-text-placeholder)]">{{ report.updated }}</span>
                </span>
              </button>
            </div>
          </div>
        </template>

        <!-- Thiết lập -->
        <template v-else-if="activeMenu === 'thiet-lap'">
          <h2 class="mb-3 shrink-0 text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Thiết lập</h2>
          <div class="min-h-0 flex-1 overflow-y-auto rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)]">
            <button
              v-for="(section, i) in settingSections"
              :key="section.key"
              type="button"
              class="flex w-full items-center gap-3 px-4 py-3 text-left hover:bg-[var(--xds-bg-hover-soft)]"
              :class="i > 0 ? 'border-t border-[var(--xds-border-light)]' : ''"
              @click="openSetting(section)"
            >
              <span class="grid h-9 w-9 shrink-0 place-items-center rounded-lg bg-[var(--xds-bg-disabled)] text-[var(--xds-icon-neutral)]">
                <XIcon :name="section.icon" :size="20" />
              </span>
              <span class="min-w-0 flex-1">
                <span class="block text-[14px] font-medium leading-[20px] text-[var(--xds-text)]">{{ section.title }}</span>
                <span class="mt-0.5 block text-[12px] leading-[16px] text-[var(--xds-text-muted)]">{{ section.description }}</span>
              </span>
              <XIcon name="chevron-right" :size="20" class="shrink-0 text-[var(--xds-icon-neutral)]" />
            </button>
          </div>
        </template>
      </main>
    </div>

    <!-- Drawer Thêm nhân viên -->
    <XDrawer v-model="drawerOpen" title="Thêm nhân viên" :width="480">
      <div class="flex flex-col gap-4">
        <div>
          <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
            Họ tên <span class="text-[var(--xds-danger)]">*</span>
          </label>
          <XInput v-model="form.name" placeholder="Nhập họ tên nhân viên" :error="formErrors.name" />
        </div>

        <div>
          <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
            Phòng ban
          </label>
          <XSelect v-model="form.department" :options="departmentOptions" placeholder="Chọn phòng ban" />
        </div>

        <div>
          <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
            Ngày vào làm
          </label>
          <XDatePicker v-model="form.startDate" />
        </div>

        <div>
          <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
            Ghi chú
          </label>
          <XTextarea v-model="form.note" :rows="3" :maxlength="500" placeholder="Nhập ghi chú" />
        </div>
      </div>

      <!-- Footer: Primary ngoài cùng bên phải theo XDS -->
      <template #footer>
        <XButton variant="secondary" @click="drawerOpen = false">Hủy</XButton>
        <XButton variant="primary" :loading="saving" @click="saveEmployee">Lưu</XButton>
      </template>
    </XDrawer>

    <XSettingsDialog v-model="showSettings" />
    <XToast />
  </div>
</template>
