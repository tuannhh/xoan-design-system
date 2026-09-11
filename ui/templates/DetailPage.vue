<script setup>
/**
 * DetailPage — template màn hình Chi tiết (dạng Page, tách mode xem) chuẩn XDS
 * Header trắng: back + tiêu đề + trạng thái; các nút thao tác với bản ghi
 * GHIM góc trên bên PHẢI ([nút phụ] [Primary] [More] — cụm căn phải).
 * Nội dung chia tab: Thông tin chung / Hợp đồng / Chấm công / Lịch sử.
 */
import { ref } from 'vue'
import XButton from '../components/XButton.vue'
import XTabs from '../components/XTabs.vue'
import XTag from '../components/XTag.vue'
import XDataTable from '../components/XDataTable.vue'
import XDropdownMenu from '../components/XDropdownMenu.vue'
import XEmptyState from '../components/XEmptyState.vue'
import XIcon from '../components/XIcon.vue'
import XToast from '../components/XToast.vue'
import { useToast } from '../components/toast.js'

const toast = useToast()

/* ── Dữ liệu bản ghi (mock) ─────────────────────────────────── */

const employee = {
  code: 'NV-0001',
  name: 'Nguyễn Văn An',
  status: 'Đang làm việc',
  department: 'Kinh doanh',
  title: 'Trưởng phòng kinh doanh',
  startDate: '12/03/2019',
  manager: 'Trần Quốc Bảo',
  email: 'nvan@congtyxoan.vn',
  phone: '0912 345 678',
  birthday: '24/08/1990',
  gender: 'Nam',
  idNumber: '001090012345',
  address: 'Số 8 Tôn Thất Thuyết, Cầu Giấy, Hà Nội',
}

// Grid thông tin: label xám 12px + value 13px
const personalFields = [
  { label: 'Mã nhân viên', value: employee.code },
  { label: 'Ngày sinh', value: employee.birthday },
  { label: 'Giới tính', value: employee.gender },
  { label: 'Số CCCD', value: employee.idNumber },
  { label: 'Email', value: employee.email },
  { label: 'Số điện thoại', value: employee.phone },
  { label: 'Địa chỉ', value: employee.address },
]

const workFields = [
  { label: 'Phòng ban', value: employee.department },
  { label: 'Chức danh', value: employee.title },
  { label: 'Ngày vào làm', value: employee.startDate },
  { label: 'Quản lý trực tiếp', value: employee.manager },
]

/* ── Tabs ───────────────────────────────────────────────────── */

const tabs = [
  { key: 'thong-tin-chung', label: 'Thông tin chung' },
  { key: 'hop-dong', label: 'Hợp đồng' },
  { key: 'cham-cong', label: 'Chấm công' },
  { key: 'lich-su', label: 'Lịch sử' },
]

const activeTab = ref('thong-tin-chung')

/* ── Bảng Hợp đồng (mock nhỏ 3 dòng) ────────────────────────── */

const contractColumns = [
  { key: 'code', label: 'Số hợp đồng', width: 140 },
  { key: 'type', label: 'Loại hợp đồng', width: 220 },
  { key: 'signDate', label: 'Ngày ký', width: 110 },
  { key: 'effectiveDate', label: 'Ngày hiệu lực', width: 120 },
  { key: 'status', label: 'Trạng thái', width: 130 },
]

const contracts = [
  { id: 1, code: 'HĐLĐ-2023-0125', type: 'Không xác định thời hạn', signDate: '01/03/2023', effectiveDate: '01/03/2023', status: 'Đang hiệu lực' },
  { id: 2, code: 'HĐLĐ-2020-0089', type: 'Xác định thời hạn 36 tháng', signDate: '01/03/2020', effectiveDate: '01/03/2020', status: 'Hết hiệu lực' },
  { id: 3, code: 'HĐTV-2019-0031', type: 'Thử việc', signDate: '12/03/2019', effectiveDate: '12/03/2019', status: 'Hết hiệu lực' },
]

/* ── Thao tác với bản ghi ───────────────────────────────────── */

const moreItems = [
  { key: 'duplicate', label: 'Nhân bản', icon: 'copy' },
  { key: 'export', label: 'Xuất hồ sơ', icon: 'file-export' },
  { divider: true },
  { key: 'delete', label: 'Xóa', icon: 'trash', danger: true },
]

function goBack() {
  toast.info('Quay lại danh sách nhân viên')
}

function onEdit() {
  toast.info(`Mở màn hình sửa nhân viên ${employee.name}`)
}

function onApprove() {
  toast.success(`Đã phê duyệt hồ sơ nhân viên ${employee.name}`)
}

function onMore(item) {
  const key = item && item.key ? item.key : item
  if (key === 'duplicate') toast.success('Đã nhân bản hồ sơ nhân viên')
  else if (key === 'export') toast.success('Đang xuất hồ sơ nhân viên')
  else if (key === 'delete') toast.warning('Xác nhận xóa hồ sơ nhân viên trước khi thực hiện')
}
</script>

