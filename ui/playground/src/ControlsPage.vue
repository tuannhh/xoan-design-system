<script setup>
import { ref } from 'vue'
import XButton from '@xds/XButton.vue'
import XTag from '@xds/XTag.vue'
import XSpinner from '@xds/XSpinner.vue'
import XProgress from '@xds/XProgress.vue'
import XInput from '@xds/XInput.vue'
import XTextarea from '@xds/XTextarea.vue'
import XCheckbox from '@xds/XCheckbox.vue'
import XRadioGroup from '@xds/XRadioGroup.vue'
import XSelect from '@xds/XSelect.vue'
import XCombobox from '@xds/XCombobox.vue'
import XDialog from '@xds/XDialog.vue'
import XToast from '@xds/XToast.vue'
import { useToast } from '@xds/toast.js'
import XTabs from '@xds/XTabs.vue'
import XEmptyState from '@xds/XEmptyState.vue'
import XDataTable from '@xds/XDataTable.vue'
import XDatePicker from '@xds/XDatePicker.vue'
import XDateRangePicker from '@xds/XDateRangePicker.vue'
import XDrawer from '@xds/XDrawer.vue'
import XContextMenu from '@xds/XContextMenu.vue'
import XTooltip from '@xds/XTooltip.vue'
import XDropdownMenu from '@xds/XDropdownMenu.vue'
import XImageViewer from '@xds/XImageViewer.vue'
import XCollapseExpandPanel from '@xds/XCollapseExpandPanel.vue'
import XTree from '@xds/XTree.vue'
import XUpload from '@xds/XUpload.vue'

const toast = useToast()
const themes = ['blue', 'indigo', 'cyan', 'teal', 'green', 'orange', 'red', 'pink', 'purple', 'blue-gray']
const theme = ref('blue')
function setTheme(t) {
  theme.value = t
  document.documentElement.setAttribute('data-xds-theme', t)
}

const loadingBtn = ref(false)
function demoLoading() {
  loadingBtn.value = true
  setTimeout(() => (loadingBtn.value = false), 2000)
}