<template>
  <div
    class="flex h-full flex-col overflow-hidden bg-[var(--xds-bg-disabled)] text-[13px] leading-[18px] text-[var(--xds-text)]"
    :style="{ fontFamily: 'var(--xds-font-family)' }"
  >
    <!-- Header trắng: back + tiêu đề + trạng thái — nút thao tác ghim góc trên PHẢI -->
    <header class="shrink-0 border-b border-[var(--xds-border)] bg-[var(--xds-bg)]">
      <div class="flex flex-wrap items-center justify-between gap-3 px-4 pb-1 pt-3">
        <div class="flex min-w-0 items-center gap-2">
          <button
            type="button"
            class="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]"
            aria-label="Quay lại"
            @click="goBack"
          >
            <XIcon name="chevron-left" :size="20" />
          </button>
          <h1 class="truncate text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">
            {{ employee.name }}
          </h1>
          <XTag color="success">{{ employee.status }}</XTag>
        </div>

        <!-- Cụm thao tác căn phải: [nút phụ] [Primary] [More] theo XDS -->
        <div class="flex items-center gap-2">
          <XButton variant="secondary" @click="onEdit">Sửa</XButton>
          <XButton variant="primary" @click="onApprove">Phê duyệt</XButton>
          <XDropdownMenu :items="moreItems" @select="onMore" />
        </div>
      </div>
    </header>

    <!-- Tabs: thanh tab nền trắng, nội dung tab nền xám cuộn được -->
    <XTabs
      v-model="activeTab"
      :tabs="tabs"
      class="flex min-h-0 flex-1 flex-col [&>[role=tablist]]:shrink-0 [&>[role=tablist]]:bg-[var(--xds-bg)] [&>[role=tablist]]:px-4 [&>[role=tabpanel]]:min-h-0 [&>[role=tabpanel]]:flex-1 [&>[role=tabpanel]]:overflow-y-auto"
    >
      <!-- Tab Thông tin chung: 2 card trắng, grid label 12px xám + value 13px -->
      <div v-if="activeTab === 'thong-tin-chung'" class="flex flex-col gap-4 p-4">
        <section class="rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)] p-5">
          <h3 class="mb-4 text-[16px] font-semibold leading-[22px] text-[var(--xds-text)]">
            Thông tin cá nhân
          </h3>
          <dl class="grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2 lg:grid-cols-3">
            <div v-for="field in personalFields" :key="field.label">
              <dt class="text-[12px] leading-[16px] text-[var(--xds-text-muted)]">{{ field.label }}</dt>
              <dd class="mt-0.5 text-[13px] leading-[18px] text-[var(--xds-text)]">{{ field.value }}</dd>
            </div>
          </dl>
        </section>

        <section class="rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)] p-5">
          <h3 class="mb-4 text-[16px] font-semibold leading-[22px] text-[var(--xds-text)]">
            Thông tin công việc
          </h3>
          <dl class="grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2 lg:grid-cols-3">
            <div v-for="field in workFields" :key="field.label">
              <dt class="text-[12px] leading-[16px] text-[var(--xds-text-muted)]">{{ field.label }}</dt>
              <dd class="mt-0.5 text-[13px] leading-[18px] text-[var(--xds-text)]">{{ field.value }}</dd>
            </div>
          </dl>
        </section>
      </div>

      <!-- Tab Hợp đồng: bảng nhỏ 3 dòng -->
      <div v-else-if="activeTab === 'hop-dong'" class="p-4">
        <XDataTable :columns="contractColumns" :rows="contracts" row-key="id">
          <template #cell-status="{ row }">
            <XTag :color="row.status === 'Đang hiệu lực' ? 'success' : 'neutral'" size="sm">
              {{ row.status }}
            </XTag>
          </template>
          <template #footer-info>Tổng số hợp đồng: {{ contracts.length }}</template>
        </XDataTable>
      </div>

      <!-- Tab Chấm công / Lịch sử: chưa có dữ liệu -->
      <div v-else-if="activeTab === 'cham-cong'" class="p-4">
        <div class="rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)]">
          <XEmptyState
            type="initial"
            title="Chưa có dữ liệu chấm công"
            description="Dữ liệu chấm công của nhân viên sẽ hiển thị tại đây khi phát sinh"
          />
        </div>
      </div>

      <div v-else class="p-4">
        <div class="rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)]">
          <XEmptyState
            type="initial"
            title="Chưa có lịch sử thay đổi"
            description="Mọi thay đổi trên hồ sơ nhân viên sẽ được ghi lại tại đây"
          />
        </div>
      </div>
    </XTabs>

    <XToast />
  </div>
</template>