const name = ref('Nguyễn Văn An')
const note = ref('')
const agree = ref(true)
const half = ref(false)
const gender = ref('male')
const dept = ref(null)
const staff = ref([])
const donvi = ref(null)
const dialogOpen = ref(false)
const activeTab = ref('info')
const imageViewerOpen = ref(false)
const sampleImages = [
  { src: 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="1200" height="800"%3E%3Crect width="100%25" height="100%25" fill="%23245FDF"/%3E%3Ctext x="600" y="400" text-anchor="middle" dominant-baseline="middle" fill="white" font-family="Arial" font-size="56"%3EChung tu 01%3C/text%3E%3C/svg%3E', alt: 'Chứng từ số 01', name: 'chung-tu-01.png' },
  { src: 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="1200" height="800"%3E%3Crect width="100%25" height="100%25" fill="%23099B70"/%3E%3Ctext x="600" y="400" text-anchor="middle" dominant-baseline="middle" fill="white" font-family="Arial" font-size="56"%3EChung tu 02%3C/text%3E%3C/svg%3E', alt: 'Chứng từ số 02', name: 'chung-tu-02.png' },
]

const deptOptions = [
  { label: 'Phòng Kinh doanh', value: 'kd' },
  { label: 'Phòng Marketing', value: 'mkt' },
  { label: 'Phòng Nhân sự', value: 'ns' },
  { label: 'Phòng Kế toán', value: 'kt' },
  { label: 'Ban Giám đốc', value: 'bgd' },
]
const staffOptions = [
  'Nguyễn Văn An', 'Trần Thị Bình', 'Lê Hoàng Cường', 'Phạm Thu Dung', 'Hoàng Văn Em',
  'Vũ Thị Phương', 'Đặng Minh Giang', 'Bùi Thu Hà', 'Ngô Văn Inh', 'Đỗ Thị Kim',
].map((n, i) => ({ label: n, value: i }))

// ===== Đợt 2 =====
// DataTable
const tableColumns = [
  { key: 'code', label: 'Mã NV', width: 110 },
  { key: 'name', label: 'Họ và tên', sortable: true },
  { key: 'dept', label: 'Phòng ban' },
  { key: 'salary', label: 'Lương (VND)', align: 'right', sortable: true, width: 140 },
  { key: 'status', label: 'Trạng thái', width: 130 },
]
const tableRows = ref([
  { id: 1, code: 'NV-0001', name: 'Nguyễn Văn An', dept: 'Phòng Kinh doanh', salary: '25.000.000', status: 'active' },
  { id: 2, code: 'NV-0002', name: 'Trần Thị Bình', dept: 'Phòng Marketing', salary: '18.500.000', status: 'active' },
  { id: 3, code: 'NV-0003', name: 'Lê Hoàng Cường', dept: 'Phòng Nhân sự', salary: '15.000.000', status: 'leave' },
  { id: 4, code: 'NV-0004', name: 'Phạm Thu Dung', dept: 'Phòng Kế toán', salary: '22.750.000', status: 'active' },
  { id: 5, code: 'NV-0005', name: 'Hoàng Văn Em', dept: 'Phòng Kinh doanh', salary: '31.200.000', status: 'probation' },
])
const selectedRows = ref([])
const tablePage = ref(1)
function onSort(e) { toast.info(`Sắp xếp: ${e.key} ${e.direction ?? 'mặc định'}`) }
function onRowClick(row) { toast.info(`Mở chi tiết: ${row.name}`) }

// Date pickers
const birthday = ref(null)
const reportRange = ref({ start: null, end: null })

// Drawer + menus
const drawerOpen = ref(false)
const ctxMenuRef = ref(null)
const collapseDemoBottom = ref(false)
const collapseDemoTop = ref(false)
const collapseDemoLeft = ref(false)
const collapseDemoRight = ref(false)

/* ── Tree demo ──────────────────────────────────────────────── */

const treeNodes = [
  {
    id: 'cty',
    label: 'Công ty TNHH Thương mại Việt Phát',
    children: [
      {
        id: 'kd',
        label: 'Phòng Kinh doanh',
        subtext: '24 nhân viên',
        children: [
          { id: 'kd-hn', label: 'Chi nhánh Hà Nội' },
          { id: 'kd-hcm', label: 'Chi nhánh Hồ Chí Minh' },
        ],
      },
      {
        id: 'kt',
        label: 'Phòng Kế toán',
        accent: true,
        children: [{ id: 'kt-thue', label: 'Nhóm Thuế' }],
      },
      { id: 'ns', label: 'Phòng Nhân sự', disabled: true },
    ],
  },
]
const treeSelected = ref(null)
const treeExpanded = ref(['cty', 'kd'])
const treeExpanded2 = ref(['cty'])
const treeChecked = ref([])

/* ── Upload demo ────────────────────────────────────────────── */

const uploadFiles = ref([
  { id: 1, name: 'hop-dong-lao-dong.pdf', size: 512000, status: 'done' },
])

function onUploadSelectFiles(files) {
  for (const file of files) {
    const id = Date.now() + Math.random()
    uploadFiles.value.push({ id, name: file.name, size: file.size, status: 'uploading', progress: 0 })
    simulateUpload(id)
  }
}

// Mock tiến trình tải lên (component không tự upload — xem useUpload.vue comment đầu file)
function simulateUpload(id) {
  const item = uploadFiles.value.find((f) => f.id === id)
  if (!item) return
  const timer = setInterval(() => {
    item.progress = Math.min(100, (item.progress || 0) + 20)
    if (item.progress >= 100) {
      clearInterval(timer)
      item.status = 'done'
    }
  }, 300)
}

function onUploadRetry(id) {
  const item = uploadFiles.value.find((f) => f.id === id)
  if (!item) return
  item.status = 'uploading'
  item.progress = 0
  simulateUpload(id)
}
const menuItems = [
  { key: 'edit', label: 'Sửa', icon: 'edit' },
  { key: 'copy', label: 'Nhân bản', icon: 'copy' },
  { key: 'divider-1', divider: true },
  { key: 'delete', label: 'Xóa', icon: 'trash', danger: true },
]
</script>

<template>
  <div class="mx-auto max-w-5xl p-8 space-y-8">
    <header class="flex items-center justify-between">
      <div>
        <h1 class="text-[20px] leading-[28px] font-semibold">XDS UI — Bộ control mới</h1>
        <p class="text-[var(--xds-text-placeholder)]">Vue 3 + Tailwind · chuẩn XDS · Đợt 1 + Đợt 2: 21 control</p>
      </div>
      <div class="flex items-center gap-1">
        <button v-for="t in themes" :key="t" @click="setTheme(t)"
          class="h-6 w-6 rounded-full border-2 cursor-pointer"
          :class="theme === t ? 'border-[var(--xds-text)]' : 'border-transparent'"
          :data-xds-theme="t" :title="t"
          :style="{ background: 'var(--xds-brand-600)' }" />
      </div>
    </header>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Data Table <XTag color="brand" size="sm">Đợt 2</XTag></h3>
      <p class="text-[var(--xds-text-placeholder)]">Tick dòng để thấy bulk action bar · hover dòng để thấy thao tác · click dòng mở chi tiết · click header Họ và tên / Lương để sort</p>
      <XDataTable :columns="tableColumns" :rows="tableRows" v-model:selected="selectedRows"
        selectable :page="tablePage" :has-next="true" @update:page="tablePage = $event"
        @sort="onSort" @row-click="onRowClick">
        <template #bulk-actions>
          <XButton @click="toast.success(`Đã xuất ${selectedRows.length} bản ghi`)">Xuất khẩu</XButton>
          <XButton variant="danger" @click="toast.error(`Đã xóa ${selectedRows.length} bản ghi`)">Xóa</XButton>
        </template>
        <template #cell-status="{ value }">
          <XTag v-if="value === 'active'" color="success" size="sm">Đang làm việc</XTag>
          <XTag v-else-if="value === 'probation'" color="warning" size="sm">Thử việc</XTag>
          <XTag v-else color="neutral" size="sm">Nghỉ phép</XTag>
        </template>
        <template #row-actions="{ row }">
          <XDropdownMenu :items="menuItems" @select="k => toast.info(`${k}: ${row.name}`)" />
        </template>
      </XDataTable>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Date Picker · Date Range <XTag color="brand" size="sm">Đợt 2</XTag></h3>
      <div class="grid grid-cols-2 gap-4 max-w-3xl">
        <XDatePicker v-model="birthday" placeholder="Ngày sinh (dd/MM/yyyy)" />
        <XDateRangePicker v-model="reportRange" />
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Drawer · Context menu · Tooltip · Dropdown menu <XTag color="brand" size="sm">Đợt 2</XTag></h3>
      <div class="flex flex-wrap items-center gap-3">
        <XButton variant="primary" @click="drawerOpen = true">Mở drawer</XButton>
        <XTooltip content="Lưu bản ghi" shortcut="Ctrl+S">
          <XButton>Hover tôi (tooltip + phím tắt)</XButton>
        </XTooltip>
        <XDropdownMenu :items="menuItems" @select="k => toast.info(`Chọn: ${k}`)" />
        <div @contextmenu.prevent="ctxMenuRef.open($event, { source: 'demo' })"
          class="flex h-20 flex-1 min-w-60 items-center justify-center rounded-lg border border-dashed border-[var(--xds-border)] text-[var(--xds-text-placeholder)] select-none">
          Chuột phải vào vùng này (context menu)
        </div>
        <XContextMenu ref="ctxMenuRef" :items="menuItems" @select="e => toast.info(`Context: ${e.key}`)" />
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Button</h3>
      <div class="flex flex-wrap items-center gap-3">
        <XButton variant="primary">Lưu</XButton>
        <XButton>Hủy</XButton>
        <XButton variant="danger">Xóa</XButton>
        <XButton variant="link">Xem chi tiết</XButton>
        <XButton variant="primary" :loading="loadingBtn" @click="demoLoading">Lưu (loading 2s)</XButton>
        <XButton disabled>Disabled</XButton>
        <XButton variant="primary" size="lg">Size lớn</XButton>
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Tag · Spinner · Progress</h3>
      <div class="flex flex-wrap items-center gap-3">
        <XTag color="brand">Đang thực hiện</XTag>
        <XTag color="success">Hoàn thành</XTag>
        <XTag color="warning">Chờ duyệt</XTag>
        <XTag color="danger" closable>Quá hạn</XTag>
        <XTag>Nháp</XTag>
        <XSpinner :size="20" class="text-[var(--xds-brand-600)]" />
      </div>
      <XProgress :value="65" label="65%" class="max-w-sm" />
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Input · Textarea · Checkbox · Radio</h3>
      <div class="grid grid-cols-2 gap-4 max-w-3xl">
        <XInput v-model="name" placeholder="Họ và tên" clearable />
        <XInput model-value="" placeholder="Có lỗi" error="Trường này là bắt buộc" />
        <XInput model-value="Chỉ đọc" readonly />
        <XInput model-value="Vô hiệu" disabled />
        <XInput type="password" model-value="matkhau123" placeholder="Mật khẩu" />
        <XTextarea v-model="note" placeholder="Ghi chú" :maxlength="200" />
      </div>
      <div class="flex items-center gap-6">
        <XCheckbox v-model="agree" label="Đồng ý điều khoản" />
        <XCheckbox v-model="half" indeterminate label="Chọn một phần" />
        <XCheckbox :model-value="true" disabled label="Disabled" />
      </div>
      <XRadioGroup v-model="gender" :options="[
        { label: 'Nam', value: 'male' },
        { label: 'Nữ', value: 'female' },
        { label: 'Khác', value: 'other' },
      ]" direction="horizontal" />
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Select (4–8 lựa chọn) · Combobox (&gt;8, gõ tìm)</h3>
      <div class="grid grid-cols-2 gap-4 max-w-3xl">
        <XSelect v-model="dept" :options="deptOptions" placeholder="Chọn phòng ban" />
        <XCombobox v-model="staff" :options="staffOptions" multiple placeholder="Chọn nhân viên (gõ để tìm)" />
        <XCombobox v-model="donvi" :options="deptOptions" allow-create placeholder="Đơn vị (gõ mới + Enter để thêm nhanh)" />
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Dialog · Toast · Tabs · Empty state</h3>
      <div class="flex flex-wrap items-center gap-3">
        <XButton variant="primary" @click="dialogOpen = true">Mở dialog</XButton>
        <XButton @click="toast.success('Lưu dữ liệu thành công')">Toast thành công</XButton>
        <XButton @click="toast.error('Không thể kết nối máy chủ')">Toast lỗi</XButton>
        <XButton @click="toast.warning('Bản ghi sắp hết hạn')">Toast cảnh báo</XButton>
      </div>
      <XTabs v-model="activeTab" :tabs="[
        { key: 'info', label: 'Thông tin chung' },
        { key: 'contract', label: 'Hợp đồng' },
        { key: 'history', label: 'Lịch sử' },
        { key: 'off', label: 'Vô hiệu', disabled: true },
      ]">
        <div v-if="activeTab === 'info'" class="py-3">Nội dung tab thông tin chung.</div>
        <div v-else-if="activeTab === 'contract'" class="py-3">Nội dung tab hợp đồng.</div>
        <div v-else class="py-3">
          <XEmptyState type="no-result" title="Không tìm thấy kết quả" description="Thử thay đổi điều kiện lọc và tìm lại." />
        </div>
      </XTabs>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold">Image viewer / Slideshow</h3>
      <XButton variant="primary" @click="imageViewerOpen = true">Xem ảnh đính kèm</XButton>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Collapse/Expand Panel <XTag color="brand" size="sm">Đợt 2</XTag></h3>
      <div class="flex flex-wrap items-center gap-10">
        <div class="flex flex-col items-center gap-1">
          <span class="text-[12px] text-[var(--xds-text-secondary)]">side="bottom" (hàng KPI)</span>
          <XCollapseExpandPanel v-model:collapsed="collapseDemoBottom" side="bottom" />
        </div>
        <div class="flex flex-col items-center gap-1">
          <span class="text-[12px] text-[var(--xds-text-secondary)]">side="top"</span>
          <XCollapseExpandPanel v-model:collapsed="collapseDemoTop" side="top" />
        </div>
        <div class="flex flex-col items-center gap-1">
          <span class="text-[12px] text-[var(--xds-text-secondary)]">side="left"</span>
          <XCollapseExpandPanel v-model:collapsed="collapseDemoLeft" side="left" />
        </div>
        <div class="flex flex-col items-center gap-1">
          <span class="text-[12px] text-[var(--xds-text-secondary)]">side="right"</span>
          <XCollapseExpandPanel v-model:collapsed="collapseDemoRight" side="right" />
        </div>
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Tree <XTag color="brand" size="sm">Đợt 3</XTag></h3>
      <div class="flex flex-wrap gap-10">
        <div class="w-[280px]">
          <span class="mb-2 block text-[12px] text-[var(--xds-text-secondary)]">Không checkbox — single-select</span>
          <XTree
            :nodes="treeNodes"
            v-model:selected="treeSelected"
            v-model:expanded="treeExpanded"
            @node-click="(n) => toast.info(`Chọn: ${n.label}`)"
          />
        </div>
        <div class="w-[280px]">
          <span class="mb-2 block text-[12px] text-[var(--xds-text-secondary)]">Có checkbox — chọn nhiều node (cascade)</span>
          <XTree :nodes="treeNodes" checkable v-model:checked="treeChecked" v-model:expanded="treeExpanded2" />
        </div>
      </div>
    </section>

    <section class="rounded-lg bg-white p-6 space-y-4">
      <h3 class="text-[16px] leading-[22px] font-semibold flex items-center gap-2">Upload <XTag color="brand" size="sm">Đợt 3</XTag></h3>
      <XUpload
        v-model="uploadFiles"
        @select-files="onUploadSelectFiles"
        @oversized="(files) => toast.info(`${files.length} tệp vượt quá dung lượng cho phép`)"
        @remove="(id) => (uploadFiles = uploadFiles.filter((f) => f.id !== id))"
        @retry="onUploadRetry"
      />
    </section>

    <XDialog v-model="dialogOpen" title="Xóa hợp đồng" type="danger"
      @confirm="dialogOpen = false; toast.success('Đã xóa hợp đồng')" @cancel="dialogOpen = false">
      Bạn có chắc muốn xóa hợp đồng HD-2026-0715 không?
    </XDialog>

    <XDrawer v-model="drawerOpen" title="Thêm nhân viên">
      <div class="space-y-4">
        <XInput placeholder="Họ và tên" />
        <XSelect :options="deptOptions" placeholder="Phòng ban" :model-value="null" />
        <XDatePicker :model-value="null" placeholder="Ngày vào làm" />
        <XTextarea placeholder="Ghi chú" :rows="3" />
      </div>
      <template #footer>
        <XButton @click="drawerOpen = false">Hủy</XButton>
        <XButton variant="primary" @click="drawerOpen = false; toast.success('Đã thêm nhân viên')">Lưu</XButton>
      </template>
    </XDrawer>

    <XImageViewer v-model="imageViewerOpen" :images="sampleImages" downloadable @download="toast.info('Bắt đầu tải ảnh')" />

    <XToast />
  </div>
</template>
